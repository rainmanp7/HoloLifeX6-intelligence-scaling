# semantic_analyzer.jl
"""
🎯 SEMANTIC ANALYZER (GitHub-Remote Optimized)
Function-level analysis without external dependencies
"""

using JSON
using Dates

function analyze_module_semantics(module_path::String)::Dict
    println("   🔍 Semantic analysis: $module_path")
    
    if !isfile(module_path)
        return Dict("error" => "File not found: $module_path")
    end

    source_code = read(module_path, String)
    lines = split(source_code, '\n')
    
    functions = extract_functions_pragmatic(source_code, lines)
    analyzed_functions = []
    
    for func in functions
        analysis = analyze_function_pragmatic(func, lines)
        push!(analyzed_functions, analysis)
    end
    
    return Dict(
        "module" => module_path,
        "functions_analyzed" => length(analyzed_functions),
        "function_details" => analyzed_functions,
        "module_smells" => detect_module_smells_pragmatic(analyzed_functions),
        "analysis_timestamp" => now()
    )
end

function extract_functions_pragmatic(source_code::String, lines::Vector{String})::Vector{Dict}
    functions = []
    current_function = nothing
    in_function = false
    brace_balance = 0
    
    for (i, line) in enumerate(lines)
        trimmed = strip(line)
        
        # Function start detection
        if !in_function && occursin(r"^function\s+[a-zA-Z_]", trimmed)
            func_match = match(r"^function\s+([a-zA-Z_][a-zA-Z0-9_!]*)", trimmed)
            func_name = func_match !== nothing ? func_match.captures[1] : "anonymous"
            
            current_function = Dict(
                "name" => func_name,
                "start_line" => i,
                "lines" => [line],
                "end_line" => i
            )
            in_function = true
            brace_balance = count(c -> c == '{', line) - count(c -> c == '}', line)
            
        elseif in_function && current_function !== nothing
            push!(current_function["lines"], line)
            brace_balance += count(c -> c == '{', line) - count(c -> c == '}', line)
            current_function["end_line"] = i
            
            # Function ends when we're back to brace balance and not in a string/comment
            if brace_balance == 0 && !occursin(r"^\s*#", trimmed) && trimmed != ""
                push!(functions, current_function)
                current_function = nothing
                in_function = false
            end
        end
    end
    
    # Handle case where function ends at EOF
    if in_function && current_function !== nothing
        push!(functions, current_function)
    end
    
    return functions
end

function analyze_function_pragmatic(func::Dict, all_lines::Vector{String})::Dict
    func_lines = func["lines"]
    func_text = join(func_lines, '\n')
    
    # Basic metrics
    line_count = length(func_lines)
    param_count = count_parameters_pragmatic(func_lines[1])
    nesting = calculate_nesting_pragmatic(func_lines)
    complexity = calculate_complexity_pragmatic(func_lines)
    
    # Semantic analysis
    responsibilities = identify_responsibilities_pragmatic(func_lines)
    smells = detect_code_smells_pragmatic(line_count, param_count, nesting, responsibilities)
    category = categorize_function_pragmatic(func["name"], func_lines)
    
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
            "responsibilities" => collect(responsibilities)
        ),
        "issues" => Dict(
            "code_smells" => collect(smells),
            "refactoring_priority" => calculate_refactoring_priority_pragmatic(line_count, complexity, nesting, length(smells))
        )
    )
end

function identify_responsibilities_pragmatic(func_lines::Vector{String})::Set{String}
    responsibilities = Set{String}()
    code = lowercase(join(func_lines))
    
    # I/O operations
    if occursin(r"read|write|open|close|print|println|file", code)
        push!(responsibilities, "io_operations")
    end
    
    # Validation
    if occursin(r"if.*==|if.*!=|assert|check|validate", code)
        push!(responsibilities, "validation")
    end
    
    # Computation
    if occursin(r"for|while|map|reduce|filter|sum|mean|calculate|compute", code)
        push!(responsibilities, "computation")
    end
    
    # Initialization
    if occursin(r"new|create|initialize|setup|construct", code)
        push!(responsibilities, "initialization")
    end
    
    return responsibilities
end

function detect_code_smells_pragmatic(line_count, param_count, nesting, responsibilities)::Set{String}
    smells = Set{String}()
    
    if line_count > 50
        push!(smells, "long_method")
    end
    if param_count > 5
        push!(smells, "many_parameters")
    end
    if nesting > 4
        push!(smells, "deep_nesting")
    end
    if length(responsibilities) > 2
        push!(smells, "mixed_abstractions")
    end
    
    return smells
end

function calculate_nesting_pragmatic(func_lines::Vector{String})::Int
    max_nesting = 0
    current_nesting = 0
    
    for line in func_lines
        # Simple nesting detection
        current_nesting += count(c -> c == '(', line) - count(c -> c == ')', line)
        current_nesting += count(c -> c == '{', line) - count(c -> c == '}', line)
        current_nesting = max(0, current_nesting)
        max_nesting = max(max_nesting, current_nesting)
    end
    
    return max_nesting
end

function calculate_complexity_pragmatic(func_lines::Vector{String})::Int
    complexity = 1  # Base complexity
    
    for line in func_lines
        # Count decision points
        if occursin(r"\bif\b|\bfor\b|\bwhile\b|\b&&\b|\b\|\|\b", line)
            complexity += 1
        end
    end
    
    return complexity
end

function count_parameters_pragmatic(first_line::String)::Int
    # Extract parameters from function signature
    if occursin(r"\(.*\)", first_line)
        param_match = match(r"\((.*)\)", first_line)
        if param_match !== nothing
            params = split(param_match.captures[1], ',')
            return length([p for p in params if !isempty(strip(p))])
        end
    end
    return 0
end

function categorize_function_pragmatic(name::String, lines::Vector{String})::String
    code = lowercase(join(lines))
    name_lower = lowercase(name)
    
    if occursin(r"test|check|verify", name_lower)
        return "testing"
    elseif occursin(r"run|execute|process|main", name_lower)
        return "orchestration"
    elseif occursin(r"calculate|compute|measure", name_lower)
        return "calculation"
    elseif occursin(r"init|setup|create", name_lower)
        return "initialization"
    else
        return "utility"
    end
end

function calculate_refactoring_priority_pragmatic(line_count, complexity, nesting, smell_count)
    score = (line_count / 30) + complexity + (nesting / 2) + (smell_count * 2)
    if score > 10
        return "HIGH"
    elseif score > 5
        return "MEDIUM"
    else
        return "LOW"
    end
end

function detect_module_smells_pragmatic(analyses::Vector{Dict})::Vector{String}
    smells = String[]
    
    # Check for long functions
    long_functions = [a["name"] for a in analyses if a["metrics"]["line_count"] > 50]
    if !isempty(long_functions)
        push!(smells, "Long functions: $(join(long_functions, ", "))")
    end
    
    # Check for high complexity
    complex_functions = [a["name"] for a in analyses if a["metrics"]["complexity_score"] > 10]
    if !isempty(complex_functions)
        push!(smells, "Complex functions: $(join(complex_functions, ", "))")
    end
    
    return smells
end

export analyze_module_semantics
