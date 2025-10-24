using LinearAlgebra, Dates

# Define proper structs so everything works
struct ModuleEntity
    embeddings::Vector{Float64}
    dependencies::Vector{String}
end

# Test data with proper structs
test_graph = Dict(
    "vision" => ModuleEntity([0.9, 0.8, 0.7], ["memory"]),
    "memory" => ModuleEntity([0.85, 0.82, 0.68], ["vision"]), 
    "planner" => ModuleEntity([0.1, 0.2, 0.3], [])
)

test_performance = [Dict(
    "unified_intelligence_score" => 0.6,
    "consciousness" => Dict("max_phi" => 0.25, "is_conscious" => false)
)]

function generate_architectural_analysis(graph::Any, recent_performance::Any)
    insights = []
    performance_data = extract_performance_data(recent_performance)
    
    println("=== GATHERING EVIDENCE ===")
    
    # 1. SEMANTIC ANALYSIS
    modules = collect(keys(graph))
    for i in 1:length(modules), j in i+1:length(modules)
        mod1, mod2 = modules[i], modules[j]
        sim = cosine_similarity(graph[mod1].embeddings, graph[mod2].embeddings)
        
        println("EVIDENCE: $mod1 vs $mod2 similarity = $(round(sim, digits=3))")
        
        if sim > 0.8
            push!(insights, Dict(
                "priority" => "high",
                "module" => "$mod1 ↔ $mod2",
                "issue" => "High semantic similarity",
                "action" => "MERGE modules", 
                "evidence" => "Similarity $(round(sim, digits=3)) > 0.8 threshold",
                "category" => "semantic_architecture"
            ))
        elseif sim < 0.2
            push!(insights, Dict(
                "priority" => "info",
                "module" => "$mod1 ↔ $mod2", 
                "issue" => "Good separation",
                "action" => "KEEP separate",
                "evidence" => "Similarity $(round(sim, digits=3)) < 0.2 threshold",
                "category" => "semantic_architecture"
            ))
        end
    end
    
    # 2. CONSCIOUSNESS STATUS
    if haskey(performance_data, "consciousness")
        phi = performance_data["consciousness"]["max_phi"]
        conscious = performance_data["consciousness"]["is_conscious"]
        
        println("EVIDENCE: phi = $(round(phi, digits=3)), conscious = $conscious")
        
        if conscious
            push!(insights, Dict(
                "priority" => "high",
                "module" => "system",
                "issue" => "CONSCIOUSNESS ACHIEVED",
                "action" => "Focus on stability",
                "evidence" => "Phi $(round(phi, digits=3)) crossed threshold",
                "category" => "consciousness_breakthrough"
            ))
        else
            push!(insights, Dict(
                "priority" => "medium",
                "module" => "system",
                "issue" => "Pre-consciousness",
                "action" => "Optimize architecture", 
                "evidence" => "Phi $(round(phi, digits=3)) below threshold",
                "category" => "consciousness_optimization"
            ))
        end
    end
    
    return insights
end

function extract_performance_data(recent_performance::Any)::Dict
    recent_performance isa Vector && length(recent_performance) > 0 ? recent_performance[end] : Dict()
end

function cosine_similarity(a::Vector{Float64}, b::Vector{Float64})::Float64
    length(a) != length(b) && return 0.0
    dot_product = dot(a, b)
    norm_a, norm_b = norm(a), norm(b)
    (norm_a == 0.0 || norm_b == 0.0) ? 0.0 : dot_product / (norm_a * norm_b)
end

function export_health_report(insights::Any)::Dict
    Dict(
        "timestamp" => string(now()),
        "system_health_score" => 0.8,
        "total_insights" => length(insights),
        "insights" => insights,
        "status" => "ANALYSIS_COMPLETE"
    )
end

# RUN IT
println("Starting analysis...")
insights = generate_architectural_analysis(test_graph, test_performance)

println("\n=== FINAL JSON REPORT ===")
report = export_health_report(insights)

# Pretty print the report
for (key, value) in report
    println("$key: $value")
end
