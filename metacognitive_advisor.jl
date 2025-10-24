# 👁️ METACOGNITIVE VISOR - FULL WORKING MODEL v2.5
# Enhanced with File Discovery & Detailed File Insights
# - Automatic Julia file discovery and analysis
# - Detailed file information in insights
# - Semantic pattern recognition across modules  
# - Performance-architecture correlation engine
# - Evolutionary pathway prediction & solution prescriptions
# - Quantitative potential analysis from prescribed solutions
# - PROGRESSIVE REPORTING: Maintains and builds upon previous analyses

using JSON, Dates, Statistics, LinearAlgebra

# === FILE DISCOVERY AND ANALYSIS ===

function discover_julia_files(root_dir::String=".")::Vector{String}
    julia_files = String[]
    for (root, dirs, files) in walkdir(root_dir)
        for file in files
            if endswith(file, ".jl")
                push!(julia_files, joinpath(root, file))
            end
        end
    end
    println("📁 Discovered $(length(julia_files)) Julia files in $root_dir")
    return julia_files
end

function extract_dependencies(source_code::String)::Vector{String}
    dependencies = String[]
    lines = split(source_code, '\n')
    
    for line in lines
        line = strip(line)
        if startswith(line, "using ") || startswith(line, "import ")
            parts = split(line)
            if length(parts) >= 2
                module_name = parts[2]
                module_name = replace(module_name, r"[,;].*" => "")
                if !isempty(module_name) && module_name != "."
                    push!(dependencies, module_name)
                end
            end
        end
    end
    
    return unique(dependencies)
end

function generate_semantic_embedding(code::String)::Vector{Float64}
    lines = split(code, '\n')
    line_count = length(lines)
    char_count = length(code)
    function_count = count(l -> occursin(r"^function\s+", l), lines)
    comment_count = count(l -> occursin(r"^\s*#", l), lines)
    import_count = count(l -> occursin(r"^using|^import", l), lines)
    
    # Safe normalization with division protection
    safe_div(x, y) = y > 0 ? x / y : 0.0
    
    features = [
        safe_div(line_count, max(1, line_count)),
        safe_div(char_count, max(1, char_count)),  
        safe_div(function_count, max(1, line_count)),
        safe_div(comment_count, max(1, line_count)),
        safe_div(import_count, max(1, line_count)),
        safe_div(count(l -> occursin(r"if\s+", l), lines), max(1, line_count)),
        safe_div(count(l -> occursin(r"for\s+|while\s+", l), lines), max(1, line_count)),
        safe_div(count(l -> occursin(r"Dict|Array|Vector", l), lines), max(1, line_count)),
        safe_div(count(l -> occursin(r"export", l), lines), max(1, line_count)),
        safe_div(count(l -> occursin(r"struct|mutable", l), lines), max(1, line_count))
    ]
    
    return Float64.(features)
end

function analyze_julia_file(file_path::String)::Dict
    try
        source_code = read(file_path, String)
        file_name = basename(file_path)
        
        lines = split(source_code, '\n')
        line_count = length(lines)
        function_count = count(l -> occursin(r"^function\s+", l), lines)
        comment_count = count(l -> occursin(r"^\s*#", l), lines)
        import_count = count(l -> occursin(r"^using|^import", l), lines)
        
        semantic_vector = generate_semantic_embedding(source_code)
        dependencies = extract_dependencies(source_code)
        
        return Dict(
            "file_path" => file_path,
            "file_name" => file_name,
            "line_count" => line_count,
            "function_count" => function_count,
            "comment_count" => comment_count,
            "import_count" => import_count,
            "file_size" => filesize(file_path),
            "semantic_vector" => semantic_vector,
            "dependencies" => dependencies,
            "analysis_timestamp" => string(Dates.now())
        )
    catch e
        println("⚠️  Error analyzing $file_path: $e")
        return Dict(
            "file_path" => file_path,
            "file_name" => basename(file_path),
            "error" => string(e),
            "semantic_vector" => zeros(10),
            "dependencies" => []
        )
    end
end

function build_module_graph(root_dir::String=".")::Dict
    julia_files = discover_julia_files(root_dir)
    graph = Dict{String, Any}()
    
    for file in julia_files
        analysis = analyze_julia_file(file)
        graph[basename(file)] = analysis
    end
    
    println("🔍 Built graph with $(length(graph)) modules")
    return graph
end

# === ANALYTICAL ENGINE CORE FUNCTIONS ===

