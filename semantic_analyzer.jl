# semantic_analyzer.jl
"""
🎯 SEMANTIC ANALYZER (GitHub-Remote Optimized)
AST-like function-level analysis that MATCHES meta_cognitive_engine.jl metrics
"""

using JSON
using Dates
using Statistics

# ==============================================================================
# MATCH META_COGNITIVE_ENGINE CONSTANTS EXACTLY
# ==============================================================================

const COMPLEXITY_THRESHOLD = 3.0
const MIN_COMMENT_COVERAGE = 0.01
const MAX_CYCLOMATIC = 20
const CRITICAL_MODULES = ["unified_network.jl", "consciousness_core.jl", "safe_tester.jl"]

# ==============================================================================
# TOKENIZER (SAME AS BEFORE)
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

        # Comments (COUNT THEM for comment coverage!)
        if char == '#'
            # Store comment tokens for coverage calculation
            start_i = i
            if i < lastindex(source_code) && source_code[i+1] == '='
                # Multi-line comment
                end_idx = findnext("=#", source_code, i + 2)
                if end_idx === nothing; break; end
                val = source_code[start_i:last(end_idx)]
                push!(tokens, PseudoNode(:comment, val, line_num))
                line_num += count(c -> c == '\n', val)
                i = last(end_idx) + 1
            else
                # Single-line comment
                next_newline = findnext('\n', source_code, i)
                end_idx = next_newline === nothing ? lastindex(source_code) : next_newline - 1
                val = source_code[start_i:end_idx]
                push!(tokens, PseudoNode(:comment, val, line_num))
                i = next_newline === nothing ? lastindex(source_code) + 1 : next_newline
            end
            continue
        end

        # Strings
        if char == '"'
            start_i = i
            i += 1
            while i <= lastindex(source_code) && (source_code[i] != '"' || source_code[i-1] == '\\')
                i += 1
            end
            val = source_code[start_i:i]
            push!(tokens, PseudoNode(:string_literal, val, line_num))
            i += 1
            continue
        end

        # Identifiers and Keywords
        if isletter(char) || char == '_'
            start_i = i
            i += 1
            while i <= lastindex(source_code) && (isletter(source_code[i]) || isdigit(source_code[i]) || source_code[i] == '_' || source_code[i] == '!')
                i += 1
            end
            val = source_code[start_i:i-1]
            kind = val in keywords ? :keyword : :identifier
            push!(tokens, PseudoNode(kind, val, line_num))
            continue
        end

        # Numbers
        if isdigit(char) || (char == '.' && i < lastindex(source_code) && isdigit(source_code[i+1]))
            start_i = i
            i += 1
            while i <= lastindex(source_code) && (isdigit(source_code[i]) || source_code[i] == '.' || source_code[i] in "eE")
                i += 1
            end
            val = source_code[start_i:i-1]
            push!(tokens, PseudoNode(:number_literal, val, line_num))
            continue
        end

        # Operators
        if i < lastindex(source_code)
            two_char = source_code[i:i+1]
            if two_char in ["==", "!=", "<=", ">=", "&&", "||", "::"]
                push!(tokens, PseudoNode(:operator, two_char, line_num))
                i += 2
                continue
            end
        end

        if char in ['(', ')', '[', ']', '{', '}', ',', ';', '.', '=', '<', '>', ':', '!', '&', '|', '+', '-', '*', '/']
            push!(tokens, PseudoNode(:operator, string(char), line_num))
            i += 1
            continue
        end

        i += 1
    end
    return tokens
end

# ==============================================================================
# FUNCTION EXTRACTION (SAME)
# ==============================================================================

function group_tokens_by_function(tokens::Vector{PseudoNode})::Vector{Dict}
    functions = []
    current_func_tokens = PseudoNode[]
    nesting_level = 0
    in_function = false
    current_func_name = ""
    current_start_line = 0

    for i in 1:length(tokens)
        token = tokens[i]
        
        if token.kind == :keyword && token.value == "function"
            if nesting_level == 0
                in_function = true
                current_start_line = token.line
                current_func_tokens = [token]
                
                if i + 1 <= length(tokens) && tokens[i+1].kind == :identifier
                    current_func_name = tokens[i+1].value
                else
                    current_func_name = "anonymous"
                end
            end
            nesting_level += 1
        end

        if in_function
            push!(current_func_tokens, token)
        end
        
        if token.kind == :keyword && token.value == "end"
            if nesting_level > 0
                nesting_level -= 1
                if nesting_level == 0 && in_function
                    in_function = false
                    push!(functions, Dict(
                        "name" => current_func_name,
                        "start_line" => current_start_line,
                        "end_line" => token.line,
                        "tokens" => current_func_tokens
                    ))
                end
            end
        end
    end
    return functions
