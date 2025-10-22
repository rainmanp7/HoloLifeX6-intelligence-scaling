# semantic_analyzer.jl
"""
🎯 SEMANTIC ANALYZER (GitHub-Remote Optimized)
AST-like function-level analysis without external dependencies.
This version refines the tokenizer and analysis logic for maximum robustness.
"""

using JSON
using Dates

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
            # ⭐ UPGRADE: Handle shebang `#!/usr/bin/env julia` on first line gracefully.
            if i == 1 && i < lastindex(source_code) && source_code[i+1] == '!'
                 # This is a shebang line, skip to the end of it.
            elseif i < lastindex(source_code) && source_code[i+1] == '='
                # Multi-line comment
                end_idx = findnext("=#", source_code, i + 2);
                if end_idx === nothing; break; end
                line_num += count(c -> c == '\n', source_code[i:last(end_idx)]) # Update line count
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
            # ⭐ UPGRADE: Differentiate between char 'c' and transpose operator x'.
            # If the previous token was an identifier, number, or ')', it's a transpose operator.
            is_transpose = !isempty(tokens) && (last(tokens).kind in [:identifier, :number_literal] || last(tokens).value == ")")
            if !is_transpose
                start_i = i; i += 1
                while i <= lastindex(source_code) && (source_code[i] != '\'' || source_code[i-1] == '\\'); i += 1; end
                val = source_code[start_i:i]
                push!(tokens, PseudoNode(:char_literal, val, line_num))
                i += 1; continue
            end
            # If it is a transpose, it will be handled by the operator logic below.
        end

        # Strings
        if char == '"'
            is_multiline = i + 2 <= lastindex(source_code) && source_code[i:i+2] == "\"\"\""
            terminator = is_multiline ? "\"\"\"" : "\""
            start_i = i
            i += (is_multiline ? 3 : 1)
            
            end_idx = findnext(terminator, source_code, i)
            if end_idx === nothing; break; end # Unclosed string
            
            val = source_code[start_i:last(end_idx)]
            line_num += count(c -> c == '\n', val) # Update line count for multiline strings
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
        
        # ⭐ UPGRADE: Reordered and consolidated operator logic for clarity and correctness.
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

        i += 1 # Unknown character
    end
    return tokens
end


# ==============================================================================
# STAGE 2 & 3 (Your excellent structure is maintained, with minor tweaks)
# ==============================================================================

# ==============================================================================
# STAGE 2: FUNCTION EXTRACTION USING TOKENS (UPGRADED AND FIXED)
# Now correctly handles both block (`function...end`) and one-line (`function...=`) syntax.
# ==============================================================================

function group_tokens_by_function(tokens::Vector{PseudoNode})::Vector{Dict}
    functions = []
    nesting_level = 0
    func_start_index = 0

    i = 1
    while i <= length(tokens)
        token = tokens[i]
        
        if token.kind == :keyword && token.value == "function"
            if nesting_level == 0
                # We found a potential top-level function start
                func_start_index = i
                
                # ⭐ FIX: Look ahead to determine if this is a one-liner or a block function
                is_one_liner = false
                # Scan from after the 'function' token to the end of the line
                j = i + 1
                while j <= length(tokens) && tokens[j].line == token.line
                    if tokens[j].kind == :operator && tokens[j].value == "="
                        is_one_liner = true
                        break
                    end
                    j += 1
                end

                if is_one_liner
                    # A one-liner ends at the end of its line.
                    line_end_idx = findnext(t -> t.line > token.line, tokens, i)
                    if line_end_idx === nothing
                        line_end_idx = length(tokens) + 1
                    end
                    func_end_idx = line_end_idx - 1
                    
                    func_tokens = tokens[func_start_index:func_end_idx]
                    name_token_idx = findfirst(t -> t.kind == :identifier, func_tokens)
                    name = name_token_idx !== nothing ? func_tokens[name_token_idx].value : "anonymous"

                    push!(functions, Dict(
                        "name" => name,
                        "start_line" => token.line,
                        "end_line" => tokens[func_end_idx].line,
                        "tokens" => func_tokens
                    ))
                    
                    # Jump the main loop index past this one-line function
                    i = func_end_idx
                    func_start_index = 0 # Reset
                else
                    # It's a block function, so we need to track nesting
                    nesting_level += 1
                end
            else
                # This is a nested function, just increment the level
                nesting_level += 1
            end
        
        elseif token.kind == :keyword && token.value == "end"
            if nesting_level > 0
                nesting_level -= 1
                if nesting_level == 0 && func_start_index > 0
                    # We found the end of a top-level block function
                    func_tokens = tokens[func_start_index:i]
                    name_token_idx = findfirst(t -> t.kind == :identifier, func_tokens)
                    name = name_token_idx !== nothing ? func_tokens[name_token_idx].value : "anonymous"

                    push!(functions, Dict(
                        "name" => name,
                        "start_line" => tokens[func_start_index].line,
                        "end_line" => token.line,
                        "tokens" => func_tokens
                    ))
                    func_start_index = 0 # Reset
                end
            end
        end
        i += 1
    end
    return functions
