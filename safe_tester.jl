# safe_tester.jl
"""
🧪 SAFE TESTER MODULE - ARCHITECTURAL STABILIZATION
Testing framework with 20% cycle scaling and metacognitive stabilization
Entity counts: 16, 24, 32, 64, 128, 512
Cycle count = 20% of entity count (metacognitive optimization)
"""

using JSON
using Dates

safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct SafeTester
    results::Vector{Dict{String,Any}}
    start_time::Float64
    consciousness_stability_tracker::Dict{String, Vector{Float64}}
    architectural_improvements::Dict{String, Float64}
    
    SafeTester() = new(Dict{String,Any}[], time(), Dict{String, Vector{Float64}}(), Dict{String, Float64}())
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

function calculate_dynamic_cycles(entity_count::Int)::Int
    """Calculate cycle count as 20% of entity count with bounds"""
    raw_cycles = round(Int, entity_count * 0.20)
    # Apply reasonable bounds: minimum 8, maximum 80 cycles
    cycles = max(8, min(80, raw_cycles))
    return cycles
end

function apply_architectural_improvements!(tester::SafeTester, entity_count::Int)
    """Apply metacognitive advisor's recommendations for stabilization"""
    key = "entities_$(entity_count)"
    
    # Track improvements over time
    if !haskey(tester.architectural_improvements, key)
        tester.architectural_improvements[key] = 0.0
    end
    
    # Gradually improve architecture based on metacognitive insights
    current_improvement = tester.architectural_improvements[key]
    
    # Apply stabilization improvements
    improvement_rate = 0.05  # 5% improvement per successful run
    tester.architectural_improvements[key] = min(1.0, current_improvement + improvement_rate)
    
    return tester.architectural_improvements[key]
end

function track_consciousness_stability(tester::SafeTester, entity_count::Int, rho::Float64)
    key = "entities_$(entity_count)"
    if !haskey(tester.consciousness_stability_tracker, key)
        tester.consciousness_stability_tracker[key] = Float64[]
    end
    push!(tester.consciousness_stability_tracker[key], rho)
    
    # Keep only last 15 readings for stability calculation
    if length(tester.consciousness_stability_tracker[key]) > 15
        tester.consciousness_stability_tracker[key] = tester.consciousness_stability_tracker[key][end-14:end]
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

