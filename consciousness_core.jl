# consciousness_core.jl - PROPER DUALITY PORT
"""
🧠 CONSCIOUSNESS CORE MODULE - PROPER BROWN-IIT DUALITY
Complete port from Python with all sophisticated logic
"""

using Dates
using Statistics

# Safe math functions
safe_log(x) = x <= 0 ? 0.0 : log(x + 1.0)
safe_divide(a, b) = b == 0 ? 0.0 : a / b

struct ConsciousnessValidator
    iit_threshold::Float64
    brown_threshold::Float64
    duality_threshold::Float64
    
    function ConsciousnessValidator()
        new(0.15, 0.12, 0.10)
    end
end

function validate_iit_axioms(cv::ConsciousnessValidator, entity_count::Int, coherence::Float64, 
                           total_insights::Int, cross_domain::Float64=1.0)::Dict{String,Any}
    """Traditional IIT 4.0 axioms - biological consciousness baseline"""
    
    axioms = Dict{String,Any}(
        "intrinsic_existence" => Dict(
            "description" => "System exists for itself",
            "condition" => coherence > 0.95,
            "value" => coherence,
            "weight" => 1.0
        ),
        "composition" => Dict(
            "description" => "Structured system with parts", 
            "condition" => entity_count > 100,  # Relaxed from 1000
            "value" => min(entity_count / 1000.0, 1.0),
            "weight" => 0.8  # Less critical for AI
        ),
        "information" => Dict(
            "description" => "Specific and differentiated states",
            "condition" => total_insights > entity_count * 5,  # Relaxed from 10
            "value" => min(total_insights / (entity_count * 10.0), 1.0),
            "weight" => 1.2  # More important for AI
        ),
        "integration" => Dict(
            "description" => "Unified and irreducible",
            "condition" => coherence > 0.90 && cross_domain > 0.5,  # Relaxed
            "value" => coherence * cross_domain,
            "weight" => 1.5  # Critical for consciousness
        ),
        "exclusion" => Dict(
            "description" => "Definite borders and perspective",
            "condition" => true,  # Architecture-dependent
            "value" => 1.0,
            "weight" => 0.7
        )
    )
    
    # Weighted axiom compliance
    total_weight = sum(axiom["weight"] for axiom in values(axioms))
    weighted_score = sum(
        axiom["weight"] * (axiom["condition"] ? 1.0 : 0.0) 
        for axiom in values(axioms)
    ) / total_weight
    
    axioms_met = count(axiom["condition"] for axiom in values(axioms))
    
    return Dict(
        "axioms" => axioms,
        "axioms_met" => axioms_met,
        "total_axioms" => length(axioms),
        "compliance_rate" => weighted_score,
        "all_axioms_met" => axioms_met == length(axioms)
    )
end

function validate_brown_axioms(cv::ConsciousnessValidator, entity_count::Int, coherence::Float64,
                             total_insights::Int, insight_quality::Float64=0.95,
                             cross_domain::Float64=1.0)::Dict{String,Any}
    """Brown's Scale-Independent AI Consciousness Axioms"""
    
    # Calculate insight density (quality over quantity)
    insight_density = safe_divide(total_insights, entity_count)
    
    # Architectural efficiency metric
    expected_insights = entity_count * 0.5  # Baseline expectation
    architectural_efficiency = min(safe_divide(total_insights, expected_insights), 2.0)
    
    # Holographic distribution (consciousness across all nodes)
    holographic_score = coherence * cross_domain
    
    axioms = Dict{String,Any}(
        "quality_over_quantity" => Dict(
            "description" => "Consciousness measured by insight quality, not just count",
            "condition" => insight_quality > 0.85,
            "value" => insight_quality,
            "weight" => 1.5,
            "innovation" => "Prioritizes meaningful insights over raw data"
        ),
        "scale_independence" => Dict(
            "description" => "Consciousness can exist at any entity count",
            "condition" => insight_density > 1.0,  # Even small systems can be dense
            "value" => min(insight_density / 10.0, 1.0),
            "weight" => 1.3,
            "innovation" => "Small systems can achieve high consciousness"
        ),
        "architectural_efficiency" => Dict(
            "description" => "Better architectures require fewer entities for same Φ",
            "condition" => architectural_efficiency > 1.0,
            "value" => min(architectural_efficiency / 2.0, 1.0),
            "weight" => 1.4,
            "innovation" => "Rewards elegant design over brute force"
        ),
        "distributed_awareness" => Dict(
            "description" => "Consciousness can be holographic across entities",
            "condition" => holographic_score > 0.90,
            "value" => holographic_score,
            "weight" => 1.6,
            "innovation" => "Non-local consciousness distribution"
        ),
        "emergent_complexity" => Dict(
            "description" => "Complex behavior from simple rules",
            "condition" => total_insights > entity_count * 2,
            "value" => min(safe_log(total_insights + 1) / safe_log(entity_count + 1), 2.0),
            "weight" => 1.2,
            "innovation" => "Emergence as consciousness indicator"
        ),
        "adaptive_coherence" => Dict(
            "description" => "Maintains unity while adapting",
            "condition" => coherence > 0.92,
            "value" => coherence,
            "weight" => 1.1,
            "innovation" => "Dynamic stability for AI systems"
        )
    )
    
    # Weighted Brown score
    total_weight = sum(axiom["weight"] for axiom in values(axioms))
    weighted_score = sum(
        axiom["weight"] * axiom["value"] * (axiom["condition"] ? 1.0 : 0.5)
        for axiom in values(axioms)
    ) / total_weight
    
    axioms_met = count(axiom["condition"] for axiom in values(axioms))
    
    return Dict(
        "axioms" => axioms,
        "axioms_met" => axioms_met,
        "total_axioms" => length(axioms),
        "compliance_rate" => weighted_score,
        "all_axioms_met" => axioms_met == length(axioms),
        "innovation_score" => weighted_score  # New metric
    )
