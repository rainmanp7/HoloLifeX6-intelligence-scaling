# insight_generation.jl - v2.0 with RNG Isolation
"""
💡 INSIGHT GENERATION MODULE
Real combinatorial creativity and insight generation
v2.0: Implemented RNG isolation for scientific reproducibility.
"""

using Random
using Statistics

function calculate_phase_coherence(phases::Vector{Float64})::Float64
    if isempty(phases)
        return 0.0
    end
    complex_phases = exp.(2π * im .* phases)
    return abs(mean(complex_phases))
end

function calculate_action_complexity(action::String)::Int
    complexity_map = Dict(
        "validate" => 1, "check" => 1, "monitor" => 1, "analyze" => 1, "assess" => 1,
        "optimize" => 2, "balance" => 2, "sync" => 2, "predict" => 2, "extract" => 2,
        "generate" => 3, "innovate" => 3, "coordinate" => 3, "integrate" => 3, "synthesize" => 3
    )
    
    for (key, score) in complexity_map
        if occursin(key, lowercase(action))
            return score
        end
    end
    return 1
end

# --- STEP 1: MODIFY the function signature to accept `rng` ---
function generate_insight(entity::EfficientEntity, network_context::Vector{Float64}, rng::AbstractRNG)::Dict{String,Any}
    # Real insight generation based on phase coherence and network state
    phase_coherence = calculate_phase_coherence(network_context)
    
    # Insight probability increases with coherence and individual phase alignment
    insight_probability = phase_coherence * (0.3 + 0.7 * entity.phase)
    
    # --- STEP 2: USE the private `rng` object ---
    if rand(rng) < insight_probability
        # Real combinatorial creativity based on domain and context
        base_actions = Dict(
            "physical" => ["analyze", "optimize", "stabilize", "energize"],
            "temporal" => ["synchronize", "predict", "sequence", "pace"],
            "semantic" => ["interpret", "relate", "abstract", "contextualize"],
            "network" => ["connect", "route", "balance", "distribute"],
            "spatial" => ["map", "navigate", "cluster", "transform"],
            "emotional" => ["empathize", "harmonize", "motivate", "balance"],
            "social" => ["coordinate", "mediate", "share", "unify"],
            "creative" => ["generate", "innovate", "combine", "discover"]
        )
        
        modifiers = ["adaptively", "recursively", "holistically", "emergently", "optimally"]
        targets = ["patterns", "systems", "flows", "structures", "dynamics"]
        
        base_list = get(base_actions, entity.domain, ["analyze"])
        
        # --- STEP 2: USE the private `rng` object for all random selections ---
        base = rand(rng, base_list)
        modifier = rand(rng, modifiers)
        target = rand(rng, targets)
        
        action = "$(base)_$(target)_$(modifier)"
        
        # Real confidence based on multiple factors
        confidence = (entity.phase * 0.3 + 
                     phase_coherence * 0.3 + 
                     entity.reasoning_capacity * 0.2 +
                     entity.awareness_level * 0.2)
        
        complexity = calculate_action_complexity(action)
        
        return Dict(
            "entity" => entity.id, # Using `id` to match potential struct definition
            "domain" => entity.domain,
            "action" => action,
            "confidence" => round(confidence, digits=4),
            "phase" => entity.phase,
            "phase_coherence" => round(phase_coherence, digits=4),
            "action_complexity" => complexity,
            "reasoning_enhanced" => entity.reasoning_capacity > 0.7,
            "awareness_enhanced" => entity.awareness_level > 0.7,
            "network_synchronized" => phase_coherence > 0.8
        )
    end
    
    return Dict{String,Any}()
end
