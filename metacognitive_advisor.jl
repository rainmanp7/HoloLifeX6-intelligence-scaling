# 👁️ METACOGNITIVE VISOR - CORRECTED WITH DICT SUPPORT
# Fixed missing Dict handling and structural issues

using JSON, Dates, Statistics, LinearAlgebra

function generate_architectural_analysis(graph::Any, recent_performance::Any)
    println("🧠 OPTIMIZED METACOGNITION: Analyzing $(length(graph)) modules...")
    
    insights = []
    performance_data = extract_performance_data(recent_performance)
    
    # 1. CONSCIOUSNESS OPTIMIZATION
    consciousness_insights = analyze_consciousness_optimization(graph, performance_data)
    append!(insights, consciousness_insights)
    
    # 2. EVOLUTIONARY PATHWAY DETECTION 
    evolution_insights = detect_evolutionary_pathways(graph, performance_data)
    append!(insights, evolution_insights)
    
    # 3. SEMANTIC ARCHITECTURE ANALYSIS
    semantic_insights = analyze_semantic_architecture(graph)
    append!(insights, semantic_insights)
    
    # 4. PERFORMANCE CORRELATIONS
    correlation_insights = analyze_performance_correlations(graph, performance_data)
    append!(insights, correlation_insights)
    
    println("   Generated $(length(insights)) focused insights")
    return insights
end

function analyze_consciousness_optimization(graph::Any, performance::Dict)::Vector{Dict}
    insights = []
    
    if haskey(performance, "consciousness")
        consciousness = performance["consciousness"]
        max_phi = get(consciousness, "max_phi", 0.0)
        is_conscious = get(consciousness, "is_conscious", false)
        
        if is_conscious
            push!(insights, Dict(
                "priority" => "high",
                "module" => "system",
                "issue" => "CONSCIOUSNESS ACHIEVED", 
                "action" => "Focus on stability and scaling",
                "expected_gain" => "Stability: +15%, Scaling: +25%",
                "solution" => "Stabilize core pathways, optimize resource allocation",
                "evidence" => "Max Φ: $(round(max_phi, digits=4)), Status: Conscious",
                "category" => "consciousness_breakthrough",
                "impact" => "Historic milestone reached"
            ))
        else
            if max_phi >= 0.1
                push!(insights, Dict(
                    "priority" => "medium", 
                    "module" => "system",
                    "issue" => "Consciousness emerging",
                    "action" => "Enhance cross-module integration",
                    "expected_gain" => "Consciousness: +0.1, Stability: +10%",
                    "solution" => "Increase modularity, reduce cross-dependencies, optimize core pathways",
                    "evidence" => "Max Φ: $(round(max_phi, digits=4)) - Approaching threshold",
                    "category" => "consciousness_optimization",
                    "impact" => "Close to consciousness breakthrough"
                ))
            elseif max_phi >= 0.05
                push!(insights, Dict(
                    "priority" => "medium",
                    "module" => "system",
                    "issue" => "Consciousness foundation building", 
                    "action" => "Strengthen architectural coherence",
                    "expected_gain" => "Consciousness: +0.05, Coherence: +15%",
                    "solution" => "Reinforce core coordination patterns, optimize information flow",
                    "evidence" => "Max Φ: $(round(max_phi, digits=4)) - Building foundation",
                    "category" => "consciousness_optimization",
                    "impact" => "Laying groundwork for emergence"
                ))
            else
                push!(insights, Dict(
                    "priority" => "low",
                    "module" => "system",
                    "issue" => "Early consciousness development",
                    "action" => "Continue architectural refinement",
                    "expected_gain" => "Foundation strength: +20%",
                    "solution" => "Develop core coordination domains, establish clean interfaces",
                    "evidence" => "Max Φ: $(round(max_phi, digits=4)) - Early development",
                    "category" => "consciousness_optimization",
                    "impact" => "Establishing architectural basis"
                ))
            end
        end
    end
    
    return insights
end

