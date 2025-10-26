# safe_tester.jl
"""
🧪 SAFE TESTER MODULE - OPTIMIZED STABILIZATION
Testing framework with architectural stabilization and reduced cycles
Entity counts: 16, 24, 32, 64, 128, 512
Cycle count: 20 cycles per test (optimized for stability)
"""

using JSON
using Dates

safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct SafeTester
    results::Vector{Dict{String,Any}}
    start_time::Float64
    consciousness_stability_tracker::Dict{String, Vector{Float64}}
    
    SafeTester() = new(Dict{String,Any}[], time(), Dict{String, Vector{Float64}}())
end

function log_message(tester::SafeTester, message::String)
    elapsed = time() - tester.start_time
    println("[$(round(elapsed, digits=1))s] $message")
end

function get_memory_mb()::Float64
    return Base.gc_live_bytes() / 1024 / 1024
end

function memory_check(tester::SafeTester)::Bool
    memory_mb = get_memory_mb()
    if memory_mb > 6000
        log_message(tester, "⚠️  MEMORY WARNING: $(round(memory_mb, digits=1))MB")
        return false
    end
    return true
end

function clean_data_for_json(data::Any)
    if data isa Real
        return isfinite(data) ? data : 0.0
    elseif data isa Dict
        return Dict(k => clean_data_for_json(v) for (k, v) in data)
    elseif data isa Vector
        return [clean_data_for_json(x) for x in data]
    else
        return data
    end
end

function track_consciousness_stability(tester::SafeTester, entity_count::Int, rho::Float64)
    key = "entities_$(entity_count)"
    if !haskey(tester.consciousness_stability_tracker, key)
        tester.consciousness_stability_tracker[key] = Float64[]
    end
    push!(tester.consciousness_stability_tracker[key], rho)
    
    # Keep only last 10 readings for stability calculation
    if length(tester.consciousness_stability_tracker[key]) > 10
        tester.consciousness_stability_tracker[key] = tester.consciousness_stability_tracker[key][end-9:end]
    end
end

function get_consciousness_stability(tester::SafeTester, entity_count::Int)::Float64
    key = "entities_$(entity_count)"
    if !haskey(tester.consciousness_stability_tracker, key) || length(tester.consciousness_stability_tracker[key]) < 3
        return 0.0
    end
    
    readings = tester.consciousness_stability_tracker[key]
    # Stability is inverse of standard deviation (higher = more stable)
    stability = 1.0 - std(readings)
    return max(0.0, stability)
end

