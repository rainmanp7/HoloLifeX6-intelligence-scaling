# proto_intelligence.jl
"""
🔍 PROTO-INTELLIGENCE MODULE
Emergent pattern recognition and learning
"""

using Statistics

# 🎯 ADDED: Safe divide function
safe_divide(a, b) = b == 0 ? 0.0 : a / b

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
    
    for i in 1:n
        bin_vector = Int[]
        for values in values_list
            bin_idx = min(Int(floor(values[i] * bins)) + 1, bins)
            push!(bin_vector, bin_idx)
        end
        
        # Convert to string key to avoid tuple conversion issues
        key = join(bin_vector, "_")
        joint_histogram[key] = get(joint_histogram, key, 0) + 1
    end
    
    probabilities = [count / n for count in values(joint_histogram)]
    joint_entropy = -sum([p > 0 ? p * log(p) : 0.0 for p in probabilities])
    
    max_entropy = log(length(probabilities))
    return max_entropy > 0 ? joint_entropy / max_entropy : 0.0
end

function calculate_effective_information(network)::Float64
    entities = network.entities
    if length(entities) < 2
        return 0.0
    end
    
    try
        # Get current phases for all entities
        current_phases = [e.phase for e in entities]
        
        if length(current_phases) < 2
            return 0.0
        end
        
        # Calculate actual phase coherence as integration measure
        coherence = calculate_phase_coherence(current_phases)
        
        # Calculate phase diversity (differentiation measure)
        phase_std = std(current_phases)
        phase_diversity = min(phase_std * 2.0, 1.0)  # Normalize to [0,1]
        
        # Effective information = integration × differentiation
        # High EI = system is both integrated AND differentiated
        effective_info = coherence * (0.3 + 0.7 * phase_diversity)
        
        # Scale by network size (larger networks can have higher EI)
        size_factor = min(length(entities) / 15.0, 1.0)
        
        return effective_info * size_factor
        
    catch e
        # Fallback: use simple coherence
        return length(entities) >= 2 ? 0.1 : 0.0
    end
end