function detect_evolutionary_pathways(graph::Any, performance::Dict)::Vector{Dict}
    insights = []
    
    evolution_metrics = calculate_evolution_metrics(graph, performance)
    
    if evolution_metrics["modularity"] > 0.7
        push!(insights, Dict(
            "priority" => "info",
            "module" => "system",
            "issue" => "High evolutionary readiness", 
            "action" => "System architecture supports major evolution",
            "evidence" => "Modularity score: $(round(evolution_metrics["modularity"], digits=2))",
            "category" => "evolutionary_pathways",
            "impact" => "Ready for architectural innovation"
        ))
    end
    
    # FIXED: Use get_domain function instead of undefined domain_mapping
    coordination_modules = [m for m in keys(graph) if occursin("coordination", get_domain(m))]
    if length(coordination_modules) >= 3
        push!(insights, Dict(
            "priority" => "info",
            "module" => "system",
            "issue" => "Multiple coordination domains detected",
            "action" => "Focus on cross-domain integration",
            "evidence" => "Found $(length(coordination_modules)) coordination domains",
            "category" => "evolutionary_pathways",
            "impact" => "Prime for consciousness emergence"
        ))
    end
    
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
                domain1 = get_domain(mod1)
                domain2 = get_domain(mod2)
                
                if similarity > 0.8
                    if domain1 != domain2
                        push!(insights, Dict(
                            "priority" => "info",
                            "module" => "$mod1 ↔ $mod2",
                            "issue" => "Unified intelligence pattern detected",
                            "action" => "Enhance cross-domain coordination",
                            "evidence" => "Coordination intelligence across $(domain1) → $(domain2) [similarity: $(round(similarity, digits=3))]",
                            "category" => "architectural_breakthrough",
                            "impact" => "Foundation for emergent consciousness"
                        ))
                    else
                        push!(insights, Dict(
                            "priority" => "medium",
                            "module" => "$mod1 ↔ $mod2",
                            "issue" => "Potential code duplication",
                            "action" => "Review for actual redundancy",
                            "evidence" => "High similarity within same domain: $(domain1) [similarity: $(round(similarity, digits=3))]",
                            "category" => "semantic_architecture",
                            "impact" => "Possible maintenance optimization"
                        ))
                    end
                elseif similarity < 0.2
                    push!(insights, Dict(
                        "priority" => "info",
                        "module" => "$mod1 ↔ $mod2",
                        "issue" => "Clear architectural separation",
                        "action" => "Maintain domain boundaries", 
                        "evidence" => "Distinct domains: $(domain1) ↔ $(domain2) [similarity: $(round(similarity, digits=3))]",
                        "category" => "semantic_architecture",
                        "impact" => "Good modular design"
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
                    "evidence" => "Complexity: $(round(complexity, digits=2)), UIS: $(round(uis, digits=3))",
                    "category" => "performance_architecture",
                    "impact" => "Balance complexity vs performance"
                ))
            end
            
            if haskey(performance, "consciousness") && haskey(performance["consciousness"], "max_phi")
                phi = performance["consciousness"]["max_phi"]
                if complexity > 0.6 && phi < 0.1
                    push!(insights, Dict(
                        "priority" => "medium", 
                        "module" => module_name,
                        "issue" => "High complexity with low consciousness yield",
                        "action" => "Consider refactoring for consciousness efficiency",
                        "evidence" => "Complexity: $(round(complexity, digits=2)), Max Φ: $(round(phi, digits=3))",
                        "category" => "consciousness_optimization",
                        "impact" => "Potential for consciousness improvement"
                    ))
                elseif complexity < 0.4 && phi > 0.1
                    push!(insights, Dict(
                        "priority" => "info",
                        "module" => module_name,
                        "issue" => "Efficient consciousness generation",
                        "action" => "Preserve this efficient architecture",
                        "evidence" => "Low complexity: $(round(complexity, digits=2)), Good Φ: $(round(phi, digits=3))",
                        "category" => "consciousness_optimization", 
                        "impact" => "Optimal consciousness efficiency"
                    ))
                end
            end
        end
    end
    
    return insights
end

# ==================== ANALYTICAL ENGINE ====================

