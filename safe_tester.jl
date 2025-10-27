[file name]: safe_tester.jl
[file content begin]
# safe_tester.jl
"""
🧪 SAFE TESTER MODULE
Testing framework with memory management and result logging
"""

using JSON
using Dates

safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct SafeTester
    results::Vector{Dict{String,Any}}
    start_time::Float64
    consciousness_smoother::ConsciousnessSmoother  # 🎯 CRITICAL FIX: Added smoother
    
    function SafeTester()
        new(Dict{String,Any}[], time(), ConsciousnessSmoother())  # Initialize smoother
    end
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

function run_unified_test(tester::SafeTester, entity_count::Int, cycles::Int=50)::Dict{String,Any}
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
            # 🎯 CRITICAL FIX: Pass smoother to calculate_unified_metrics
            metrics = calculate_unified_metrics(network, tester.consciousness_smoother)
            metrics["cycle"] = cycle
            metrics["step_insights"] = step_result["insights"]
            metrics["new_patterns"] = step_result["new_patterns"]
            metrics["memory_mb"] = get_memory_mb()
            
            clean_metrics = clean_data_for_json(metrics)
            push!(metrics_snapshots, clean_metrics)
            
            if !memory_check(tester)
                log_message(tester, "🛑 Stopping early - memory limit")
                break
            end
        end
    end
    
    # 🎯 CRITICAL FIX: Pass smoother to final metrics calculation
    final_metrics = calculate_unified_metrics(network, tester.consciousness_smoother)
    clean_final_metrics = clean_data_for_json(final_metrics)
    
    result = merge(clean_final_metrics, Dict(
        "test_name" => "unified_$(entity_count)_entities",
        "cycles_completed" => length(metrics_snapshots) * 10,
        "avg_memory_mb" => mean([m["memory_mb"] for m in metrics_snapshots]),
        "peak_memory_mb" => maximum([m["memory_mb"] for m in metrics_snapshots]),
        "status" => "completed",
        "snapshots" => metrics_snapshots
    ))
    
    push!(tester.results, result)
    
    log_message(tester, "✅ Completed: UIS=$(round(result["unified_intelligence_score"], digits=3)), " *
                       "R=$(round(result["reasoning_accuracy"], digits=3)), " *
                       "Φ=$(round(result["consciousness"]["max_phi"], digits=3))")
    
    return result
end

function run_scaling_sweep(tester::SafeTester)::Vector{Dict{String,Any}}
    log_message(tester, "🚀 Starting scaling sweep...")
    
    # Entity counts with adjusted cycle counts based on entity size
    entity_configs = [
        (32, 20),   # Small: more cycles to establish patterns
        (64, 20),    # Medium: slightly fewer cycles
        (128, 20),   # Large: moderate cycles
        (256, 20),   # Very large: fewer cycles
        (1024, 20)   # Massive: minimal cycles for stability
    ]
    
    sweep_results = Dict{String,Any}[]
    
    for (entity_count, cycles) in entity_configs
        try
            log_message(tester, "🔧 Config: $entity_count entities, $cycles cycles")
            result = run_unified_test(tester, entity_count, cycles)
            push!(sweep_results, result)
            
            if result["status"] != "completed"
                log_message(tester, "🛑 Stopping sweep at $entity_count entities")
                break
            end
            
            GC.gc()
            sleep(1)  # Brief pause between tests for system stability
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
    
    if !isempty(sweep_results)
        baseline = sweep_results[1]
        baseline_uis = baseline["unified_intelligence_score"]
        baseline_memory = baseline["avg_memory_mb"]
        
        for result in sweep_results[2:end]
            scale_factor = result["entity_count"] / baseline["entity_count"]
            
            uis_ratio = safe_divide(result["unified_intelligence_score"], baseline_uis)
            result["intelligence_scaling"] = round(safe_divide(uis_ratio, scale_factor), digits=3)
            
            expected_memory = baseline_memory * scale_factor
            actual_memory = result["avg_memory_mb"]
            result["memory_efficiency"] = round(safe_divide((expected_memory - actual_memory), expected_memory) * 100, digits=1)
            
            result["consciousness_scaling"] = round(safe_divide(result["consciousness"]["max_phi"], max(baseline["consciousness"]["max_phi"], 0.01)), digits=3)
            result["reasoning_scaling"] = round(safe_divide(result["reasoning_accuracy"], max(baseline["reasoning_accuracy"], 0.01)), digits=3)
            result["awareness_scaling"] = round(safe_divide(result["awareness_level"], max(baseline["awareness_level"], 0.01)), digits=3)
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
        println("\n🧬 $(result["test_name"]):")
        println("   Entities: $(result["entity_count"])")
        println("   Cycles: $(result["cycles_completed"])")
        println("   ─────────────────────────────────────────")
        println("   🧠 CONSCIOUSNESS:")
        println("      • Status: $(result["consciousness"]["is_conscious"] ? "YES ✅" : "NO ❌")")
        println("      • Max Φ: $(result["consciousness"]["max_phi"])")
        println("      • Effective Info: $(result["effective_information"])")
        println("      • Frameworks: $(join(result["consciousness"]["confirming_frameworks"], ", "))")
        
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
            println("      • Memory Efficiency: $(result["memory_efficiency"])%")
        end
    end
end
[file content end]