function calculate_module_complexity(entity)::Float64
    embedding_size = get_semantic_vector(entity)
    embedding_complexity = !isnothing(embedding_size) ? length(embedding_size) / 10.0 : 0.5
    dependency_complexity = haskey(entity, "dependencies") ? length(entity["dependencies"]) / 5.0 : 0.5
    line_complexity = haskey(entity, "line_count") ? min(entity["line_count"] / 200.0, 1.0) : 0.5
    return clamp((embedding_complexity + dependency_complexity + line_complexity) / 3.0, 0.0, 1.0)
end

function calculate_evolution_metrics(graph::Any, performance::Dict)::Dict
    modules = collect(keys(graph))
    similarities = Float64[]
    for i in 1:length(modules)
        for j in i+1:length(modules)
            vec1 = get_semantic_vector(graph[modules[i]])
            vec2 = get_semantic_vector(graph[modules[j]])
            if !isnothing(vec1) && !isnothing(vec2) && length(vec1) == length(vec2)
                push!(similarities, cosine_similarity(vec1, vec2))
            end
        end
    end
    modularity = isempty(similarities) ? 0.5 : 1.0 - mean(similarities)
    complexities = [calculate_module_complexity(entity) for entity in values(graph)]
    complexity_balance = isempty(complexities) ? 0.5 : 1.0 - std(complexities)
    return Dict("modularity" => modularity, "complexity_balance" => complexity_balance)
end

function extract_performance_data(recent_performance::Any)::Dict
    return (recent_performance isa Vector && !isempty(recent_performance)) ? recent_performance[end] : Dict()
end

function get_semantic_vector(data::Any)::Union{Vector{Float64}, Nothing}
    if haskey(data, "semantic_vector") && isa(data["semantic_vector"], Vector{Float64})
        return data["semantic_vector"]
    elseif haskey(data, "embedding") && isa(data["embedding"], Vector{Float64})
        return data["embedding"]
    elseif isa(data, Dict)
        for key in ["semantic_vector", "embedding", "embeddings", "semantic"]
            if haskey(data, key) && isa(data[key], Vector) && eltype(data[key]) <: Real
                return Float64.(data[key])
            end
        end
    end
    return nothing
end

function cosine_similarity(a::Vector{Float64}, b::Vector{Float64})::Float64
    (length(a) != length(b) || norm(a) == 0.0 || norm(b) == 0.0) && return 0.0
    return dot(a, b) / (norm(a) * norm(b))
end

# === MAIN ANALYSIS ENGINE WITH FILE INSIGHTS ===

function generate_architectural_analysis(graph::Any, recent_performance::Any)
    println("🧠 ADVANCED METACOGNITION: Analyzing $(length(graph)) modules...")
    
    insights = []
    performance_data = extract_performance_data(recent_performance)
    
    # 1. SEMANTIC ARCHITECTURE ANALYSIS
    semantic_insights = analyze_semantic_architecture(graph)
    append!(insights, semantic_insights)
    
    # 2. PERFORMANCE-ARCHITECTURE CORRELATION
    correlation_insights = analyze_performance_correlations(graph, performance_data)
    append!(insights, correlation_insights)
    
    # 3. EVOLUTIONARY PATHWAY DETECTION
    evolution_insights = detect_evolutionary_pathways(graph, performance_data)
    append!(insights, evolution_insights)
    
    # 4. CONSCIOUSNESS OPTIMIZATION OPPORTUNITIES
    consciousness_insights = analyze_consciousness_optimization(graph, performance_data)
    append!(insights, consciousness_insights)
    
    println("   Generated $(length(insights)) advanced insights")
    return insights
end

