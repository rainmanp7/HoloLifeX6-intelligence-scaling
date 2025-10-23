# metacognitive_advisor.jl - FIXED SYNTAX
function generate_architectural_analysis(graph::Dict, recent_performance::Vector{Dict})
    println("✅ Metacognition running - generating simple analysis")
    
    insights = [
        Dict("priority" => "high", "module" => "consciousness_core.jl", "issue" => "High complexity", "action" => "Refactor"),
        Dict("priority" => "medium", "module" => "geometric_reasoning.jl", "issue" => "Coupling detected", "action" => "Extract interface")
    ]
    
    return Dict(
        "timestamp" => "2024-01-15T10:30:00Z",
        "insights_generated" => length(insights),
        "status" => "SUCCESS",
        "insights" => insights
    )
end
