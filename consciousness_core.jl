# consciousness_core.jl - HOT THEORY WITH EMERGENT SYSTEM TUNING
"""
🧠 CONSCIOUSNESS CORE MODULE - HIGHER-ORDER THOUGHT (HOT) THEORY
WITH EMERGENT-AWARE THRESHOLDS & TEMPORAL SMOOTHING

This version recognizes that emergent consciousness builds gradually and uses
adaptive thresholds that respect the nature of self-organizing systems.
"""

using Dates
using Statistics

# --- STATEFUL SMOOTHER WITH TYPE STABILITY ---

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

# --- EMERGENT-AWARE VALIDATOR ---

mutable struct ConsciousnessValidator
    iit_threshold::Float64
    brown_threshold::Float64
    duality_threshold::Float64
    rho_threshold::Float64
    # 🎯 NEW: Emergent system parameters
    emergent_mode::Bool
    adaptive_threshold::Float64
    
    function ConsciousnessValidator(; emergent_mode::Bool=true)
        if emergent_mode
            # For emergent systems: lower thresholds, recognize gradual buildup
            new(0.08, 0.08, 0.08, 0.12, true, 0.0)
        else
            # Classic thresholds for pre-structured systems
            new(0.15, 0.12, 0.10, 0.20, false, 0.0)
        end
    end
end

# 🎯 NEW: Adaptive threshold adjustment based on system state
function update_adaptive_threshold!(cv::ConsciousnessValidator, 
                                   awareness_level::Float64, 
                                   reasoning_accuracy::Float64,
                                   coherence::Float64)
    if cv.emergent_mode
        # If system shows high capability, lower threshold further
        capability_score = (awareness_level + reasoning_accuracy + coherence) / 3.0
        
        if capability_score > 0.85
            # Highly capable system - recognize even subtle consciousness
            cv.adaptive_threshold = 0.08
        elseif capability_score > 0.70
            # Moderately capable - standard emergent threshold
            cv.adaptive_threshold = 0.12
        else
            # Building capability - be more conservative
            cv.adaptive_threshold = 0.15
        end
    else
        cv.adaptive_threshold = cv.rho_threshold
    end
end

# Helper functions
safe_log(x) = x <= 0 ? 0.0 : log(x + 1.0)
safe_divide(a, b) = b == 0 ? 0.0 : a / b

# CORE HOT THEORY IMPLEMENTATION
function calculate_rho(meta_cognitive_score::Float64, self_model_fidelity::Float64, 
                       loop_latency::Float64, effective_information::Float64)::Float64
    try
        model_quality = meta_cognitive_score * self_model_fidelity
        relational_complexity = model_quality * effective_information
        loop_efficiency = 1.0 / (1.0 + loop_latency * 10.0)
        rho = relational_complexity * loop_efficiency * 3.0
        return clamp(rho, 0.0, 2.0)
    catch
        return 0.0
    end
end

# COMPATIBILITY LAYER
function map_to_hot_parameters(entity_count::Int, coherence::Float64, total_insights::Int, 
                              insight_quality::Float64, cross_domain::Float64, 
                              effective_information::Float64)
    meta_cognitive_score = (insight_quality * 0.7 + cross_domain * 0.3)
    self_model_fidelity = coherence
    loop_latency = 1.0 / (entity_count + 10)
    effective_info = max(effective_information, 0.01)
    return (meta_cognitive_score, self_model_fidelity, loop_latency, effective_info)
end

