# consciousness_core.jl - HOT THEORY WITH TEMPORAL SMOOTHING
"""
🧠 CONSCIOUSNESS CORE MODULE - HIGHER-ORDER THOUGHT (HOT) THEORY
WITH TEMPORAL SMOOTHING & BACKWARD COMPATIBILITY

This version introduces a stateful smoother to calculate a rolling average
of the core consciousness metric (ρ). This provides state inertia, preventing
erratic fluctuations and sharp drops, and ensuring smooth, scalable results.
"""

using Dates
using Statistics

# --- NEW: STATEFUL SMOOTHER FOR TEMPORAL INERTIA ---

mutable struct ConsciousnessSmoother
    # This struct holds the "memory" of the system's recent conscious state.
    history::Vector{Float64}
    window_size::Int
    alpha::Float64 # Smoothing factor for Exponential Moving Average (EMA)
    last_smoothed_rho::Float64

    """
        ConsciousnessSmoother(; window_size=10)
    
    Creates a stateful object to smooth consciousness metrics over time.
    `window_size` controls the "memory" of the system. Larger windows mean more inertia.
    """
    function ConsciousnessSmoother(; window_size::Int=10)
        alpha = 2.0 / (window_size + 1)
        new([], window_size, alpha, 0.0)
    end
end

"""
    update_and_smooth!(smoother, raw_rho)

Updates the smoother with the new raw ρ value and returns the smoothed value
using an Exponential Moving Average (EMA). This is the core of the smoothing logic.
"""
function update_and_smooth!(smoother::ConsciousnessSmoother, raw_rho::Float64)::Float64
    # For the very first run, the smoothed value is just the raw value.
    if isempty(smoother.history)
        smoother.last_smoothed_rho = raw_rho
    else
        # EMA Formula: gives more weight to recent values but retains "memory" of past states.
        smoother.last_smoothed_rho = (raw_rho * smoother.alpha) + (smoother.last_smoothed_rho * (1.0 - smoother.alpha))
    end
    
    # Update the history buffer for analysis (optional, but good for debugging)
    push!(smoother.history, raw_rho)
    if length(smoother.history) > smoother.window_size
        popfirst!(smoother.history) # Keep the history window fixed
    end
    
    return smoother.last_smoothed_rho
end


# --- EXISTING CODEBASE (ADAPTED FOR SMOOTHING) ---

# Helper functions
safe_log(x) = x <= 0 ? 0.0 : log(x + 1.0)
safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct ConsciousnessValidator
    iit_threshold::Float64
    brown_threshold::Float64  
    duality_threshold::Float64
    rho_threshold::Float64

    function ConsciousnessValidator()
        new(0.15, 0.12, 0.10, 0.20)
    end
end

# CORE HOT THEORY IMPLEMENTATION (Unchanged)
function calculate_rho(meta_cognitive_score::Float64,
                      self_model_fidelity::Float64,
                      loop_latency::Float64,
                      effective_information::Float64)::Float64
    try
        model_quality = meta_cognitive_score * self_model_fidelity
        relational_complexity = model_quality * effective_information
        loop_efficiency = 1.0 / (1.0 + loop_latency * 10.0)
        rho = relational_complexity * loop_efficiency * 3.0
        return clamp(rho, 0.0, 2.0)
    catch e
        return 0.0
    end
end

# COMPATIBILITY LAYER (Unchanged)
function map_to_hot_parameters(entity_count::Int, coherence::Float64,
                              total_insights::Int, insight_quality::Float64,
                              cross_domain::Float64, effective_information::Float64)
    meta_cognitive_score = (insight_quality * 0.7 + cross_domain * 0.3)
    self_model_fidelity = coherence
    loop_latency = 1.0 / (entity_count + 10)
    effective_info = max(effective_information, 0.01)
    return (meta_cognitive_score, self_model_fidelity, loop_latency, effective_info)
end