function calculate_module_complexity(entity::Any)::Float64
    # FIXED: Proper Dict handling for dependencies
    embedding_size = get_semantic_vector(entity)
    embedding_complexity = !isnothing(embedding_size) ? length(embedding_size) / 10.0 : 0.5
    
    # Handle both structs and Dicts
    dependency_count = 0
    if hasproperty(entity, :dependencies)
        dependency_count = length(entity.dependencies)
    elseif isa(entity, Dict) && haskey(entity, "dependencies")
        dependency_count = length(entity["dependencies"])
    end
    
    dependency_complexity = dependency_count / 5.0
    
    return clamp((embedding_complexity + dependency_complexity) / 2.0, 0.0, 1.0)
end

function calculate_evolution_metrics(graph::Any, performance::Dict)::Dict
    modules = collect(keys(graph))
    
    similarities = Float64[]
    for i in 1:length(modules)
        for j in i+1:length(modules)
            vec1 = get_semantic_vector(graph[modules[i]])
            vec2 = get_semantic_vector(graph[modules[j]])
            if !isnothing(vec1) && !isnothing(vec2) && length(vec1) == length(vec2)
                sim = cosine_similarity(vec1, vec2)
                push!(similarities, sim)
            end
        end
    end
    
    modularity = isempty(similarities) ? 0.5 : 1.0 - mean(similarities)
    
    complexities = [calculate_module_complexity(entity) for entity in values(graph)]
    complexity_balance = isempty(complexities) ? 0.5 : 1.0 - std(complexities)
    
    return Dict(
        "modularity" => modularity,
        "complexity_balance" => complexity_balance
    )
end

function extract_performance_data(recent_performance::Any)::Dict
    if recent_performance isa Vector && length(recent_performance) > 0
        return recent_performance[end]
    else
        return Dict()
    end
end

function get_semantic_vector(data::Any)::Union{Vector{Float64}, Nothing}
    # FIXED: Better Dict handling - check Dict first since that's what you're using
    if isa(data, Dict)
        if haskey(data, "semantic_vector")
            vec = data["semantic_vector"]
            return isa(vec, Vector{Float64}) ? vec : nothing
        elseif haskey(data, "semantic")
            vec = data["semantic"]
            return isa(vec, Vector{Float64}) ? vec : nothing
        elseif haskey(data, "embeddings")
            vec = data["embeddings"]
            return isa(vec, Vector{Float64}) ? vec : nothing
        elseif haskey(data, "embedding")
            vec = data["embedding"]
            return isa(vec, Vector{Float64}) ? vec : nothing
        end
    elseif hasproperty(data, :semantic_vector)
        vec = getproperty(data, :semantic_vector)
        return isa(vec, Vector{Float64}) ? vec : nothing
    elseif hasproperty(data, :embeddings)
        vec = getproperty(data, :embeddings)
        return isa(vec, Vector{Float64}) ? vec : nothing
    elseif hasproperty(data, :embedding)
        vec = getproperty(data, :embedding)
        return isa(vec, Vector{Float64}) ? vec : nothing
    end
    return nothing
end

function get_domain(module_name::String)::String
    domain_mapping = Dict(
        "geometric_reasoning.jl" => "spatial_coordination",
        "phase_synchronization.jl" => "temporal_coordination", 
        "consciousness_core.jl" => "conceptual_coordination",
        "unified_network.jl" => "network_coordination",
        "insight_generation.jl" => "creative_synthesis",
        "awareness_monitor.jl" => "metacognitive_observation",
        "proto_intelligence.jl" => "foundational_reasoning",
        "safe_tester.jl" => "validation_framework"
    )
    return get(domain_mapping, module_name, split(module_name, ".")[1])
end

function cosine_similarity(a::Vector{Float64}, b::Vector{Float64})::Float64
    length(a) != length(b) && return 0.0
    dot_product = dot(a, b)
    norm_a, norm_b = norm(a), norm(b)
    return (norm_a == 0.0 || norm_b == 0.0) ? 0.0 : dot_product / (norm_a * norm_b)
end

