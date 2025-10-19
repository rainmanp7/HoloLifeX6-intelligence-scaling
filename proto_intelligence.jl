# proto_intelligence.jl
"""
🔍 PROTO-INTELLIGENCE MODULE
Emergent pattern recognition and learning
"""

using Statistics

mutable struct ProtoIntelligence
    pattern_memory::Dict{String, Int}
    discovery_count::Int
    
    ProtoIntelligence() = new(Dict{String, Int}(), 0)
end

function observe_pattern(pi::ProtoIntelligence, pattern::String)
    if haskey(pi.pattern_memory, pattern)
        pi.pattern_memory[pattern] += 1
    else
        pi.pattern_memory[pattern] = 1
        pi.discovery_count += 1
    end
end

function recognize_emergent_patterns(pi::ProtoIntelligence, insights::Vector{Dict{String,Any}})::Int
    new_patterns = 0
    
    for insight in insights
        if haskey(insight, "action") && haskey(insight, "domain")
            pattern = "$(insight["domain"]):$(insight["action"])"
            old_count = get(pi.pattern_memory, pattern, 0)
            observe_pattern(pi, pattern)
            if old_count == 0
                new_patterns += 1
            end
        end
    end
    return new_patterns
end

function calculate_proto_intelligence(pi::ProtoIntelligence)::Float64
    if isempty(pi.pattern_memory)
        return 0.0
    end
    
    unique_patterns = length(pi.pattern_memory)
    total_observations = sum(values(pi.pattern_memory))
    pattern_diversity = safe_divide(unique_patterns, total_observations)
    
    repeated_patterns = count(v -> v > 1, values(pi.pattern_memory))
    learning_indicator = safe_divide(repeated_patterns, unique_patterns)
    
    proto_iq = (pattern_diversity * 0.6 + learning_indicator * 0.4) * min(unique_patterns / 10, 1.0)
    return min(proto_iq, 1.0)
end

# Information Integration Functions
function calculate_entropy(values::Vector{Float64}, bins::Int=10)::Float64
    # Real entropy calculation
    if isempty(values)
        return 0.0
    end
    
    histogram = zeros(Int, bins)
    bin_size = 1.0 / bins
    
    for v in values
        bin_idx = min(Int(floor(v / bin_size)) + 1, bins)
        histogram[bin_idx] += 1
    end
    
    probabilities = histogram ./ length(values)
    entropy = -sum([p > 0 ? p * log(p) : 0.0 for p in probabilities])
    
    return entropy / log(bins)  # Normalized entropy
end

function calculate_joint_entropy(values_list::Vector{Vector{Float64}}, bins::Int=10)::Float64
    # Real joint entropy calculation - FIXED VERSION
    if isempty(values_list) || any(isempty.(values_list))
        return 0.0
    end
    
    n = length(values_list[1])
    joint_histogram = Dict{String, Int}()  # Use String keys instead of Vector{Int}
    
   
