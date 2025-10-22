# safe_tester.jl
"""
🔬 REFACTORED SAFE TESTER MODULE
A modular testing framework for performance, scaling, and correctness,
with a focus on clarity and single-responsibility functions.
"""

using JSON
using Dates
using Statistics

# ==============================================================================
# 1. CORE TESTER STRUCT AND HELPERS
# Unchanged core structure, but with more focused utility functions.
# ==============================================================================

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
    # Encapsulate memory reading for clarity.
    return Base.gc_live_bytes() / (1024^2)
end

function clean_data_for_json(data::Any)
    # This recursive function is well-defined and serves a single purpose. No changes needed.
    if data isa Real
        return isfinite(data) ? data : 0.0
    elseif data isa Dict
        return Dict(k => clean_data_for_json(v) for (k, v) in data)
    elseif data isa Vector
        return [clean_data_for_json(x) for x in data]
    else
        return string(data) # Safer fallback to stringify unknown types
    end
end

# ==============================================================================
# 2. REFACTORED TEST EXECUTION LOGIC
# `run_unified_test` is now broken down into smaller, testable components.
# ==============================================================================

"""
Creates and populates a UnifiedNetwork with a specified number of entities.
"""
function setup_network_for_test(entity_count::Int)::UnifiedNetwork
    network = UnifiedNetwork()
    domains = ["physical", "temporal", "semantic", "network", "spatial", "emotional", "social", "creative"]
    
    for i in 1:entity_count
        domain = domains[mod1(i, length(domains))]
        freq = 0.02 + (i * 0.0005)
        entity_id = "$(uppercase(domain[1:3]))-$(lpad(i, 3, '0'))"
        entity = EfficientEntity(entity_id, domain, freq)
        add_entity!(network, entity)
    end
    return network
end

"""
Executes the simulation loop for a given network and returns metric snapshots.
"""
function execute_simulation_cycles(network::UnifiedNetwork, cycles::Int)::Vector{Dict{String,Any}}
    snapshots = Dict{String,Any}[]
    
    for cycle in 1:cycles
        step_result = evolve_step!(network)
        
        if mod(cycle, 10) == 0
            metrics = calculate_unified_metrics(network)
            metrics["cycle"] = cycle
            metrics["step_insights"] = get(step_result, "insights", 0)
            metrics["new_patterns"] = get(step_result, "new_patterns", 0)
            metrics["memory_mb"] = get_memory_mb()
            
            push!(snapshots, clean_data_for_json(metrics))
            
            # Memory check logic is simple enough to remain here.
            if get_memory_mb() > 6000
                println("   ⚠️  MEMORY WARNING: Stopping test early.")
                break
            end
        end
    end
    return snapshots
end

"""
Main entry point for a single test run. Orchestrates setup, execution, and result compilation.
"""
function run_unified_test(tester::SafeTester, entity_count::Int, cycles::Int=50)::Dict{String,Any}
    log_message(tester, "🔬 Testing $entity_count entities for $cycles cycles...")
    
    # --- DELEGATION ---
    network = setup_network_for_test(entity_count)
    metrics_snapshots = execute_simulation_cycles(network, cycles)
    # ------------------
    
    if isempty(metrics_snapshots)
        log_message(tester, "❌ Test failed to produce any metrics snapshots.")
        return Dict("status" => "failed", "test_name" => "unified_$(entity_count)_entities")
    end
    
    # Compile the final results dictionary
    final_metrics = metrics_snapshots[end] # Use the last snapshot's metrics
    avg_memory = mean(get.(metrics_snapshots, "memory_mb", 0.0))
    peak_memory = maximum(get.(metrics_snapshots, "memory_mb", 0.0))

    result = merge(final_metrics, Dict(
        "test_name" => "unified_$(entity_count)_entities",
        "cycles_completed" => length(metrics_snapshots) * 10,
        "avg_memory_mb" => avg_memory,
        "peak_memory_mb" => peak_memory,
        "status" => "completed",
        "snapshots" => metrics_snapshots
    ))
    
    push!(tester.results, result)
    
    # Use a helper for the log summary to keep this function clean
    log_test_completion(tester, result)
    
    return result
end

# ==============================================================================
# 3. REFACTORED SCALING SWEEP LOGIC
# `run_scaling_sweep` is now clearer by separating analysis from execution.
# ==============================================================================

"""
Calculates scaling metrics by comparing a result to a baseline.
"""
function analyze_scaling_performance(result::Dict, baseline::Dict)
    scale_factor = result["entity_count"] / baseline["entity_count"]
    
    # Intelligence Scaling
    uis_ratio = safe_divide(result["unified_intelligence_score"], baseline["unified_intelligence_score"])
    result["intelligence_scaling"] = round(safe_divide(uis_ratio, scale_factor), digits=3)
    
    # Memory Efficiency
    expected_memory = baseline["avg_memory_mb"] * scale_factor^2 # Memory often scales quadratically (e.g., matrices)
    result["memory_efficiency"] = round(safe_divide(expected_memory, result["avg_memory_mb"]), digits=2)

    # Component Scaling
    result["consciousness_scaling"] = round(safe_divide(get(result["consciousness"],"max_phi",0.0), get(baseline["consciousness"],"max_phi",0.01)), digits=3)
    result["reasoning_scaling"] = round(safe_divide(result["reasoning_accuracy"], max(baseline["reasoning_accuracy"], 0.01)), digits=3)
