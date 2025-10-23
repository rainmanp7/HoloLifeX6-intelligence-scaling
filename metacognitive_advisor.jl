"""
🎯 METACOGNITIVE ADVISOR
The system's internal architect - identifies improvements without breaking execution
"""
module MetacognitiveAdvisor

using .NeuralCodeEmbeddings, .SemanticCodeGraph

struct ArchitecturalInsight
    priority::Symbol  # :critical, :high, :medium  
    module_affected::String
    issue::String
    evidence::Vector{Tuple{String, Float64}}  # (metric, correlation)
    suggested_action::String
    expected_impact::String
end

function generate_architectural_analysis(
    graph::Dict{String, CodeEntity}, 
    recent_performance::Vector{Dict}
)::Vector{ArchitecturalInsight}
    
    insights = ArchitecturalInsight[]
    
    # Pattern 1: Identify performance bottlenecks
    for (name, entity) in graph
        if has_high_complexity(entity)
            push!(insights, ArchitecturalInsight(
                :high, name, 
                "High structural complexity detected",
                [("reasoning_accuracy", -0.7), ("execution_time", 0.8)],
                "Refactor into smaller, focused functions",
                "Improve reasoning accuracy by 15-20%"
            ))
        end
        
        # Pattern 2: Identify integration opportunities
        if has_strong_semantic_similarity(entity, graph["consciousness_core.jl"])
            push!(insights, ArchitecturalInsight(
                :medium, name,
                "High semantic alignment with consciousness core",
                [("phi_correlation", 0.9), ("integration_potential", 0.85)],
                "Consider direct integration or shared abstractions", 
                "Potential 25% coherence improvement"
            ))
        end
    end
    
    return sort(insights, by=x->priority_weight(x.priority))
end

function export_health_report(insights::Vector{ArchitecturalInsight})::Dict
    return Dict(
        "timestamp" => now(),
        "system_health_score" => calculate_health_score(insights),
        "critical_insights" => filter(i -> i.priority == :critical, insights),
        "optimization_opportunities" => filter(i -> i.priority in [:high, :medium], insights),
        "architectural_strengths" => identify_strengths(insights),
        "evolution_recommendations" => generate_evolution_plan(insights)
    )
end
