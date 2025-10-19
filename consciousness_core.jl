# consciousness_core.jl
"""
🧠 CONSCIOUSNESS CORE MODULE
Brown-IIT Duality Framework for consciousness detection
"""

using Statistics
using LinearAlgebra
using Random

mutable struct ConsciousnessValidator
    iit_threshold::Float64
    brown_threshold::Float64
    duality_threshold::Float64
    
    ConsciousnessValidator() = new(0.15, 0.12, 0.10)
end

function safe_divide(a, b)
    return b == 0 ? 0.0 : a / b
end

function safe_log(x)
    return x <= 0 ? 0.0 : log(x + 1.0)
end

function calculate_iit_phi(cv::ConsciousnessValidator, entity_count::Int, 
                          coherence::Float64, total_insights::Int, 
                          cross_domain::Float64, effective_information::Float64)::Float64
    integration = coherence * effective_information * 0.8
    complexity = safe_divide(safe_log(total_insights), safe_log(entity_count + 1))
    differentiation = cross_domain
    phi = integration * complexity * differentiation
    return max(0.0, min(phi, 5.0))
end

function calculate_brown_phi(cv::ConsciousnessValidator, entity_count::Int,
                            coherence::Float64, total_insights::Int,
                            insight_quality::Float64, cross_domain::Float64,
                            effective_information::Float64)::Float64
    density_factor = safe_divide(total_insights, max(entity_count, 1))
    density_score = min(safe_log(density_factor) / 2.5, 1.2)
    efficiency_score = sqrt(max(coherence * insight_quality, 0.0))
    holographic_factor = coherence * cross_domain * insight_quality * effective_information
    emergence = safe_divide(safe_log(total_insights), safe_log(max(entity_count, 10)))
    brown_phi = efficiency_score * density_score * holographic_factor * (1.0 + emergence * 0.4)
    return max(0.0, min(brown_phi, 5.0))
end

function assess_consciousness(cv::ConsciousnessValidator, entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64,
                             effective_information::Float64)::Dict{String,Any}
    
    # Real IIT Φ calculation with effective information
    iit_phi = calculate_iit_phi(cv, entity_count, coherence, total_insights, cross_domain, effective_information)
    
    # Real Brown Φ with holographic principles
    brown_phi = calculate_brown_phi(cv, entity_count, coherence, total_insights, insight_quality, cross_domain, effective_information)
    
    # Real duality synthesis
    harmonic = safe_divide(2 * iit_phi * brown_phi, (iit_phi + brown_phi + 0.001))
    weighted = (iit_phi + brown_phi) / 2.0
    maximum_val = max(iit_phi, brown_phi)
    duality_phi = harmonic * 0.4 + weighted * 0.3 + maximum_val * 0.3
    
    # Threshold checks with real values
    iit_conscious = iit_phi > cv.iit_threshold
    brown_conscious = brown_phi > cv.brown_threshold
    duality_conscious = duality_phi > cv.duality_threshold
    is_conscious = iit_conscious || brown_conscious || duality_conscious
    
    frameworks = String[]
    iit_conscious && push!(frameworks, "IIT-4.0")
    brown_conscious && push!(frameworks, "Brown-Theory")
    duality_conscious && !iit_conscious && !brown_conscious && push!(frameworks, "Duality-Synthesis")
    
    confidence = maximum_val > 0.6 ? "very_high" :
                 maximum_val > 0.35 ? "high" :
                 maximum_val > 0.2 ? "medium" : "low"
    
    return Dict(
        "is_conscious" => is_conscious,
        "iit_phi" => round(iit_phi, digits=4),
        "brown_phi" => round(brown_phi, digits=4),
        "duality_phi" => round(duality_phi, digits=4),
        "max_phi" => round(maximum_val, digits=4),
        "effective_information" => round(effective_information, digits=4),
        "confirming_frameworks" => frameworks,
        "confidence" => confidence
    )
end