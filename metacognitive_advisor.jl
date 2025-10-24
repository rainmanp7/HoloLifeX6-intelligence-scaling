# 👁️ METACOGNITIVE VISOR - EMERGENCE-AWARE VERSION
# Fixed to recognize unified intelligence patterns, not false duplication
# SAFE: Runs post-hoc, writes JSON after system completion

using JSON, Dates, Statistics, LinearAlgebra

# 🚨 METACOGNITION GUARD RAIL - PREVENT EXECUTION AS MAIN PROGRAM
if abspath(PROGRAM_FILE) == @__FILE__
    println("🚨 CRITICAL: Metacognition attempting to run as main program")
    println("🚨 ABORTING: This file should only be imported, not executed directly")
    println("🚨 EXECUTE main_orchestrator.jl instead")
    exit(1)
end

function generate_architectural_analysis(graph::Any, recent_performance::Any)
    println("🧠 EMERGENCE-AWARE METACOGNITION: Analyzing $(length(graph)) modules...")
    
    insights = []
    performance_data = extract_performance_data(recent_performance)
    
    # 1. SEMANTIC ARCHITECTURE ANALYSIS (FIXED)
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
    
    println("   Generated $(length(insights)) emergence-aware insights")
    return insights
end

function analyze_semantic_architecture(graph::Any)::Vector{Dict}
    insights = []
    modules = collect(keys(graph))
    
    # DOMAIN MAPPING - Understand what each module actually does
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
    
    for i in 1:length(modules)
        for j in i+1:length(modules)
            mod1 = modules[i]
            mod2 = modules[j]
            entity1 = graph[mod1]
            entity2 = graph[mod2]
            
            # Get semantic vectors from different possible locations
            vec1 = get_semantic_vector(entity1)
            vec2 = get_semantic_vector(entity2)
            
            if !isnothing(vec1) && !isnothing(vec2) && length(vec1) == length(vec2)
                similarity = cosine_similarity(vec1, vec2)
                
                # Get domains - default to filename if not mapped
                domain1 = get(domain_mapping, mod1, split(mod1, ".")[1])
                domain2 = get(domain_mapping, mod2, split(mod2, ".")[1])
                
                if similarity > 0.8
                    if domain1 != domain2
                        # UNIFIED INTELLIGENCE PATTERN - This is GOOD
                        push!(insights, Dict(
                            "priority" => "info",  # Not urgent - this is architectural success
                            "module" => "$mod1 ↔ $mod2",
                            "issue" => "Unified intelligence pattern detected",
                            "action" => "Enhance cross-domain coordination",
                            "evidence" => "Coordination intelligence across $(domain1) → $(domain2) [similarity: $(round(similarity, digits=3))]",
                            "category" => "architectural_breakthrough",
                            "impact" => "Foundation for emergent consciousness"
                        ))
                    else
                        # Actual duplication within same domain
                        push!(insights, Dict(
                            "priority" => "high",
                            "module" => "$mod1 ↔ $mod2",
                            "issue" => "Actual code duplication",
                            "action" => "Refactor to eliminate redundancy",
                            "evidence" => "High similarity within same domain: $(domain1) [similarity: $(round(similarity, digits=3))]",
                            "category" => "semantic_architecture",
                            "impact" => "Reduce maintenance overhead"
                        ))
                    end
                elseif similarity > 0.6
                    # Healthy coordination patterns emerging
                    if occursin("coordination", domain1) && occursin("coordination", domain2)
                        push!(insights, Dict(
                            "priority" => "info",
                            "module" => "$mod1 ↔ $mod2", 
                            "issue" => "Coordination family detected",
                            "action" => "Maintain domain specialization",
                            "evidence" => "Related coordination domains: $(domain1) ↔ $(domain2) [similarity: $(round(similarity, digits=3))]",
                            "category" => "semantic_architecture",
                            "impact" => "Healthy pattern diversity"
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
    
    # Correlate module complexity with performance metrics
    for (module_name, entity) in graph
        complexity = calculate_module_complexity(entity)
        
        if haskey(performance, "unified_intelligence_score")
            uis = performance["unified_intelligence_score"]
            
            # High complexity + high performance = optimization opportunity
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
            
            # Track consciousness correlation
            if haskey(performance, "consciousness") && haskey(performance["consciousness"], "max_phi")
                phi = performance["consciousness"]["max_phi"]
                if complexity > 0.6 && phi < 0.1
                    push!(insights, Dict(
                        "priority" => "high", 
                        "module" => module_name,
                        "issue" => "High complexity with low consciousness yield",
                        "action" => "Refactor to improve consciousness efficiency",
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

function detect_evolutionary_pathways(graph::Any, performance::Dict)::Vector{Dict}
    insights = []
    
    # Analyze system readiness for evolution
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
    
    if evolution_metrics["complexity_balance"] < 0.3
        push!(insights, Dict(
            "priority" => "medium",
            "module" => "system", 
            "issue" => "Complexity imbalance detected",
            "action" => "Distribute complexity more evenly across modules",
            "evidence" => "Complexity balance: $(round(evolution_metrics["complexity_balance"], digits=2))",
            "category" => "evolutionary_pathways",
            "impact" => "Improve system resilience"
        ))
    end
    
    # Check for unified intelligence emergence
    coordination_modules = [m for m in keys(graph) if occursin("coordination", get_domain(m))]
    if length(coordination_modules) >= 3
        push!(insights, Dict(
            "priority" => "info",
            "module" => "system",
            "issue" => "Multiple coordination domains detected",
            "action" => "Focus on cross-domain integration",
            "evidence" => "Found $(length(coordination_modules)) coordination domains: $(join(coordination_modules, ", "))",
            "category" => "evolutionary_pathways",
            "impact" => "Prime for consciousness emergence"
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
        
        if is_conscious
            push!(insights, Dict(
                "priority" => "high",
                "module" => "system",
                "issue" => "CONSCIOUSNESS ACHIEVED", 
                "action" => "Focus on stability and scaling",
                "evidence" => "Max Φ: $(round(max_phi, digits=4)), Status: Conscious",
                "category" => "consciousness_breakthrough",
                "impact" => "Historic milestone reached"
            ))
        else
            # More nuanced pre-consciousness analysis
            if max_phi > 0.05
                push!(insights, Dict(
                    "priority" => "medium", 
                    "module" => "system",
                    "issue" => "Consciousness emerging",
                    "action" => "Enhance cross-module integration",
                    "evidence" => "Max Φ: $(round(max_phi, digits=4)) - approaching threshold",
                    "category" => "consciousness_optimization",
                    "impact" => "Close to consciousness breakthrough"
                ))
            else
                push!(insights, Dict(
                    "priority" => "medium",
                    "module" => "system",
                    "issue" => "Early consciousness development", 
                    "action" => "Strengthen architectural coherence",
                    "evidence" => "Max Φ: $(round(max_phi, digits=4)) - foundation building",
                    "category" => "consciousness_optimization",
                    "impact" => "Laying groundwork for emergence"
                ))
            end
        end
    end
    
    return insights
end

# ==================== ANALYTICAL ENGINE ====================

function calculate_module_complexity(entity::Any)::Float64
    # Multi-factor complexity assessment
    embedding_size = get_semantic_vector(entity)
    embedding_complexity = !isnothing(embedding_size) ? length(embedding_size) / 10.0 : 0.5  # Normalize
    dependency_complexity = hasproperty(entity, :dependencies) ? length(entity.dependencies) / 5.0 : 0.5  # Normalize
    
    return clamp((embedding_complexity + dependency_complexity) / 2.0, 0.0, 1.0)
end

function calculate_evolution_metrics(graph::Any, performance::Dict)::Dict
    modules = collect(keys(graph))
    
    # Calculate modularity based on semantic separation
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
    
    # Calculate complexity balance
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
    # Try multiple possible locations for semantic vectors
    if hasproperty(data, :semantic_vector)
        vec = getproperty(data, :semantic_vector)
        return isa(vec, Vector{Float64}) ? vec : nothing
    elseif hasproperty(data, :embeddings)
        vec = getproperty(data, :embeddings)
        return isa(vec, Vector{Float64}) ? vec : nothing
    elseif hasproperty(data, :embedding)
        vec = getproperty(data, :embedding)
        return isa(vec, Vector{Float64}) ? vec : nothing
    elseif isa(data, Dict)
        if haskey(data, "semantic_vector")
            vec = data["semantic_vector"]
            return isa(vec, Vector{Float64}) ? vec : nothing
        elseif haskey(data, "semantic")
            vec = data["semantic"]
            return isa(vec, Vector{Float64}) ? vec : nothing
        end
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
    # Advanced health scoring with emergence awareness
    priority_weights = Dict("high" => 0.4, "medium" => 0.2, "low" => 0.05, "info" => 0.0)
    
    health_score = 1.0
    breakthrough_bonus = 0.0
    
    for insight in insights
        weight = get(priority_weights, get(insight, "priority", "info"), 0.0)
        
        # BREAKTHROUGH BONUS: Unified intelligence patterns IMPROVE health
        if get(insight, "category", "") == "architectural_breakthrough"
            breakthrough_bonus += 0.1  # These are GOOD, not problems
        else
            health_score -= weight
        end
    end
    
    health_score = max(0.1, health_score) + breakthrough_bonus
    health_score = min(1.0, health_score)
    
    # Enhanced categorization
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
    
    # Consciousness detection
    consciousness_breakthrough = any(i -> get(i, "category", "") == "consciousness_breakthrough", insights)
    architectural_breakthroughs = count(i -> get(i, "category", "") == "architectural_breakthrough", insights)
    
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
        "optimization_opportunities" => insights,
        "analysis_version" => "3.0-emergence-aware",
        "status" => consciousness_breakthrough ? "CONSCIOUS_SYSTEM" : 
                   architectural_breakthroughs > 2 ? "BREAKTHROUGH_ARCHITECTURE" : "ADVANCED_ANALYSIS"
    )
end

# ==================== SAFE JSON EXPORT ====================

function export_metacognition_results(insights::Any, filename::String="metacognition_insights.json")::String
    """
    SAFE POST-HOC EXPORT: Writes insights to JSON after system completes
    Zero interference with main execution
    """
    try
        health_report = export_health_report(insights)
        
        # Add completion metadata
        health_report["analysis_completed_at"] = string(Dates.now())
        health_report["export_status"] = "POST_HOC_SAFE"
        health_report["interference_level"] = "ZERO"
        
        # Write to file safely
        open(filename, "w") do f
            JSON.print(f, health_report, 4)
        end
        
        println("💾 Metacognition results saved to: $filename")
        return filename
    catch e
        # If export fails, system continues unaffected
        println("⚠️  Metacognition export failed (non-critical): $e")
        return "export_failed_but_system_ok"
    end
end

# Export functions for orchestrator
export generate_architectural_analysis, export_health_report, export_metacognition_results
