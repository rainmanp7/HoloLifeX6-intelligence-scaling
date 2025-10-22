# semantic_analyzer.jl
"""
🎯 SEMANTIC ANALYZER (GitHub-Remote Optimized)
AST-like function-level analysis without external dependencies.
Fixed to match meta_cognitive_engine.jl data structure expectations.
"""

using JSON
using Dates
using Statistics

# Configurable thresholds (matching meta_cognitive_engine.jl pattern)
const LONG_METHOD_THRESHOLD = 50
const MAX_PARAMS = 5
const MAX_NESTING = 4
const MAX_RESPONSIBILITIES = 2
const HIGH_PRIORITY_SCORE = 10.0
const MEDIUM_PRIORITY_SCORE = 5.0

# ==============================================================================
# STAGE 1: THE TOKENIZER (LEXER) - CORE UPGRADE
# ==============================================================================

struct PseudoNode
    kind::Symbol
    value::String
    line::Int
end

function tokenize_code(source_code::String)::Vector{PseudoNode}
    tokens = PseudoNode[]
    keywords = Set(["function", "struct", "mutable", "if", "else", "elseif", "while", "for", "begin", "end", "try", "catch", "finally", "let", "return", "using", "export", "module", "import"])
    
    line_num = 1
    i = 1
    while i <= lastindex(source_code)
        char = source_code[i]

        if char == '\n'; line_num += 1; i += 1; continue; end
        if isspace(char); i += 1; continue; end

        # Comments
        if char == '#'
            # Handle shebang `#!/usr/bin/env julia` on first line gracefully.
            if i == 1 && i < lastindex(source_code) && source_code[i+1] == '!'
                 # This is a shebang line, skip to the end of it.
            elseif i < lastindex(source_code) && source_code[i+1] == '='
                # Multi-line comment
                end_idx = findnext("=#", source_code, i + 2);
                if end_idx === nothing; break; end
                line_num += count(c -> c == '\n', source_code[i:last(end_idx)])
                i = last(end_idx) + 1;
                continue
            end
            # Single-line comment: skip to the next newline
            next_newline = findnext('\n', source_code, i)
            if next_newline === nothing; break; end
            i = next_newline
            continue
        end

        # Handle ' (can be char literal or transpose operator)
        if char == '\''
            is_transpose = !isempty(tokens) && (last(tokens).kind in [:identifier, :number_literal] || last(tokens).value == ")")
            if !is_transpose
                start_i = i; i += 1
                while i <= lastindex(source_code) && (source_code[i] != '\'' || source_code[i-1] == '\\'); i += 1; end
                val = source_code[start_i:i]
                push!(tokens, PseudoNode(:char_literal, val, line_num))
                i += 1; continue
            end
        end

        # Strings
        if char == '"'
            is_multiline = i + 2 <= lastindex(source_code) && source_code[i:i+2] == "\"\"\""
            terminator = is_multiline ? "\"\"\"" : "\""
            start_i = i
            i += (is_multiline ? 3 : 1)
            
            end_idx = findnext(terminator, source_code, i)
            if end_idx === nothing; break; end
            
            val = source_code[start_i:last(end_idx)]
            line_num += count(c -> c == '\n', val)
            push!(tokens, PseudoNode(:string_literal, val, line_num))
            i = last(end_idx) + 1
            continue
        end

        # Identifiers and Keywords
        if isletter(char) || char == '_'
            start_i = i; i += 1
            while i <= lastindex(source_code) && (isletter(source_code[i]) || isdigit(source_code[i]) || source_code[i] == '_' || source_code[i] == '!'); i += 1; end
            val = source_code[start_i:i-1]
            kind = val in keywords ? :keyword : :identifier
            push!(tokens, PseudoNode(kind, val, line_num))
            continue
        end

        # Numbers
        if isdigit(char) || (char == '.' && i < lastindex(source_code) && isdigit(source_code[i+1]))
            start_i = i; i += 1
            while i <= lastindex(source_code) && (isdigit(source_code[i]) || source_code[i] == '.' || source_code[i] in "eE" || (source_code[i] == '-' && source_code[i-1] in "eE")); i += 1; end
            val = source_code[start_i:i-1]
            push!(tokens, PseudoNode(:number_literal, val, line_num))
            continue
        end
        
        # Check for 3-char operators first
        if i + 2 <= lastindex(source_code)
            three_char = source_code[i:i+2]
            if three_char in ["!==", "==="]
                push!(tokens, PseudoNode(:operator, three_char, line_num)); i += 3; continue
            end
        end
        # Then 2-char operators
        if i + 1 <= lastindex(source_code)
            two_char = source_code[i:i+1]
            if two_char in ["==", "!=", "<=", ">=", "&&", "||", "::", "+=", "-=", "*=", "/="]
                push!(tokens, PseudoNode(:operator, two_char, line_num)); i += 2; continue
            end
        end
        # Finally, 1-char operators
        if char in "()[]{},;.=<>:!&|+-*/'^"
            push!(tokens, PseudoNode(:operator, string(char), line_num)); i += 1; continue
        end

        i += 1
    end
    return tokens