end

"""
Executes a series of tests with increasing entity counts to measure scaling.
"""
function run_scaling_sweep(tester::SafeTester)::Vector{Dict{String,Any}}
    log_message(tester, "🚀 Starting scaling sweep...")
    
    entity_counts = [16, 32, 64]
    sweep_results = Dict{String,Any}[]
    
    for entity_count in entity_counts
        try
            result = run_unified_test(tester, entity_count, 50)
            push!(sweep_results, result)
            
            if result["status"] != "completed"
                log_message(tester, "🛑 Stopping sweep at $entity_count entities due to test failure.")
                break
            end
            
            GC.gc() # Force garbage collection between heavy tests
        catch e
            log_message(tester, "❌ Error testing $entity_count entities: $e")
            # Simplified stack trace for cleaner logs
            showerror(stdout, e, catch_backtrace())
            println()
            break
        end
    end
    
    # --- DELEGATION ---
    # Analyze results only after all tests are run
    if length(sweep_results) > 1
        baseline = sweep_results[1]
        for result in sweep_results[2:end]
            analyze_scaling_performance(result, baseline)
        end
    end
    # ------------------
    
    return sweep_results
end

# ==============================================================================
# 4. REFACTORED OUTPUT AND LOGGING
# `print_summary` now uses helpers to avoid deep nesting.
# ==============================================================================

function log_test_completion(tester::SafeTester, result::Dict)
    # Helper to format the one-line summary.
    uis = round(get(result, "unified_intelligence_score", 0.0), digits=3)
    reasoning = round(get(result, "reasoning_accuracy", 0.0), digits=3)
    phi = round(get(get(result, "consciousness", Dict()), "max_phi", 0.0), digits=3)
    
    log_message(tester, "✅ Completed $(result["test_name"]): UIS=$uis, R=$reasoning, Φ=$phi")
end

function print_single_result_summary(result::Dict)
    # Helper to print one formatted result block.
    println("\n🔬 $(get(result, "test_name", "Unknown Test")): ($(get(result, "entity_count", 0)) entities)")
    println("   " * "─"^60)
    
    # Consciousness
    consciousness = get(result, "consciousness", Dict())
    println("   🧠 CONSCIOUSNESS:")
    println("      • Status: $(get(consciousness, "is_conscious", false) ? "YES ✅" : "NO ❌")")
    println("      • Max Φ: $(get(consciousness, "max_phi", "N/A"))")
    
    # Core Metrics
    println("   🎯 REASONING & AWARENESS:")
    println("      • Reasoning Accuracy: $(get(result, "reasoning_accuracy", "N/A"))")
    println("      • Awareness Level: $(get(result, "awareness_level", "N/A"))")
    
    # Intelligence
    println("   💡 INTELLIGENCE:")
    println("      • Unified Score: $(get(result, "unified_intelligence_score", "N/A"))")
    
    # Scaling Metrics
    if haskey(result, "intelligence_scaling")
        println("   📈 SCALING:")
        println("      • Intelligence Scaling: $(get(result, "intelligence_scaling", "N/A"))x")
        println("      • Memory Efficiency: $(get(result, "memory_efficiency", "N/A"))")
    end
end

"""
Prints a formatted summary of all test results stored in the tester.
"""
function print_summary(tester::SafeTester)
    println("\n" * "="^70)
    println("📊 UNIFIED INTELLIGENCE SCALING SUMMARY")
    println("="^70)
    
    if isempty(tester.results)
        println("❌ No results to display.")
        return
    end
    
    # --- DELEGATION ---
    for result in tester.results
        print_single_result_summary(result)
    end
    # ------------------
    println("\n" * "="^70)
end

"""
Saves all test results to a timestamped JSON file.
"""
function save_results(tester::SafeTester)::String
    timestamp = Dates.format(now(), "yyyymmdd_HHMMSS")
    filename = "test_results_$(timestamp).json"
    
    output_data = Dict(
        "test_run_summary" => "Unified Intelligence Scaling Test",
        "test_suite_time_seconds" => time() - tester.start_time,
        "timestamp_utc" => string(now(UTC)),
        "results" => clean_data_for_json(tester.results)
    )
    
    try
        open(filename, "w") do f
            write(f, JSON.json(output_data, 2))
        end
        log_message(tester, "💾 Results saved to: $filename")
    catch e
        log_message(tester, "⚠️  Failed to save results: $e")
    end
    
    return filename
end
