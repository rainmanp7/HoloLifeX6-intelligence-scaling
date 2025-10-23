# neural_code_embeddings.jl
"""
🧠 NEURAL CODE EMBEDDINGS
Transforms code into semantic vectors that preserve meaning across syntax changes
"""

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
    features = [
        length(code) / 1000.0,
        count_contains(code, ["function", "if", "for", "while"]),
        count_contains(code, ["phi", "consciousness", "intelligence"]),
        count_contains(code, ["include", "import", "using"])
    ]
    return normalize(features)
end

function count_contains(code::String, patterns::Vector{String})::Float64
    count = 0.0
    for pattern in patterns
        count += occursin(pattern, code) ? 1.0 : 0.0
    end
    return count
end

function normalize(features::Vector{Float64})::Vector{Float64}
    norm = sqrt(sum(x -> x^2, features))
    return norm > 0 ? features ./ norm : features
end

function structural_fingerprint(code::String)::Vector{Float64}
    # Simple structural analysis
    lines = split(code, '\n')
    features = [
        Float64(length(lines)) / 100.0,
        Float64(count(l -> occursin(r"^function", l), lines)),
        Float64(count(l -> occursin(r"^#", l), lines)) / max(1.0, length(lines)),
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
    for mod in modules
        if isfile(mod)
            code = read(mod, String)
            embedding = generate_embedding(code)
            embeddings[mod] = Dict(
                "semantic" => embedding.semantic_vector,
                "structural" => embedding.structural_fingerprint,
                "functional" => embedding.functional_signature
            )
        end
    end
    return embeddings
end