end

# ==============================================================================
# STAGE 2: FUNCTION EXTRACTION
# ==============================================================================

function group_tokens_by_function(tokens::Vector{PseudoNode})::Vector{Dict}
    functions = []
    if isempty(tokens) return functions end

    nesting_level = 0
    func_start_index = 0
    skip_until_index = 0

    for i in 1:length(tokens)
        if i < skip_until_index
            continue
        end
        
        token = tokens[i]
        
        # Start of a potential top-level function
        if token.kind == :keyword && token.value == "function" && nesting_level == 0
            func_start_index = i
            
            # Lookahead to determine function style
            is_one_liner = false
            j = i + 1
            while j <= length(tokens) && tokens[j].line == token.line
                if tokens[j].kind == :operator && tokens[j].value == "="
                    if j > 1 && !(tokens[j-1].value in ["=", "!", "<", ">"])
                        is_one_liner = true
                        break
                    end
                end
                j += 1
            end

            if is_one_liner
                # Handle One-Line Function
                line_end_idx = findnext(t -> t.line > token.line, tokens, i)
                func_end_idx = (line_end_idx === nothing) ? length(tokens) : line_end_idx - 1
                
                func_tokens = tokens[func_start_index:func_end_idx]
                name = "anonymous"
                name_idx = findfirst(t -> t.kind == :identifier, func_tokens)
                if name_idx !== nothing; name = func_tokens[name_idx].value; end

                push!(functions, Dict(
                    "name" => name,
                    "start_line" => token.line,
                    "end_line" => tokens[func_end_idx].line,
                    "tokens" => func_tokens
                ))
                
                skip_until_index = func_end_idx + 1
                func_start_index = 0
            else
                # Handle Block Function
                nesting_level = 1
            end
        
        # Handle nested functions
        elseif token.kind == :keyword && token.value == "function" && nesting_level > 0
            nesting_level += 1

        # Handle end of a block
        elseif token.kind == :keyword && token.value == "end"
            if nesting_level > 0
                nesting_level -= 1
                if nesting_level == 0 && func_start_index > 0
                    func_tokens = tokens[func_start_index:i]
                    name = "anonymous"

                    if length(func_tokens) >= 2 && func_tokens[2].kind == :identifier
                        name = func_tokens[2].value
                    end

                    push!(functions, Dict(
                        "name" => name,
                        "start_line" => tokens[func_start_index].line,
                        "end_line" => token.line,
                        "tokens" => func_tokens
                    ))
                    func_start_index = 0
                end
            end
        end
    end
    return functions
end

