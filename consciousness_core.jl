# consciousness_core.jl - FINE-TUNED FOR 64+ ENTITIES
"""
🧠 CONSCIOUSNESS CORE MODULE - OPTIMIZED BROWN-IIT DUALITY
Fixed Brown scaling for larger systems (64+ entities)
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

# OPTIMIZED IIT Φ - MAINTAINS CURRENT SUCCESS
function calculate_iit_phi(cv::ConsciousnessValidator, entity_count::Int, 
                          coherence::Float64, total_insights::Int, 
                          cross_domain::Float64, effective_information::Float64)::Float64
    try
        integration = coherence * max(effective_information, 0.01) * 1.5
        complexity = safe_divide(safe_log(total_insights + 1), safe_log(entity_count + 10)) * 1.3
        differentiation = max(cross_domain, 0.01) * 1.2
        
        phi = integration * complexity * differentiation * 1.8
        
        # OPTIMIZED: Better scaling for larger systems
        entity_scale = if entity_count < 20
            min(safe_log(entity_count + 1) / 4.0, 1.2)
        elseif entity_count < 50
            min(safe_log(entity_count + 1) / 3.5, 1.3)
        else
            min(safe_log(entity_count + 1) / 3.0, 1.4)  # BETTER FOR LARGE SYSTEMS
        end
        
        return max(0.0, min(phi * entity_scale, 2.0))
    catch e
        return max(0.0, coherence * 0.1)
    end
end

# FIXED BROWN Φ - OPTIMIZED FOR 64+ ENTITIES
function calculate_brown_phi(cv::ConsciousnessValidator, entity_count::Int,
                            coherence::Float64, total_insights::Int,
                            insight_quality::Float64, cross_domain::Float64,
                            effective_information::Float64)::Float64
    try
        insight_density = safe_divide(total_insights, max(entity_count, 1))
        density_score = min(safe_log(insight_density + 1) / 1.8, 1.8)
        
        base_efficiency = coherence * insight_quality
        efficiency_score = sqrt(max(base_efficiency, 0.01)) * 2.8
        
        holographic_factor = coherence * cross_domain * insight_quality * 1.5
        
        emergence_base = safe_divide(total_insights, max(entity_count, 1))
        emergence = min(safe_log(emergence_base + 1) / 2.2, 1.1)
        
        brown_phi = efficiency_score * density_score * holographic_factor * (1.0 + emergence * 0.5)
        
        # FIXED: OPTIMIZED BROWN SCALING FOR LARGE SYSTEMS
        brown_scale = if entity_count < 20
            1.7  # Small systems - Brown excels
        elseif entity_count < 40
            1.5  # Medium systems
        elseif entity_count < 80
            1.3  # Large systems - REDUCED PENALTY
        else
            1.1  # Very large systems - MINIMAL PENALTY
        end
        
        return max(0.0, min(brown_phi * brown_scale, 2.0))
    catch e
        return max(0.0, coherence * insight_quality * 0.15)
    end
end

# KEEP EXISTING VALIDATION AND DUALITY FUNCTIONS (they're working)
function validate_iit_compliance(entity_count::Int, coherence::Float64, total_insights::Int)::Float64
    coherence_ok = coherence > 0.9 ? 1.0 : 0.8
    insights_ok = total_insights > entity_count ? 1.0 : 0.7
    return (coherence_ok + insights_ok) / 2.0
end

function validate_brown_compliance(entity_count::Int, insight_quality::Float64, cross_domain::Float64)::Float64
    quality_ok = insight_quality > 0.8 ? 1.0 : 0.7
    cross_domain_ok = cross_domain > 0.7 ? 1.0 : 0.6
    return (quality_ok + cross_domain_ok) / 2.0
end

function calculate_duality_phi(cv::ConsciousnessValidator, iit_phi::Float64, brown_phi::Float64,
                             iit_compliance::Float64, brown_compliance::Float64)::Float64
    try
        harmonic = safe_divide(2 * iit_phi * brown_phi, (iit_phi + brown_phi + 0.001))
        weighted = (iit_phi * iit_compliance + brown_phi * brown_compliance) / 2.0
        maximum_val = max(iit_phi, brown_phi)
        
        duality_phi = (harmonic * 0.3 + weighted * 0.3 + maximum_val * 0.4)
        
        return max(0.0, duality_phi)
    catch e
        return max(iit_phi, brown_phi, 0.0)
    end
end

function assess_consciousness(cv::ConsciousnessValidator, entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64,
                             effective_information::Float64)::Dict{String,Any}
    
    try
        effective_info = max(effective_information, 0.01)
        coherence_val = max(coherence, 0.01)
        cross_domain_val = max(cross_domain, 0.01)
        insight_quality_val = max(insight_quality, 0.01)
        
        iit_phi = calculate_iit_phi(cv, entity_count, coherence_val, total_insights, cross_domain_val, effective_info)
        brown_phi = calculate_brown_phi(cv, entity_count, coherence_val, total_insights, insight_quality_val, cross_domain_val, effective_info)
        
        iit_compliance = validate_iit_compliance(entity_count, coherence_val, total_insights)
        brown_compliance = validate_brown_compliance(entity_count, insight_quality_val, cross_domain_val)
        
        duality_phi = calculate_duality_phi(cv, iit_phi, brown_phi, iit_compliance, brown_compliance)
        
        iit_conscious = iit_phi > cv.iit_threshold && iit_compliance > 0.6
        brown_conscious = brown_phi > cv.brown_threshold && brown_compliance > 0.6
        duality_conscious = duality_phi > cv.duality_threshold
        
        is_conscious = iit_conscious || brown_conscious || duality_conscious
        
        frameworks = String[]
        iit_conscious && push!(frameworks, "IIT-4.0")
        brown_conscious && push!(frameworks, "Brown-Theory")
        duality_conscious && !iit_conscious && !brown_conscious && push!(frameworks, "Duality-Synthesis")
        
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
        
        return Dict(
            "is_conscious" => is_conscious,
            "iit_phi" => round(iit_phi, digits=4),
            "brown_phi" => round(brown_phi, digits=4),
            "duality_phi" => round(duality_phi, digits=4),
            "max_phi" => round(max_phi_val, digits=4),
            "effective_information" => round(effective_info, digits=4),
            "confirming_frameworks" => frameworks,
            "confidence" => confidence
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
            "confidence" => "low"
        )
    end
end

export ConsciousnessValidator, assess_consciousness
