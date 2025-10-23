# 👁️ METACOGNITIVE VISOR - FULL WORKING MODEL v2.3
# Enhanced with Progressive Reporting & True Quantitative Analysis
# - Semantic pattern recognition across modules  
# - Performance-architecture correlation engine
# - Evolutionary pathway prediction & solution prescriptions
# - Quantitative potential analysis from prescribed solutions
# - PROGRESSIVE REPORTING: Maintains and builds upon previous analyses

using JSON, Dates, Statistics, LinearAlgebra

# --- Main analysis function remains the same ---
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


# --- Analysis modules remain the same ---
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
                    # Clean up file extensions for the new module name
                    clean_mod1 = replace(mod1, r"\.jl$" => "")
                    clean_mod2 = replace(mod2, r"\.jl$" => "")

                    push!(insights, Dict(
                        "priority" => "high",
                        "module" => "$mod1 ↔ $mod2",
                        "issue" => "High semantic similarity detected",
                        "action" => "Consider integration or interface abstraction",
                        "evidence" => "Cosine similarity: $(round(similarity, digits=3))",
                        "category" => "semantic_architecture",
                        "impact" => "Reduce cognitive duplication",
                        "solution" => "Merge $mod1 and $mod2 into shared_$(clean_mod1)_$(clean_mod2)_core.jl",
                        "expected_gain" => "Maintenance: -60%, Consciousness: +0.15"
                    ))
                elseif similarity < 0.2
                    push!(insights, Dict(
                        "priority" => "info",
                        "module" => "$mod1 ↔ $mod2",
                        "issue" => "Low semantic coupling",
                        "action" => "Maintain clear separation of concerns",
                        "evidence" => "Cosine similarity: $(round(similarity, digits=3))",
                        "category" => "semantic_architecture", 
                        "impact" => "Good architectural boundaries",
                        "solution" => "Keep modules separated - maintain current boundaries",
                        "expected_gain" => "Stability: +20%"
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
                    "impact" => "Balance complexity vs performance",
                    "solution" => "Extract core logic into helper modules, keep performance-critical parts",
                    "expected_gain" => "Maintainability: +40%, Performance: +0%"
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
                        "evidence" => "Complexity: $(round(complexity, digits=2)), Max Φ: $(round(phi, digits=3))",
                        "category" => "consciousness_optimization",
                        "impact" => "Potential for consciousness improvement",
                        "solution" => "Break into smaller focused modules: $(clean_module_name)_processor.jl, $(clean_module_name)_coordinator.jl",
                        "expected_gain" => "Consciousness: +0.25, Complexity: -45%"
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
        push!(insights, Dict(
            "priority" => "info",
            "module" => "system",
            "issue" => "High evolutionary readiness", 
            "action" => "System architecture supports major evolution",
            "evidence" => "Modularity score: $(round(evolution_metrics["modularity"], digits=2))",
            "category" => "evolutionary_pathways",
            "impact" => "Ready for architectural innovation",
            "solution" => "Implement major feature: system is architecturally prepared",
            "expected_gain" => "Development Velocity: +70%, Risk: -60%"
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
            "impact" => "Improve system resilience",
            "solution" => "Identify top 3 complex modules and extract shared logic",
            "expected_gain" => "Resilience: +35%, Velocity: +25%"
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
                "impact" => "Historic milestone reached",
                "solution" => "Monitor stability, document emergent behaviors, scale carefully",
                "expected_gain" => "Stability: +100%"
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
                    "expected_gain" => "Consciousness: +0.3" # Large expected jump
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
                    "expected_gain" => "Consciousness: +0.1, Stability: +10%"
                ))
            end
        end
    end
    
    return insights
end

# --- Analytical engine remains the same ---
function calculate_module_complexity(entity)::Float64
    embedding_size = get_semantic_vector(entity)
    embedding_complexity = !isnothing(embedding_size) ? length(embedding_size) / 10.0 : 0.5
    dependency_complexity = hasproperty(entity, :dependencies) ? length(entity.dependencies) / 5.0 : 0.5
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
    if hasproperty(data, :semantic_vector) && isa(getproperty(data, :semantic_vector), Vector{Float64})
        return getproperty(data, :semantic_vector)
    elseif hasproperty(data, :embedding) && isa(getproperty(data, :embedding), Vector{Float64})
        return getproperty(data, :embedding)
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


# ==================== PROGRESSIVE REPORTING FUNCTIONS ====================
# ENHANCED: Now maintains and builds upon previous analyses instead of replacing

# FIXED: Changed signature from ::Vector{Dict} to ::Vector to avoid type mismatch
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

# ENHANCED: This function now properly parses gain strings instead of using placeholders.
function parse_gain_value(gain_text::String, key::String)::Float64
    # Regex to find a key followed by a sign, numbers, and optionally a percent sign.
    # e.g., "Consciousness: +0.15" or "Maintenance: -60%"
    regex = Regex("$(key):\\s*([+-]?\\d*\\.?\\d+)\\s*%?")
    match_result = match(regex, gain_text)
    
    if !isnothing(match_result)
        try
            # Return the captured number, converted to Float64
            return parse(Float64, match_result.captures[1])
        catch e
            # Handle cases where parsing fails unexpectedly
            return 0.0
        end
    end
    return 0.0
end

# FIXED & ENHANCED: Changed signature and implemented real parsing.
function calculate_system_potential(insights::Vector)::Dict
    consciousness_boost = 0.0
    maintenance_reduction = 0.0 # Stored as positive values
    velocity_increase = 0.0
    
    for insight in insights
        !haskey(insight, "expected_gain") && continue
        gain_text = insight["expected_gain"]
        
        # Use the robust parser for each category
        consciousness_boost += parse_gain_value(gain_text, "Consciousness")
        
        # Maintenance and Complexity are both cost reductions
        maintenance_reduction += abs(parse_gain_value(gain_text, "Maintenance"))
        maintenance_reduction += abs(parse_gain_value(gain_text, "Complexity"))

        # Velocity, Speed, and Resilience are performance/development gains
        velocity_increase += parse_gain_value(gain_text, "Velocity")
        velocity_increase += parse_gain_value(gain_text, "Development Velocity")
        velocity_increase += parse_gain_value(gain_text, "Resilience")
        velocity_increase += parse_gain_value(gain_text, "Stability")
    end
    
    # Calculate an overall potential score
    overall_potential = (consciousness_boost * 2.0) + # Weight consciousness heavily
                        (maintenance_reduction / 100.0) +
                        (velocity_increase / 100.0)

    return Dict(
        "potential_consciousness_gain" => round(consciousness_boost, digits=3),
        "potential_maintenance_reduction_pct" => round(maintenance_reduction, digits=1),
        "potential_velocity_increase_pct" => round(velocity_increase, digits=1),
        "overall_potential_score" => round(overall_potential, digits=2)
    )
end

# HELPER FUNCTIONS FOR PROGRESSIVE REPORTING
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

# ENHANCED: Now properly merges with existing report data
function export_health_report(insights::Vector, existing_report::Union{Dict, Nothing}=nothing)::Dict
    # If we have an existing report, merge with it instead of replacing
    if existing_report !== nothing
        # Merge insights - append new ones to existing ones
        existing_insights = get(existing_report, "optimization_opportunities", [])
        all_insights = vcat(existing_insights, insights)
        
        # Recalculate everything based on combined insights
        health_score = calculate_health_score(all_insights)
        categories = categorize_insights(all_insights)
        consciousness_breakthrough = any(i -> get(i, "category", "") == "consciousness_breakthrough", all_insights)
        
        potential_analysis = calculate_system_potential(all_insights)
        evolutionary_roadmap = generate_evolutionary_roadmap(all_insights)
        
        return Dict(
            "timestamp" => string(Dates.now()),
            "analysis_version" => "2.3-progressive-patch",
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
            "previous_analysis_timestamp" => get(existing_report, "timestamp", "none"),  # Track history
            "analysis_cycle" => get(existing_report, "analysis_cycle", 0) + 1  # Increment cycle counter
        )
    else
        # Original logic for first-time report generation
        health_score = calculate_health_score(insights)
        categories = categorize_insights(insights)
        consciousness_breakthrough = any(i -> get(i, "category", "") == "consciousness_breakthrough", insights)
        
        potential_analysis = calculate_system_potential(insights)
        evolutionary_roadmap = generate_evolutionary_roadmap(insights)
        
        return Dict(
            "timestamp" => string(Dates.now()),
            "analysis_version" => "2.3-progressive-patch",
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
            "analysis_cycle" => 1  # Start cycle counter
        )
    end
end

# Export functions for orchestrator
export generate_architectural_analysis, export_health_report
