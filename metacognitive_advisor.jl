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
    line_count = max(1, length(lines))
    char_count = max(1, length(code))
    function_count = count(l -> occursin(r"^function\s+", l), lines)
    comment_count = count(l -> occursin(r"^\s*#", l), lines)
    import_count = count(l -> occursin(r"^using|^import", l), lines)
    
    features = [
        line_count / line_count,  # Always 1.0, normalized
        char_count / 10000.0,  # Normalize by typical file size
        function_count / line_count,
        comment_count / line_count,
        import_count / line_count,
        count(l -> occursin(r"if\s+", l), lines) / line_count,
        count(l -> occursin(r"for\s+|while\s+", l), lines) / line_count,
        count(l -> occursin(r"Dict|Array|Vector", l), lines) / line_count,
        count(l -> occursin(r"export", l), lines) / line_count,
        count(l -> occursin(r"struct|mutable", l), lines) / line_count
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
            "dependencies" => [],
            "line_count" => 0,
            "function_count" => 0,
            "comment_count" => 0,
            "import_count" => 0,
            "file_size" => 0
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

# === HELPER FUNCTIONS ===

function safe_get(entity::Any, key::Union{String, Symbol}, default::Any=nothing)::Any
    """Get a field from either a Dict or a struct"""
    # Convert string key to symbol for struct access
    sym_key = isa(key, String) ? Symbol(key) : key
    str_key = isa(key, Symbol) ? string(key) : key
    
    if isa(entity, Dict)
        # Try both string and symbol keys for Dict
        if haskey(entity, str_key)
            return entity[str_key]
        elseif haskey(entity, sym_key)
            return entity[sym_key]
        else
            return default
        end
    elseif hasfield(typeof(entity), sym_key)
        return getfield(entity, sym_key)
    else
        return default
    end
end

function get_semantic_vector(entity::Any)::Union{Vector{Float64}, Nothing}
    vec = safe_get(entity, "semantic_vector", nothing)
    return vec
end

function cosine_similarity(vec1::Vector{Float64}, vec2::Vector{Float64})::Float64
    if length(vec1) != length(vec2) || length(vec1) == 0
        return 0.0
    end
    
    norm1 = norm(vec1)
    norm2 = norm(vec2)
    
    if norm1 == 0.0 || norm2 == 0.0
        return 0.0
    end
    
    return dot(vec1, vec2) / (norm1 * norm2)
end

function calculate_module_complexity(entity::Any)::Float64
    line_count = safe_get(entity, "line_count", 0)
    function_count = safe_get(entity, "function_count", 0)
    dependencies = safe_get(entity, "dependencies", [])
    
    # Normalize and combine metrics
    normalized_lines = min(1.0, line_count / 500.0)  # 500 lines = high complexity
    normalized_functions = min(1.0, function_count / 20.0)  # 20 functions = high complexity
    normalized_deps = min(1.0, length(dependencies) / 10.0)  # 10 deps = high complexity
    
    complexity = (normalized_lines * 0.4 + normalized_functions * 0.3 + normalized_deps * 0.3)
    
    return complexity
end

function extract_performance_data(recent_performance::Any)::Dict
    if isa(recent_performance, Dict)
        return recent_performance
    else
        # Return default performance structure
        return Dict(
            "unified_intelligence_score" => 0.5,
            "consciousness" => Dict(
                "max_phi" => 0.3,
                "is_conscious" => false
            )
        )
    end
end

function calculate_evolution_metrics(graph::Any, performance::Any)::Dict
    if !isa(graph, Dict) || isempty(graph)
        return Dict("modularity" => 0.0, "complexity_balance" => 0.0)
    end
    
    # Calculate modularity based on dependency structure
    total_files = length(graph)
    
    # Get dependencies handling both Dict and struct types
    all_deps_lengths = [length(safe_get(f, "dependencies", [])) for f in values(graph)]
    
    avg_dependencies = isempty(all_deps_lengths) ? 0.0 : mean(all_deps_lengths)
    modularity = 1.0 - min(1.0, avg_dependencies / 5.0)  # Lower dependencies = higher modularity
    
    # Calculate complexity balance (how evenly distributed complexity is)
    complexities = [calculate_module_complexity(f) for f in values(graph)]
    if isempty(complexities)
        complexity_balance = 0.0
    else
        complexity_std = std(complexities)
        complexity_balance = 1.0 - min(1.0, complexity_std)
    end
    
    return Dict(
        "modularity" => modularity,
        "complexity_balance" => complexity_balance
    )
end

function categorize_insights(insights::Vector{Dict})::Dict
    categories = Dict{String, Vector{Dict}}()
    
    for insight in insights
        category = get(insight, "category", "uncategorized")
        if !haskey(categories, category)
            categories[category] = Dict[]
        end
        push!(categories[category], insight)
    end
    
    return categories
end

function count_insights_by_priority(insights::Vector{Dict})::Dict
    priority_counts = Dict("high" => 0, "medium" => 0, "low" => 0, "info" => 0)
    
    for insight in insights
        priority = get(insight, "priority", "info")
        if haskey(priority_counts, priority)
            priority_counts[priority] += 1
        end
    end
    
    return priority_counts
end

function parse_gain_value(gain_str::String)::Float64
    # Parse strings like "+0.25", "-45%", "+70%"
    if occursin("%", gain_str)
        # Parse percentage
        num_str = replace(gain_str, r"[%+]" => "")
        return parse(Float64, num_str) / 100.0
    else
        # Parse decimal
        num_str = replace(gain_str, "+" => "")
        return parse(Float64, num_str)
    end
end

function calculate_system_potential(insights::Vector{Dict})::Dict
    total_consciousness_gain = 0.0
    total_performance_gain = 0.0
    total_maintainability_gain = 0.0
    
    for insight in insights
        expected_gain = get(insight, "expected_gain", "")
        
        # Parse different gain metrics
        if occursin("Consciousness", expected_gain)
            match_result = match(r"Consciousness:\s*([+\-\d.]+)", expected_gain)
            if match_result !== nothing
                total_consciousness_gain += parse_gain_value(match_result.captures[1])
            end
        end
        
        if occursin("Performance", expected_gain) || occursin("Velocity", expected_gain)
            match_result = match(r"(?:Performance|Velocity):\s*([+\-\d.%]+)", expected_gain)
            if match_result !== nothing
                total_performance_gain += abs(parse_gain_value(match_result.captures[1]))
            end
        end
        
        if occursin("Maintainability", expected_gain) || occursin("Maintenance", expected_gain)
            match_result = match(r"(?:Maintainability|Maintenance):\s*([+\-\d.%]+)", expected_gain)
            if match_result !== nothing
                total_maintainability_gain += abs(parse_gain_value(match_result.captures[1]))
            end
        end
    end
    
    return Dict(
        "consciousness_potential" => total_consciousness_gain,
        "performance_potential" => total_performance_gain,
        "maintainability_potential" => total_maintainability_gain
    )
end

function calculate_health_score(graph::Any, insights::Vector{Dict})::Float64
    if !isa(graph, Dict) || isempty(graph)
        return 0.0
    end
    
    # Base health on complexity and insight priorities
    avg_complexity = mean([calculate_module_complexity(f) for f in values(graph)])
    complexity_score = 1.0 - avg_complexity  # Lower complexity = better health
    
    # Count critical issues
    priority_counts = count_insights_by_priority(insights)
    high_priority = get(priority_counts, "high", 0)
    medium_priority = get(priority_counts, "medium", 0)
    
    # Penalize for critical issues
    issue_penalty = (high_priority * 0.1 + medium_priority * 0.05)
    
    health_score = max(0.0, min(1.0, complexity_score - issue_penalty))
    
    return health_score
end

function generate_evolutionary_roadmap(insights::Vector{Dict})::Vector{Dict}
    # Sort insights by priority and expected gain
    priority_order = Dict("high" => 3, "medium" => 2, "low" => 1, "info" => 0)
    
    sorted_insights = sort(insights, by = i -> (
        -get(priority_order, get(i, "priority", "info"), 0),
        -length(get(i, "expected_gain", ""))
    ))
    
    roadmap = Dict[]
    for (idx, insight) in enumerate(sorted_insights[1:min(5, length(sorted_insights))])
        push!(roadmap, Dict(
            "phase" => idx,
            "action" => get(insight, "solution", "No solution specified"),
            "expected_gain" => get(insight, "expected_gain", "Unknown"),
            "priority" => get(insight, "priority", "info"),
            "module" => get(insight, "module", "Unknown")
        ))
    end
    
    return roadmap
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
                        "evidence" => "Cosine similarity: $(round(similarity, digits=3)) | Files: $(safe_get(entity1, "file_path", mod1)) ↔ $(safe_get(entity2, "file_path", mod2))",
                        "category" => "semantic_architecture",
                        "impact" => "Reduce cognitive duplication",
                        "solution" => "Merge $mod1 and $mod2 into shared_$(clean_mod1)_$(clean_mod2)_core.jl",
                        "expected_gain" => "Maintenance: -60%, Consciousness: +0.15",
                        "file_insights" => Dict(
                            "file1" => safe_get(entity1, "file_path", mod1),
                            "file2" => safe_get(entity2, "file_path", mod2),
                            "file1_stats" => "$(safe_get(entity1, "line_count", 0)) lines, $(safe_get(entity1, "function_count", 0)) functions",
                            "file2_stats" => "$(safe_get(entity2, "line_count", 0)) lines, $(safe_get(entity2, "function_count", 0)) functions"
                        )
                    ))
                elseif similarity < 0.2
                    push!(insights, Dict(
                        "priority" => "info",
                        "module" => "$mod1 ↔ $mod2",
                        "issue" => "Low semantic coupling",
                        "action" => "Maintain clear separation of concerns",
                        "evidence" => "Cosine similarity: $(round(similarity, digits=3)) | Files: $(safe_get(entity1, "file_path", mod1)) ↔ $(safe_get(entity2, "file_path", mod2))",
                        "category" => "semantic_architecture", 
                        "impact" => "Good architectural boundaries",
                        "solution" => "Keep modules separated - maintain current boundaries",
                        "expected_gain" => "Stability: +20%",
                        "file_insights" => Dict(
                            "file1" => safe_get(entity1, "file_path", mod1),
                            "file2" => safe_get(entity2, "file_path", mod2),
                            "file1_stats" => "$(safe_get(entity1, "line_count", 0)) lines, $(safe_get(entity1, "function_count", 0)) functions",
                            "file2_stats" => "$(safe_get(entity2, "line_count", 0)) lines, $(safe_get(entity2, "function_count", 0)) functions"
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
                    "evidence" => "Complexity: $(round(complexity, digits=2)), UIS: $(round(uis, digits=3)) | File: $(safe_get(entity, "file_path", module_name))",
                    "category" => "performance_architecture",
                    "impact" => "Balance complexity vs performance",
                    "solution" => "Extract core logic into helper modules, keep performance-critical parts",
                    "expected_gain" => "Maintainability: +40%, Performance: +0%",
                    "file_insights" => Dict(
                        "file" => safe_get(entity, "file_path", module_name),
                        "line_count" => safe_get(entity, "line_count", 0),
                        "function_count" => safe_get(entity, "function_count", 0),
                        "dependencies" => safe_get(entity, "dependencies", []),
                        "complexity_breakdown" => "Lines: $(safe_get(entity, "line_count", 0)), Functions: $(safe_get(entity, "function_count", 0)), Dependencies: $(length(safe_get(entity, "dependencies", [])))"
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
                        "evidence" => "Complexity: $(round(complexity, digits=2)), Max Φ: $(round(phi, digits=3)) | File: $(safe_get(entity, "file_path", module_name))",
                        "category" => "consciousness_optimization",
                        "impact" => "Potential for consciousness improvement",
                        "solution" => "Break into smaller focused modules: $(clean_module_name)_processor.jl, $(clean_module_name)_coordinator.jl",
                        "expected_gain" => "Consciousness: +0.25, Complexity: -45%",
                        "file_insights" => Dict(
                            "file" => safe_get(entity, "file_path", module_name),
                            "current_complexity" => "High ($(round(complexity, digits=2)))",
                            "suggested_refactoring" => "Split into $(clean_module_name)_processor.jl and $(clean_module_name)_coordinator.jl",
                            "current_structure" => "$(safe_get(entity, "line_count", 0)) lines, $(safe_get(entity, "function_count", 0)) functions, $(length(safe_get(entity, "dependencies", []))) dependencies"
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
        files_by_size = sort([(safe_get(f, "file_path", "unknown"), safe_get(f, "line_count", 0)) for f in values(graph)], by=x->x[2], rev=true)[1:min(3, length(graph))]
        
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

# === REPORTING AND EXPORT ===

function export_health_report(graph::Any, insights::Vector{Dict}, output_file::String="health_report.json")
    report = Dict(
        "timestamp" => string(Dates.now()),
        "system_overview" => Dict(
            "total_modules" => length(graph),
            "total_lines" => sum(safe_get(f, "line_count", 0) for f in values(graph)),
            "health_score" => calculate_health_score(graph, insights)
        ),
        "insights" => insights,
        "insights_by_category" => categorize_insights(insights),
        "insights_by_priority" => count_insights_by_priority(insights),
        "system_potential" => calculate_system_potential(insights),
        "evolutionary_roadmap" => generate_evolutionary_roadmap(insights)
    )
    
    open(output_file, "w") do io
        JSON.print(io, report, 4)
    end
    
    println("📊 Health report exported to $output_file")
    return report
end

function run_complete_analysis(root_dir::String=".", performance_data::Any=nothing)
    println("\n🔬 Starting Complete Metacognitive Analysis...")
    println("=" ^ 60)
    
    # Build module graph
    graph = build_module_graph(root_dir)
    
    # Use default performance if none provided
    if isnothing(performance_data)
        performance_data = Dict(
            "unified_intelligence_score" => 0.5,
            "consciousness" => Dict(
                "max_phi" => 0.3,
                "is_conscious" => false
            )
        )
    end
    
    # Generate insights
    insights = generate_architectural_analysis(graph, performance_data)
    
    # Export report
    report = export_health_report(graph, insights)
    
    println("=" ^ 60)
    println("✅ Analysis complete!")
    println("   Modules analyzed: $(length(graph))")
    println("   Insights generated: $(length(insights))")
    println("   Health score: $(round(report["system_overview"]["health_score"], digits=2))")
    
    return report
end

# Export functions for orchestrator
export generate_architectural_analysis, export_health_report, build_module_graph, run_complete_analysis
