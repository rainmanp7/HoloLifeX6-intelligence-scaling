# calculus_optimizer.jl
"""
🧮 UNIVERSAL CALCULUS DETECTIVE
One file, one analysis - everything included
No over-engineering, no pattern matching
"""

using JSON
using Dates
using Statistics

function run_universal_calculus_analysis(results_path::String="intelligence_results.json")
    """SIMPLE: Analyze everything in one shot"""
    println("🧮 CALCULUS DETECTIVE - ANALYZING RESULTS...")
    
    try
        if !isfile(results_path)
            println("❌ No results found")
            return false
        end
        
        results_data = JSON.parsefile(results_path)
        all_analyses = []
        
        for result in results_data
            entity_count = get(result, "entity_count", 0)
            snapshots = get(result, "snapshots", [])
            
            println("   🔍 Analyzing $entity_count entities...")
            analysis = analyze_entity(snapshots, entity_count)
            push!(all_analyses, analysis)
        end
        
        # Save simple report
        report_file = "calculus_report_$(Dates.format(now(), "yyyymmdd_HHMMSS")).json"
        open(report_file, "w") do f
            JSON.print(f, all_analyses, 2)
        end
        
        println("✅ CALCULUS ANALYSIS COMPLETE")
        println("   📁 Report: $report_file")
        
        return true
        
    catch e
        println("❌ Calculus analysis failed: $e")
        return false
    end
end

function analyze_entity(snapshots, entity_count)
    """Analyze one entity - keep it simple"""
    if length(snapshots) < 3
        return Dict("entity_count" => entity_count, "status" => "insufficient_data")
    end
    
    # Extract basic data
    cycles = [get(s, "cycle", 0.0) for s in snapshots]
    phi_vals = [get(s, "consciousness", Dict()) |> c -> get(c, "max_phi", 0.0) for s in snapshots]
    intel_vals = [get(s, "unified_intelligence_score", 0.0) for s in snapshots]
    memory_vals = [get(s, "memory_mb", 0.0) for s in snapshots]
    
    # Calculate simple derivatives
    phi_derivatives = calculate_simple_derivatives(cycles, phi_vals)
    intel_derivatives = calculate_simple_derivatives(cycles, intel_vals)
    
    # Find basic issues
    issues = find_basic_issues(phi_vals, intel_vals, memory_vals, entity_count)
    
    return Dict(
        "entity_count" => entity_count,
        "max_phi" => maximum(phi_vals),
        "final_phi" => phi_vals[end],
        "max_intelligence" => maximum(intel_vals),
        "phi_derivatives" => phi_derivatives,
        "intel_derivatives" => intel_derivatives,
        "issues_found" => issues,
        "health_score" => calculate_simple_health(phi_vals, intel_vals, issues)
    )
end

function calculate_simple_derivatives(cycles, values)
    """Calculate basic derivatives"""
    derivatives = zeros(length(cycles))
    for i in 2:length(cycles)
        dt = cycles[i] - cycles[i-1]
        if dt > 0
            derivatives[i] = (values[i] - values[i-1]) / dt
        end
    end
    return derivatives
end

function find_basic_issues(phi_vals, intel_vals, memory_vals, entity_count)
    """Find obvious issues - no complex pattern matching"""
    issues = []
    
    # Consciousness collapse
    if length(phi_vals) >= 3
        max_phi = maximum(phi_vals)
        final_phi = phi_vals[end]
        if max_phi > 0.2 && final_phi < max_phi * 0.7
            push!(issues, "Consciousness dropped $(round((max_phi - final_phi)/max_phi*100, digits=1))%")
        end
    end
    
    # Intelligence drop
    if length(intel_vals) >= 3
        max_intel = maximum(intel_vals)
        final_intel = intel_vals[end]
        if max_intel > 0.5 && final_intel < max_intel * 0.8
            push!(issues, "Intelligence dropped $(round((max_intel - final_intel)/max_intel*100, digits=1))%")
        end
    end
    
    # High memory usage
    if !isempty(memory_vals)
        max_memory = maximum(memory_vals)
        if max_memory > 100  # Over 100MB
            push!(issues, "High memory usage: $(round(max_memory, digits=1))MB")
        end
    end
    
    return issues
end

function calculate_simple_health(phi_vals, intel_vals, issues)
    """Calculate simple health score"""
    score = 100.0
    score -= length(issues) * 20
    if !isempty(phi_vals) && phi_vals[end] > 0.15
        score += 10
    end
    if !isempty(intel_vals) && intel_vals[end] > 0.5
        score += 10
    end
    return max(0.0, min(100.0, score))
end

function integrate_with_main_orchestrator()
    """Keep the same function name for main orchestrator"""
    println("🧮 CALCULUS DETECTIVE - ANALYZING...")
    success = run_universal_calculus_analysis()
    println("   ✅ Analysis completed")
    return success
end

export integrate_with_main_orchestrator

if abspath(PROGRAM_FILE) == @__FILE__
    integrate_with_main_orchestrator()
end
