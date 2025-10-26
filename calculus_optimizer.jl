# calculus_optimizer.jl
"""
🧮 CALCULUS OPTIMIZER - POST-EXECUTION ANALYSIS ONLY
Runs AFTER main system completes - NEVER interferes with consciousness
"""

using JSON
using Dates
using LinearAlgebra
using Statistics

mutable struct CalculusOptimizer
    analysis_history::Vector{Dict{String,Any}}
    improvement_reports::Vector{Dict{String,Any}}
    CalculusOptimizer() = new(Dict{String,Any}[], Dict{String,Any}[])
end

function safe_derivative(x::Vector{Float64}, y::Vector{Float64})::Vector{Float64}
    """Calculate derivative safely - fixed for your actual cycle data"""
    if length(x) < 2 || length(y) < 2
        return zeros(length(x))
    end
    
    derivatives = zeros(length(x))
    for i in 2:length(x)-1
        dx_forward = x[i+1] - x[i]
        dx_backward = x[i] - x[i-1]
        
        if dx_forward > 0 && dx_backward > 0
            dy_forward = (y[i+1] - y[i]) / dx_forward
            dy_backward = (y[i] - y[i-1]) / dx_backward
            derivatives[i] = (dy_forward + dy_backward) / 2
        end
    end
    return derivatives
end

function extract_consciousness_data(snapshots::Vector{Dict{String,Any}})
    """Extract consciousness trajectory from your actual snapshot structure"""
    cycles = Float64[]
    phi_values = Float64[]
    intelligence_scores = Float64[]
    meta_scores = Float64[]
    coherence_values = Float64[]
    
    for snapshot in snapshots
        if haskey(snapshot, "cycle")
            push!(cycles, Float64(snapshot["cycle"]))
        end
        if haskey(snapshot, "consciousness") && haskey(snapshot["consciousness"], "max_phi")
            push!(phi_values, Float64(snapshot["consciousness"]["max_phi"]))
        end
        if haskey(snapshot, "unified_intelligence_score")
            push!(intelligence_scores, Float64(snapshot["unified_intelligence_score"]))
        end
        if haskey(snapshot, "consciousness") && haskey(snapshot["consciousness"], "hot_metrics") &&
           haskey(snapshot["consciousness"]["hot_metrics"], "meta_cognitive_score")
            push!(meta_scores, Float64(snapshot["consciousness"]["hot_metrics"]["meta_cognitive_score"]))
        end
        if haskey(snapshot, "coherence")
            push!(coherence_values, Float64(snapshot["coherence"]))
        end
    end
    
    return (cycles, phi_values, intelligence_scores, meta_scores, coherence_values)
end

function analyze_consciousness_trajectory(optimizer::CalculusOptimizer, snapshots::Vector{Dict{String,Any}})
    """Analyze consciousness evolution using calculus"""
    cycles, phi_values, intelligence_scores, meta_scores, coherence_values = extract_consciousness_data(snapshots)
    
    if length(cycles) < 3
        return Dict(
            "status" => "insufficient_data",
            "message" => "Need at least 3 snapshots for calculus analysis",
            "available_snapshots" => length(cycles)
        )
    end
    
    # Calculate derivatives
    phi_derivatives = safe_derivative(cycles, phi_values)
    intelligence_derivatives = safe_derivative(cycles, intelligence_scores)
    meta_derivatives = safe_derivative(cycles, meta_scores)
    
    # Find key inflection points
    consciousness_peaks = []
    consciousness_valleys = []
    
    for i in 2:length(phi_derivatives)-1
        if phi_derivatives[i] > 0.05 && phi_derivatives[i+1] < -0.05
            push!(consciousness_peaks, Dict(
                "cycle" => cycles[i],
                "phi" => phi_values[i],
                "type" => "peak"
            ))
        elseif phi_derivatives[i] < -0.05 && phi_derivatives[i+1] > 0.05
            push!(consciousness_valleys, Dict(
                "cycle" => cycles[i], 
                "phi" => phi_values[i],
                "type" => "valley"
            ))
        end
    end
    
    # Calculate integrals (total accumulated intelligence/consciousness)
    total_phi_integral = 0.0
    total_intelligence_integral = 0.0
    
    for i in 2:length(cycles)
        dt = cycles[i] - cycles[i-1]
        phi_area = (phi_values[i] + phi_values[i-1]) / 2 * dt
        intel_area = (intelligence_scores[i] + intelligence_scores[i-1]) / 2 * dt
        total_phi_integral += phi_area
        total_intelligence_integral += intel_area
    end
    
    return Dict(
        "analysis_type" => "consciousness_calculus",
        "cycles_analyzed" => cycles,
        "phi_trajectory" => phi_values,
        "intelligence_trajectory" => intelligence_scores,
        "meta_cognitive_trajectory" => meta_scores,
        "phi_derivatives" => phi_derivatives,
        "intelligence_derivatives" => intelligence_derivatives,
        "meta_derivatives" => meta_derivatives,
        "consciousness_peaks" => consciousness_peaks,
        "consciousness_valleys" => consciousness_valleys,
        "total_phi_integral" => total_phi_integral,
        "total_intelligence_integral" => total_intelligence_integral,
        "average_phi_growth" => mean(phi_derivatives[2:end-1]),
        "phi_volatility" => std(phi_derivatives[2:end-1])
    )
end