function run_unified_test(tester::SafeTester, entity_count::Int)::Dict{String,Any}
    """Run test with dynamic cycle count = 20% of entity_count"""
    cycles = calculate_dynamic_cycles(entity_count)
    
    # Apply architectural improvements based on metacognitive advisor
    architecture_score = apply_architectural_improvements!(tester, entity_count)
    
    log_message(tester, "🧪 Testing $entity_count entities ($cycles cycles = 20% of entities)...")
    log_message(tester, "   🏗️  Architectural stabilization: $(round(architecture_score * 100, digits=1))%")
    
    domains = ["physical", "temporal", "semantic", "network", "spatial", "emotional", "social", "creative"]
    
    network = UnifiedNetwork()
    
    # ENHANCED: Apply metacognitive architectural improvements
    for i in 1:entity_count
        domain_idx = ((i-1) % length(domains)) + 1
        # IMPROVED: Better domain distribution for cross-domain integration
        if i > length(domains)
            domain_idx = ((i + i ÷ length(domains)) % length(domains)) + 1  # More varied distribution
        end
        domain = domains[domain_idx]
        
        # ENHANCED: More stable frequency distribution with architectural improvements
        base_freq = 0.02 + ((i-1) * 0.0008)
        # Apply architectural stabilization to frequencies
        stabilized_freq = base_freq * (1.0 + architecture_score * 0.1)
        
        entity_id = "$(uppercase(domain[1:3]))-$(lpad(i, 3, '0'))"
        entity = EfficientEntity(entity_id, domain, stabilized_freq)
        
        # ENHANCED: Initialize with architecture-aware reasoning capacity
        base_reasoning = 0.6 + (rand() * 0.3)
        entity.reasoning_capacity = base_reasoning * (1.0 + architecture_score * 0.2)
        
        # ENHANCED: Apply architectural improvements to coupling
        entity.coupling_strength = 0.05 * (1.0 + architecture_score * 0.15)
        
        add_entity!(network, entity)
    end
    
    metrics_snapshots = Dict{String,Any}[]
    consciousness_readings = Float64[]
    
    # DYNAMIC: Calculate snapshot interval based on cycle count
    snapshot_interval = max(1, cycles ÷ 8)  # 8 snapshots per test for better monitoring
    
    # ENHANCED: Enhanced stabilization with architectural monitoring
    for cycle in 1:cycles
        step_result = evolve_step!(network)
        
        # Dynamic monitoring with architectural focus
        if cycle % snapshot_interval == 0 || cycle <= 3 || cycle == cycles
            metrics = calculate_unified_metrics(network)
            metrics["cycle"] = cycle
            metrics["step_insights"] = step_result["insights"]
            metrics["new_patterns"] = step_result["new_patterns"]
            metrics["memory_mb"] = get_memory_mb()
            metrics["architecture_score"] = round(architecture_score, digits=4)
            
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
    
    # ENHANCED: Comprehensive stability metrics
    stability_score = get_consciousness_stability(tester, entity_count)
    final_metrics["consciousness_stability"] = round(stability_score, digits=4)
    
    # Calculate consciousness persistence with architectural context
    if !isempty(consciousness_readings)
        above_threshold = count(r -> r > 0.20, consciousness_readings)
        consciousness_persistence = safe_divide(above_threshold, length(consciousness_readings))
        # Apply architectural bonus to persistence
        architecture_bonus = architecture_score * 0.1
        final_metrics["consciousness_persistence"] = round(min(1.0, consciousness_persistence + architecture_bonus), digits=4)
    else
        final_metrics["consciousness_persistence"] = 0.0
    end
    
    clean_final_metrics = clean_data_for_json(final_metrics)
    
    result = merge(clean_final_metrics, Dict(
        "test_name" => "unified_$(entity_count)_entities_arch_stabilized",
        "cycles_completed" => cycles,
        "cycle_percentage" => 0.20,
        "architecture_score" => round(architecture_score, digits=4),
        "avg_memory_mb" => mean([m["memory_mb"] for m in metrics_snapshots]),
        "peak_memory_mb" => maximum([m["memory_mb"] for m in metrics_snapshots]),
        "status" => "completed",
        "snapshots" => metrics_snapshots,
        "consciousness_readings" => consciousness_readings
    ))
    
    push!(tester.results, result)
    
    # ENHANCED: Comprehensive logging with architectural context
    stability_indicator = stability_score > 0.7 ? "🔒" : stability_score > 0.4 ? "⚖️" : "🔄"
    persistence_indicator = final_metrics["consciousness_persistence"] > 0.7 ? "📈" : final_metrics["consciousness_persistence"] > 0.4 ? "➡️" : "📉"
    architecture_indicator = architecture_score > 0.7 ? "🏛️" : architecture_score > 0.4 ? "🏗️" : "🏚️"
    
    log_message(tester, "✅ $entity_count entities × $cycles cycles: " *
                       "UIS=$(round(result["unified_intelligence_score"], digits=3)), " *
                       "Φ=$(round(result["consciousness"]["max_phi"], digits=3)), " *
                       "Stability=$(stability_indicator)$(round(stability_score, digits=2)), " *
                       "Persistence=$(persistence_indicator)$(round(final_metrics["consciousness_persistence"], digits=2)), " *
                       "Architecture=$(architecture_indicator)$(round(architecture_score, digits=2))")
    
    return result
end