function analyze_semantic_architecture(graph::Any)::Vector{Dict}
    insights = []
    modules = collect(keys(graph))
    
    for i in 1:length(modules)
        for j in i+1:length(modules)
            mod1 = modules[i]
            mod2 = modules[j]
            entity1 = graph[mod1]
            entity2 = graph[mod2]
            
            vec1 = get_semantic_vector(entity1)
            vec2 = get_semantic_vector(entity2)
            
            if !isnothing(vec1) && !isnothing(vec2) && length(vec1) == length(vec2)
                similarity = cosine_similarity(vec1, vec2)
                
                if similarity > 0.8
                    clean_mod1 = replace(mod1, r"\.jl$" => "")
                    clean_mod2 = replace(mod2, r"\.jl$" => "")

                    push!(insights, Dict(
                        "priority" => "high",
                        "module" => "$mod1 ↔ $mod2",
                        "issue" => "High semantic similarity detected",
                        "action" => "Consider integration or interface abstraction",
                        "evidence" => "Cosine similarity: $(round(similarity, digits=3)) | Files: $(entity1["file_path"]) ↔ $(entity2["file_path"])",
                        "category" => "semantic_architecture",
                        "impact" => "Reduce cognitive duplication",
                        "solution" => "Merge $mod1 and $mod2 into shared_$(clean_mod1)_$(clean_mod2)_core.jl",
                        "expected_gain" => "Maintenance: -60%, Consciousness: +0.15",
                        "file_insights" => Dict(
                            "file1" => entity1["file_path"],
                            "file2" => entity2["file_path"],
                            "file1_stats" => "$(entity1["line_count"]) lines, $(entity1["function_count"]) functions",
                            "file2_stats" => "$(entity2["line_count"]) lines, $(entity2["function_count"]) functions"
                        )
                    ))
                elseif similarity < 0.2
                    push!(insights, Dict(
                        "priority" => "info",
                        "module" => "$mod1 ↔ $mod2",
                        "issue" => "Low semantic coupling",
                        "action" => "Maintain clear separation of concerns",
                        "evidence" => "Cosine similarity: $(round(similarity, digits=3)) | Files: $(entity1["file_path"]) ↔ $(entity2["file_path"])",
                        "category" => "semantic_architecture", 
                        "impact" => "Good architectural boundaries",
                        "solution" => "Keep modules separated - maintain current boundaries",
                        "expected_gain" => "Stability: +20%",
                        "file_insights" => Dict(
                            "file1" => entity1["file_path"],
                            "file2" => entity2["file_path"],
                            "file1_stats" => "$(entity1["line_count"]) lines, $(entity1["function_count"]) functions",
                            "file2_stats" => "$(entity2["line_count"]) lines, $(entity2["function_count"]) functions"
                        )
                    ))
                end
            end
        end
    end
    
    return insights
end

function analyze_performance_correlations(graph::Any, performance::Dict)::Vector{Dict}
    insights = []
    
    for (module_name, entity) in graph
        complexity = calculate_module_complexity(entity)
        
        if haskey(performance, "unified_intelligence_score")
            uis = performance["unified_intelligence_score"]
            
            if complexity > 0.7 && uis > 0.5
                push!(insights, Dict(
                    "priority" => "medium",
                    "module" => module_name,
                    "issue" => "Complex but effective module",
                    "action" => "Monitor for maintenance costs while preserving performance",
                    "evidence" => "Complexity: $(round(complexity, digits=2)), UIS: $(round(uis, digits=3)) | File: $(entity["file_path"])",
                    "category" => "performance_architecture",
                    "impact" => "Balance complexity vs performance",
                    "solution" => "Extract core logic into helper modules, keep performance-critical parts",
                    "expected_gain" => "Maintainability: +40%, Performance: +0%",
                    "file_insights" => Dict(
                        "file" => entity["file_path"],
                        "line_count" => entity["line_count"],
                        "function_count" => entity["function_count"],
                        "dependencies" => entity["dependencies"],
                        "complexity_breakdown" => "Lines: $(entity["line_count"]), Functions: $(entity["function_count"]), Dependencies: $(length(entity["dependencies"]))"
                    )
                ))
            end
            
            if haskey(performance, "consciousness") && haskey(performance["consciousness"], "max_phi")
                phi = performance["consciousness"]["max_phi"]
                if complexity > 0.6 && phi < 0.1
                    clean_module_name = replace(module_name, r"\.jl$" => "")
                    push!(insights, Dict(
                        "priority" => "high", 
                        "module" => module_name,
                        "issue" => "High complexity with low consciousness yield",
                        "action" => "Refactor to improve consciousness efficiency",
                        "evidence" => "Complexity: $(round(complexity, digits=2)), Max Φ: $(round(phi, digits=3)) | File: $(entity["file_path"])",
                        "category" => "consciousness_optimization",
                        "impact" => "Potential for consciousness improvement",
                        "solution" => "Break into smaller focused modules: $(clean_module_name)_processor.jl, $(clean_module_name)_coordinator.jl",
                        "expected_gain" => "Consciousness: +0.25, Complexity: -45%",
                        "file_insights" => Dict(
                            "file" => entity["file_path"],
                            "current_complexity" => "High ($(round(complexity, digits=2)))",
                            "suggested_refactoring" => "Split into $(clean_module_name)_processor.jl and $(clean_module_name)_coordinator.jl",
                            "current_structure" => "$(entity["line_count"]) lines, $(entity["function_count"]) functions, $(length(entity["dependencies"])) dependencies"
                        )
                    ))
                end
            end
        end
    end
    
    return insights