# ==============================================================================
# STAGE 3: ANALYSIS FUNCTIONS (FIXED TO MATCH META_COGNITIVE_ENGINE PATTERNS)
# ==============================================================================

function analyze_function_from_tokens(func::Dict)::Dict
    tokens = get(func, "tokens", PseudoNode[])
    func_name = get(func, "name", "unknown")
    start_line = get(func, "start_line", 0)
    end_line = get(func, "end_line", 0)
    
    if isempty(tokens) 
        return create_empty_function_analysis(func_name, start_line, end_line)
    end

    # Enhanced metrics using tokens (with proper defaults like meta_cognitive_engine)
    line_count = end_line - start_line + 1
    param_count = count_parameters_from_tokens(tokens)
    complexity = calculate_complexity_from_tokens(tokens)
    nesting = calculate_nesting_from_tokens(tokens)

    # Semantic analysis
    responsibilities = identify_responsibilities_from_tokens(tokens)
    dependencies = extract_dependencies_from_tokens(tokens)
    category = categorize_function_from_tokens(func_name, tokens, responsibilities)
    smells = detect_code_smells_from_metrics(line_count, param_count, nesting, responsibilities)
    
    # Calculate numerical refactoring priority (matching meta_cognitive_engine pattern)
    priority_score = calculate_priority_score(line_count, complexity, nesting, length(smells))
    priority_level = determine_priority_level(priority_score)
    
    return Dict(
        "name" => func_name,
        "location" => "$(start_line)-$(end_line)",
        "metrics" => Dict(
            "line_count" => line_count,
            "parameter_count" => param_count,
            "nesting_depth" => nesting,
            "complexity_score" => complexity
        ),
        "semantic" => Dict(
            "category" => category,
            "responsibilities" => collect(responsibilities),
            "dependencies" => collect(dependencies)
        ),
        "issues" => Dict(
            "code_smells" => collect(smells),
            "refactoring_priority" => priority_level,
            "priority_score" => priority_score
        )
    )
end

function create_empty_function_analysis(name::String, start_line::Int, end_line::Int)::Dict
    return Dict(
        "name" => name,
        "location" => "$start_line-$end_line",
        "metrics" => Dict(
            "line_count" => max(1, end_line - start_line + 1),
            "parameter_count" => 0,
            "nesting_depth" => 0,
            "complexity_score" => 1
        ),
        "semantic" => Dict(
            "category" => "unknown",
            "responsibilities" => String[],
            "dependencies" => String[]
        ),
        "issues" => Dict(
            "code_smells" => String[],
            "refactoring_priority" => "LOW",
            "priority_score" => 0.0
        )
    )
end

function count_parameters_from_tokens(tokens::Vector{PseudoNode})::Int
    start_paren_idx = findfirst(t -> t.value == "(", tokens)
    if start_paren_idx === nothing return 0 end
    
    end_paren_idx = findfirst(t -> t.value == ")", tokens[start_paren_idx:end])
    if end_paren_idx === nothing return 0 end
    
    param_tokens = tokens[start_paren_idx : start_paren_idx + end_paren_idx - 1]
    # Count identifiers that are not keywords
    return count(t -> t.kind == :identifier && !(t.value in ["function", "end"]), param_tokens)
end

function calculate_complexity_from_tokens(tokens::Vector{PseudoNode})::Int
    complexity = 1
    for token in tokens
        if (token.kind == :keyword && token.value in ["if", "for", "while", "catch"]) ||
           (token.kind == :operator && token.value in ["&&", "||"])
            complexity += 1
        end
    end
    return complexity
end

function calculate_nesting_from_tokens(tokens::Vector{PseudoNode})::Int
    max_depth, current_depth = 0, 0
    starters = Set(["function", "struct", "if", "for", "while", "let", "begin", "try"])
    for token in tokens
        if token.kind == :keyword
            if token.value in starters
                current_depth += 1
                max_depth = max(max_depth, current_depth)
            end
            if token.value == "end"
                current_depth = max(0, current_depth - 1)
            end
        end
    end
    return max_depth
