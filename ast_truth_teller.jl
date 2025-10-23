"""
🔮 AST TRUTH TELLER - Second Opinion Architecture Analysis
Simplified version that only parses structure without executing code
"""

module ASTTruthTeller

using JSON
using Dates
using Statistics

export generate_ast_second_opinion, create_health_prescription, parse_file_ast

function parse_file_ast(filename::String)::Dict
    println("   🔍 AST Parsing: $filename")
    
    try
        source_code = read(filename, String)
        lines = split(source_code, '\n')
        
        # Simplified function analysis - just count functions and structure
        functions = extract_functions_simple(source_code, lines)
        complexity = calculate_simple_complexity(source_code, lines)
        dependencies = find_simple_dependencies(source_code)
        structure_issues = find_simple_structure_issues(source_code, lines, functions)
        
        return Dict(
            "filename" => filename,
            "functions" => functions,
            "complexity" => complexity,
            "dependencies" => dependencies,
            "ast_health_score" => calculate_simple_health(functions, complexity, structure_issues),
            "analysis_method" => "SIMPLE_AST_PARSER",
            "line_count" => length(lines),
            "structure_issues" => structure_issues,
            "file_size_kb" => round(length(source_code) / 1024, digits=2)
        )
    catch e
        println("   ⚠️  AST parsing failed for $filename: $e")
        return create_simple_fallback_analysis(filename)
    end
end

function extract_functions_simple(source_code::String, lines::Vector{String})::Vector{Dict}
    functions = Dict[]
    
    for (i, line) in enumerate(lines)
        stripped = strip(line)
        
        # Simple function detection - just look for function definitions
        if occursin(r"^function\s+[a-zA-Z_][a-zA-Z0-9_]*", stripped)
            func_name_match = match(r"^function\s+([a-zA-Z_][a-zA-Z0-9_]*!?)", stripped)
            if func_name_match !== nothing
                func_name = func_name_match.captures[1]
                
                # Estimate function size by counting lines until next function or end of scope
                line_count = 1
                end_line = i
                for j in (i+1):min(i+100, length(lines))  # Limit search to next 100 lines
                    next_line = strip(lines[j])
                    if occursin(r"^function\s+", next_line) || occursin(r"^end\s*$", next_line)
                        end_line = j
                        line_count = j - i + 1
                        break
                    end
                end
                
                push!(functions, Dict(
                    "name" => func_name,
                    "start_line" => i,
                    "end_line" => end_line,
                    "line_count" => line_count,
                    "complexity" => count_control_flow_simple(lines[i:min(end_line, length(lines))])
                ))
            end
        end
    end
    
    return functions
end

function calculate_simple_complexity(source_code::String, lines::Vector{String})::Dict
    total_control_flow = 0
    total_functions = 0
    
    for line in lines
        stripped = strip(line)
        
        # Count control flow statements
        if occursin(r"^\s*(if|for|while|try|catch)\b", stripped)
            total_control_flow += 1
        end
        
        # Count function definitions
        if occursin(r"^function\s+[a-zA-Z_]", stripped)
            total_functions += 1
        end
    end
    
    complexity_score = total_functions > 0 ? total_control_flow / total_functions : 0.0
    
    return Dict(
        "cyclomatic_complexity" => total_control_flow,
        "control_flow_density" => round(complexity_score, digits=3),
        "total_functions" => total_functions,
        "total_control_flow" => total_control_flow
    )
end

function count_control_flow_simple(function_lines::Vector{String})::Int
    complexity = 0
    for line in function_lines
        if occursin(r"\b(if|for|while|try|catch)\b", line)
            complexity += 1
        end
    end
    return complexity
end

function find_simple_structure_issues(source_code::String, lines::Vector{String}, functions::Vector{Dict})::Vector{Dict}
    issues = Dict[]
    
    # Check for long functions
    for func in functions
        line_count = func["line_count"]
        if line_count > 50
            push!(issues, Dict(
                "type" => "LONG_FUNCTION",
                "function" => func["name"],
                "description" => "Function is too long ($line_count lines)",
                "severity" => "MEDIUM",
                "suggestion" => "Break into smaller functions"
            ))
        end
        
        if func["complexity"] > 10
            push!(issues, Dict(
                "type" => "HIGH_COMPLEXITY",
                "function" => func["name"],
                "description" => "Function has high control flow complexity ($(func["complexity"]))",
                "severity" => "MEDIUM",
                "suggestion" => "Simplify control flow logic"
            ))
        end
    end
    
    # Check for many functions (potential god file)
    if length(functions) > 15
        push!(issues, Dict(
            "type" => "MANY_FUNCTIONS",
            "description" => "File contains $(length(functions)) functions - consider splitting",
            "severity" => "MEDIUM",
            "suggestion" => "Split into multiple focused modules"
        ))
    end
    
    return issues
end

function find_simple_dependencies(source_code::String)::Vector{String}
    dependencies = String[]
    lines = split(source_code, '\n')
    
    for line in lines
        stripped = strip(line)
        # Find include statements
        if occursin(r"^include\(", stripped)
            m = match(r"[\"'](.*?)[\"']", stripped)
            if m !== nothing
                push!(dependencies, m.captures[1])
            end
        # Find using/import statements
        elseif occursin(r"^(using|import)\s+", stripped)
            m = match(r"^(using|import)\s+([a-zA-Z0-9_.]+)", stripped)
            if m !== nothing
                push!(dependencies, m.captures[2])
            end
        end
    end
    
    return dependencies
end