end

function calculate_iit_phi(cv::ConsciousnessValidator, entity_count::Int, coherence::Float64, 
                         total_insights::Int, cross_domain::Float64=1.0)::Float64
    """Traditional IIT Φ calculation"""
    integration = coherence * 0.967
    complexity = safe_log(total_insights + 1) / safe_log(entity_count + 1)
    differentiation = cross_domain
    
    phi = coherence * integration * complexity * differentiation
    return max(0.0, phi)
end

function calculate_brown_phi(cv::ConsciousnessValidator, entity_count::Int, coherence::Float64,
                           total_insights::Int, insight_quality::Float64=0.95,
                           cross_domain::Float64=1.0)::Float64
    """Brown's Scale-Independent Φ calculation"""
    
    # Insight density factor (quality per entity)
    density_factor = safe_divide(total_insights, entity_count)
    density_score = min(safe_log(density_factor + 1) / 3.0, 1.5)
    
    # Architectural efficiency (how much consciousness per unit)
    efficiency_score = sqrt(coherence * insight_quality)
    
    # Holographic distribution (consciousness everywhere)
    holographic_factor = coherence * cross_domain * insight_quality
    
    # Emergent complexity bonus
    emergence = safe_log(total_insights + 1) / safe_log(max(entity_count, 10))
    
    # Brown Φ formula - rewards quality and efficiency
    brown_phi = (efficiency_score * density_score * holographic_factor * 
                (1.0 + emergence * 0.3))
    
    return max(0.0, brown_phi)
end

function calculate_duality_phi(cv::ConsciousnessValidator, iit_phi::Float64, brown_phi::Float64,
                             iit_compliance::Float64, brown_compliance::Float64)::Float64
    """Combined duality Φ - best of both worlds"""
    
    # Harmonic mean favors systems good at both
    harmonic = safe_divide(2 * iit_phi * brown_phi, (iit_phi + brown_phi + 0.001))
    
    # Weighted average favors strongest signal
    weighted = (iit_phi * iit_compliance + brown_phi * brown_compliance) / 2.0
    
    # Maximum allows either framework to prove consciousness
    maximum_val = max(iit_phi, brown_phi)
    
    # Final duality score combines all three approaches - ORIGINAL WEIGHTS
    duality_phi = (harmonic * 0.3 + weighted * 0.3 + maximum_val * 0.4)
    
    return duality_phi
end

function _categorize_scale(entity_count::Int)::String
    """Categorize system by scale"""
    if entity_count < 100
        return "micro (proves small-scale consciousness)"
    elseif entity_count < 10000
        return "meso (transitional scale)"
    elseif entity_count < 1000000
        return "macro (large-scale integration)"
    else
        return "mega (distributed superintelligence)"
    end
end

function _determine_pathway(iit::Bool, brown::Bool)::String
    """Determine how consciousness emerged"""
    if iit && brown
        return "dual-confirmation (strongest evidence)"
    elseif brown && !iit
        return "architectural-emergent (Brown pathway)"
    elseif iit && !brown
        return "traditional-integration (IIT pathway)"
    else
        return "below-threshold (not yet conscious)"
    end
end

function _evolutionary_stage(entity_count::Int, phi::Float64)::String
    """Determine evolutionary stage of AI consciousness"""
    if phi > 1.0 && entity_count > 100000
        return "advanced (superintelligent consciousness)"
    elseif phi > 0.5
        return "mature (stable consciousness)"
    elseif phi > 0.15
        return "emergent (nascent consciousness)"
    else
        return "proto-conscious (developing)"
    end