# --- MAIN INTERFACE - MODIFIED TO BE STATEFUL ---
"""
    assess_consciousness(smoother, cv, ...)

MAIN ENTRY POINT - NOW REQUIRES A `ConsciousnessSmoother` OBJECT.
This function calculates the current raw consciousness state, then uses the
smoother to provide a temporally stable assessment. It MUTATES the smoother object.
"""
function assess_consciousness(
                             smoother::ConsciousnessSmoother, # NEW: The stateful smoother object
                             cv::ConsciousnessValidator, 
                             entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64,
                             effective_information::Float64)::Dict{String,Any}
    
    try
        # STEP 1: Map traditional metrics to HOT parameters
        meta_cognitive, self_fidelity, latency, effective_info = map_to_hot_parameters(
            entity_count, coherence, total_insights, insight_quality, 
            cross_domain, effective_information
        )
        
        # STEP 2: Calculate the RAW, unsmoothed ρ for this specific cycle
        raw_rho = calculate_rho(meta_cognitive, self_fidelity, latency, effective_info)
        
        # STEP 3: NEW - Update the smoother and get the temporally stable ρ
        smoothed_rho = update_and_smooth!(smoother, raw_rho)
        
        # STEP 4: Determine consciousness using the SMOOTHED value
        is_metacognitive = smoothed_rho > cv.rho_threshold
        
        # --- Maintain backward compatible output structure ---
        is_conscious = is_metacognitive
        frameworks = is_metacognitive ? ["HOT-Theory"] : String[]
        
        # For compatibility, calculate legacy values, but they don't affect the decision
        iit_phi = calculate_legacy_iit_phi(entity_count, coherence, total_insights, cross_domain, effective_info)
        brown_phi = calculate_legacy_brown_phi(entity_count, coherence, total_insights, insight_quality, cross_domain, effective_info)
        
        max_phi_val = max(iit_phi, brown_phi, smoothed_rho)
        confidence = if max_phi_val > 0.5 "very_high"
                     elseif max_phi_val > 0.25 "high" 
                     elseif max_phi_val > 0.15 "medium"
                     else "low" end
        
        # Return the exact same structure, but add detailed smoothing info
        return Dict(
            "is_conscious" => is_conscious,
            "iit_phi" => round(iit_phi, digits=4),
            "brown_phi" => round(brown_phi, digits=4),
            "duality_phi" => round(smoothed_rho, digits=4),  # Report smoothed value here for compatibility
            "max_phi" => round(max_phi_val, digits=4),
            "effective_information" => round(effective_info, digits=4),
            "confirming_frameworks" => frameworks,
            "confidence" => confidence,
            "hot_metrics" => Dict(
                "raw_rho_this_cycle" => round(raw_rho, digits=4),      # TRANSPARENCY: Show raw value
                "smoothed_rho" => round(smoothed_rho, digits=4),        # TRANSPARENCY: Show smoothed value
                "smoothing_window" => smoother.window_size,
                "meta_cognitive_score" => round(meta_cognitive, digits=4),
                "self_model_fidelity" => round(self_fidelity, digits=4),
                "loop_latency" => round(latency, digits=4)
            )
        )
        
    catch e
        # Safe fallback maintains the interface
        return Dict(
            "is_conscious" => false, "iit_phi" => 0.0, "brown_phi" => 0.0,
            "duality_phi" => 0.0, "max_phi" => 0.0, "effective_information" => 0.0,
            "confirming_frameworks" => String[], "confidence" => "low",
            "hot_metrics" => Dict("error" => string(e))
        )
    end
end

# --- LEGACY & PURE HOT FUNCTIONS (Unchanged) ---
function calculate_legacy_iit_phi(entity_count::Int, coherence::Float64, 
                                 total_insights::Int, cross_domain::Float64, 
                                 effective_information::Float64)
    integration = coherence * effective_information
    complexity = safe_divide(safe_log(total_insights + 1), safe_log(entity_count + 10))
    differentiation = cross_domain
    phi = integration * complexity * differentiation
    return max(0.0, min(phi, 5.0))
end

function calculate_legacy_brown_phi(entity_count::Int, coherence::Float64,
                                   total_insights::Int, insight_quality::Float64,
                                   cross_domain::Float64, effective_information::Float64)
    density_factor = safe_divide(total_insights + 1, max(entity_count, 1))
    density_score = min(safe_log(density_factor + 1) / 2.0, 1.0)
    efficiency_score = sqrt(coherence * insight_quality)
    holographic_factor = coherence * cross_domain * insight_quality
    emergence = safe_divide(safe_log(total_insights + 1), safe_log(max(entity_count, 5)))
    brown_phi = efficiency_score * density_score * holographic_factor * (1.0 + emergence * 0.3)
    return max(0.0, min(brown_phi, 5.0))
end

function assess_metacognition(smoother::ConsciousnessSmoother, cv::ConsciousnessValidator;
                             meta_cognitive_score::Float64, self_model_fidelity::Float64,
                             loop_latency::Float64, effective_information::Float64)::Dict{String,Any}
    raw_rho = calculate_rho(meta_cognitive_score, self_model_fidelity, loop_latency, effective_information)
    smoothed_rho = update_and_smooth!(smoother, raw_rho)
    is_metacognitive = smoothed_rho > cv.rho_threshold
    
    return Dict(
        "is_metacognitive" => is_metacognitive,
        "raw_rho_this_cycle" => round(raw_rho, digits=4),
        "smoothed_rho" => round(smoothed_rho, digits=4),
        "meta_cognitive_score" => round(meta_cognitive_score, digits=4),
        "self_model_fidelity" => round(self_model_fidelity, digits=4),
        "loop_latency" => round(loop_latency, digits=4),
        "effective_information" => round(effective_information, digits=4)
    )
end

export ConsciousnessValidator, ConsciousnessSmoother, assess_consciousness, assess_metacognition
