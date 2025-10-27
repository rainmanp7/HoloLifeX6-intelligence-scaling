# safe_tester.jl
"""
🧪 SAFE TESTER MODULE - ADAPTIVE SCALING BASELINE
A non-invasive testing framework with adaptive cycle counts for reliable
baseline measurements across a defined scaling range (16 to 1024 entities).
"""

using JSON
using Dates
using Statistics

# Helper function for safe math
safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct SafeTester
    results::Vector{Dict{String,Any}}
    start_time::Float64
    
    SafeTester() = new(Dict{String,Any}[], time())
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
    if memory_mb > 8000 # 8 GB limit for baseline tests
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

# --- ADAPTIVE CYCLE CALCULATION ---
"""
    calculate_adaptive_cycles(entity_count, base_cycles, base_entity_count)

Intelligently calculates the number of cycles for a test run based on a baseline.
"""
function calculate_adaptive_cycles(entity_count::Int, base_cycles::Int, base_entity_count::Int)::Int
    if entity_count <= base_entity_count
        return base_cycles
    else
        # Use a logarithmic reduction factor to smoothly decrease cycles for larger systems.
        reduction_factor = log2(entity_count / base_entity_count)
        cycles = round(Int, base_cycles / (1 + reduction_factor * 0.5))
        return max(10, cycles) # Ensure at least 10 cycles are run.
    end
end

function run_unified_test(tester::SafeTester, entity_count::Int, cycles::Int)::Dict{String,Any}
    log_message(tester, "🧪 Testing $entity_count entities for $cycles cycles...")
    
    domains = ["physical", "temporal", "semantic", "network", "spatial", "emotional", "social", "creative"]
    
    network = UnifiedNetwork()
    
    for i in 1:entity_count
        domain = domains[(i-1) % length(domains) + 1]
        freq = 0.02 + (i * 0.0005)
        entity_id = "$(uppercase(domain[1:3]))-$(lpad(i, 3, '0'))"
        entity = EfficientEntity(entity_id, domain, freq)
        add_entity!(network, entity)
    end
    
    metrics_snapshots = Dict{String,Any}[]
    
    for cycle in 1:cycles
        step_result = evolve_step!(network)
        
        if cycle % 10 == 0
            metrics = calculate_unified_metrics(network)
            metrics["cycle"] = cycle
            metrics["step_insights"] = get(step_result, "insights", 0)
            metrics["new_patterns"] = get(step_result, "new_patterns", 0)
            metrics["memory_mb"] = get_memory_mb()
            
            clean_metrics = clean_data_for_json(metrics)
            push!(metrics_snapshots, clean_metrics)
            
            if !memory_check(tester)
                log_message(tester, "🛑 Stopping early - memory limit")
                break
            end
        end
    end
    
    final_metrics = calculate_unified_metrics(network)
    clean_final_metrics = clean_data_for_json(final_metrics)
    
    avg_memory = !isempty(metrics_snapshots) ? mean([m["memory_mb"] for m in metrics_snapshots]) : 0.0
    peak_memory = !isempty(metrics_snapshots) ? maximum([m["memory_mb"] for m in metrics_snapshots]) : 0.0

    result = merge(clean_final_metrics, Dict(
        "test_name" => "unified_$(entity_count)_entities",
        "cycles_completed" => isempty(metrics_snapshots) ? 0 : last(metrics_snapshots)["cycle"],
        "avg_memory_mb" => avg_memory,
        "peak_memory_mb" => peak_memory,
        "status" => "completed",
        "snapshots" => metrics_snapshots
    ))
    
    push!(tester.results, result)
    
    log_message(tester, "✅ Completed: UIS=$(round(get(result, "unified_intelligence_score", 0.0), digits=3)), " *
                       "R=$(round(get(result, "reasoning_accuracy", 0.0), digits=3)), " *
                       "Φ=$(round(get(get(result, "consciousness", Dict()), "max_phi", 0.0), digits=3))")
    
    return result
end

