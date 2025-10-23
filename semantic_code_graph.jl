# semantic_code_graph.jl
"""
🏗️ SEMANTIC CODE GRAPH  
Cross-module relationship mapping - understands architectural patterns
"""
module SemanticCodeGraph

using .NeuralCodeEmbeddings

mutable struct CodeEntity
    name::String
    entity_type::Symbol  # :function, :module, :data_flow
    embeddings::Vector{Float64}
    dependencies::Vector{String}
    performance_correlations::Dict{Symbol, Float64}
end

function extract_dependencies(source::String)::Vector{String}
    deps = String[]
    lines = split(source, '\n')
    for line in lines
        if occursin(r"include\(", line) || occursin(r"using\s+", line) || occursin(r"import\s+", line)
            # Extract the module/file name (simplified)
            push!(deps, "dependency_placeholder")
        end
    end
    return unique(deps)
end

function compute_correlation(embeddings::Vector{Float64}, value::Any)::Float64
    # Simplified correlation - in real implementation, use proper stats
    if value isa Number
        return clamp(embeddings[1] * Float64(value), -1.0, 1.0)
    else
        return 0.0
    end
end

function build_semantic_graph(modules::Vector{String})::Dict{String, CodeEntity}
    graph = Dict{String, CodeEntity}()
    
    for mod in modules  # FIXED: module → mod
        source = read(mod, String)  # FIXED: module → mod
        embedding = NeuralCodeEmbeddings.generate_embedding(source)
        
        entity = CodeEntity(
            mod,  # FIXED: module → mod
            :module,
            embedding.semantic_vector,
            extract_dependencies(source),
            Dict()  # Will be populated during runtime
        )
        graph[mod] = entity  # FIXED: module → mod
    end
    return graph
end

function correlate_performance!(graph::Dict, metrics::Dict)
    # Link code patterns to performance outcomes
    for (mod, entity) in graph  # FIXED: module → mod
        for (metric_name, value) in metrics
            correlation = compute_correlation(entity.embeddings, value)
            entity.performance_correlations[Symbol(metric_name)] = correlation
        end
    end
end

# Export functions
export build_semantic_graph, correlate_performance!, CodeEntity

end  # end module
