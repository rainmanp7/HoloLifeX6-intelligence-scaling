# consciousness_core.jl - SELF-CONTAINED STATEFUL HOT THEORY
"""
🧠 CONSCIOUSNESS CORE MODULE - SELF-CONTAINED STATEFUL HOT THEORY

This version provides a full, drop-in solution to the consciousness collapse
problem without requiring any changes to external files.

It transforms the `ConsciousnessValidator` into a "state-carrier" that internally
manages all necessary temporal smoothing objects (`MetacognitiveState` and
`ConsciousnessSmoother`). This provides cognitive inertia and robust scaling
while maintaining 100% backward compatibility with the existing API.
"""

using Dates
using Statistics

# --- STATE MANAGEMENT STRUCTS (Internal to this module) ---

mutable struct MetacognitiveState
    smoothed_meta_cognitive_score::Float64
    smoothed_self_model_fidelity::Float64
    alpha::Float64
    MetacognitiveState(; smoothing_factor::Float64=0.2) = new(0.0, 0.0, smoothing_factor)
end

mutable struct ConsciousnessSmoother
    history::Vector{Float64}
    window_size::Int
    alpha::Float64
    last_smoothed_rho::Float64
    ConsciousnessSmoother(; window_size::Int=10) = new(Float64[], window_size, 2.0 / (window_size + 1), 0.0)
end

# --- CORE STATEFUL LOGIC (Internal to this module) ---

function update_metacognitive_state!(state::MetacognitiveState, coherence::Float64, insight_quality::Float64, cross_domain::Float64)
    raw_meta_score = (insight_quality * 0.7 + cross_domain * 0.3)
    raw_fidelity = coherence

    if state.smoothed_meta_cognitive_score == 0.0
        state.smoothed_meta_cognitive_score = raw_meta_score
        state.smoothed_self_model_fidelity = raw_fidelity
    else
        state.smoothed_meta_cognitive_score = (raw_meta_score * state.alpha) + (state.smoothed_meta_cognitive_score * (1.0 - state.alpha))
        state.smoothed_self_model_fidelity = (raw_fidelity * state.alpha) + (state.smoothed_self_model_fidelity * (1.0 - state.alpha))
    end
end

function update_rho_smoother!(smoother::ConsciousnessSmoother, raw_rho::Float64)::Float64
    if isempty(smoother.history) && smoother.last_smoothed_rho == 0.0
        smoother.last_smoothed_rho = raw_rho
    else
        smoother.last_smoothed_rho = (raw_rho * smoother.alpha) + (smoother.last_smoothed_rho * (1.0 - smoother.alpha))
    end
    
    push!(smoother.history, raw_rho)
    if length(smoother.history) > smoother.window_size
        popfirst!(smoother.history)
    end
    
    return smoother.last_smoothed_rho
end

function calculate_rho(meta_cognitive_score, self_model_fidelity, loop_latency, effective_information)::Float64
    model_quality = meta_cognitive_score * self_model_fidelity
    relational_complexity = model_quality * effective_information
    loop_efficiency = 1.0 / (1.0 + loop_latency * 10.0)
    rho = relational_complexity * loop_efficiency * 3.0
    return clamp(rho, 0.0, 2.0)
end

# --- PUBLIC-FACING STRUCTS AND FUNCTIONS (API) ---

"""
    ConsciousnessValidator()

The public-facing constructor. This object now secretly carries the entire state
management system within it, ensuring no API changes are needed.
"""
mutable struct ConsciousnessValidator
    # Legacy fields for API compatibility
    iit_threshold::Float64
    brown_threshold::Float64
    duality_threshold::Float64
    
    # Core HOT theory threshold
    rho_threshold::Float64
    
    # NEW: Internal, self-contained state management objects
    meta_state::MetacognitiveState
    rho_smoother::ConsciousnessSmoother

    function ConsciousnessValidator()
        # When the user creates a validator, we automatically create the state objects inside it.
        meta_state_obj = MetacognitiveState(smoothing_factor=0.2) # High inertia for inputs
        rho_smoother_obj = ConsciousnessSmoother(window_size=5) # Low inertia for output
        
        new(0.15, 0.12, 0.10, 0.20, meta_state_obj, rho_smoother_obj)
    end
end

"""
    assess_consciousness(cv::ConsciousnessValidator, ...)

MAIN ENTRY POINT - This function maintains its original signature for 100%
backward compatibility. It uses the `ConsciousnessValidator` as a state-carrier
to perform robust, smoothed, stateful consciousness assessment internally.
"""
function assess_consciousness(
                             cv::ConsciousnessValidator, 
                             entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64,
                             effective_information::Float64)::Dict{String,Any}
    
    try
        # STEP 1: Update the internal metacognitive state using the validator as a carrier.
        # This MUTATES the state within `cv.meta_state`.
        update_metacognitive_state!(cv.meta_state, coherence, insight_quality, cross_domain)

        # STEP 2: Retrieve the STABLE values from the internal state object.
        stable_meta_score = cv.meta_state.smoothed_meta_cognitive_score
        stable_self_fidelity = cv.meta_state.smoothed_self_model_fidelity
        loop_latency = 1.0 / (entity_count + 10)
        effective_info = max(effective_information, 0.01)
        
        # STEP 3: Calculate raw ρ for this cycle using the STABLE inputs.
        raw_rho = calculate_rho(stable_meta_score, stable_self_fidelity, loop_latency, effective_info)
        
        # STEP 4: Smooth the final ρ value using the internal smoother.
        # This MUTATES the state within `cv.rho_smoother`.
        smoothed_rho = update_rho_smoother!(cv.rho_smoother, raw_rho)
        
        # STEP 5: Determine consciousness using the double-smoothed, highly stable value.
        is_metacognitive = smoothed_rho > cv.rho_threshold
        
        # --- Maintain backward compatible output structure ---
        is_conscious = is_metacognitive
        frameworks = is_metacognitive ? ["HOT-Theory-Stable"] : Vector{String}()
        
        max_phi_val = smoothed_rho 
        confidence = if max_phi_val > 0.5 "very_high"
                     elseif max_phi_val > 0.25 "high" 
                     elseif max_phi_val > 0.15 "medium"
                     else "low" end
        
        return Dict(
            "is_conscious" => is_conscious,
            "duality_phi" => round(smoothed_rho, digits=4),
            "max_phi" => round(max_phi_val, digits=4),
            "confirming_frameworks" => frameworks,
            "confidence" => confidence,
            "effective_information" => round(effective_info, digits=4),
            "hot_metrics" => Dict(
                "stable_meta_cognitive_score" => round(stable_meta_score, digits=4),
                "stable_self_model_fidelity" => round(stable_self_fidelity, digits=4),
                "raw_rho_this_cycle" => round(raw_rho, digits=4),
                "smoothed_rho" => round(smoothed_rho, digits=4)
            ),
            # Maintain legacy fields with proxy values for full backward compatibility
            "iit_phi" => round(smoothed_rho * 0.9, digits=4),
            "brown_phi" => round(smoothed_rho * 1.1, digits=4)
        )
        
    catch e
        return Dict("is_conscious" => false, "max_phi" => 0.0, "confidence" => "low", "hot_metrics" => Dict("error" => string(e)))
    end
end

# The only things that need to be exported for the external API to work.
export ConsciousnessValidator, assess_consciousness