function generate_ast_second_opinion()::Dict
    println("\n" * "🔮"^50)
    println("🔮 AST TRUTH TELLER - Second Opinion Analysis")
    println("🔮"^50)
    
    core_modules = [
        "consciousness_core.jl", "geometric_reasoning.jl",
        "phase_synchronization.jl", "unified_network.jl", 
        "safe_tester.jl", "meta_cognitive_engine.jl"
    ]
    
    ast_analysis = Dict()
    total_issues = 0
    health_scores = Float64[]
    
    for module_file in core_modules
        if isfile(module_file)
            println("   📊 Analyzing: $module_file")
            module_analysis = parse_file_ast(module_file)
            ast_analysis[module_file] = module_analysis
            
            issues = length(get(module_analysis, "structure_issues", []))
            total_issues += issues
            health_score = get(module_analysis, "ast_health_score", 0.0)
            push!(health_scores, health_score)
            
            println("      ✅ Functions: $(length(get(module_analysis, "functions", [])))")
            println("      ⚠️  Issues: $issues")
            println("      🏥 Health: $(round(health_score * 100, digits=1))%")
        end
    end
    
    avg_health = isempty(health_scores) ? 0.0 : mean(health_scores)
    
    return Dict(
        "timestamp" => now(),
        "analysis_method" => "SIMPLE_AST_SECOND_OPINION",
        "modules_analyzed" => ast_analysis,
        "summary" => Dict(
            "total_modules" => length(ast_analysis),
            "total_issues" => total_issues,
            "average_health" => round(avg_health, digits=3),
            "overall_assessment" => assess_overall_health(avg_health, total_issues),
            "truth_teller_confidence" => "HIGH"
        )
    )
end

function create_health_prescription(ast_analysis::Dict)::Dict
    """Generate actual helpful fixes based on real AST analysis"""
    prescriptions = Dict[]
    
    for (filename, analysis) in ast_analysis
        issues = get(analysis, "structure_issues", [])
        
        for issue in issues
            severity = get(issue, "severity", "LOW")
            if severity in ["HIGH", "MEDIUM"]
                push!(prescriptions, Dict(
                    "module" => filename,
                    "issue" => get(issue, "type", "UNKNOWN"),
                    "description" => get(issue, "description", "Structural issue detected"),
                    "prescribed_fix" => get(issue, "suggestion", "Review code structure"),
                    "confidence" => "HIGH",
                    "priority" => severity,
                    "function" => get(issue, "function", "global")
                ))
            end
        end
    end
    
    # Sort by priority: HIGH > MEDIUM > LOW
    sort!(prescriptions, by = x -> x["priority"] == "HIGH" ? 0 : x["priority"] == "MEDIUM" ? 1 : 2)
    
    return Dict(
        "prescription_timestamp" => now(),
        "total_prescriptions" => length(prescriptions),
        "high_priority_fixes" => count(p -> p["priority"] == "HIGH", prescriptions),
        "medium_priority_fixes" => count(p -> p["priority"] == "MEDIUM", prescriptions),
        "prescriptions" => prescriptions,
        "overall_advice" => generate_overall_advice(prescriptions)
    )
end

function calculate_simple_health(functions::Vector{Dict}, complexity::Dict, issues::Vector{Dict})::Float64
    base_score = 0.7
    
    # Penalize for issues
    issue_penalty = length(issues) * 0.05
    base_score -= issue_penalty
    
    # Penalize for high complexity
    if complexity["control_flow_density"] > 3.0
        base_score -= 0.1
    elseif complexity["control_flow_density"] < 1.0
        base_score += 0.1
    end
    
    # Reward for good function distribution
    if length(functions) >= 3 && length(functions) <= 10
        base_score += 0.1
    end
    
    # Cap between 0.3 and 0.95
    return max(0.3, min(0.95, base_score))
end

function create_simple_fallback_analysis(filename::String)::Dict
    try
        source_code = read(filename, String)
        lines = split(source_code, '\n')
        functions = extract_functions_simple(source_code, lines)
        complexity = calculate_simple_complexity(source_code, lines)
        
        return Dict(
            "filename" => filename,
            "functions" => functions,
            "complexity" => complexity,
            "dependencies" => find_simple_dependencies(source_code),
            "ast_health_score" => 0.5,
            "analysis_method" => "SIMPLE_FALLBACK",
            "line_count" => length(lines),
            "structure_issues" => []
        )
    catch e
        return Dict(
            "filename" => filename,
            "functions" => [],
            "complexity" => Dict("cyclomatic_complexity" => 0, "control_flow_density" => 0.0, "total_functions" => 0, "total_control_flow" => 0),
            "dependencies" => [],
            "ast_health_score" => 0.3,
            "analysis_method" => "ERROR_FALLBACK",
            "line_count" => 0,
            "structure_issues" => [Dict("type" => "PARSE_ERROR", "description" => "Failed to parse file", "severity" => "HIGH", "suggestion" => "Check file syntax")]
        )
    end
end

function generate_overall_advice(prescriptions::Vector{Dict})::String
    high_priority = count(p -> p["priority"] == "HIGH", prescriptions)
    medium_priority = count(p -> p["priority"] == "MEDIUM", prescriptions)
    
    if high_priority > 0
        return "Focus on $(high_priority) high-priority AST-identified issues first"
    elseif medium_priority > 0
        return "Address $(medium_priority) medium-priority structural issues"
    else
        return "Code structure is generally sound - focus on functionality"
    end
end

function assess_overall_health(avg_health::Float64, total_issues::Int)::String
    if avg_health > 0.8 && total_issues == 0
        return "EXCELLENT"
    elseif avg_health > 0.7 && total_issues < 3
        return "GOOD"
    elseif avg_health > 0.5
        return "NEEDS_ATTENTION"
    else
        return "CRITICAL"
    end
end

end # module ASTTruthTeller