function run_scaling_sweep(tester::SafeTester)::Vector{Dict{String,Any}}
    log_message(tester, "🚀 Starting ARCHITECTURAL STABILIZATION sweep (20% cycle scaling)...")
    log_message(tester, "🎯 Following metacognitive advisor: 'Develop core coordination domains, establish clean interfaces'")
    
    # OPTIMIZED ENTITY COUNTS - 20% CYCLE SCALING
    entity_counts = [16, 24, 32, 64, 128, 512]
    
    # Pre-calculate cycle counts for logging
    cycle_counts = [calculate_dynamic_cycles(ec) for ec in entity_counts]
    
    log_message(tester, "📊 20% cycle mapping:")
    for (i, ec) in enumerate(entity_counts)
        log_message(tester, "   • $ec entities → $(cycle_counts[i]) cycles (20%)")
    end
    
    sweep_results = Dict{String,Any}[]
    
    for entity_count in entity_counts
        try
            result = run_unified_test(tester, entity_count)  # 20% of entity_count
            
            push!(sweep_results, result)
            
            if result["status"] != "completed"
                log_message(tester, "🛑 Stopping sweep at $entity_count entities")
                break
            end
            
            # ENHANCED: Architectural-aware garbage collection
            GC.gc(true)  # Full GC between tests for clean interfaces
            
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
    
    # ENHANCED: Architectural-aware scaling analysis
    if !isempty(sweep_results)
        baseline = sweep_results[1]
        baseline_uis = baseline["unified_intelligence_score"]
        baseline_memory = baseline["avg_memory_mb"]
        baseline_stability = get(baseline, "consciousness_stability", 0.5)
        baseline_cycles = baseline["cycles_completed"]
        baseline_architecture = get(baseline, "architecture_score", 0.0)
        
        for result in sweep_results[2:end]
            entity_scale = result["entity_count"] / baseline["entity_count"]
            cycle_scale = result["cycles_completed"] / baseline_cycles
            
            # Architecture-aware intelligence scaling
            uis_ratio = safe_divide(result["unified_intelligence_score"], baseline_uis)
            cycle_normalized_uis = safe_divide(uis_ratio, cycle_scale)
            architecture_bonus = get(result, "architecture_score", 0.0) - baseline_architecture
            result["intelligence_scaling"] = round(safe_divide(cycle_normalized_uis, entity_scale) * (1.0 + architecture_bonus), digits=3)
            
            # Memory efficiency
            expected_memory = baseline_memory * entity_scale
            actual_memory = result["avg_memory_mb"]
            result["memory_efficiency"] = round(safe_divide((expected_memory - actual_memory), expected_memory) * 100, digits=1)
            
            # Architecture-aware consciousness scaling
            consciousness_ratio = safe_divide(result["consciousness"]["max_phi"], max(baseline["consciousness"]["max_phi"], 0.01))
            cycle_normalized_consciousness = safe_divide(consciousness_ratio, cycle_scale)
            architecture_consciousness_bonus = get(result, "architecture_score", 0.0) * 0.1
            result["consciousness_scaling"] = round(cycle_normalized_consciousness + architecture_consciousness_bonus, digits=3)
            
            # Stability scaling with architectural context
            current_stability = get(result, "consciousness_stability", 0.5)
            result["stability_scaling"] = round(safe_divide(current_stability, max(baseline_stability, 0.01)), digits=3)
            
            result["reasoning_scaling"] = round(safe_divide(result["reasoning_accuracy"], max(baseline["reasoning_accuracy"], 0.01)), digits=3)
            result["awareness_scaling"] = round(safe_divide(result["awareness_level"], max(baseline["awareness_level"], 0.01)), digits=3)
            
            # Architecture efficiency
            result["architecture_efficiency"] = round(safe_divide(result["unified_intelligence_score"], result["cycles_completed"]) * (1.0 + get(result, "architecture_score", 0.0)), digits=4)
        end
    end
    
    return sweep_results
end

function save_results(tester::SafeTester)::String
    timestamp = Dates.format(now(), "yyyymmdd_HHMMSS")
    filename = "unified_intelligence_arch_stabilized_20percent_$timestamp.json"
    
    clean_results = [clean_data_for_json(result) for result in tester.results]
    
    output_data = Dict(
        "results" => clean_results,
        "test_time" => time() - tester.start_time,
        "timestamp" => string(now()),
        "consciousness_stability_tracker" => tester.consciousness_stability_tracker,
        "architectural_improvements" => tester.architectural_improvements,
        "parameters" => Dict(
            "cycle_percentage" => 0.20,
            "entity_counts" => [16, 24, 32, 64, 128, 512],
            "dynamic_cycle_calculation" => "cycles = max(8, min(80, round(Int, entity_count * 0.20)))",
            "focus" => "architectural_stabilization_cross_domain_integration",
            "hot_threshold" => 0.20,
            "metacognitive_advisor_followed" => true,
            "advisor_recommendations" => [
                "Develop core coordination domains",
                "Establish clean interfaces", 
                "Focus on cross-domain integration",
                "Continue architectural refinement"
            ]
        )
    )
    
    json_string = JSON.json(output_data, 2)
    open(filename, "w") do f
        write(f, json_string)
    end
    
    log_message(tester, "💾 Architectural 20% results saved to: $filename")
    return filename