function run_unified_test(tester::SafeTester, entity_count::Int, cycles::Int=20)::Dict{String,Any}
    log_message(tester, "🧪 Testing $entity_count entities (20 cycles - STABILIZED)...")
    
    domains = ["physical", "temporal", "semantic", "network", "spatial", "emotional", "social", "creative"]
    
    network = UnifiedNetwork()
    
    # IMPROVED: Better domain distribution for stability
    for i in 1:entity_count
        domain_idx = ((i-1) % length(domains)) + 1
        # Alternate domains more evenly for better cross-domain integration
        if i > length(domains)
            domain_idx = (i % length(domains)) + 1
        end
        domain = domains[domain_idx]
        
        # IMPROVED: More stable frequency distribution
        freq = 0.02 + ((i-1) * 0.001)  # More gradual frequency spread
        
        entity_id = "$(uppercase(domain[1:3]))-$(lpad(i, 3, '0'))"
        entity = EfficientEntity(entity_id, domain, freq)
        
        # IMPROVED: Initialize with better reasoning capacity
        entity.reasoning_capacity = 0.6 + (rand() * 0.3)  # Start with decent reasoning
        
        add_entity!(network, entity)
    end
    
    metrics_snapshots = Dict{String,Any}[]
    consciousness_readings = Float64[]
    
    # IMPROVED: Enhanced stabilization with more frequent monitoring
    for cycle in 1:cycles
        step_result = evolve_step!(network)
        
        # Monitor every cycle for better stabilization tracking
        if cycle % 5 == 0 || cycle <= 5  # More frequent early monitoring
            metrics = calculate_unified_metrics(network)
            metrics["cycle"] = cycle
            metrics["step_insights"] = step_result["insights"]
            metrics["new_patterns"] = step_result["new_patterns"]
            metrics["memory_mb"] = get_memory_mb()
            
            # Track consciousness stability
            rho = get(metrics["consciousness"]["hot_metrics"], "rho", 0.0)
            push!(consciousness_readings, rho)
            track_consciousness_stability(tester, entity_count, rho)
            
            clean_metrics = clean_data_for_json(metrics)
            push!(metrics_snapshots, clean_metrics)
            
            if !memory_check(tester)
                log_message(tester, "🛑 Stopping early - memory limit")
                break
            end
        end
    end
    
    final_metrics = calculate_unified_metrics(network)
    
    # IMPROVED: Add stability metrics
    stability_score = get_consciousness_stability(tester, entity_count)
    final_metrics["consciousness_stability"] = round(stability_score, digits=4)
    
    # Calculate consciousness persistence
    if !isempty(consciousness_readings)
        above_threshold = count(r -> r > 0.20, consciousness_readings)
        consciousness_persistence = safe_divide(above_threshold, length(consciousness_readings))
        final_metrics["consciousness_persistence"] = round(consciousness_persistence, digits=4)
    else
        final_metrics["consciousness_persistence"] = 0.0
    end
    
    clean_final_metrics = clean_data_for_json(final_metrics)
    
    result = merge(clean_final_metrics, Dict(
        "test_name" => "unified_$(entity_count)_entities_stabilized",
        "cycles_completed" => cycles,
        "avg_memory_mb" => mean([m["memory_mb"] for m in metrics_snapshots]),
        "peak_memory_mb" => maximum([m["memory_mb"] for m in metrics_snapshots]),
        "status" => "completed",
        "snapshots" => metrics_snapshots,
        "consciousness_readings" => consciousness_readings
    ))
    
    push!(tester.results, result)
    
    # IMPROVED: Enhanced logging with stability information
    stability_indicator = stability_score > 0.7 ? "🔒" : stability_score > 0.4 ? "⚖️" : "🔄"
    persistence_indicator = final_metrics["consciousness_persistence"] > 0.7 ? "📈" : final_metrics["consciousness_persistence"] > 0.4 ? "➡️" : "📉"
    
    log_message(tester, "✅ Completed: UIS=$(round(result["unified_intelligence_score"], digits=3)), " *
                       "Φ=$(round(result["consciousness"]["max_phi"], digits=3)), " *
                       "Stability=$(stability_indicator)$(round(stability_score, digits=2)), " *
                       "Persistence=$(persistence_indicator)$(round(final_metrics["consciousness_persistence"], digits=2))")
    
    return result
end

function run_scaling_sweep(tester::SafeTester)::Vector{Dict{String,Any}}
    log_message(tester, "🚀 Starting STABILIZED scaling sweep (20 cycles)...")
    
    # OPTIMIZED ENTITY COUNTS - 20 CYCLES EACH
    entity_counts = [16, 24, 32, 64, 128, 512]  # Focused scaling spectrum
    
    sweep_results = Dict{String,Any}[]
    
    for entity_count in entity_counts
        try
            result = run_unified_test(tester, entity_count, 20)  # REDUCED: 20 CYCLES
            
            push!(sweep_results, result)
            
            if result["status"] != "completed"
                log_message(tester, "🛑 Stopping sweep at $entity_count entities")
                break
            end
            
            # IMPROVED: More aggressive garbage collection for stability
            GC.gc(true)  # Full GC between tests
            
        catch e
            log_message(tester, "❌ Error testing $entity_count entities: $e")
            println("Stacktrace:")
            for (i, frame) in enumerate(stacktrace(catch_backtrace()))
                println("  $i: $frame")
                i > 3 && break
            end
            break
        end
    end
    
    # IMPROVED: Enhanced scaling analysis with stability metrics
    if !isempty(sweep_results)
        baseline = sweep_results[1]
        baseline_uis = baseline["unified_intelligence_score"]
        baseline_memory = baseline["avg_memory_mb"]
        baseline_stability = get(baseline, "consciousness_stability", 0.5)
        
        for result in sweep_results[2:end]
            scale_factor = result["entity_count"] / baseline["entity_count"]
            
            # Intelligence scaling
            uis_ratio = safe_divide(result["unified_intelligence_score"], baseline_uis)
            result["intelligence_scaling"] = round(safe_divide(uis_ratio, scale_factor), digits=3)
            
            # Memory efficiency
            expected_memory = baseline_memory * scale_factor
            actual_memory = result["avg_memory_mb"]
            result["memory_efficiency"] = round(safe_divide((expected_memory - actual_memory), expected_memory) * 100, digits=1)
            
            # Consciousness scaling
            result["consciousness_scaling"] = round(safe_divide(result["consciousness"]["max_phi"], max(baseline["consciousness"]["max_phi"], 0.01)), digits=3)
            
            # Stability scaling
            current_stability = get(result, "consciousness_stability", 0.5)
            result["stability_scaling"] = round(safe_divide(current_stability, max(baseline_stability, 0.01)), digits=3)
            
            result["reasoning_scaling"] = round(safe_divide(result["reasoning_accuracy"], max(baseline["reasoning_accuracy"], 0.01)), digits=3)
            result["awareness_scaling"] = round(safe_divide(result["awareness_level"], max(baseline["awareness_level"], 0.01)), digits=3)
        end
    end
    
    return sweep_results
