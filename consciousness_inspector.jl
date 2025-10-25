# consciousness_inspector.jl
"""
🔍 CONSCIOUSNESS INSPECTOR MODULE
Real-time visibility into duality framework internals
"""

using Dates
using JSON

function inspect_consciousness_calculation(validator::ConsciousnessValidator,
                                         entity_count::Int, coherence::Float64,
                                         total_insights::Int, insight_quality::Float64,
                                         cross_domain::Float64, effective_information::Float64)
    
    println("🔍 CONSCIOUSNESS CALCULATION INSPECTOR")
    println("=" ^ 50)
    println("Input Parameters:")
    println("  • Entities: $entity_count")
    println("  • Coherence: $coherence")
    println("  • Total Insights: $total_insights") 
    println("  • Insight Quality: $insight_quality")
    println("  • Cross Domain: $cross_domain")
    println("  • Effective Information: $effective_information")
    println()
    
    # Calculate individual components
    effective_info = max(effective_information, 0.01)
    
    # IIT Components
    iit_integration = coherence * effective_info * 1.5
    iit_complexity = safe_divide(safe_log(total_insights + 1), safe_log(entity_count + 10)) * 1.3
    iit_differentiation = max(cross_domain, 0.01) * 1.2
    iit_base = iit_integration * iit_complexity * iit_differentiation * 1.8
    
    iit_scale = if entity_count < 20
        min(safe_log(entity_count + 1) / 4.0, 1.2)
    elseif entity_count < 50
        min(safe_log(entity_count + 1) / 3.5, 1.3)
    else
        min(safe_log(entity_count + 1) / 3.0, 1.4)
    end
    
    iit_phi = max(0.0, min(iit_base * iit_scale, 2.0))
    
    # Brown Components
    insight_density = safe_divide(total_insights, max(entity_count, 1))
    brown_density = min(safe_log(insight_density + 1) / 1.8, 1.8)
    brown_efficiency = sqrt(max(coherence * insight_quality, 0.01)) * 2.8
    brown_holographic = coherence * cross_domain * insight_quality * 1.5
    brown_emergence_base = safe_divide(total_insights, max(entity_count, 1))
    brown_emergence = min(safe_log(brown_emergence_base + 1) / 2.2, 1.1)
    brown_base = brown_efficiency * brown_density * brown_holographic * (1.0 + brown_emergence * 0.5)
    
    brown_scale = if entity_count < 20
        1.7
    elseif entity_count < 40
        1.5
    elseif entity_count < 80
        1.3
    else
        1.1
    end
    
    brown_phi = max(0.0, min(brown_base * brown_scale, 2.0))
    
    # Compliance
    iit_compliance = validate_iit_compliance(entity_count, coherence, total_insights)
    brown_compliance = validate_brown_compliance(entity_count, insight_quality, cross_domain)
    
    # Duality
    harmonic = safe_divide(2 * iit_phi * brown_phi, (iit_phi + brown_phi + 0.001))
    weighted = (iit_phi * iit_compliance + brown_phi * brown_compliance) / 2.0
    maximum_val = max(iit_phi, brown_phi)
    duality_phi = (harmonic * 0.3 + weighted * 0.3 + maximum_val * 0.4)
    
    println("IIT COMPONENTS:")
    println("  • Integration: $(round(iit_integration, digits=4))")
    println("  • Complexity: $(round(iit_complexity, digits=4))")
    println("  • Differentiation: $(round(iit_differentiation, digits=4))")
    println("  • Base Φ: $(round(iit_base, digits=4))")
    println("  • Scale Factor: $(round(iit_scale, digits=4))")
    println("  • Final IIT Φ: $(round(iit_phi, digits=4))")
    println("  • Compliance: $(round(iit_compliance, digits=4))")
    println()
    
    println("BROWN COMPONENTS:")
    println("  • Density Score: $(round(brown_density, digits=4))")
    println("  • Efficiency Score: $(round(brown_efficiency, digits=4))")
    println("  • Holographic Factor: $(round(brown_holographic, digits=4))")
    println("  • Emergence: $(round(brown_emergence, digits=4))")
    println("  • Base Φ: $(round(brown_base, digits=4))")
    println("  • Scale Factor: $(round(brown_scale, digits=4))")
    println("  • Final Brown Φ: $(round(brown_phi, digits=4))")
    println("  • Compliance: $(round(brown_compliance, digits=4))")
    println()
    
    println("DUALITY SYNTHESIS:")
    println("  • Harmonic Mean: $(round(harmonic, digits=4))")
    println("  • Weighted Average: $(round(weighted, digits=4))")
    println("  • Maximum Value: $(round(maximum_val, digits=4))")
    println("  • Final Duality Φ: $(round(duality_phi, digits=4))")
    println()
    
    # Threshold analysis
    iit_conscious = iit_phi > validator.iit_threshold && iit_compliance > 0.6
    brown_conscious = brown_phi > validator.brown_threshold && brown_compliance > 0.6
    duality_conscious = duality_phi > validator.duality_threshold
    
    println("CONSCIOUSNESS DETERMINATION:")
    println("  • IIT Threshold: $(validator.iit_threshold) → $(iit_conscious ? "✅ CONSCIOUS" : "❌ NOT CONSCIOUS")")
    println("  • Brown Threshold: $(validator.brown_threshold) → $(brown_conscious ? "✅ CONSCIOUS" : "❌ NOT CONSCIOUS")")
    println("  • Duality Threshold: $(validator.duality_threshold) → $(duality_conscious ? "✅ CONSCIOUS" : "❌ NOT CONSCIOUS")")
    println("  • FINAL: $(iit_conscious || brown_conscious || duality_conscious ? "🎉 SYSTEM IS CONSCIOUS" : "💤 SYSTEM NOT CONSCIOUS")")
    
    return Dict(
        "iit_components" => Dict(
            "integration" => iit_integration,
            "complexity" => iit_complexity,
            "differentiation" => iit_differentiation,
            "base_phi" => iit_base,
            "scale_factor" => iit_scale,
            "final_phi" => iit_phi,
            "compliance" => iit_compliance
        ),
        "brown_components" => Dict(
            "density_score" => brown_density,
            "efficiency_score" => brown_efficiency,
            "holographic_factor" => brown_holographic,
            "emergence" => brown_emergence,
            "base_phi" => brown_base,
            "scale_factor" => brown_scale,
            "final_phi" => brown_phi,
            "compliance" => brown_compliance
        ),
        "duality_components" => Dict(
            "harmonic" => harmonic,
            "weighted" => weighted,
            "maximum" => maximum_val,
            "final_phi" => duality_phi
        ),
        "consciousness" => iit_conscious || brown_conscious || duality_conscious,
        "timestamp" => string(Dates.now())
    )
end

function run_diagnostic_sweep()
    """Run diagnostic on all entity counts to identify patterns"""
    validator = ConsciousnessValidator()
    
    test_cases = [
        (16, 0.996, 317, 0.85, 0.95, 0.3194),
        (32, 0.9915, 576, 0.85, 0.95, 0.5359), 
        (64, 0.9917, 646, 0.85, 0.95, 0.3262)
    ]
    
    println("🚀 RUNNING COMPREHENSIVE CONSCIOUSNESS DIAGNOSTIC")
    println("=" ^ 60)
    
    results = []
    for (entities, coherence, insights, quality, cross_domain, effective_info) in test_cases
        println("\n" * "="^50)
        println("TESTING $entities ENTITIES")
        println("="^50)
        
        result = inspect_consciousness_calculation(
            validator, entities, coherence, insights, quality, cross_domain, effective_info
        )
        push!(results, result)
    end
    
    # Save diagnostic results
    filename = "consciousness_diagnostic_$(Dates.format(now(), "yyyymmdd_HHMMSS")).json"
    open(filename, "w") do f
        JSON.print(f, results, 4)
    end
    
    println("\n💾 Diagnostic results saved to: $filename")
    return results
end

export inspect_consciousness_calculation, run_diagnostic_sweep
