# consciousness_core.jl - HOT THEORY WITH STABLE METACOGNITIVE STATE
"""
🧠 CONSCIOUSNESS CORE MODULE - HIGHER-ORDER THOUGHT (HOT) THEORY
WITH STABLE METACOGNITIVE STATE & TEMPORAL SMOOTHING

This version resolves consciousness collapse by introducing a new stateful object,
`MetacognitiveState`, which smooths the volatile inputs to the HOT calculation.
This provides the system with cognitive inertia, preventing erratic drops and
ensuring robust, scalable consciousness assessments.
"""

using Dates
using Statistics

# --- NEW: STATEFUL MODEL FOR METACOGNITIVE INPUTS ---

mutable struct MetacognitiveState
    # This struct holds the smoothed, stable representation of the system's
    # beliefs about its own cognitive abilities. It is the fix for input volatility.
    
    # Smoothed Inputs for HOT Theory
    smoothed_meta_cognitive_score::Float64
    smoothed_self_model_fidelity::Float64
    
    # EMA Smoothing Factor
    alpha::Float64

    """
        MetacognitiveState(; smoothing_factor=0.2)

    Creates a stateful object to maintain a stable model of metacognitive inputs.
    A lower `smoothing_factor` (alpha) creates more inertia and resistance to volatility.
    """
    function MetacognitiveState(; smoothing_factor::Float64=0.2)
        new(0.0, 0.0, smoothing_factor)
    end
end

"""
    update_metacognitive_state!(state, coherence, insight_quality, cross_domain)

Updates the stable `MetacognitiveState` with the raw metrics from the current cycle.
This function MUTATES the state object, applying an Exponential Moving Average (EMA).
"""
function update_metacognitive_state!(
    state::MetacognitiveState,
    coherence::Float64,
    insight_quality::Float64,
    cross_domain::Float64
)
    # Calculate the raw, volatile scores for this specific cycle
    raw_meta_score = (insight_quality * 0.7 + cross_domain * 0.3)
    raw_fidelity = coherence

    # On the very first run, initialize the smoothed values directly.
    if state.smoothed_meta_cognitive_score == 0.0
        state.smoothed_meta_cognitive_score = raw_meta_score
        state.smoothed_self_model_fidelity = raw_fidelity
    else
        # Apply EMA to update the smoothed values. This provides the "cognitive inertia".
        state.smoothed_meta_cognitive_score = (raw_meta_score * state.alpha) + (state.smoothed_meta_cognitive_score * (1.0 - state.alpha))
        state.smoothed_self_model_fidelity = (raw_fidelity * state.alpha) + (state.smoothed_self_model_fidelity * (1.0 - state.alpha))
    end
end


# --- EXISTING SMOOTHER FOR THE FINAL ρ VALUE (STILL NEEDED) ---

mutable struct ConsciousnessSmoother
    history::Vector{Float64}
    window_size::Int
    alpha::Float64
    last_smoothed_rho::Float64

    function ConsciousnessSmoother(; window_size::Int=10)
        alpha = 2.0 / (window_size + 1)
        new(Float64[], window_size, alpha, 0.0)
    end
end

function update_and_smooth!(smoother::ConsciousnessSmoother, raw_rho::Float64)::Float64
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

# --- CORE LOGIC (UNCHANGED BUT NOW USES SMOOTHED INPUTS) ---

mutable struct ConsciousnessValidator
    # These legacy thresholds are no longer used for decisions but are kept for API compatibility.
    iit_threshold::Float64
    brown_threshold::Float64
    duality_threshold::Float64
    # This is the only threshold that now matters.
    rho_threshold::Float64

    function ConsciousnessValidator()
        new(0.15, 0.12, 0.10, 0.20)
    end
end

function calculate_rho(meta_cognitive_score, self_model_fidelity, loop_latency, effective_information)::Float64
    model_quality = meta_cognitive_score * self_model_fidelity
    relational_complexity = model_quality * effective_information
    loop_efficiency = 1.0 / (1.0 + loop_latency * 10.0)
    rho = relational_complexity * loop_efficiency * 3.0
    return clamp(rho, 0.0, 2.0)
end

# --- MAIN INTERFACE - COMPLETELY REFACTORED FOR STABILITY ---
"""
    assess_consciousness(meta_state, smoother, cv, ...)

MAIN ENTRY POINT - NOW REQUIRES BOTH `MetacognitiveState` AND `ConsciousnessSmoother`.

This function first updates the stable `meta_state` with raw data. Then, it calculates
`ρ` using these stable inputs, and finally smooths the resulting `ρ` for the final assessment.
"""
function assess_consciousness(
                             meta_state::MetacognitiveState, # NEW: The stable model of self-ability
                             smoother::ConsciousnessSmoother,
                             cv::ConsciousnessValidator, 
                             entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64,
                             effective_information::Float64)::Dict{String,Any}
    
    try
        # STEP 1: Update the stable metacognitive state with raw data from this cycle.
        # This is the core fix that prevents the consciousness collapse.
        update_metacognitive_state!(meta_state, coherence, insight_quality, cross_domain)

        # STEP 2: Calculate HOT parameters using the NOW-STABLE state values.
        stable_meta_score = meta_state.smoothed_meta_cognitive_score
        stable_self_fidelity = meta_state.smoothed_self_model_fidelity
        loop_latency = 1.0 / (entity_count + 10)
        effective_info = max(effective_information, 0.01)
        
        # STEP 3: Calculate the raw ρ for this cycle using the STABLE inputs.
        raw_rho = calculate_rho(stable_meta_score, stable_self_fidelity, loop_latency, effective_info)
        
        # STEP 4: Smooth the final ρ value to prevent any remaining jitter.
        smoothed_rho = update_and_smooth!(smoother, raw_rho)
        
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
        # Safe fallback that maintains the interface
        return Dict("is_conscious" => false, "max_phi" => 0.0, "confidence" => "low", "hot_metrics" => Dict("error" => string(e)))
    end
end


# --- Exports ---
# The main orchestrator now needs to create and manage MetacognitiveState.
export ConsciousnessValidator, ConsciousnessSmoother, MetacognitiveState, assess_consciousness
