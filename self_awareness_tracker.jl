# self_awareness_tracker.jl
"""
📈 SELF-AWARENESS TRACKER
Longitudinal memory of system evolution and architectural learning
"""

using JSON
using Dates

mutable struct SelfModel
    architecture_snapshots::Vector{Dict}
    performance_trends::Vector{Dict}
    meta_cognitive_insights::Vector{Dict}
    improvement_decisions::Vector{Dict}
    self_reflection_scores::Vector{Float64}
    created_at::DateTime
end

function initialize_self_model()::SelfModel
    return SelfModel([], [], [], [], [], now())
end

function update_self_model!(model::SelfModel, current_architecture::Dict, current_performance::Dict, meta_insights::Dict)
    # Track architecture evolution
    push!(model.architecture_snapshots, Dict(
        "timestamp" => now(),
        "modules" => get(current_architecture, "modules_analyzed", Dict()),
        "complexity" => get(current_architecture, "average_complexity", 0.0),
        "cohesion" => get(current_architecture, "system_cohesion", "")
    ))
    
    # Track performance trends
    push!(model.performance_trends, Dict(
        "timestamp" => now(),
        "success_rate" => get(current_performance, "success_rate", 0.0),
        "entities_tested" => get(current_performance, "entities_tested", 0)
    ))
    
    # Track meta-cognitive insights
    push!(model.meta_cognitive_insights, Dict(
        "timestamp" => now(),
        "self_reflection_score" => get(meta_insights, "self_reflection_score", 0.0),
        "bottlenecks_identified" => length(get(meta_insights, "bottlenecks", [])),
        "recommendations_generated" => length(get(meta_insights, "recommendations", []))
    ))
    
    # Track self-reflection score
    push!(model.self_reflection_scores, get(meta_insights, "self_reflection_score", 0.0))
    
    # Keep only last 50 snapshots to manage memory
    if length(model.architecture_snapshots) > 50
        model.architecture_snapshots = model.architecture_snapshots[end-49:end]
        model.performance_trends = model.performance_trends[end-49:end]
        model.meta_cognitive_insights = model.meta_cognitive_insights[end-49:end]
        model.self_reflection_scores = model.self_reflection_scores[end-49:end]
    end
end

function calculate_architectural_momentum(model::SelfModel)::Dict
    if length(model.architecture_snapshots) < 2
        return Dict("trend" => "INSUFFICIENT_DATA", "velocity" => 0.0)
    end
    
    recent = model.architecture_snapshots[end]
    previous = model.architecture_snapshots[end-1]
    
    complexity_change = get(recent, "complexity", 0.0) - get(previous, "complexity", 0.0)
    module_count_change = length(get(recent, "modules", Dict())) - length(get(previous, "modules", Dict()))
    
    return Dict(
        "complexity_trend" => complexity_change > 0 ? "INCREASING" : complexity_change < 0 ? "DECREASING" : "STABLE",
        "complexity_velocity" => round(complexity_change, digits=3),
        "module_growth" => module_count_change,
        "architectural_health" => complexity_change < 0.1 ? "IMPROVING" : "CONCERN"
    )
end

function generate_evolution_insights(model::SelfModel)::Dict
    momentum = calculate_architectural_momentum(model)
    
    insights = []
    
    if momentum["complexity_trend"] == "INCREASING" && momentum["complexity_velocity"] > 0.5
        push!(insights, Dict(
            "type" => "COMPLEXITY_WARNING",
            "message" => "Architectural complexity growing rapidly",
            "suggestion" => "Consider refactoring before technical debt accumulates"
        ))
    end
    
    if length(model.self_reflection_scores) > 3
        recent_scores = model.self_reflection_scores[end-2:end]
        if all(score -> score > 0.7, recent_scores)
            push!(insights, Dict(
                "type" => "SELF_AWARENESS_STRENGTH", 
                "message" => "Consistently high self-reflection scores",
                "suggestion" => "System demonstrates strong meta-cognitive capabilities"
            ))
        end
    end
    
    return Dict(
        "momentum_analysis" => momentum,
        "evolution_insights" => insights,
        "total_snapshots" => length(model.architecture_snapshots),
        "time_span_days" => length(model.architecture_snapshots) > 1 ? 
            round((now() - model.created_at).value / 1000 / 60 / 60 / 24, digits=1) : 0.0
    )
end

function save_self_model(model::SelfModel, filename::String="self_awareness_model.json")
    try
        # Convert to serializable format
        model_data = Dict(
            "architecture_snapshots" => model.architecture_snapshots,
            "performance_trends" => model.performance_trends,
            "meta_cognitive_insights" => model.meta_cognitive_insights,
            "improvement_decisions" => model.improvement_decisions,
            "self_reflection_scores" => model.self_reflection_scores,
            "created_at" => string(model.created_at),
            "current_evolution_insights" => generate_evolution_insights(model)
        )
        
        json_data = JSON.json(model_data, 2)
        open(filename, "w") do file
            write(file, json_data)
        end
        return true
    catch e
        println("⚠️  Failed to save self model: $e")
        return false
    end
end

# Export functions
export initialize_self_model, update_self_model!, generate_evolution_insights, save_self_model
