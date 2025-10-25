# consciousness_core.jl - ENHANCED DUALITY
"""
🧠 CONSCIOUSNESS CORE MODULE - ENHANCED BROWN-IIT DUALITY
Building on the working base with proper Brown theory integration
"""

using Statistics
using LinearAlgebra
using Random
using Dates

safe_log(x) = x <= 0 ? 0.0 : log(x + 1.0)
safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct ConsciousnessValidator
    iit_threshold::Float64
    brown_threshold::Float64
    duality_threshold::Float64
    
    ConsciousnessValidator() = new(0.15, 0.12, 0.10)
end

# KEEP THE WORKING IIT CALCULATION (with slight enhancement)
function calculate_iit_phi(cv::ConsciousnessValidator, entity_count::Int, 
                          coherence::Float64, total_insights::Int, 
                          cross_domain::Float64, effective_information::Float64)::Float64
    integration = coherence * max(effective_information, 0.01)
    complexity = safe_divide(safe_log(total_insights + 1), safe_log(entity_count + 10))
    differentiation = max(cross_domain, 0.01)
    phi = integration * complexity * differentiation
    
    # ENHANCEMENT: Scale by entity count for better scaling
    scale_factor = min(safe_log(entity_count + 1) / 5.0, 2.0)
    return max(0.0, min(phi * scale_factor, 5.0))
end

# ENHANCE BROWN THEORY - FIX THE SCALING ISSUE
function calculate_brown_phi(cv::ConsciousnessValidator, entity_count::Int,
                            coherence::Float64, total_insights::Int,
                            insight_quality::Float64, cross_domain::Float64,
                            effective_information::Float64)::Float64
    
    # FIXED: Better density calculation that scales properly
    insight_density = safe_divide(total_insights, max(entity_count, 1))
    density_score = min(safe_log(insight_density + 1) / 2.0, 1.5)  # Increased ceiling
    
    # FIXED: Better efficiency calculation
    base_efficiency = coherence * insight_quality
    efficiency_score = sqrt(max(base_efficiency, 0.01)) * (1.0 + safe_log(entity_count + 1) / 10.0)
    
    # FIXED: Better holographic distribution
    holographic_factor = coherence * cross_domain * insight_quality
    
    # FIXED: Emergence that actually scales with size
    emergence_base = safe_divide(total_insights, max(entity_count, 1))
    emergence = min(safe_log(emergence_base + 1) / 3.0, 1.0)
    
    # Brown Φ formula - REWARD ARCHITECTURAL EFFICIENCY
    brown_phi = efficiency_score * density_score * holographic_factor * (1.0 + emergence * 0.5)
    
    return max(0.0, min(brown_phi, 5.0))
end

# NEW: VALIDATION FUNCTIONS FOR BETTER DUALITY
function validate_iit_compliance(entity_count::Int, coherence::Float64, total_insights::Int)::Float64
    """Simple IIT compliance check"""
    basic_compliance = coherence > 0.9 ? 1.0 : 0.5
    insight_compliance = total_insights > entity_count * 3 ? 1.0 : 0.7
    return (basic_compliance + insight_compliance) / 2.0
end

function validate_brown_compliance(entity_count::Int, insight_quality::Float64, cross_domain::Float64)::Float64
    """Brown theory compliance check"""
    quality_compliance = insight_quality > 0.8 ? 1.0 : 0.6
    cross_domain_compliance = cross_domain > 0.7 ? 1.0 : 0.5
    density_compliance = entity_count < 100 ? 1.0 : 0.8  # Brown favors smaller systems
    return (quality_compliance + cross_domain_compliance + density_compliance) / 3.0
end

