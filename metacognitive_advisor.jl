# metacognitive_advisor.jl
"""
🎯 BASIC METACOGNITION ENGINE
First-generation self-analysis system
- Identifies code patterns and architectural smells
- Correlates structure with performance
- Generates actionable improvement insights
"""

function generate_architectural_analysis(graph::Any, recent_performance::Any)
    println("✅ Metacognition analyzing $(length(graph)) modules...")
    
    insights = []
    
    # 1. BASIC COMPLEXITY ANALYSIS
    for (module_name, entity) in graph
        embedding_size = length(entity.embeddings)
        
        if embedding_size > 4
            push!(insights, Dict(
                "priority" => "high",
                "module" => module_name,
                "issue" => "High-dimensional embeddings detected",
                "action" => "Consider dimensionality reduction",
                "evidence" => "Vector size: $(embedding_size)",
                "category" => "complexity"
            ))
        end
        
        if length(entity.dependencies) == 0
            push!(insights, Dict(
                "priority" => "low", 
                "module" => module_name,
                "issue" => "No dependencies detected",
                "action" => "Review module isolation",
                "evidence" => "Zero external dependencies",
                "category" => "coupling"
            ))
        end
    end
    
    # 2. CROSS-MODULE ANALYSIS
    modules = collect(keys(graph))
    if length(modules) >= 2
        # Check coupling between key modules
        core_modules = ["consciousness_core.jl", "geometric_reasoning.jl", "phase_synchronization.jl"]
        for mod in core_modules
            if mod in modules
                push!(insights, Dict(
                    "priority" => "medium",
                    "module" => mod, 
                    "issue" => "Core architecture module",
                    "action" => "Monitor for stability and performance",
                    "evidence" => "Identified as system foundation",
                    "category" => "architecture"
                ))
            end
        end
    end
    
    # 3. PERFORMANCE CORRELATION (if data available)
    if recent_performance isa Vector && length(recent_performance) > 0
        latest_perf = recent_performance[end]
        if haskey(latest_perf, "unified_intelligence_score")
            uis = latest_perf["unified_intelligence_score"]
            push!(insights, Dict(
                "priority" => "info",
                "module" => "system",
                "issue" => "Current intelligence metrics",
                "action" => "Track evolution over time", 
                "evidence" => "UIS: $(round(uis, digits=3))",
                "category" => "performance"
            ))
        end
    end
    
    println("   Generated $(length(insights)) architectural insights")
    return insights
end

function export_health_report(insights::Any)::Dict
    # Calculate basic health score
    high_priority = count(i -> get(i, "priority", "") == "high", insights)
    medium_priority = count(i -> get(i, "priority", "") == "medium", insights)
    
    health_score = 1.0 - (high_priority * 0.2 + medium_priority * 0.1)
    health_score = max(0.1, min(1.0, health_score))
    
    # Categorize insights
    categories = Dict{String, Vector}()
    for insight in insights
        category = get(insight, "category", "general")
        if !haskey(categories, category)
            categories[category] = []
        end
        push!(categories[category], insight)
    end
    
    return Dict(
        "timestamp" => string(Dates.now()),
        "system_health_score" => round(health_score, digits=3),
        "total_insights" => length(insights),
        "insights_by_priority" => Dict(
            "high" => count(i -> get(i, "priority", "") == "high", insights),
            "medium" => count(i -> get(i, "priority", "") == "medium", insights),
            "low" => count(i -> get(i, "priority", "") == "low", insights),
            "info" => count(i -> get(i, "priority", "") == "info", insights)
        ),
        "insights_by_category" => categories,
        "optimization_opportunities" => insights,
        "analysis_version" => "1.0-basic",
        "status" => "COMPLETE"
    )
end

# Export both functions for orchestrator
export generate_architectural_analysis, export_health_report
