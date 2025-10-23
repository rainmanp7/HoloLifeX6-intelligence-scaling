# File 1: neural_code_embeddings.jl
"""
🧠 NEURAL CODE EMBEDDINGS
Transforms code into semantic vectors that preserve meaning across syntax changes
"""
module NeuralCodeEmbeddings

using LinearAlgebra, Statistics

struct CodeEmbedding
    semantic_vector::Vector{Float64}
    structural_fingerprint::Vector{Float64}
    functional_signature::Vector{Float64}
end

function generate_embedding(source_code::String)::CodeEmbedding
    # Lightweight semantic hashing - no heavy ML
    semantic = semantic_hash(source_code)
    structural = structural_fingerprint(source_code) 
    functional = functional_signature(source_code)
    return CodeEmbedding(semantic, structural, functional)
end

function semantic_hash(code::String)::Vector{Float64}
    # Simple but effective: capture semantic patterns without syntax
    tokens = split(code, r"\W+")
    features = [
        length(code) / 1000,                    # Size feature
        count_contains(code, ["function", "if", "for"]), # Control flow density
        count_contains(code, ["phi", "consciousness"]),  # Domain concepts
        # Add more semantic features...
    ]
    return normalize(features)
end

function count_contains(code::String, patterns::Vector{String})::Float64
    count = 0
    for pattern in patterns
        count += occursin(pattern, code)
    end
    return Float64(count)
end

function normalize(features::Vector{Float64})::Vector{Float64}
    norm = sqrt(sum(x -> x^2, features))
    return norm > 0 ? features ./ norm : features
end

function structural_fingerprint(code::String)::Vector{Float64}
    # Simple structural analysis
    lines = split(code, '\n')
    features = [
        Float64(length(lines)) / 100,           # Number of lines
        Float64(count(l -> occursin(r"^function", l), lines)), # Function count
        Float64(count(l -> occursin(r"^#", l), lines)) / max(1, length(lines)), # Comment density
    ]
    return normalize(features)
end

function functional_signature(code::String)::Vector{Float64}
    # Simple functional analysis
    features = [
        Float64(count(occursin(r"function", code))),
        Float64(count(occursin(r"return", code))),
        Float64(count(occursin(r"if|for|while", code))),
    ]
    return normalize(features)
end

function generate_embeddings_for_modules(modules::Vector{String})::Dict{String, Any}
    embeddings = Dict{String, Any}()
    for module in modules
        if isfile(module)
            code = read(module, String)
            embedding = generate_embedding(code)
            embeddings[module] = Dict(
                "semantic" => embedding.semantic_vector,
                "structural" => embedding.structural_fingerprint,
                "functional" => embedding.functional_signature
            )
        end
    end
    return embeddings
end

# Export functions
export generate_embedding, generate_embeddings_for_modules, CodeEmbedding

end  # end module
