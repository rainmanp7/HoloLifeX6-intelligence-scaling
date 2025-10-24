using LinearAlgebra, Dates

# Simple test data matching your structure
modules = Dict(
    "vision" => (embeddings = [0.9, 0.8, 0.7], dependencies = ["memory"]),
    "memory" => (embeddings = [0.85, 0.82, 0.68], dependencies = ["vision"]),
    "planner" => (embeddings = [0.1, 0.2, 0.3], dependencies = [])
)

performance = [Dict(
    "unified_intelligence_score" => 0.6,
    "consciousness" => Dict("max_phi" => 0.25, "is_conscious" => false)
)]

# Core functions from your files
function cosine_similarity(a, b)
    dot_product = dot(a, b)
    norms = norm(a) * norm(b)
    return norms == 0 ? 0.0 : dot_product / norms
end

function calculate_complexity(entity)
    embedding_complexity = length(entity.embeddings) / 10.0
    dependency_complexity = length(entity.dependencies) / 5.0
    return (embedding_complexity + dependency_complexity) / 2.0
end

function generate_simple_analysis(graph, recent_performance)
    insights = []
    perf = recent_performance[end]
    
    # 1. Semantic analysis
    mod_names = collect(keys(graph))
    for i in 1:length(mod_names), j in i+1:length(mod_names)
        mod1, mod2 = mod_names[i], mod_names[j]
        sim = cosine_similarity(graph[mod1].embeddings, graph[mod2].embeddings)
        
        if sim > 0.8
            push!(insights, Dict(
                "priority" => "high",
                "module" => "$mod1 ↔ $mod2", 
                "issue" => "High semantic similarity",
                "action" => "Merge modules",
                "evidence" => "Cosine similarity: $(round(sim, digits=3)) > 0.8",
                "category" => "semantic_architecture"
            ))
        end
    end
    
    # 2. Consciousness status
    if haskey(perf, "consciousness")
        phi = perf["consciousness"]["max_phi"]
        status = perf["consciousness"]["is_conscious"] ? "CONSCIOUS" : "PRE_CONSCIOUS"
        push!(insights, Dict(
            "priority" => "medium",
            "module" => "system",
            "issue" => "Consciousness status: $status",
            "action" => "Continue optimization",
            "evidence" => "Phi: $(round(phi, digits=3))",
            "category" => "consciousness"
        ))
    end
    
    return insights
end

function export_simple_report(insights)
    return Dict(
        "timestamp" => string(now()),
        "total_insights" => length(insights),
        "insights" => insights,
        "status" => "ANALYSIS_COMPLETE"
    )
end

# Run and show JSON output
insights = generate_simple_analysis(modules, performance)
report = export_simple_report(insights)

println("JSON-READY REPORT:")
for (key, value) in report
    println("$key: $value")
end