end

function detect_evolutionary_pathways(graph::Any, performance::Dict)::Vector{Dict}
    insights = []
    
    evolution_metrics = calculate_evolution_metrics(graph, performance)
    
    if evolution_metrics["modularity"] > 0.7
        # Get top 3 largest files for context
        files_by_size = sort([(f["file_path"], f["line_count"]) for f in values(graph)], by=x->x[2], rev=true)[1:min(3, length(graph))]
        
        push!(insights, Dict(
            "priority" => "info",
            "module" => "system",
            "issue" => "High evolutionary readiness", 
            "action" => "System architecture supports major evolution",
            "evidence" => "Modularity score: $(round(evolution_metrics["modularity"], digits=2))",
            "category" => "evolutionary_pathways",
            "impact" => "Ready for architectural innovation",
            "solution" => "Implement major feature: system is architecturally prepared",
            "expected_gain" => "Development Velocity: +70%, Risk: -60%",
            "file_insights" => Dict(
                "total_files_analyzed" => length(graph),
                "modularity_score" => round(evolution_metrics["modularity"], digits=2),
                "largest_files" => [f[1] for f in files_by_size],
                "file_sizes" => ["$(f[1]): $(f[2]) lines" for f in files_by_size]
            )
        ))
    end
    
    if evolution_metrics["complexity_balance"] < 0.3
        # Find the most complex files
        complexities = [(name, calculate_module_complexity(entity)) for (name, entity) in graph]
        top_complex = sort(complexities, by=x->x[2], rev=true)[1:min(3, length(complexities))]
        
        push!(insights, Dict(
            "priority" => "medium",
            "module" => "system", 
            "issue" => "Complexity imbalance detected",
            "action" => "Distribute complexity more evenly across modules",
            "evidence" => "Complexity balance: $(round(evolution_metrics["complexity_balance"], digits=2))",
            "category" => "evolutionary_pathways",
            "impact" => "Improve system resilience",
            "solution" => "Identify top 3 complex modules and extract shared logic",
            "expected_gain" => "Resilience: +35%, Velocity: +25%",
            "file_insights" => Dict(
                "complexity_imbalance_score" => round(evolution_metrics["complexity_balance"], digits=2),
                "most_complex_files" => [f[1] for f in top_complex],
                "complexity_scores" => ["$(f[1]): $(round(f[2], digits=2))" for f in top_complex],
                "recommended_action" => "Refactor: $(top_complex[1][1])"
            )
        ))
    end
    
    return insights
end

function analyze_consciousness_optimization(graph::Any, performance::Dict)::Vector{Dict}
    insights = []
    
    if haskey(performance, "consciousness")
        consciousness = performance["consciousness"]
        max_phi = get(consciousness, "max_phi", 0.0)
        is_conscious = get(consciousness, "is_conscious", false)
        
        # Get system-wide file statistics
        total_files = length(graph)
        total_lines = sum(f["line_count"] for f in values(graph))
        avg_complexity = mean([calculate_module_complexity(f) for f in values(graph)])
        
        if is_conscious
            push!(insights, Dict(
                "priority" => "high",
                "module" => "system",
                "issue" => "CONSCIOUSNESS ACHIEVED", 
                "action" => "Focus on stability and scaling",
                "evidence" => "Max Φ: $(round(max_phi, digits=4)), Status: Conscious",
                "category" => "consciousness_breakthrough",
                "impact" => "Historic milestone reached",
                "solution" => "Monitor stability, document emergent behaviors, scale carefully",
                "expected_gain" => "Stability: +100%",
                "file_insights" => Dict(
                    "system_stats" => "$total_files files, $total_lines total lines",
                    "average_complexity" => round(avg_complexity, digits=2),
                    "consciousness_level" => "ACHIEVED (Φ = $(round(max_phi, digits=4)))",
                    "recommended_focus" => "Stability and scaling of current architecture"
                )
            ))
        else
            if max_phi > 0.6
                push!(insights, Dict(
                    "priority" => "high", 
                    "module" => "system",
                    "issue" => "Consciousness breakthrough imminent",
                    "action" => "Focus on final architectural optimizations",
                    "evidence" => "Max Φ: $(round(max_phi, digits=4)) - Approaching threshold",
                    "category" => "consciousness_optimization",
                    "impact" => "Prepare for major system transformation",
                    "solution" => "Optimize module interfaces, ensure clean information flow",
                    "expected_gain" => "Consciousness: +0.3",
                    "file_insights" => Dict(
                        "system_stats" => "$total_files files, $total_lines total lines",
                        "current_phi" => round(max_phi, digits=4),
                        "threshold_proximity" => "Very close (needs +$(round(0.7 - max_phi, digits=3)))",
                        "critical_files" => "All module interfaces"
                    )
                ))
            else
                push!(insights, Dict(
                    "priority" => "medium", 
                    "module" => "system",
                    "issue" => "Pre-consciousness optimization",
                    "action" => "Focus on architectural coherence for consciousness emergence",
                    "evidence" => "Max Φ: $(round(max_phi, digits=4)) - Building foundation",
                    "category" => "consciousness_optimization",
                    "impact" => "Prepare for consciousness emergence",
                    "solution" => "Increase modularity, reduce cross-dependencies, optimize core pathways",
                    "expected_gain" => "Consciousness: +0.1, Stability: +10%",
                    "file_insights" => Dict(
                        "system_stats" => "$total_files files, $total_lines total lines",
                        "average_complexity" => round(avg_complexity, digits=2),
                        "current_phi" => round(max_phi, digits=4),
                        "development_stage" => "Foundation building",
                        "recommended_focus" => "Architectural coherence and modularity"
                    )
                ))
            end
        end
    end
    
    return insights