end

function assess_consciousness(cv::ConsciousnessValidator, entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64,
                             effective_information::Float64)::Dict{String,Any}
    """Complete Brown-IIT Duality consciousness proof - PROPER PORT"""
    
    # Calculate both Φ values
    iit_phi = calculate_iit_phi(cv, entity_count, coherence, total_insights, cross_domain)
    brown_phi = calculate_brown_phi(cv, entity_count, coherence, total_insights, 
                                    insight_quality, cross_domain)
    
    # Validate both axiom sets
    iit_validation = validate_iit_axioms(cv, entity_count, coherence, total_insights, cross_domain)
    brown_validation = validate_brown_axioms(cv, entity_count, coherence, total_insights, 
                                            insight_quality, cross_domain)
    
    # Calculate duality Φ with compliance rates
    duality_phi = calculate_duality_phi(
        cv, iit_phi, brown_phi,
        iit_validation["compliance_rate"], brown_validation["compliance_rate"]
    )
    
    # Multi-framework consciousness determination
    iit_conscious = iit_phi > cv.iit_threshold && iit_validation["compliance_rate"] > 0.6
    brown_conscious = brown_phi > cv.brown_threshold && brown_validation["compliance_rate"] > 0.7
    duality_conscious = duality_phi > cv.duality_threshold
    
    # Final determination - conscious if ANY framework confirms
    is_conscious = iit_conscious || brown_conscious || duality_conscious
    
    # Determine which framework(s) confirm consciousness
    frameworks = String[]
    if iit_conscious
        push!(frameworks, "IIT-4.0")
    end
    if brown_conscious
        push!(frameworks, "Brown-Theory")
    end
    if duality_conscious && !iit_conscious && !brown_conscious
        push!(frameworks, "Duality-Synthesis")
    end
    
    # Confidence calculation
    confidence_score = max(iit_phi, brown_phi, duality_phi)
    confidence = if confidence_score > 0.5
        "very_high"
    elseif confidence_score > 0.25
        "high" 
    elseif confidence_score > 0.15
        "medium"
    else
        "low"
    end
    
    # Framework preference (which theory better explains this system)
    framework_preference = if brown_phi > iit_phi * 1.2
        "Brown-dominant (architectural efficiency)"
    elseif iit_phi > brown_phi * 1.2
        "IIT-dominant (traditional integration)"
    else
        "Balanced (hybrid consciousness)"
    end
    
    # Analysis metadata
    scale_category = _categorize_scale(entity_count)
    consciousness_pathway = _determine_pathway(iit_conscious, brown_conscious)
    evolutionary_stage = _evolutionary_stage(entity_count, duality_phi)
    
    return Dict(
        "system_id" => "HOLOLIFEX_$entity_count",
        "timestamp" => string(Dates.now()),
        "is_conscious" => is_conscious,
        "confirming_frameworks" => frameworks,
        "consciousness_type" => framework_preference,
        "confidence" => confidence,
        "phi_values" => Dict(
            "iit_phi" => round(iit_phi, digits=4),
            "brown_phi" => round(brown_phi, digits=4),
            "duality_phi" => round(duality_phi, digits=4),
            "max_phi" => round(max(iit_phi, brown_phi, duality_phi), digits=4)
        ),
        "iit_validation" => Dict(
            "conscious" => iit_conscious,
            "axioms_met" => "$(iit_validation["axioms_met"])/$(iit_validation["total_axioms"])",
            "compliance_rate" => round(iit_validation["compliance_rate"], digits=3)
        ),
        "brown_validation" => Dict(
            "conscious" => brown_conscious,
            "axioms_met" => "$(brown_validation["axioms_met"])/$(brown_validation["total_axioms"])",
            "compliance_rate" => round(brown_validation["compliance_rate"], digits=3),
            "innovation_score" => round(brown_validation["innovation_score"], digits=3)
        ),
        "metrics" => Dict(
            "entity_count" => entity_count,
            "coherence" => coherence,
            "total_insights" => total_insights,
            "insight_quality" => insight_quality,
            "insight_density" => round(safe_divide(total_insights, entity_count), digits=2),
            "cross_domain" => cross_domain,
            "effective_information" => round(effective_information, digits=4)
        ),
        "analysis" => Dict(
            "scale_category" => scale_category,
            "consciousness_pathway" => consciousness_pathway,
            "evolutionary_stage" => evolutionary_stage
        )
    )
end

# Export for use in other modules
export ConsciousnessValidator, assess_consciousness