end

function extract_dependencies_from_tokens(tokens::Vector{PseudoNode})::Set{String}
    deps = Set{String}()
    for i in 1:(length(tokens)-1)
        if tokens[i].kind == :identifier && i + 1 <= length(tokens) && tokens[i+1].value == "("
            push!(deps, tokens[i].value)
        end
    end
    return deps
end

function identify_responsibilities_from_tokens(tokens::Vector{PseudoNode})::Set{String}
    resp = Set{String}()
    io_keywords = Set(["println", "print", "read", "write", "open", "close"])
    val_keywords = Set(["assert", "error", "check", "validate"])
    comp_keywords = Set(["for", "while"])
    init_keywords = Set(["new", "create", "initialize", "setup"])
    
    for token in tokens
        if token.kind == :identifier
            if token.value in io_keywords
                push!(resp, "io_operations")
            elseif token.value in val_keywords
                push!(resp, "validation")
            elseif token.value in init_keywords
                push!(resp, "initialization")
            end
        elseif token.kind == :keyword && token.value in comp_keywords
            push!(resp, "computation")
        end
    end
    return resp
end

function categorize_function_from_tokens(name::String, tokens::Vector{PseudoNode}, responsibilities::Set{String})::String
    name_lower = lowercase(name)
    if occursin(r"test|check|verify", name_lower); return "testing"; end
    if occursin(r"run|execute|process|main", name_lower); return "orchestration"; end
    if occursin(r"calculate|compute|measure", name_lower); return "calculation"; end
    if "initialization" in responsibilities; return "initialization"; end
    if "io_operations" in responsibilities; return "io_handler"; end
    if "validation" in responsibilities; return "validation"; end
    return "utility"
end

function detect_code_smells_from_metrics(line_count::Int, param_count::Int, nesting::Int, responsibilities::Set{String})::Set{String}
    smells = Set{String}()
    if line_count > LONG_METHOD_THRESHOLD
        push!(smells, "long_method")
    end
    if param_count > MAX_PARAMS
        push!(smells, "many_parameters")
    end
    if nesting > MAX_NESTING
        push!(smells, "deep_nesting")
    end
    if length(responsibilities) > MAX_RESPONSIBILITIES
        push!(smells, "mixed_abstractions")
    end
    return smells
end

# FIXED: Proper numerical calculation matching meta_cognitive_engine pattern
function calculate_priority_score(line_count::Int, complexity::Int, nesting::Int, smell_count::Int)::Float64
    score = (line_count / 30.0) + Float64(complexity) + (nesting / 2.0) + (smell_count * 2.0)
    return round(score, digits=2)
end

function determine_priority_level(score::Float64)::String
    if score > HIGH_PRIORITY_SCORE
        return "HIGH"
    elseif score > MEDIUM_PRIORITY_SCORE
        return "MEDIUM"
    else
        return "LOW"
    end
end

# ==============================================================================
# MODULE-LEVEL ANALYSIS (FIXED TO MATCH META_COGNITIVE_ENGINE EXPECTATIONS)
# ==============================================================================

