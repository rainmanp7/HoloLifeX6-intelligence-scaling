# safe_tester.jl
"""
🧪 SAFE TESTER MODULE
v4.2: Correctly configured for ADAPTIVE time-to-consciousness experiment within the scalable architecture.
"""

using JSON
using Dates
using Statistics
using Random

# This must be included here to define the functions we will call.
include("calculus_optimizer.jl")

safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct SafeTester
    results::Vector{Dict{String,Any}}
    start_time::Float64
    
    SafeTester() = new(Dict{String,Any}[], time())
end

# (All helper functions and run_unified_test are correct and unchanged)
function log_message(tester::SafeTester, message::String)
    elapsed = time() - tester.start_time; println("[$(round(elapsed, digits=1))s] $message")
end
function get_memory_mb()::Float64
    return Base.gc_live_bytes() / 1024 / 1024
end
function memory_check(tester::SafeTester)::Bool
    memory_mb = get_memory_mb(); if memory_mb > 6000; log_message(tester, "⚠️ MEMORY WARNING: $(round(memory_mb, digits=1))MB. Stopping run."); return false; end; return true
end
function clean_data_for_json(data::Any)
    if data isa Real; return isfinite(data) ? data : 0.0; elseif data isa Dict; return Dict(k => clean_data_for_json(v) for (k, v) in data); elseif data isa Vector; return [clean_data_for_json(x) for x in data]; else; return data; end
end
function run_unified_test(tester::SafeTester, entity_count::Int, cycles::Int, adaptive_cycles::Bool, sim_rng::AbstractRNG)::Dict{String,Any}
    log_message(tester, "🧪 Testing $entity_count entities... (Cycles: $(adaptive_cycles ? "Adaptive up to $cycles" : "$cycles Fixed"))"); domains = ["physical", "temporal", "semantic", "network", "spatial", "emotional", "social", "creative"]; network = UnifiedNetwork(); for i in 1:entity_count; domain = domains[(i-1) % length(domains) + 1]; freq = 0.02 + (i * 0.0005); entity_id = "$(uppercase(domain[1:3]))-$(lpad(i, 3, '0'))"; entity = EfficientEntity(entity_id, domain, freq); add_entity!(network, entity); end; metrics_snapshots = Dict{String,Any}[]; for cycle in 1:cycles; step_result = evolve_step!(network, sim_rng); if cycle % 10 == 0; metrics = calculate_unified_metrics(network); metrics["cycle"] = cycle; metrics["step_insights"] = step_result["insights"]; metrics["new_patterns"] = step_result["new_patterns"]; metrics["memory_mb"] = get_memory_mb(); clean_metrics = clean_data_for_json(metrics); push!(metrics_snapshots, clean_metrics); if adaptive_cycles && get(get(metrics, "consciousness", Dict()), "is_conscious", false); log_message(tester, "✨ Consciousness achieved at cycle $cycle. Ending adaptive run."); break; end; if !memory_check(tester); break; end; end; end; final_metrics = calculate_unified_metrics(network); clean_final_metrics = clean_data_for_json(final_metrics); cycles_completed = isempty(metrics_snapshots) ? 0 : metrics_snapshots[end]["cycle"]; result = merge(clean_final_metrics, Dict("test_name" => "unified_$(entity_count)_entities", "cycles_completed" => cycles_completed, "avg_memory_mb" => isempty(metrics_snapshots) ? 0.0 : mean([m["memory_mb"] for m in metrics_snapshots]), "peak_memory_mb" => isempty(metrics_snapshots) ? 0.0 : maximum([m["memory_mb"] for m in metrics_snapshots]), "status" => "completed", "snapshots" => metrics_snapshots)); push!(tester.results, result); log_message(tester, "✅ Completed: UIS=$(round(result["unified_intelligence_score"], digits=3)), R=$(round(result["reasoning_accuracy"], digits=3)), Φ=$(round(result["consciousness"]["max_phi"], digits=3))"); return result
end