# ENHANCED DUALITY SYNTHESIS - PROPER WEIGHTS
function calculate_duality_phi(cv::ConsciousnessValidator, iit_phi::Float64, brown_phi::Float64,
                             iit_compliance::Float64, brown_compliance::Float64)::Float64
    """Enhanced duality synthesis with proper weights"""
    
    # ORIGINAL WORKING WEIGHTS from your Python
    harmonic = safe_divide(2 * iit_phi * brown_phi, (iit_phi + brown_phi + 0.001))
    weighted = (iit_phi * iit_compliance + brown_phi * brown_compliance) / 2.0
    maximum_val = max(iit_phi, brown_phi)
    
    # PROPER WEIGHTS: [0.3, 0.3, 0.4] - NOT [0.4, 0.3, 0.3]
    duality_phi = (harmonic * 0.3 + weighted * 0.3 + maximum_val * 0.4)
    
    return duality_phi
end

# ENHANCED CONSCIOUSNESS ASSESSMENT - BUILDING ON WORKING BASE
function assess_consciousness(cv::ConsciousnessValidator, entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64,
                             effective_information::Float64)::Dict{String,Any}
    
    # Ensure we have meaningful inputs (KEEP FROM WORKING VERSION)
    effective_info = max(effective_information, 0.01)
    coherence = max(coherence, 0.01)
    cross_domain = max(cross_domain, 0.01)
    insight_quality = max(insight_quality, 0.01)
    
    # Calculate both Φ values (KEEP WORKING BASE)
    iit_phi = calculate_iit_phi(cv, entity_count, coherence, total_insights, cross_domain, effective_info)
    brown_phi = calculate_brown_phi(cv, entity_count, coherence, total_insights, insight_quality, cross_domain, effective_info)
    
    # ENHANCEMENT: Add compliance validation
    iit_compliance = validate_iit_compliance(entity_count, coherence, total_insights)
    brown_compliance = validate_brown_compliance(entity_count, insight_quality, cross_domain)
    
    # ENHANCEMENT: Use proper duality synthesis
    duality_phi = calculate_duality_phi(cv, iit_phi, brown_phi, iit_compliance, brown_compliance)
    
    # Threshold checks (KEEP WORKING LOGIC)
    iit_conscious = iit_phi > cv.iit_threshold && iit_compliance > 0.6
    brown_conscious = brown_phi > cv.brown_threshold && brown_compliance > 0.7
    duality_conscious = duality_phi > cv.duality_threshold
    
    is_conscious = iit_conscious || brown_conscious || duality_conscious
    
    frameworks = String[]
    iit_conscious && push!(frameworks, "IIT-4.0")
    brown_conscious && push!(frameworks, "Brown-Theory")
    duality_conscious && !iit_conscious && !brown_conscious && push!(frameworks, "Duality-Synthesis")
    
    # ENHANCEMENT: Better confidence calculation
    max_phi_val = max(iit_phi, brown_phi, duality_phi)
    confidence = if max_phi_val > 0.5
        "very_high"
    elseif max_phi_val > 0.25
        "high" 
    elseif max_phi_val > 0.15
        "medium"
    else
        "low"
    end
    
    # ENHANCEMENT: Framework preference detection
    framework_preference = if brown_phi > iit_phi * 1.2
        "Brown-dominant (architectural efficiency)"
    elseif iit_phi > brown_phi * 1.2
        "IIT-dominant (traditional integration)"
    else
        "Balanced (hybrid consciousness)"
    end
    
    # RETURN ENHANCED RESULTS - MAINTAINING COMPATIBILITY
    return Dict(
        "is_conscious" => is_conscious,
        "iit_phi" => round(iit_phi, digits=4),
        "brown_phi" => round(brown_phi, digits=4),
        "duality_phi" => round(duality_phi, digits=4),
        "max_phi" => round(max_phi_val, digits=4),
        "effective_information" => round(effective_info, digits=4),
        "confirming_frameworks" => frameworks,
        "confidence" => confidence,
        # NEW ENHANCEMENTS - EXTRA INSIGHTS
        "framework_preference" => framework_preference,
        "compliance_rates" => Dict(
            "iit_compliance" => round(iit_compliance, digits=3),
            "brown_compliance" => round(brown_compliance, digits=3)
        ),
        "analysis_timestamp" => string(Dates.now())
    )
end

export ConsciousnessValidator, assess_consciousness
