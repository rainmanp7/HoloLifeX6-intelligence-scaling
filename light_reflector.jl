# light_reflector.jl
"""
🪞 LIGHTWEIGHT SELF-REFLECTION v2
Enhanced with complexity metrics and dependency analysis
"""

using JSON
using Dates

function calculate_complexity_metrics(source_code::String)::Dict{String, Any}
    lines = split(source_code, '\n')
    non_empty_lines = filter(line -> !isempty(strip(line)), lines)
    
    # Basic complexity indicators
    control_flow_count = count(line -> occursin(r"if |for |while |try |catch", line), lines)
    function_count = count(line -> occursin(r"^function", line), lines)
    comment_count = count(line -> occursin(r"^#", line), lines)
    
    complexity_score = control_flow_count / max(1, function_count)
    comment_ratio = comment_count / max(1, length(non_empty_lines))
    
    return Dict(
        "control_flow_density" => round(complexity_score, digits=3),
        "comment_coverage" => round(comment_ratio, digits=3),
        "line_count" => length(non_empty_lines),
        "cyclomatic_indicators" => control_flow_count
    )
end

function analyze_module_dependencies()::Dict{String, Vector{String}}
    dependency_map = Dict{String, Vector{String}}()
    core_modules = [
        "consciousness_core.jl", "geometric_reasoning.jl",
        "phase_synchronization.jl", "unified_network.jl", 
        "safe_tester.jl", "awareness_monitor.jl",
        "proto_intelligence.jl", "insight_generation.jl"
    ]
    
    for module in core_modules
        if isfile(module)
            source = read(module, String)
            dependencies = String[]
            
            # Find include statements
            for line in split(source, '\n')
                if occursin(r"include\(", line)
                    # Extract filename from include statement
                    if occursin(r"\"(.*?)\"", line)
                        match = match(r"\"(.*?)\"", line)
                        push!(dependencies, match.captures[1])
                    end
                end
            end
            dependency_map[module] = dependencies
        end
    end
    return dependency_map
end

function generate_enhanced_ast()::Dict{String, Any}
    println("   🔍 Enhanced architectural scan...")
    
    core_modules = [
        "consciousness_core.jl", "geometric_reasoning.jl",
        "phase_synchronization.jl", "unified_network.jl", 
        "safe_tester.jl"
    ]
    
    enhanced_ast = Dict{String, Any}()
    total_functions = 0
    total_complexity = 0.0
    
    for module_file in core_modules
        if isfile(module_file)
            source_code = read(module_file, String)
            source_lines = split(source_code, '\n')
            
            # Function counting
            func_lines = filter(line -> occursin("function", line), source_lines)
            func_count = length(func_lines)
            total_functions += func_count
            
            # Complexity analysis
            metrics = calculate_complexity_metrics(source_code)
            total_complexity += metrics["control_flow_density"]
            
            enhanced_ast[module_file] = Dict(
                "function_count" => func_count,
                "file_size_kb" => round(length(source_code) / 1024, digits=2),
                "last_modified" => string(mtime(module_file)),
                "complexity_metrics" => metrics
            )
        end
    end
    
    # Dependency analysis
    dependency_map = analyze_module_dependencies()
    
    result = Dict(
        "timestamp" => now(),
        "scan_type" => "enhanced_github_v2",
        "modules_analyzed" => enhanced_ast,
        "dependency_graph" => dependency_map,
        "total_functions" => total_functions,
        "module_count" => length(enhanced_ast),
        "average_complexity" => round(total_complexity / length(enhanced_ast), digits=3),
        "system_cohesion" => calculate_system_cohesion(dependency_map)
    )
    
    return result
end

function calculate_system_cohesion(dependency_map::Dict)::String
    total_deps = sum(length(v) for v in values(dependency_map))
    avg_deps = total_deps / max(1, length(dependency_map))
    
    if avg_deps < 1.0
        return "LOW_COUPLING"
    elseif avg_deps < 3.0
        return "BALANCED" 
    else
        return "HIGH_COUPLING"
    end
end

function analyze_architecture_health_v2(ast_map::Dict)::Dict
    total_funcs = get(ast_map, "total_functions", 0)
    module_count = get(ast_map, "module_count", 0)
    avg_complexity = get(ast_map, "average_complexity", 0.0)
    
    # Enhanced health scoring
    health_factors = []
    
    if module_count >= 5
        push!(health_factors, "MODULAR")
    else
        push!(health_factors, "CONSOLIDATED")
    end
    
    if avg_complexity < 2.0
        push!(health_factors, "LOW_COMPLEXITY")
    elseif avg_complexity < 4.0
        push!(health_factors, "MEDIUM_COMPLEXITY")
    else
        push!(health_factors, "HIGH_COMPLEXITY")
    end
    
    if total_funcs > 30
        push!(health_factors, "MATURE")
    elseif total_funcs > 15
        push!(health_factors, "DEVELOPING")
    else
        push!(health_factors, "EMERGING")
    end
    
    health_score = join(health_factors, "|")
    
    return merge(ast_map, Dict(
        "architecture_health" => health_score,
        "recommendation" => total_funcs > 50 ? "Ready for deep analysis" : "Continue core development",
        "scan_duration_seconds" => "@github_remote"
    ))
end

function save_enhanced_blueprint(ast_summary::Dict, filename::String="enhanced_architecture_scan.json")
    try
        json_data = JSON.json(ast_summary, 2)
        open(filename, "w") do file
            write(file, json_data)
        end
        return true
    catch
        return false
    end
end

# Export enhanced functions
export generate_enhanced_ast, analyze_architecture_health_v2, save_enhanced_blueprint