function analyze_module_semantics(module_path::String)::Dict
    println("   🔬 Performing enhanced token-based semantic analysis: $module_path")
    
    if !isfile(module_path)
        return Dict(
            "error" => "File not found: $module_path",
            "functions_analyzed" => 0,
            "function_details" => [],
            "module_smells" => String[],
            "aggregate_metrics" => Dict(
                "total_lines" => 0,
                "average_complexity" => 0.0,
                "high_priority_functions" => 0
            )
        )
    end

    try
        source_code = read(module_path, String)
        tokens = tokenize_code(source_code)
        function_groups = group_tokens_by_function(tokens)
        
        analyzed_functions = [analyze_function_from_tokens(f) for f in function_groups]
        
        # Calculate aggregate metrics (matching meta_cognitive_engine pattern)
        total_lines = sum(get(get(f, "metrics", Dict()), "line_count", 0) for f in analyzed_functions)
        
        # Safe average calculation
        avg_complexity = if length(analyzed_functions) > 0
            complexities = [get(get(f, "metrics", Dict()), "complexity_score", 1) for f in analyzed_functions]
            round(mean(complexities), digits=2)
        else
            0.0
        end
        
        high_priority_count = count(f -> get(get(f, "issues", Dict()), "refactoring_priority", "LOW") == "HIGH", analyzed_functions)
        
        module_smells = detect_module_smells(analyzed_functions)
        
        # CRITICAL: Return structure that meta_cognitive_engine expects
        return Dict(
            "module" => module_path,
            "functions_analyzed" => length(analyzed_functions),
            "function_details" => analyzed_functions,
            "module_smells" => module_smells,
            "aggregate_metrics" => Dict(
                "total_lines" => total_lines,
                "average_complexity" => avg_complexity,
                "high_priority_functions" => high_priority_count
            ),
            "analysis_timestamp" => string(now(UTC)),
            "analysis_method" => "enhanced_tokenizer"
        )
    catch e
        println("   ⚠️  Error during analysis: $e")
        return Dict(
            "error" => "Analysis failed: $e",
            "functions_analyzed" => 0,
            "function_details" => [],
            "module_smells" => String[],
            "aggregate_metrics" => Dict(
                "total_lines" => 0,
                "average_complexity" => 0.0,
                "high_priority_functions" => 0
            )
        )
    end
end

function detect_module_smells(analyses::Vector{Dict})::Vector{String}
    smells = String[]
    if isempty(analyses) return smells end
    
    # Dead Code Detection
    all_names = Set(get(f, "name", "") for f in analyses)
    all_deps = Set{String}()
    for f in analyses
        semantic = get(f, "semantic", Dict())
        deps = get(semantic, "dependencies", String[])
        for dep in deps
            push!(all_deps, dep)
        end
    end
    
    dead_code = setdiff(all_names, all_deps)
    # Exclude entry points and exported functions
    filter!(f -> f != "analyze_module_semantics" && 
                 !startswith(f, "main") && 
                 !isempty(f) &&
                 f != "anonymous", dead_code)
    
    if !isempty(dead_code)
        push!(smells, "Potential Dead Code: $(join(sort(collect(dead_code)), ", "))")
    end
    
    # High complexity concentration
    high_complexity_funcs = filter(f -> get(get(f, "metrics", Dict()), "complexity_score", 0) > 10, analyses)
    if length(analyses) > 0 && length(high_complexity_funcs) > length(analyses) / 3
        push!(smells, "High Complexity Concentration: $(length(high_complexity_funcs))/$(length(analyses)) functions exceed complexity threshold")
    end
    
    # Long methods concentration
    long_methods = filter(f -> get(get(f, "metrics", Dict()), "line_count", 0) > LONG_METHOD_THRESHOLD, analyses)
    if !isempty(long_methods)
        push!(smells, "Long Methods Detected: $(length(long_methods)) functions exceed $(LONG_METHOD_THRESHOLD) lines")
    end

    return smells
end

# Save functionality matching meta_cognitive_engine pattern
function save_semantic_analysis(analysis::Dict, filename::String="semantic_analysis.json")::Bool
    try
        json_data = JSON.json(analysis, 2)
        open(filename, "w") do file
            write(file, json_data)
        end
        println("   ✅ Semantic analysis saved to: $filename")
        return true
    catch e
        println("   ⚠️  Failed to save semantic analysis: $e")
        return false
    end
end

export analyze_module_semantics, save_semantic_analysis,
       LONG_METHOD_THRESHOLD, MAX_PARAMS, MAX_NESTING, MAX_RESPONSIBILITIES