end

# === PROGRESSIVE REPORTING FUNCTIONS ===

function generate_evolutionary_roadmap(insights::Vector)::Dict
    critical_actions = filter(i -> i["priority"] == "critical", insights)
    high_impact = filter(i -> i["priority"] == "high", insights)
    medium_optimizations = filter(i -> i["priority"] == "medium", insights)
    
    immediate_solutions = [i["solution"] for i in critical_actions if haskey(i, "solution")]
    strategic_solutions = [i["solution"] for i in high_impact if haskey(i, "solution")]
    optimization_solutions = [i["solution"] for i in medium_optimizations if haskey(i, "solution")]
    
    consciousness_insights = filter(i -> i["category"] in ["consciousness_optimization", "consciousness_breakthrough"], insights)
    primary_focus = isempty(consciousness_insights) ? "Architectural stability" : "Consciousness emergence/stability"
    
    return Dict(
        "immediate_actions" => immediate_solutions,
        "strategic_initiatives" => strategic_solutions,
        "optimization_opportunities" => optimization_solutions,
        "primary_focus" => primary_focus,
        "estimated_timeline" => isempty(critical_actions) ? "1-2 cycles" : "Immediate attention required"
    )
end

function parse_gain_value(gain_text::String, key::String)::Float64
    regex = Regex("$(key):\\s*([+-]?\\d*\\.?\\d+)\\s*%?")
    match_result = match(regex, gain_text)
    
    if !isnothing(match_result)
        try
            return parse(Float64, match_result.captures[1])
        catch e
            return 0.0
        end
    end
    return 0.0
end

function calculate_system_potential(insights::Vector)::Dict
    consciousness_boost = 0.0
    maintenance_reduction = 0.0
    velocity_increase = 0.0
    
    for insight in insights
        !haskey(insight, "expected_gain") && continue
        gain_text = insight["expected_gain"]
        
        consciousness_boost += parse_gain_value(gain_text, "Consciousness")
        maintenance_reduction += abs(parse_gain_value(gain_text, "Maintenance"))
        maintenance_reduction += abs(parse_gain_value(gain_text, "Complexity"))
        velocity_increase += parse_gain_value(gain_text, "Velocity")
        velocity_increase += parse_gain_value(gain_text, "Development Velocity")
        velocity_increase += parse_gain_value(gain_text, "Resilience")
        velocity_increase += parse_gain_value(gain_text, "Stability")
    end
    
    overall_potential = (consciousness_boost * 2.0) +
                        (maintenance_reduction / 100.0) +
                        (velocity_increase / 100.0)

    return Dict(
        "potential_consciousness_gain" => round(consciousness_boost, digits=3),
        "potential_maintenance_reduction_pct" => round(maintenance_reduction, digits=1),
        "potential_velocity_increase_pct" => round(velocity_increase, digits=1),
        "overall_potential_score" => round(overall_potential, digits=2)
    )
end