end

function save_results(tester::SafeTester)::String
    timestamp = Dates.format(now(), "yyyymmdd_HHMMSS")
    filename = "unified_intelligence_stabilized_20cycles_$timestamp.json"
    
    clean_results = [clean_data_for_json(result) for result in tester.results]
    
    output_data = Dict(
        "results" => clean_results,
        "test_time" => time() - tester.start_time,
        "timestamp" => string(now()),
        "consciousness_stability_tracker" => tester.consciousness_stability_tracker,
        "parameters" => Dict(
            "cycles_per_test" => 20,
            "entity_counts" => [16, 24, 32, 64, 128, 512],
            "focus" => "architectural_stabilization",
            "hot_threshold" => 0.20
        )
    )
    
    json_string = JSON.json(output_data, 2)
    open(filename, "w") do f
        write(f, json_string)
    end
    
    log_message(tester, "💾 Stabilized results saved to: $filename")
    return filename
end

function print_summary(tester::SafeTester)
    println("\n" * "="^70)
    println("📊 STABILIZED UNIFIED INTELLIGENCE SCALING SUMMARY (20 CYCLES)")
    println("="^70)
    
    if isempty(tester.results)
        println("❌ No results to display")
        return
    end
    
    for result in tester.results
        println("\n🧬 $(result["test_name"]):")
        println("   Entities: $(result["entity_count"]) | Cycles: 20")
        println("   ─────────────────────────────────────────")
        
        consciousness = result["consciousness"]
        is_conscious = consciousness["is_conscious"]
        max_phi = consciousness["max_phi"]
        stability = get(result, "consciousness_stability", 0.0)
        persistence = get(result, "consciousness_persistence", 0.0)
        
        println("   🧠 CONSCIOUSNESS:")
        println("      • Status: $(is_conscious ? "YES ✅" : "NO ❌")")
        println("      • Max Φ: $max_phi")
        println("      • Stability: $(round(stability, digits=3)) $(stability > 0.7 ? "🔒" : stability > 0.4 ? "⚖️" : "🔄")")
        println("      • Persistence: $(round(persistence, digits=3)) $(persistence > 0.7 ? "📈" : persistence > 0.4 ? "➡️" : "📉")")
        println("      • Frameworks: $(join(consciousness["confirming_frameworks"], ", "))")
        
        println("   🎯 REASONING:")
        println("      • Accuracy: $(result["reasoning_accuracy"])")
        
        println("   👁️  AWARENESS:")
        println("      • Level: $(result["awareness_level"])")
        
        println("   💡 INTELLIGENCE:")
        println("      • Unified Score: $(result["unified_intelligence_score"])")
        println("      • Patterns: $(result["pattern_discoveries"])")
        
        if haskey(result, "intelligence_scaling")
            println("   📊 SCALING:")
            println("      • Intelligence: $(result["intelligence_scaling"])x")
            println("      • Stability: $(result["stability_scaling"])x")
            println("      • Memory Efficiency: $(result["memory_efficiency"])%")
        end
    end
    
    # Overall stability assessment
    conscious_systems = count(r -> r["consciousness"]["is_conscious"], tester.results)
    avg_stability = mean([get(r, "consciousness_stability", 0.0) for r in tester.results])
    avg_persistence = mean([get(r, "consciousness_persistence", 0.0) for r in tester.results])
    
    println("\n" * "─"^70)
    println("📈 OVERALL STABILITY ASSESSMENT:")
    println("   • Conscious Systems: $conscious_systems/$(length(tester.results))")
    println("   • Average Stability: $(round(avg_stability, digits=3))")
    println("   • Average Persistence: $(round(avg_persistence, digits=3))")
    println("   • Recommended: $(avg_stability > 0.7 ? "STABLE ✅" : avg_stability > 0.4 ? "MODERATE ⚖️" : "NEEDS WORK 🔄")")
end