end

# The rest of your analysis functions are very solid.
# I've kept them as they are, as they correctly build upon the tokenizer's output.
# The following section contains your functions, unchanged.

function analyze_function_from_tokens(func::Dict)::Dict
    tokens = func["tokens"]
    if isempty(tokens) 
        return create_empty_function_analysis(func["name"], func["start_line"], func["end_line"])
    end

    # Enhanced metrics using tokens
    line_count = func["end_line"] - func["start_line"] + 1
    param_count = count_parameters_from_tokens(tokens)
    complexity = calculate_complexity_from_tokens(tokens)
    nesting = calculate_nesting_from_tokens(tokens)

    # Semantic analysis
    responsibilities = identify_responsibilities_from_tokens(tokens)
    dependencies = extract_dependencies_from_tokens(tokens)
    category = categorize_function_from_tokens(func["name"], tokens, responsibilities)
    smells = detect_code_smells_from_metrics(line_count, param_count, nesting, responsibilities)
    
    return Dict(
        "name" => func["name"],
        "location" => "$(func["start_line"])-$(func["end_line"])",
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
            "refactoring_priority" => calculate_refactoring_priority(line_count, complexity, nesting, length(smells))
        )
    )
end

function create_empty_function_analysis(name::String, start_line::Int, end_line::Int)::Dict
    return Dict(
        "name" => name,
        "location" => "$start_line-$end_line",
        "metrics" => Dict("line_count"=>end_line-start_line+1, "parameter_count"=>0, "nesting_depth"=>0, "complexity_score"=>1),
        "semantic" => Dict("category"=>"unknown", "responsibilities"=>[], "dependencies"=>[]),
        "issues" => Dict("code_smells"=>[], "refactoring_priority"=>"LOW")
    )
end

function count_parameters_from_tokens(tokens::Vector{PseudoNode})::Int
    start_paren_idx = findfirst(t -> t.value == "(", tokens)
    if start_paren_idx === nothing return 0 end
    end_paren_idx = findfirst(t -> t.value == ")", tokens[start_paren_idx:end])
    if end_paren_idx === nothing return 0 end
    
    param_tokens = tokens[start_paren_idx : start_paren_idx + end_paren_idx - 1]
    # This is more robust as it just counts identifiers inside the parens
    return count(t -> t.kind == :identifier, param_tokens)
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
            if token.value in starters; current_depth += 1; max_depth = max(max_depth, current_depth); end
            if token.value == "end"; current_depth -= 1; end
        end
    end
    return max_depth
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
        if token.kind == :identifier && token.value in io_keywords; push!(resp, "io_operations"); end
        if token.kind == :identifier && token.value in val_keywords; push!(resp, "validation"); end
        if token.kind == :keyword && token.value in comp_keywords; push!(resp, "computation"); end
        if token.kind == :identifier && token.value in init_keywords; push!(resp, "initialization"); end
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

function detect_code_smells_from_metrics(l,p,n,r)
    smells = Set{String}()
    if l > 50; push!(smells, "long_method"); end
    if p > 5; push!(smells, "many_parameters"); end
    if n > 4; push!(smells, "deep_nesting"); end
    if length(r) > 2; push!(smells, "mixed_abstractions"); end
    return smells
end

calculate_refactoring_priority(l,c,n,s) = (score = (l/30)+c+(n/2)+(s*2)) > 10 ? "HIGH" : score > 5 ? "MEDIUM" : "LOW"

function analyze_module_semantics(module_path::String)::Dict
    println("   🔬 Performing enhanced token-based semantic analysis: $module_path")
    if !isfile(module_path); return Dict("error" => "File not found: $module_path"); end

    source_code = read(module_path, String)
    tokens = tokenize_code(source_code)
    function_groups = group_tokens_by_function(tokens)
    
    analyzed_functions = [analyze_function_from_tokens(f) for f in function_groups]
    
    return Dict(
        "module" => module_path,
        "functions_analyzed" => length(analyzed_functions),
        "function_details" => analyzed_functions,
        "module_smells" => detect_module_smells(analyzed_functions),
        "analysis_timestamp" => now(UTC),
        "analysis_method" => "enhanced_tokenizer"
    )
end

function detect_module_smells(analyses::Vector{Dict})::Vector{String}
    smells = String[]
    if isempty(analyses) return smells end
    
    # Dead Code Detection
    all_names = Set(get.(analyses, "name", ""))
    all_deps = union(get.(get.(get.(analyses, "semantic", Dict()), "dependencies", Set()), "")...)
    dead_code = setdiff(all_names, all_deps)
    # Exclude the entry point from being marked as dead code
    filter!(f -> f != "analyze_module_semantics", dead_code)
    if !isempty(dead_code); push!(smells, "Potential Dead Code: $(join(collect(dead_code), ", "))"); end

    return smells
end

export analyze_module_semantics