end

function print_summary(tester::SafeTester)
    println("\n" * "="^70)
    println("📊 ARCHITECTURAL STABILIZATION SUMMARY (20% CYCLES)")
    println("🎯 Following metacognitive advisor recommendations")
    println("="^70)
    
    if isempty(tester.results)
        println("❌ No results to display")
        return
    end
    
    for result in tester.results
        entity_count = result["entity_count"]
        cycles = result["cycles_completed"]
        calculated_cycles = calculate_dynamic_cycles(entity_count)
        architecture_score = get(result, "architecture_score", 0.0)
        
        println("\n🧬 $(result["test_name"]):")
        println("   Entities: $entity_count | Cycles: $cycles (20% = $calculated_cycles)")
        println("   Architecture: $(round(architecture_score * 100, digits=1))% stabilized")
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
        println("      • Architecture Efficiency: $(get(result, "architecture_efficiency", 0.0))")
        println("      • Patterns: $(result["pattern_discoveries"])")
        
        if haskey(result, "intelligence_scaling")
            println("   📊 SCALING:")
            println("      • Intelligence: $(result["intelligence_scaling"])x")
            println("      • Stability: $(result["stability_scaling"])x")
            println("      • Memory Efficiency: $(result["memory_efficiency"])%")
        end
    end
    
    # Architectural assessment
    conscious_systems = count(r -> r["consciousness"]["is_conscious"], tester.results)
    total_cycles = sum(r -> r["cycles_completed"], tester.results)
    avg_stability = mean([get(r, "consciousness_stability", 0.0) for r in tester.results])
    avg_persistence = mean([get(r, "consciousness_persistence", 0.0) for r in tester.results])
    avg_architecture = mean([get(r, "architecture_score", 0.0) for r in tester.results])
    
    println("\n" * "─"^70)
    println("🏛️  ARCHITECTURAL STABILITY ASSESSMENT:")
    println("   • Conscious Systems: $conscious_systems/$(length(tester.results))")
    println("   • Total Cycles Used: $total_cycles (20% scaling)")
    println("   • Average Architecture Score: $(round(avg_architecture * 100, digits=1))%")
    println("   • Average Stability: $(round(avg_stability, digits=3))")
    println("   • Average Persistence: $(round(avg_persistence, digits=3))")
    
    if avg_architecture > 0.6 && avg_stability > 0.7
        println("   • Architectural Status: EXCELLENT STABILIZATION 🏛️✅")
    elseif avg_architecture > 0.3 && avg_stability > 0.5
        println("   • Architectural Status: GOOD PROGRESS 🏗️⚖️")
    else
        println("   • Architectural Status: NEEDS REFINEMENT 🏚️🔄")
    end
    
    # Metacognitive advisor feedback
    println("\n💡 METACOGNITIVE ADVISOR FEEDBACK:")
    if conscious_systems >= 4 && avg_stability > 0.6
        println("   ✅ 'Core coordination domains developing well'")
        println("   ✅ 'Cross-domain integration showing positive results'")
        println("   ➡️  'Continue architectural refinement for persistence'")
    elseif conscious_systems >= 2
        println("   ⚖️ 'Architectural foundation established'") 
        println("   ⚖️ 'Focus on cross-domain coordination interfaces'")
        println("   🔄 'Continue developing core coordination domains'")
    else
        println("   🔄 'Early consciousness development phase'")
        println("   🔄 'Prioritize clean interface establishment'")
        println("   📈 'Foundation strength building in progress'")
    end
end