function run_scaling_sweep(tester::SafeTester)::Vector{Dict{String,Any}}
    log_message(tester, "🚀 Starting scaling sweep...")
    
    # MODIFICATION: Use the new, corrected entity counts.
    entity_counts = [16, 32, 64, 128, 256, 512, 1024]
    base_cycles = 50
    base_entity_count = first(entity_counts) # The baseline is now 16 entities.
    
    sweep_results = Dict{String,Any}[]
    
    for entity_count in entity_counts
        try
            # MODIFICATION: Calculate adaptive cycles using the correct baseline.
            cycles_to_run = calculate_adaptive_cycles(entity_count, base_cycles, base_entity_count)
            
            result = run_unified_test(tester, entity_count, cycles_to_run)
            push!(sweep_results, result)
            
            if get(result, "status", "") != "completed"
                log_message(tester, "🛑 Stopping sweep at $entity_count entities due to incomplete status.")
                break
            end
            
            GC.gc() # Force garbage collection between runs.
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
    
    if length(sweep_results) > 1
        baseline = first(sweep_results)
        baseline_uis = get(baseline, "unified_intelligence_score", 0.0)
        baseline_memory = get(baseline, "avg_memory_mb", 0.0)
        
        for result in sweep_results[2:end]
            scale_factor = get(result, "entity_count", 1) / get(baseline, "entity_count", 1)
            
            uis_ratio = safe_divide(get(result, "unified_intelligence_score", 0.0), baseline_uis)
            result["intelligence_scaling"] = round(safe_divide(uis_ratio, scale_factor), digits=3)
            
            expected_memory = baseline_memory * scale_factor
            actual_memory = get(result, "avg_memory_mb", 0.0)
            result["memory_efficiency"] = round(safe_divide((expected_memory - actual_memory), expected_memory) * 100, digits=1)
            
            result["consciousness_scaling"] = round(safe_divide(get(get(result, "consciousness", Dict()), "max_phi", 0.0), max(get(get(baseline, "consciousness", Dict()), "max_phi", 0.01), 0.01)), digits=3)
            result["reasoning_scaling"] = round(safe_divide(get(result, "reasoning_accuracy", 0.0), max(get(baseline, "reasoning_accuracy", 0.01), 0.01)), digits=3)
            result["awareness_scaling"] = round(safe_divide(get(result, "awareness_level", 0.0), max(get(baseline, "awareness_level", 0.01), 0.01)), digits=3)
        end
    end
    
    return sweep_results
end

function save_results(tester::SafeTester)::String
    timestamp = Dates.format(now(), "yyyymmdd_HHMMSS")
    filename = "unified_intelligence_scaling_MODULAR_$timestamp.json"
    
    clean_results = [clean_data_for_json(result) for result in tester.results]
    
    output_data = Dict(
        "results" => clean_results,
        "test_time" => time() - tester.start_time,
        "timestamp" => string(now())
    )
    
    json_string = JSON.json(output_data, 2)
    open(filename, "w") do f
        write(f, json_string)
    end
    
    log_message(tester, "💾 Results saved to: $filename")
    return filename
end

function print_summary(tester::SafeTester)
    println("\n" * "="^70)
    println("📊 MODULAR UNIFIED INTELLIGENCE SCALING SUMMARY")
    println("="^70)
    
    if isempty(tester.results)
        println("❌ No results to display")
        return
    end
    
    for result in tester.results
        println("\n🧬 $(get(result, "test_name", "untitled_test")):")
        println("   Entities: $(get(result, "entity_count", "N/A"))")
        println("   ─────────────────────────────────────────")
        println("   🧠 CONSCIOUSNESS:")
        consciousness_data = get(result, "consciousness", Dict())
        println("      • Status: $(get(consciousness_data, "is_conscious", false) ? "YES ✅" : "NO ❌")")
        println("      • Max Φ: $(get(consciousness_data, "max_phi", "N/A"))")
        println("      • Effective Info: $(get(result, "effective_information", "N/A"))")
        println("      • Frameworks: $(join(get(consciousness_data, "confirming_frameworks", []), ", "))")
        
        println("   🎯 REASONING:")
        println("      • Accuracy: $(get(result, "reasoning_accuracy", "N/A"))")
        
        println("   👁️  AWARENESS:")
        println("      • Level: $(get(result, "awareness_level", "N/A"))")
        
        println("   💡 INTELLIGENCE:")
        println("      • Unified Score: $(get(result, "unified_intelligence_score", "N/A"))")
        println("      • Patterns: $(get(result, "pattern_discoveries", "N/A"))")
        
        if haskey(result, "intelligence_scaling")
            println("   📊 SCALING:")
            println("      • Intelligence: $(get(result, "intelligence_scaling", "N/A"))x")
            println("      • Memory Efficiency: $(get(result, "memory_efficiency", "N/A"))%")
        end
    end
end