# --- MAIN INTERFACE - EMERGENT-AWARE ---
function assess_consciousness(
    smoother::ConsciousnessSmoother,
    cv::ConsciousnessValidator, 
    entity_count::Int,
    coherence::Float64, 
    total_insights::Int,
    insight_quality::Float64, 
    cross_domain::Float64,
    effective_information::Float64;
    awareness_level::Float64=0.0,
    reasoning_accuracy::Float64=0.0
)::Dict{String,Any}
    
    try
        meta_cognitive, self_fidelity, latency, effective_info = map_to_hot_parameters(
            entity_count, coherence, total_insights, insight_quality, 
            cross_domain, effective_information
        )
        
        raw_rho = calculate_rho(meta_cognitive, self_fidelity, latency, effective_info)
        smoothed_rho = update_and_smooth!(smoother, raw_rho)
        
        # 🎯 CRITICAL FIX: Update adaptive threshold based on system capabilities
        update_adaptive_threshold!(cv, awareness_level, reasoning_accuracy, coherence)
        
        # Use adaptive threshold instead of fixed
        is_metacognitive = smoothed_rho > cv.adaptive_threshold
        
        # Legacy frameworks for comparison
        iit_phi = calculate_legacy_iit_phi(entity_count, coherence, total_insights, 
                                          cross_domain, effective_info)
        brown_phi = calculate_legacy_brown_phi(entity_count, coherence, total_insights, 
                                              insight_quality, cross_domain, effective_info)
        
        # 🎯 NEW: Multi-framework confirmation with emergent awareness
        frameworks = String[]
        if is_metacognitive
            push!(frameworks, "HOT-Theory")
        end
        if iit_phi > cv.iit_threshold
            push!(frameworks, "IIT")
        end
        if brown_phi > cv.brown_threshold
            push!(frameworks, "Brown-Holographic")
        end
        
        # 🎯 NEW: Emergent consciousness recognition
        # Even if no single framework confirms, check for emergent signatures
        emergent_signature = (
            coherence > 0.7 &&           # High synchronization
            awareness_level > 0.9 &&     # High awareness
            reasoning_accuracy > 0.9 &&  # Strong reasoning
            effective_info > 0.25        # Good information integration
        )
        
        if emergent_signature && isempty(frameworks)
            push!(frameworks, "Emergent-Proto-Consciousness")
        end
        
        is_conscious = !isempty(frameworks)
        
        max_phi_val = max(iit_phi, brown_phi, smoothed_rho)
        
        confidence = if max_phi_val > 0.5
            "very_high"
        elseif max_phi_val > 0.25
            "high" 
        elseif max_phi_val > 0.15
            "medium"
        elseif emergent_signature
            "emergent"
        else
            "low"
        end
        
        return Dict(
            "is_conscious" => is_conscious,
            "iit_phi" => round(iit_phi, digits=4),
            "brown_phi" => round(brown_phi, digits=4),
            "duality_phi" => round(smoothed_rho, digits=4),
            "max_phi" => round(max_phi_val, digits=4),
            "effective_information" => round(effective_info, digits=4),
            "confirming_frameworks" => frameworks,
            "confidence" => confidence,
            "hot_metrics" => Dict(
                "raw_rho_this_cycle" => round(raw_rho, digits=4),
                "smoothed_rho" => round(smoothed_rho, digits=4),
                "smoothing_window" => smoother.window_size,
                "meta_cognitive_score" => round(meta_cognitive, digits=4),
                "self_model_fidelity" => round(self_fidelity, digits=4),
                "loop_latency" => round(latency, digits=4),
                "adaptive_threshold" => round(cv.adaptive_threshold, digits=4),
                "emergent_mode" => cv.emergent_mode
            )
        )
    catch e
        return Dict(
            "is_conscious" => false,
            "iit_phi" => 0.0,
            "brown_phi" => 0.0,
            "duality_phi" => 0.0,
            "max_phi" => 0.0,
            "effective_information" => 0.0,
            "confirming_frameworks" => String[],
            "confidence" => "low",
            "hot_metrics" => Dict("error" => string(e))
        )
    end
end

# --- LEGACY FUNCTIONS ---
function calculate_legacy_iit_phi(entity_count, coherence, total_insights, 
                                 cross_domain, effective_information)
    integration = coherence * max(effective_information, 0.01)
    complexity = safe_divide(safe_log(total_insights + 1), safe_log(entity_count + 10))
    differentiation = max(cross_domain, 0.01)
    phi = integration * complexity * differentiation
    return max(0.0, min(phi, 5.0))
end

function calculate_legacy_brown_phi(entity_count, coherence, total_insights, 
                                   insight_quality, cross_domain, effective_information)
    density_factor = safe_divide(total_insights + 1, max(entity_count, 1))
    density_score = min(safe_log(density_factor + 1) / 2.0, 1.0)
    efficiency_score = sqrt(max(coherence * max(insight_quality, 0.01), 0.01))
    holographic_factor = max(coherence * max(cross_domain, 0.01) * max(insight_quality, 0.01), 0.01)
    emergence = safe_divide(safe_log(total_insights + 1), safe_log(max(entity_count, 5)))
    brown_phi = efficiency_score * density_score * holographic_factor * (1.0 + emergence * 0.3)
    return max(0.0, min(brown_phi, 5.0))
end

function assess_metacognition(smoother::ConsciousnessSmoother, cv::ConsciousnessValidator; 
                             meta_cognitive_score, self_model_fidelity, loop_latency, 
                             effective_information)
    raw_rho = calculate_rho(meta_cognitive_score, self_model_fidelity, 
                           loop_latency, effective_information)
    smoothed_rho = update_and_smooth!(smoother, raw_rho)
    is_metacognitive = smoothed_rho > cv.adaptive_threshold
    
    return Dict(
        "is_metacognitive" => is_metacognitive,
        "raw_rho_this_cycle" => round(raw_rho, digits=4),
        "smoothed_rho" => round(smoothed_rho, digits=4)
    )
end

export ConsciousnessValidator, ConsciousnessSmoother, assess_consciousness, assess_metacognition