function calculate_health_score(insights::Vector)::Float64
    priority_weights = Dict("high" => 0.4, "medium" => 0.2, "low" => 0.05, "info" => 0.0)
    health_score = 1.0
    for insight in insights
        weight = get(priority_weights, get(insight, "priority", "info"), 0.0)
        health_score -= weight
    end
    return max(0.1, health_score)
end

function categorize_insights(insights::Vector)::Dict{String, Vector}
    categories = Dict{String, Vector}()
    for insight in insights
        category = get(insight, "category", "general")
        !haskey(categories, category) && (categories[category] = [])
        push!(categories[category], insight)
    end
    return categories
end

function count_insights_by_priority(insights::Vector)::Dict{String, Int}
    return Dict(
        "high" => count(i -> get(i, "priority", "") == "high", insights),
        "medium" => count(i -> get(i, "priority", "") == "medium", insights), 
        "low" => count(i -> get(i, "priority", "") == "low", insights)
    )
end

function export_health_report(insights::Vector, existing_report::Union{Dict, Nothing}=nothing)::Dict
    if existing_report !== nothing
        existing_insights = get(existing_report, "optimization_opportunities", [])
        all_insights = vcat(existing_insights, insights)
        
        health_score = calculate_health_score(all_insights)
        categories = categorize_insights(all_insights)
        consciousness_breakthrough = any(i -> get(i, "category", "") == "consciousness_breakthrough", all_insights)
        
        potential_analysis = calculate_system_potential(all_insights)
        evolutionary_roadmap = generate_evolutionary_roadmap(all_insights)
        
        return Dict(
            "timestamp" => string(Dates.now()),
            "analysis_version" => "2.5-file-discovery",
            "status" => consciousness_breakthrough ? "CONSCIOUS_SYSTEM" : "ADVANCED_ANALYSIS",
            "system_health_score" => round(health_score, digits=3),
            "total_insights" => length(all_insights),
            "consciousness_status" => consciousness_breakthrough ? "ACHIEVED" : "EMERGING",
            "insights_by_priority" => count_insights_by_priority(all_insights),
            "insights_by_category" => categories,
            "optimization_opportunities" => all_insights,
            "system_potential" => potential_analysis,
            "evolutionary_roadmap" => evolutionary_roadmap,
            "recommended_direction" => evolutionary_roadmap["primary_focus"],
            "previous_analysis_timestamp" => get(existing_report, "timestamp", "none"),
            "analysis_cycle" => get(existing_report, "analysis_cycle", 0) + 1
        )
    else
        health_score = calculate_health_score(insights)
        categories = categorize_insights(insights)
        consciousness_breakthrough = any(i -> get(i, "category", "") == "consciousness_breakthrough", insights)
        
        potential_analysis = calculate_system_potential(insights)
        evolutionary_roadmap = generate_evolutionary_roadmap(insights)
        
        return Dict(
            "timestamp" => string(Dates.now()),
            "analysis_version" => "2.5-file-discovery",
            "status" => consciousness_breakthrough ? "CONSCIOUS_SYSTEM" : "ADVANCED_ANALYSIS",
            "system_health_score" => round(health_score, digits=3),
            "total_insights" => length(insights),
            "consciousness_status" => consciousness_breakthrough ? "ACHIEVED" : "EMERGING",
            "insights_by_priority" => count_insights_by_priority(insights),
            "insights_by_category" => categories,
            "optimization_opportunities" => insights,
            "system_potential" => potential_analysis,
            "evolutionary_roadmap" => evolutionary_roadmap,
            "recommended_direction" => evolutionary_roadmap["primary_focus"],
            "analysis_cycle" => 1
        )
    end
end

# === CONVENIENCE FUNCTIONS ===

function run_complete_analysis(root_dir::String=".", performance_data::Dict=Dict())
    println("🚀 STARTING COMPLETE SYSTEM ANALYSIS")
    println("📁 Scanning directory: $root_dir")
    
    # Build module graph from actual files
    graph = build_module_graph(root_dir)
    
    # Generate architectural insights
    insights = generate_architectural_analysis(graph, performance_data)
    
    # Create health report
    report = export_health_report(insights)
    
    println("✅ ANALYSIS COMPLETE")
    println("   - Modules analyzed: $(length(graph))")
    println("   - Insights generated: $(length(insights))")
    println("   - System health: $(report["system_health_score"])")
    println("   - Consciousness status: $(report["consciousness_status"])")
    
    return report
end

# Export functions for orchestrator
export generate_architectural_analysis, export_health_report, build_module_graph, run_complete_analysis