# --- THIS IS THE CORRECTED FUNCTION FOR THE ADAPTIVE EXPERIMENT ---
function run_scaling_sweep(tester::SafeTester, adaptive_cycles::Bool=true)::Vector{Dict{String,Any}}
    # Forcing adaptive mode as requested by the experiment design
    log_message(tester, "🚀 Starting ADAPTIVE scaling sweep to measure time-to-consciousness...")
    
    master_seed = 1234
    master_rng = MersenneTwister(master_seed)

    entity_counts = [16, 32, 64, 128, 256, 512]
    max_runway_cycles = 500 # Give a long time for emergence if needed

    sweep_results = Dict{String,Any}[]
    calc_optimizer = LearningCalculusOptimizer()
    
    for entity_count in entity_counts
        try
            sim_rng = MersenneTwister(rand(master_rng, UInt32))
            
            # Pass `true` for adaptive_cycles and the long runway
            result = run_unified_test(tester, entity_count, max_runway_cycles, true, sim_rng)
            push!(sweep_results, result)
            
            analyze_single_run_and_learn(calc_optimizer, result)

            if result["status"] != "completed"; log_message(tester, "🛑 Stopping sweep at $entity_count entities"); break; end
            
            GC.gc()
        catch e
            log_message(tester, "❌ Error testing $entity_count entities: $e")
            showerror(stdout, e, catch_backtrace())
            break
        end
    end

    finalize_and_save_report(calc_optimizer)
    
    # Restore calculation of scaling metrics
    if length(sweep_results) > 1
        baseline = sweep_results[1]
        if haskey(baseline, "unified_intelligence_score") && haskey(baseline, "avg_memory_mb")
            baseline_uis = baseline["unified_intelligence_score"]
            baseline_memory = baseline["avg_memory_mb"]
            
            for result in sweep_results[2:end]
                scale_factor = result["entity_count"] / baseline["entity_count"]
                uis_ratio = safe_divide(result["unified_intelligence_score"], baseline_uis)
                result["intelligence_scaling"] = round(safe_divide(uis_ratio, scale_factor), digits=3)
                expected_memory = baseline_memory * scale_factor
                actual_memory = get(result, "avg_memory_mb", 0.0)
                result["memory_efficiency"] = round(safe_divide((expected_memory - actual_memory), expected_memory) * 100, digits=1)
            end
        end
    end
    
    return sweep_results
end

# (save_results and print_summary are unchanged)
function save_results(tester::SafeTester)::String
    timestamp = Dates.format(now(), "yyyymmdd_HHMMSS"); filename = "unified_intelligence_scaling_MODULAR_$timestamp.json"; clean_results = [clean_data_for_json(result) for result in tester.results]; output_data = Dict("results" => clean_results, "test_time" => time() - tester.start_time, "timestamp" => string(now())); json_string = JSON.json(output_data, 2); open(filename, "w") do f; write(f, json_string); end; log_message(tester, "💾 Results saved to: $filename"); return filename
end
function print_summary(tester::SafeTester)
    println("\n" * "="^70); println("📊 MODULAR UNIFIED INTELLIGENCE SCALING SUMMARY"); println("="^70); if isempty(tester.results); println("❌ No results to display"); return; end; for result in tester.results; println("\n🧬 $(result["test_name"]):"); println("   Entities: $(result["entity_count"])"); println("   Cycles to Result: $(get(result, "cycles_completed", "N/A"))"); println("   ─────────────────────────────────────────"); println("   🧠 CONSCIOUSNESS:"); println("      • Status: $(result["consciousness"]["is_conscious"] ? "YES ✅" : "NO ❌")"); println("      • Max Φ: $(result["consciousness"]["max_phi"])"); println("      • Effective Info: $(result["effective_information"])"); println("      • Frameworks: $(join(result["consciousness"]["confirming_frameworks"], ", "))"); println("   🎯 REASONING:"); println("      • Accuracy: $(result["reasoning_accuracy"])"); println("   👁️  AWARENESS:"); println("      • Level: $(result["awareness_level"])"); println("   💡 INTELLIGENCE:"); println("      • Unified Score: $(result["unified_intelligence_score"])"); println("      • Patterns: $(result["pattern_discoveries"])"); if haskey(result, "intelligence_scaling"); println("   📊 SCALING:"); println("      • Intelligence: $(result["intelligence_scaling"])x"); println("      • Memory Efficiency: $(get(result, "memory_efficiency", "N/A"))%"); end; end
end