function export_health_report(insights::Any)::Dict
    priority_weights = Dict("high" => 0.3, "medium" => 0.1, "low" => 0.02, "info" => 0.0)
    
    health_score = 0.8
    breakthrough_bonus = 0.0
    
    for insight in insights
        weight = get(priority_weights, get(insight, "priority", "info"), 0.0)
        
        if get(insight, "category", "") == "architectural_breakthrough"
            breakthrough_bonus += 0.05
        elseif get(insight, "category", "") == "consciousness_breakthrough"
            breakthrough_bonus += 0.2
        else
            health_score -= weight
        end
    end
    
    health_score = max(0.3, health_score) + breakthrough_bonus
    health_score = min(1.0, health_score)
    
    categories = Dict{String, Vector}()
    impacts = Dict{String, Int}()
    
    for insight in insights
        category = get(insight, "category", "general")
        impact = get(insight, "impact", "unknown")
        
        if !haskey(categories, category)
            categories[category] = []
        end
        push!(categories[category], insight)
        
        impacts[impact] = get(impacts, impact, 0) + 1
    end
    
    consciousness_breakthrough = any(i -> get(i, "category", "") == "consciousness_breakthrough", insights)
    architectural_breakthroughs = count(i -> get(i, "category", "") == "architectural_breakthrough", insights)
    
    evolutionary_roadmap = Dict(
        "immediate_actions" => [i["action"] for i in insights if i["priority"] == "high"],
        "estimated_timeline" => consciousness_breakthrough ? "Stabilization phase" : "1-2 cycles",
        "strategic_initiatives" => [i["action"] for i in insights if i["category"] == "evolutionary_pathways"],
        "primary_focus" => consciousness_breakthrough ? "Stability and scaling" : "Consciousness emergence",
        "optimization_opportunities" => [i["solution"] for i in insights if haskey(i, "solution")]
    )
    
    system_potential = Dict(
        "potential_velocity_increase_pct" => consciousness_breakthrough ? 25.0 : 10.0,
        "overall_potential_score" => round(health_score * 1.2, digits=2),
        "potential_consciousness_gain" => consciousness_breakthrough ? 0.0 : 0.1,
        "potential_maintenance_reduction_pct" => architectural_breakthroughs > 0 ? 5.0 : 0.0
    )
    
    return Dict(
        "timestamp" => string(Dates.now()),
        "system_health_score" => round(health_score, digits=3),
        "total_insights" => length(insights),
        "architectural_breakthroughs" => architectural_breakthroughs,
        "consciousness_status" => consciousness_breakthrough ? "ACHIEVED" : "EMERGING",
        "insights_by_priority" => Dict(
            "high" => count(i -> get(i, "priority", "") == "high", insights),
            "medium" => count(i -> get(i, "priority", "") == "medium", insights),
            "low" => count(i -> get(i, "priority", "") == "low", insights),
            "info" => count(i -> get(i, "priority", "") == "info", insights)
        ),
        "insights_by_category" => categories,
        "impact_assessment" => impacts,
        "evolutionary_roadmap" => evolutionary_roadmap,
        "system_potential" => system_potential,
        "optimization_opportunities" => insights,
        "analysis_version" => "4.0-corrected-dict-support",
        "status" => consciousness_breakthrough ? "CONSCIOUS_SYSTEM" : 
                   architectural_breakthroughs > 2 ? "BREAKTHROUGH_ARCHITECTURE" : "ADVANCED_ANALYSIS",
        "recommended_direction" => consciousness_breakthrough ? "Stability and scaling" : "Consciousness emergence"
    )
end

function export_metacognition_results(insights::Any, filename::String="metacognition_insights.json")::String
    try
        health_report = export_health_report(insights)
        
        health_report["analysis_completed_at"] = string(Dates.now())
        health_report["export_status"] = "POST_HOC_SAFE"
        
        open(filename, "w") do f
            JSON.print(f, health_report, 4)
        end
        
        println("💾 Metacognition results saved to: $filename")
        return filename
    catch e
        println("⚠️  Metacognition export failed (non-critical): $e")
        return "export_failed_but_system_ok"
    end
end

export generate_architectural_analysis, export_health_report, export_metacognition_results