end

# ==============================================================================
# KEY FIX: MATCH META_COGNITIVE_ENGINE METRICS EXACTLY
# ==============================================================================

function analyze_function_from_tokens(func::Dict)::Dict
    tokens = get(func, "tokens", PseudoNode[])
    if isempty(tokens) 
        return create_empty_function_analysis(
            get(func, "name", "unknown"),
            get(func, "start_line", 0),
            get(func, "end_line", 0)
        )
    end

    # CRITICAL: Calculate metrics EXACTLY like meta_cognitive_engine
    line_count = get(func, "end_line", 0) - get(func, "start_line", 0) + 1
    
    # Calculate cyclomatic complexity indicators (decision points + 1)
    cyclomatic_indicators = calculate_cyclomatic_indicators(tokens)
    
    # Calculate control flow density (cyclomatic / line_count)
    control_flow_density = line_count > 0 ? cyclomatic_indicators / line_count : 0.0
    
    # Calculate comment coverage
    comment_lines = count(t -> t.kind == :comment, tokens)
    comment_coverage = line_count > 0 ? comment_lines / line_count : 0.0
    
    # Other metrics
    param_count = count_parameters_from_tokens(tokens)
    nesting = calculate_nesting_from_tokens(tokens)
    responsibilities = identify_responsibilities_from_tokens(tokens)
    dependencies = extract_dependencies_from_tokens(tokens)
    category = categorize_function_from_tokens(get(func, "name", ""), tokens, responsibilities)
    smells = detect_code_smells_from_metrics(line_count, param_count, nesting, cyclomatic_indicators)
    
    # Refactoring priority (match meta_cognitive_engine pattern)
    priority_score = calculate_priority_score(line_count, cyclomatic_indicators, nesting, length(smells))
    priority_level = determine_priority_level(priority_score)
    
    return Dict(
        "name" => get(func, "name", "unknown"),
        "location" => "$(get(func, "start_line", 0))-$(get(func, "end_line", 0))",
        "metrics" => Dict(
            "line_count" => line_count,
            "parameter_count" => param_count,
            "nesting_depth" => nesting,
            "complexity_score" => cyclomatic_indicators,  # Use cyclomatic as complexity score
            # ADD THE CRITICAL METRICS THAT META_COGNITIVE_ENGINE EXPECTS:
            "cyclomatic_indicators" => cyclomatic_indicators,
            "control_flow_density" => round(control_flow_density, digits=3),
            "comment_coverage" => round(comment_coverage, digits=3)
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

# CRITICAL: Calculate cyclomatic complexity the SAME way as meta_cognitive_engine
function calculate_cyclomatic_indicators(tokens::Vector{PseudoNode})::Int
    complexity = 1  # Base complexity
    
    for token in tokens
        if token.kind == :keyword && token.value in ["if", "elseif", "for", "while", "catch"]
            complexity += 1
        elseif token.kind == :operator && token.value in ["&&", "||"]
            complexity += 1
        end
    end
    
    return complexity
end

function calculate_nesting_from_tokens(tokens::Vector{PseudoNode})::Int
    max_depth, current_depth = 0, 0
    starters = Set(["function", "if", "for", "while", "let", "begin", "try"])
    
    for token in tokens
        if token.kind == :keyword
            if token.value in starters
                current_depth += 1
                max_depth = max(max_depth, current_depth)
            elseif token.value == "end"
                current_depth -= 1
            end
        end
    end
    return max_depth
end

function count_parameters_from_tokens(tokens::Vector{PseudoNode})::Int
    start_paren_idx = findfirst(t -> t.value == "(", tokens)
    if start_paren_idx === nothing return 0 end
    end_paren_idx = findfirst(t -> t.value == ")", tokens[start_paren_idx:end])
    if end_paren_idx === nothing return 0 end
    
    param_tokens = tokens[start_paren_idx : start_paren_idx + end_paren_idx - 1]
    return count(t -> t.kind == :identifier, param_tokens)
end

function extract_dependencies_from_tokens(tokens::Vector{PseudoNode})::Set{String}
    deps = Set{String}()
    for i in 1:(length(tokens)-1)
        if tokens[i].kind == :identifier && tokens[i+1].value == "("
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
        if token.kind == :identifier && token.value in io_keywords
            push!(resp, "io_operations")
        end
        if token.kind == :identifier && token.value in val_keywords
            push!(resp, "validation")
        end
        if token.kind == :keyword && token.value in comp_keywords
            push!(resp, "computation")
        end
        if token.kind == :identifier && token.value in init_keywords
            push!(resp, "initialization")
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

# Use cyclomatic_indicators for smell detection (matching meta_cognitive_engine)
function detect_code_smells_from_metrics(line_count::Int, param_count::Int, nesting::Int, cyclomatic_indicators::Int)::Set{String}
    smells = Set{String}()
    if line_count > 50; push!(smells, "long_method"); end
    if param_count > 5; push!(smells, "many_parameters"); end
    if nesting > 4; push!(smells, "deep_nesting"); end
    if cyclomatic_indicators > MAX_CYCLOMATIC; push!(smells, "high_cyclomatic_complexity"); end
    return smells
end

function calculate_priority_score(line_count::Int, cyclomatic_indicators::Int, nesting::Int, smell_count::Int)::Float64
    score = (line_count / 30.0) + Float64(cyclomatic_indicators) + (nesting / 2.0) + (smell_count * 2.0)
    return round(score, digits=2)
end

function determine_priority_level(score::Float64)::String
    if score > 10.0; return "HIGH"; end
    if score > 5.0; return "MEDIUM"; end
    return "LOW"
end

function create_empty_function_analysis(name::String, start_line::Int, end_line::Int)::Dict
    return Dict(
        "name" => name,
        "location" => "$start_line-$end_line",
        "metrics" => Dict(
            "line_count" => end_line - start_line + 1,
            "parameter_count" => 0,
            "nesting_depth" => 0,
            "complexity_score" => 1,
            "cyclomatic_indicators" => 1,
            "control_flow_density" => 0.0,
            "comment_coverage" => 0.0
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

# ==============================================================================
# MODULE-LEVEL ANALYSIS THAT MATCHES META_COGNITIVE_ENGINE
# ==============================================================================

function analyze_module_semantics(module_path::String)::Dict
    println("   🔬 Semantic analysis (META-COGNITIVE COMPATIBLE): $module_path")
    
    if !isfile(module_path)
        return Dict(
            "error" => "File not found: $module_path",
            "functions_analyzed" => 0,
            "function_details" => [],
            "module_smells" => String[]
        )
    end

    source_code = read(module_path, String)
    tokens = tokenize_code(source_code)
    function_groups = group_tokens_by_function(tokens)
    
    analyzed_functions = [analyze_function_from_tokens(f) for f in function_groups]
    
    # Calculate aggregate metrics that MATCH meta_cognitive_engine format
    if !isempty(analyzed_functions)
        total_lines = sum(get(f["metrics"], "line_count", 0) for f in analyzed_functions)
        avg_complexity = mean(get(f["metrics"], "cyclomatic_indicators", 1) for f in analyzed_functions)
        high_priority_count = count(f -> f["issues"]["refactoring_priority"] == "HIGH", analyzed_functions)
    else
        total_lines = 0
        avg_complexity = 0.0
        high_priority_count = 0
    end
    
    return Dict(
        "module" => module_path,
        "functions_analyzed" => length(analyzed_functions),
        "function_details" => analyzed_functions,
        "module_smells" => detect_module_smells(analyzed_functions),
        "complexity_metrics" => Dict(  # CRITICAL: This matches meta_cognitive_engine structure!
            "cyclomatic_indicators" => sum(get(f["metrics"], "cyclomatic_indicators", 0) for f in analyzed_functions),
            "line_count" => total_lines,
            "comment_coverage" => length(analyzed_functions) > 0 ? 
                mean(get(f["metrics"], "comment_coverage", 0.0) for f in analyzed_functions) : 0.0,
            "control_flow_density" => length(analyzed_functions) > 0 ? 
                mean(get(f["metrics"], "control_flow_density", 0.0) for f in analyzed_functions) : 0.0
        ),
        "analysis_timestamp" => string(now()),
        "analysis_method" => "meta_cognitive_compatible"
    )
end

function detect_module_smells(analyses::Vector{Dict})::Vector{String}
    smells = String[]
    if isempty(analyses) return smells end
    
    # Check for functions exceeding cyclomatic complexity threshold
    high_complexity_funcs = [f["name"] for f in analyses if get(f["metrics"], "cyclomatic_indicators", 0) > MAX_CYCLOMATIC]
    if !isempty(high_complexity_funcs)
        push!(smells, "High cyclomatic complexity: $(join(high_complexity_funcs, ", "))")
    end
    
    # Check for low comment coverage
    low_comment_funcs = [f["name"] for f in analyses if get(f["metrics"], "comment_coverage", 0.0) < MIN_COMMENT_COVERAGE]
    if !isempty(low_comment_funcs)
        push!(smells, "Low comment coverage: $(join(low_comment_funcs, ", "))")
    end
    
    return smells
end

export analyze_module_semantics, COMPLEXITY_THRESHOLD, MIN_COMMENT_COVERAGE, MAX_CYCLOMATIC, CRITICAL_MODULES
