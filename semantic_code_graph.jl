"""
🏗️ SEMANTIC CODE GRAPH  
Cross-module relationship mapping - understands architectural patterns
"""
module SemanticCodeGraph

mutable struct CodeEntity
    name::String
    entity_type::Symbol  # :function, :module, :data_flow
    embeddings::Vector{Float64}
    dependencies::Vector{String}
    performance_correlations::Dict{Symbol, Float64}
end

function build_semantic_graph(modules::Vector{String})::Dict{String, CodeEntity}
    graph = Dict{String, CodeEntity}()
    
    for module in modules
        source = read(module, String)
        embedding = NeuralCodeEmbeddings.generate_embedding(source)
        
        entity = CodeEntity(
            module,
            :module,
            embedding.semantic_vector,
            extract_dependencies(source),
            Dict()  # Will be populated during runtime
        )
        graph[module] = entity
    end
    return graph
end

function correlate_performance!(graph::Dict, metrics::Dict)
    # Link code patterns to performance outcomes
    for (module, entity) in graph
        for (metric_name, value) in metrics
            correlation = compute_correlation(entity.embeddings, value)
            entity.performance_correlations[metric_name] = correlation
        end
    end
end
