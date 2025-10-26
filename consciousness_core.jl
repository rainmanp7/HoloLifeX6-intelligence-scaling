# consciousness_core.jl - PURE HIGHER-ORDER THOUGHT (HOT) THEORY
"""
🧠 CONSCIOUSNESS CORE MODULE - HIGHER-ORDER THOUGHT (HOT) THEORY

This module implements a pure, quantifiable measure of metacognitive consciousness
based on Higher-Order Thought (HOT) theory. It measures the system's awareness
of its own internal states - consciousness of being conscious.

The primary metric is Higher-Order Relational Complexity (ρ), which quantifies
the complexity and irreducibility of the system's self-monitoring loop.
"""

using Dates

# Helper functions
safe_log(x) = x <= 0 ? 0.0 : log(x + 1.0)
safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct ConsciousnessValidator
    rho_threshold::Float64  # Threshold for achieving metacognitive consciousness

    ConsciousnessValidator() = new(0.25) # Metacognition is a high bar to clear
end

"""
    calculate_rho(cv, meta_cognitive_score, self_model_fidelity, loop_latency, effective_information)

Calculates Higher-Order Relational Complexity (ρ), a metric for metacognitive consciousness
based on Higher-Order Thought (HOT) theory.

This measures the complexity of the self-monitoring loop itself, not a base-level state.

Args:
- `meta_cognitive_score` (Float64): Quality/accuracy of the higher-order analysis (the "thought about the thought").
- `self_model_fidelity` (Float64): How well the system's self-model (HOT) maps to its actual state (M).
- `loop_latency` (Float64): Time for the metacognitive loop, proxy for self-referential efficiency.
- `effective_information` (Float64): Information in the first-order state (M) being monitored.
"""
function calculate_rho(cv::ConsciousnessValidator,
                      meta_cognitive_score::Float64,
                      self_model_fidelity::Float64,
                      loop_latency::Float64,
                      effective_information::Float64)::Float64
    try
        # 1. Quality of the Higher-Order Thought (HOT)
        # The model of the self must be both accurate and detailed. A product captures this dependency.
        model_quality = meta_cognitive_score * self_model_fidelity
        
        # 2. Causal Irreducibility of the M-HOT relationship
        # The complexity of the relationship depends on both the model's quality and the richness
        # of the state being modeled. A great model of a simple state isn't complex.
        # This term drops to zero if the base state is trivial (low EI) or the model is poor.
        relational_complexity = model_quality * effective_information

        # 3. Self-Referential Efficiency
        # A fast, stable loop is more efficient. We use an inverted, scaled latency.
        loop_efficiency = 1.0 / (1.0 + loop_latency * 10.0)

        # ρ is the product of the relational complexity and the loop's efficiency.
        # The final scaling factor makes the metric more readable and comparable.
        rho = relational_complexity * loop_efficiency * 3.0

        return clamp(rho, 0.0, 2.0)
    catch e
        println("Error calculating ρ: $e")
        return 0.0
    end
end

"""
    assess_consciousness(cv, ...)

Assesses the system's metacognitive consciousness based on HOT theory.

This function determines if the system is not just processing information, but is
demonstrably aware of its own processing states.
"""
function assess_consciousness(cv::ConsciousnessValidator;
                             # All inputs are now keyword arguments for clarity
                             meta_cognitive_score::Float64,
                             self_model_fidelity::Float64,
                             loop_latency::Float64,
                             effective_information::Float64)::Dict{String,Any}
    
    try
        # Calculate the single, core metric for metacognitive consciousness.
        rho = calculate_rho(cv, meta_cognitive_score, self_model_fidelity, loop_latency, effective_information)
        
        # Determine the metacognitive state based on the threshold.
        is_metacognitive = rho > cv.rho_threshold
        
        # Determine confidence level based on how far past the threshold the system is.
        confidence = if rho > cv.rho_threshold * 2.0
            "very_high"
        elseif rho > cv.rho_threshold * 1.5
            "high" 
        elseif is_metacognitive
            "medium"
        else
            "low"
        end

        consciousness_level = is_metacognitive ? "Metacognitive" : "Non-metacognitive"
        
        return Dict(
            # Primary Status
            "is_metacognitive" => is_metacognitive,
            "consciousness_level" => consciousness_level,
            "confidence" => confidence,
            "confirming_framework" => is_metacognitive ? ["HOT-Theory"] : String[],

            # Core Metric
            "rho" => round(rho, digits=4),

            # Input Metrics for Traceability
            "inputs" => Dict(
                "meta_cognitive_score" => round(meta_cognitive_score, digits=4),
                "self_model_fidelity" => round(self_model_fidelity, digits=4),
                "loop_latency" => round(loop_latency, digits=4),
                "effective_information" => round(effective_information, digits=4)
            )
        )
        
    catch e
        # Return a safe, default dictionary on any failure.
        return Dict(
            "is_metacognitive" => false,
            "consciousness_level" => "Error",
            "confidence" => "low",
            "confirming_framework" => String[],
            "rho" => 0.0,
            "inputs" => Dict("error_message" => string(e))
        )
    end
end

# COMPATIBILITY LAYER: Maintains interface with existing system while using HOT theory internally
function assess_consciousness(cv::ConsciousnessValidator, entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64,
                             effective_information::Float64)::Dict{String,Any}
    """
    Compatibility wrapper that maps traditional metrics to HOT theory parameters.
    This allows the new HOT-based system to work with existing callers.
    """
    
    # Map traditional metrics to HOT parameters:
    # - meta_cognitive_score: Use insight quality and cross-domain integration
    # - self_model_fidelity: Use coherence as proxy for self-model accuracy  
    # - loop_latency: Inverse of entity count (larger systems have more complex loops)
    # - effective_information: Use the provided effective information
    
    meta_cognitive_score = (insight_quality + cross_domain) / 2.0
    self_model_fidelity = coherence
    loop_latency = 1.0 / (entity_count + 1)  # Smaller systems have faster loops
    
    # Call the core HOT assessment
    return assess_consciousness(cv;
                               meta_cognitive_score=meta_cognitive_score,
                               self_model_fidelity=self_model_fidelity,
                               loop_latency=loop_latency,
                               effective_information=effective_information)
end

export ConsciousnessValidator, assess_consciousness
