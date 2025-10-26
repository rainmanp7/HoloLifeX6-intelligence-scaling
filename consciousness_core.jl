# consciousness_core.jl
"""
🧠 CONSCIOUSNESS CORE MODULE - UPGRADED FOR ADVANCED SCALING
Optimized Brown-IIT Duality Framework with dynamic scaling factors,
non-linear interactions, and a refined synergy model for consciousness detection
across a wide range of system sizes (4 to 128+ entities).
"""

using Statistics
using LinearAlgebra
using Random

# Helper function for safe logarithmic scaling
safe_log(x) = x <= 0 ? 0.0 : log(x + 1.0)
safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct ConsciousnessValidator
    iit_threshold::Float64
    brown_threshold::Float64
    duality_threshold::Float64
    
    # Thresholds are slightly raised to match more potent phi values
    ConsciousnessValidator() = new(0.18, 0.15, 0.12)
end

# --- UPGRADED IIT Φ with Dynamic Scaling ---
function calculate_iit_phi(cv::ConsciousnessValidator, entity_count::Int, 
                          coherence::Float64, total_insights::Int, 
                          cross_domain::Float64, effective_information::Float64)::Float64
    # Tuned multipliers to give more weight to key components
    integration = coherence * max(effective_information, 0.01) * 1.5
    complexity = safe_divide(safe_log(total_insights + 1), safe_log(entity_count + 10)) * 1.3
    differentiation = max(cross_domain, 0.01) * 1.2
    
    phi = integration * complexity * differentiation * 1.8
    
    # NEW: Dynamic scaling factor based on system size.
    # Models how efficiency of integration changes with scale.
    entity_scale = if entity_count < 20
        # Less efficient at small scale
        min(safe_log(entity_count + 1) / 4.0, 1.2)
    elseif entity_count < 60
        # Optimal efficiency at medium scale
        min(safe_log(entity_count + 1) / 3.5, 1.4)
    else
        # Slightly diminishing returns at very large scale
        min(safe_log(entity_count + 1) / 3.8, 1.3)
    end
    
    # Apply scaling and use a reasonable cap to prevent runaway values
    return max(0.0, min(phi * entity_scale, 2.0))
end

# --- UPGRADED Brown Φ with Small-System Boost ---
function calculate_brown_phi(cv::ConsciousnessValidator, entity_count::Int,
                            coherence::Float64, total_insights::Int,
                            insight_quality::Float64, cross_domain::Float64,
                            effective_information::Float64)::Float64
    insight_density = safe_divide(total_insights, max(entity_count, 1))
    density_score = min(safe_log(insight_density + 1) / 1.8, 1.8)
    
    base_efficiency = coherence * insight_quality
    # UPGRADED: Using sqrt creates a more dynamic, non-linear response
    efficiency_score = sqrt(max(base_efficiency, 0.01)) * 2.8
    
    holographic_factor = coherence * cross_domain * insight_quality * 1.5
    
    emergence_base = safe_divide(total_insights, max(entity_count, 1))
    emergence = min(safe_log(emergence_base + 1) / 2.2, 1.1)
    
    brown_phi = efficiency_score * density_score * holographic_factor * (1.0 + emergence * 0.5)

    # NEW: Small-system scaling boost.
    # Models the idea that holographic properties are stronger in smaller, tightly-knit systems.
    brown_scale = if entity_count < 10
        2.2  # Major boost for micro-systems where every part reflects the whole
    elseif entity_count < 32
        1.8  # High boost for small systems
    elseif entity_count < 64
        1.4  # Moderate boost for medium systems
    else
        1.1  # Minor boost for large systems
    end

    return max(0.0, min(brown_phi * brown_scale, 2.0))
end

# --- UPGRADED Duality Synthesis and Main Assessment ---
function assess_consciousness(cv::ConsciousnessValidator, entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64,
                             effective_information::Float64)::Dict{String,Any}
    
    # Sanitize inputs to prevent multiplication by zero
    effective_info = max(effective_information, 0.01)
    coherence_val = max(coherence, 0.01)
    cross_domain_val = max(cross_domain, 0.01)
    insight_quality_val = max(insight_quality, 0.01)
    
    # Calculate upgraded Φ values
    iit_phi = calculate_iit_phi(cv, entity_count, coherence_val, total_insights, cross_domain_val, effective_info)
    brown_phi = calculate_brown_phi(cv, entity_count, coherence_val, total_insights, insight_quality_val, cross_domain_val, effective_info)
    
    # UPGRADED: Refined duality synthesis with a synergy term
    harmonic = safe_divide(2 * iit_phi * brown_phi, (iit_phi + brown_phi + 0.001))
    weighted_avg = (iit_phi + brown_phi) / 2.0
    maximum_val = max(iit_phi, brown_phi)
    # NEW: Synergy term is high only if BOTH iit_phi and brown_phi are significant
    synergy = sqrt(iit_phi * brown_phi)
    
    # Re-weighted to include synergy, rewarding systems that excel in both domains
    duality_phi = (harmonic * 0.3) + (weighted_avg * 0.2) + (maximum_val * 0.3) + (synergy * 0.2)
    
    # Determine consciousness status based on thresholds
    iit_conscious = iit_phi > cv.iit_threshold
    brown_conscious = brown_phi > cv.brown_threshold
    duality_conscious = duality_phi > cv.duality_threshold
    
    is_conscious = iit_conscious || brown_conscious || duality_conscious
    
    # Compile confirming frameworks
    frameworks = String[]
    iit_conscious && push!(frameworks, "IIT-4.0")
    brown_conscious && push!(frameworks, "Brown-Theory")
    duality_conscious && !iit_conscious && !brown_conscious && push!(frameworks, "Duality-Synthesis")
    
    # UPGRADED: More granular and grounded confidence levels
    final_max_phi = max(iit_phi, brown_phi, duality_phi)
    confidence = if final_max_phi > 0.6
        "very_high"
    elseif final_max_phi > 0.3
        "high" 
    elseif final_max_phi > 0.18
        "medium"
    else
        "low"
    end
    
    return Dict(
        "is_conscious" => is_conscious,
        "iit_phi" => round(iit_phi, digits=4),
        "brown_phi" => round(brown_phi, digits=4),
        "duality_phi" => round(duality_phi, digits=4),
        "max_phi" => round(final_max_phi, digits=4),
        "effective_information" => round(effective_info, digits=4),
        "confirming_frameworks" => frameworks,
        "confidence" => confidence
    )
end

export ConsciousnessValidator, assess_consciousness