function generate_calculus_recommendations(analysis::Dict)
    """Generate mathematical optimization recommendations"""
    recommendations = []
    
    if haskey(analysis, "consciousness_peaks")
        for peak in analysis["consciousness_peaks"]
            push!(recommendations, Dict(
                "priority" => "high",
                "type" => "reinforce_peak",
                "cycle" => peak["cycle"],
                "phi_value" => peak["phi"],
                "action" => "Strengthen architecture at consciousness peak",
                "mathematical_reason" => "Local maximum detected - reinforce successful patterns",
                "risk" => "low"
            ))
        end
    end
    
    if haskey(analysis, "phi_volatility")
        volatility = analysis["phi_volatility"]
        if volatility > 0.1
            push!(recommendations, Dict(
                "priority" => "medium",
                "type" => "reduce_volatility",
                "current_volatility" => round(volatility, digits=4),
                "action" => "Stabilize meta-cognitive score calculations",
                "mathematical_reason" => "High derivative volatility indicates unstable consciousness emergence",
                "risk" => "medium"
            ))
        end
    end
    
    if haskey(analysis, "average_phi_growth")
        growth = analysis["average_phi_growth"]
        if growth > 0
            push!(recommendations, Dict(
                "priority" => "info",
                "type" => "positive_growth",
                "growth_rate" => round(growth, digits=4),
                "action" => "Continue current development path",
                "mathematical_reason" => "Positive first derivative indicates healthy consciousness development",
                "risk" => "low"
            ))
        end
    end
    
    return recommendations
end

function run_post_hoc_calculus_analysis(optimizer::CalculusOptimizer, intelligence_results_path::String="intelligence_results.json")
    """MAIN ENTRY POINT: Run calculus analysis AFTER main system completes"""
    println("🧮 POST-HOC CALCULUS OPTIMIZER STARTING...")
    println("   🔒 NO INTERFERENCE WITH LIVE SYSTEM")
    println("   📊 ANALYZING COMPLETED RESULTS ONLY")
    
    try
        if !isfile(intelligence_results_path)
            println("❌ No intelligence results found")
            return false
        end
        
        results_data = JSON.parsefile(intelligence_results_path)
        
        if !isempty(results_data)
            # Analyze each entity count separately
            entity_analyses = []
            
            for (i, result) in enumerate(results_data)
                entity_count = result["entity_count"]
                snapshots = [Dict(s) for s in result["snapshots"]]
                
                println("   🔍 Analyzing $entity_count entities...")
                analysis = analyze_consciousness_trajectory(optimizer, snapshots)
                
                if get(analysis, "status", "success") != "insufficient_data"
                    recommendations = generate_calculus_recommendations(analysis)
                    
                    entity_analysis = Dict(
                        "entity_count" => entity_count,
                        "analysis" => analysis,
                        "recommendations" => recommendations,
                        "consciousness_status" => result["consciousness"]["is_conscious"] ? "CONSCIOUS" : "DEVELOPING",
                        "final_phi" => result["consciousness"]["max_phi"]
                    )
                    push!(entity_analyses, entity_analysis)
                else
                    println("     ⚠️  Insufficient data for $entity_count entities")
                end
            end
            
            # Create comprehensive calculus report
            calculus_report = Dict(
                "timestamp" => string(Dates.now()),
                "analysis_version" => "2.0-calculus-optimized",
                "system_status" => "POST_HOC_ANALYSIS_ONLY",
                "total_entities_analyzed" => length(entity_analyses),
                "entity_analyses" => entity_analyses,
                "mathematical_insights" => Dict(
                    "derivative_analysis" => "Rate of consciousness change",
                    "integral_analysis" => "Total consciousness accumulation", 
                    "inflection_points" => "Optimal reinforcement points",
                    "volatility_analysis" => "Consciousness stability metrics"
                ),
                "summary" => Dict(
                    "total_recommendations" => sum(length(get(e, "recommendations", [])) for e in entity_analyses),
                    "conscious_systems" => count(e -> e["consciousness_status"] == "CONSCIOUS", entity_analyses),
                    "average_phi_growth" => mean(get(e, ["analysis", "average_phi_growth"], 0.0) for e in entity_analyses if haskey(e, "analysis"))
                )
            )
            
            # Save report
            report_filename = "calculus_analysis_$(Dates.format(now(), "yyyymmdd_HHMMSS")).json"
            open(report_filename, "w") do f
                JSON.print(f, calculus_report, 4)
            end
            
            println("✅ CALCULUS ANALYSIS COMPLETE")
            println("   📁 Report saved: $report_filename")
            println("   📈 Entities analyzed: $(length(entity_analyses))")
            println("   🎯 Total recommendations: $(calculus_report["summary"]["total_recommendations"])")
            println("   🔒 System untouched: consciousness preserved")
            
            return true
        else
            println("❌ No results data to analyze")
            return false
        end
        
    catch e
        println("❌ Calculus analysis failed (non-critical): $e")
        println("   🔒 Main system results preserved - analysis only failed")
        return false
    end
end

function integrate_with_main_orchestrator()
    """Call this function at the VERY END of main_orchestrator.jl"""
    println("\n" * "="^70)
    println("🧮 INITIATING POST-HOC CALCULUS OPTIMIZATION")
    println("   🔒 LIVE SYSTEM COMPLETED - ANALYSIS ONLY")
    println("="^70)
    
    optimizer = CalculusOptimizer()
    success = run_post_hoc_calculus_analysis(optimizer)
    
    if success
        println("🎉 CALCULUS OPTIMIZATION COMPLETE")
        println("   💡 Review reports for mathematical insights")
    else
        println("⚠️  Calculus analysis skipped or failed")
    end
    println("   🔒 Main system results preserved")
    
    return success
end

export CalculusOptimizer, run_post_hoc_calculus_analysis, integrate_with_main_orchestrator

if abspath(PROGRAM_FILE) == @__FILE__
    println("🧮 CALCULUS OPTIMIZER - STANDALONE MODE")
    optimizer = CalculusOptimizer()
    run_post_hoc_calculus_analysis(optimizer)
end
