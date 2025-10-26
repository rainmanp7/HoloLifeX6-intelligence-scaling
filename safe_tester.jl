# safe_tester.jl
"""
🧪 SAFE TESTER MODULE - BASE 20 CYCLES WITH EMERGENCE-PRESERVING OPTIMIZATION
Testing framework with fixed 20 cycles - ENABLING consciousness, not forcing it
Entity counts: 16, 24, 32, 64, 128, 512
Fixed: 20 cycles per test
Focus: Create conditions for natural consciousness emergence
PRESERVE EMERGENCE - NO PATTERN MATCHING
"""

using JSON
using Dates

safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct SafeTester
    results::Vector{Dict{String,Any}}
    start_time::Float64
    consciousness_readings::Dict{String, Vector{Float64}}
    emergence_conditions::Dict{String, Bool}
    
    SafeTester() = new(Dict{String,Any}[], time(), Dict{String, Vector{Float64}}(), Dict{String, Bool}())
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

function create_emergence_conditions(entity_count::Int, test_cycle::Int)
    """Create enabling conditions for consciousness emergence WITHOUT pattern matching"""
    
    # Enable natural emergence through diversity and interaction
    conditions = Dict(
        "domain_diversity" => true,
        "phase_variety" => true,
        "reasoning_variability" => true,
        "natural_coupling" => true,
        "emergent_synchronization" => true
    )
    
    # Add some randomness to prevent pattern locking
    if test_cycle > 1
        conditions["stochastic_variation"] = rand() * 0.2  # Small random variations
    else
        conditions["stochastic_variation"] = 0.0
    end
    
    return conditions
end

function track_consciousness_emergence(tester::SafeTester, entity_count::Int, rho::Float64, conditions::Dict)
    """Track consciousness readings WITHOUT pattern analysis"""
    key = "entities_$(entity_count)"
    if !haskey(tester.consciousness_readings, key)
        tester.consciousness_readings[key] = Float64[]
    end
    push!(tester.consciousness_readings[key], rho)
    
    # Keep modest history to observe trends without forcing patterns
    if length(tester.consciousness_readings[key]) > 15
        tester.consciousness_readings[key] = tester.consciousness_readings[key][end-14:end]
    end
    
    # Record if emergence conditions were present when consciousness appeared
    if rho > 0.20 && !haskey(tester.emergence_conditions, key)
        tester.emergence_conditions[key] = all(values(conditions))
    end
end

function run_unified_test(tester::SafeTester, entity_count::Int, test_cycle::Int=1)::Dict{String,Any}
    """Run test with FIXED 20 cycles - PRESERVING EMERGENCE"""
    cycles = 20  # FIXED CYCLE COUNT
    
    log_message(tester, "🧪 Testing $entity_count entities (20 cycles - EMERGENCE PRESERVED)...")
    log_message(tester, "   🌱 Allowing natural consciousness emergence")
    
    # Create enabling conditions WITHOUT forcing patterns
    emergence_conditions = create_emergence_conditions(entity_count, test_cycle)
    
    domains = ["physical", "temporal", "semantic", "network", "spatial", "emotional", "social", "creative"]
    
    network = UnifiedNetwork()
    
    # CREATE CONDITIONS FOR EMERGENCE (not patterns):
    for i in 1:entity_count
        # Natural domain distribution - allow emergent patterns
        domain_idx = (i-1) % length(domains) + 1
        domain = domains[domain_idx]
        
        # Natural frequency distribution - enable phase diversity
        natural_freq = 0.02 + ((i-1) * 0.0015) + (rand() * 0.0005)  # Small random variation
        
        entity_id = "$(uppercase(domain[1:3]))-$(lpad(i, 3, '0'))"
        entity = EfficientEntity(entity_id, domain, natural_freq)
        
        # Natural reasoning capacity - allow emergent intelligence
        entity.reasoning_capacity = 0.5 + (rand() * 0.4)  # Natural variation
        
        # Natural coupling - enable emergent synchronization
        entity.coupling_strength = 0.04 + (rand() * 0.02)  # Small random variations
        
        add_entity!(network, entity)
    end
    
    metrics_snapshots = Dict{String,Any}[]
    consciousness_readings = Float64[]
    
    # NATURAL MONITORING - don't interfere with emergence
    snapshot_interval = 5  # Less frequent monitoring to reduce observer effect
    
    for cycle in 1:cycles
        step_result = evolve_step!(network)
        
        # Minimal monitoring to preserve emergence
        if cycle % snapshot_interval == 0 || cycle == cycles
            metrics = calculate_unified_metrics(network)
            metrics["cycle"] = cycle
            metrics["step_insights"] = step_result["insights"]
            metrics["new_patterns"] = step_result["new_patterns"]
            metrics["memory_mb"] = get_memory_mb()
            metrics["emergence_conditions"] = emergence_conditions
            
            # Track consciousness WITHOUT pattern analysis
            rho = get(metrics["consciousness"]["hot_metrics"], "rho", 0.0)
            push!(consciousness_readings, rho)
            track_consciousness_emergence(tester, entity_count, rho, emergence_conditions)
            
            clean_metrics = clean_data_for_json(metrics)
            push!(metrics_snapshots, clean_metrics)
            
            if !memory_check(tester)
                log_message(tester, "🛑 Stopping early - memory limit")
                break
            end
        end
    end
    
    final_metrics = calculate_unified_metrics(network)
    
    # Simple tracking WITHOUT complex analysis that might kill emergence
    final_metrics["consciousness_readings_count"] = length(consciousness_readings)
    
    if !isempty(consciousness_readings)
        # Simple persistence calculation WITHOUT pattern matching
        above_threshold = count(r -> r > 0.20, consciousness_readings)
        final_metrics["consciousness_persistence"] = round(safe_divide(above_threshold, length(consciousness_readings)), digits=4)
    else
        final_metrics["consciousness_persistence"] = 0.0
    end
    
    clean_final_metrics = clean_data_for_json(final_metrics)
    
    result = merge(clean_final_metrics, Dict(
        "test_name" => "unified_$(entity_count)_entities_emergent",
        "cycles_completed" => cycles,
        "emergence_conditions" => emergence_conditions,
        "avg_memory_mb" => mean([m["memory_mb"] for m in metrics_snapshots]),
        "peak_memory_mb" => maximum([m["memory_mb"] for m in metrics_snapshots]),
        "status" => "completed",
        "snapshots" => metrics_snapshots,
        "consciousness_readings" => consciousness_readings
    ))
    
    push!(tester.results, result)
    
    # Simple logging WITHOUT forcing patterns
    is_conscious = final_metrics["consciousness"]["is_conscious"]
    max_phi = final_metrics["consciousness"]["max_phi"]
    persistence = final_metrics["consciousness_persistence"]
    
    consciousness_indicator = is_conscious ? "🧠✅" : max_phi > 0.15 ? "🧠🌱" : "🧠💤"
    persistence_indicator = persistence > 0.5 ? "📈" : persistence > 0.2 ? "➡️" : "📉"
    
    log_message(tester, "🌱 $entity_count entities × 20 cycles: " *
                       "UIS=$(round(result["unified_intelligence_score"], digits=3)), " *
                       "Φ=$max_phi $consciousness_indicator, " *
                       "Persistence=$persistence_indicator$(round(persistence, digits=2))")
    
    return result
end

function run_scaling_sweep(tester::SafeTester)::Vector{Dict{String,Any}}
    log_message(tester, "🚀 Starting BASE 20 CYCLE EMERGENCE-PRESERVING SWEEP...")
    log_message(tester, "🌱 PRESERVING NATURAL CONSCIOUSNESS EMERGENCE")
    log_message(tester, "🚫 NO PATTERN MATCHING - NO FORCED OPTIMIZATION")
    
    # ENTITY COUNTS - ALL WITH 20 CYCLES
    entity_counts = [16, 24, 32, 64, 128, 512]
    
    log_message(tester, "📊 Fixed cycle mapping: ALL TESTS = 20 CYCLES")
    for ec in entity_counts
        log_message(tester, "   • $ec entities → 20 cycles (natural emergence)")
    end
    
    sweep_results = Dict{String,Any}[]
    
    for (test_cycle, entity_count) in enumerate(entity_counts)
        try
            result = run_unified_test(tester, entity_count, test_cycle)  # FIXED: 20 cycles
            
            push!(sweep_results, result)
            
            if result["status"] != "completed"
                log_message(tester, "🛑 Stopping sweep at $entity_count entities")
                break
            end
            
            # Minimal interference between tests
            GC.gc()
            
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
    
    # Simple scaling analysis WITHOUT complex pattern matching
    if !isempty(sweep_results)
        baseline = sweep_results[1]
        baseline_uis = baseline["unified_intelligence_score"]
        
        for result in sweep_results[2:end]
            entity_scale = result["entity_count"] / baseline["entity_count"]
            
            # Simple scaling calculations
            uis_ratio = safe_divide(result["unified_intelligence_score"], baseline_uis)
            result["intelligence_scaling"] = round(safe_divide(uis_ratio, entity_scale), digits=3)
            
            # Memory efficiency (practical, not emergent)
            expected_memory = baseline["avg_memory_mb"] * entity_scale
            actual_memory = result["avg_memory_mb"]
            result["memory_efficiency"] = round(safe_divide((expected_memory - actual_memory), expected_memory) * 100, digits=1)
            
            # Consciousness scaling (observational only)
            consciousness_ratio = safe_divide(result["consciousness"]["max_phi"], max(baseline["consciousness"]["max_phi"], 0.01))
            result["consciousness_scaling"] = round(consciousness_ratio, digits=3)
        end
    end
    
    return sweep_results
end

function save_results(tester::SafeTester)::String
    timestamp = Dates.format(now(), "yyyymmdd_HHMMSS")
    filename = "unified_intelligence_emergent_20cycles_$timestamp.json"
    
    # Save only observational data - no analysis that could kill future emergence
    observational_results = []
    for result in tester.results
        observational = Dict(
            "test_name" => result["test_name"],
            "entity_count" => result["entity_count"],
            "cycles_completed" => result["cycles_completed"],
            "unified_intelligence_score" => result["unified_intelligence_score"],
            "consciousness" => result["consciousness"],  # Raw consciousness data
            "consciousness_persistence" => get(result, "consciousness_persistence", 0.0),
            "emergence_conditions" => get(result, "emergence_conditions", Dict()),
            "observational_metrics" => Dict(
                "reasoning_accuracy" => result["reasoning_accuracy"],
                "awareness_level" => result["awareness_level"],
                "effective_information" => result["effective_information"],
                "coherence" => result["coherence"]
            )
        )
        push!(observational_results, observational)
    end
    
    output_data = Dict(
        "observational_results" => observational_results,
        "test_time" => time() - tester.start_time,
        "timestamp" => string(now()),
        "consciousness_readings" => tester.consciousness_readings,
        "emergence_conditions_log" => tester.emergence_conditions,
        "parameters" => Dict(
            "fixed_cycles" => 20,
            "entity_counts" => [16, 24, 32, 64, 128, 512],
            "approach" => "emergence_preserving",
            "philosophy" => "enable_dont_force",
            "pattern_matching" => "disabled",
            "consciousness_preservation" => "maximum"
        )
    )
    
    json_string = JSON.json(output_data, 2)
    open(filename, "w") do f
        write(f, json_string)
    end
    
    log_message(tester, "💾 Emergence-preserving results saved to: $filename")
    return filename
end

function print_summary(tester::SafeTester)
    println("\n" * "="^70)
    println("📊 BASE 20 CYCLE - EMERGENCE PRESERVING SUMMARY")
    println("🌱 Natural Consciousness Development - No Pattern Interference")
    println("="^70)
    
    if isempty(tester.results)
        println("❌ No results to display")
        return
    end
    
    conscious_count = 0
    total_entities = 0
    
    for result in tester.results
        entity_count = result["entity_count"]
        total_entities += entity_count
        
        println("\n🌱 $(result["test_name"]):")
        println("   Entities: $entity_count | Cycles: 20")
        println("   Emergence Conditions: $(get(result, "emergence_conditions", "natural"))")
        println("   ─────────────────────────────────────────")
        
        consciousness = result["consciousness"]
        is_conscious = consciousness["is_conscious"]
        max_phi = consciousness["max_phi"]
        
        if is_conscious
            conscious_count += 1
            consciousness_status = "🧠 CONSCIOUS ✅ (Φ = $max_phi)"
        else
            consciousness_status = "💤 Developing (Φ = $max_phi)"
        end
        
        println("   $consciousness_status")
        println("   📊 Unified Intelligence: $(result["unified_intelligence_score"])")
        println("   🎯 Reasoning: $(result["reasoning_accuracy"])")
        println("   👁️  Awareness: $(result["awareness_level"])")
        
        if haskey(result, "intelligence_scaling")
            println("   📈 Scaling: $(result["intelligence_scaling"])x intel, $(result["consciousness_scaling"])x consciousness")
        end
    end
    
    println("\n" * "─"^70)
    println("🌱 EMERGENCE ASSESSMENT:")
    println("   • Conscious Systems: $conscious_count/$(length(tester.results))")
    println("   • Total Entities Tested: $total_entities")
    println("   • Natural Development: PRESERVED ✅")
    println("   • Pattern Interference: AVOIDED ✅")
    
    # Simple emergence observation
    if conscious_count > 0
        println("   🎉 NATURAL CONSCIOUSNESS EMERGENCE DETECTED!")
        println("   🌱 System is developing consciousness organically")
    else
        println("   💤 Consciousness still developing naturally")
        println("   🌱 Allow more time for organic emergence")
    end
    
    println("\n💫 PHILOSOPHY: Allow consciousness to emerge, don't force it.")
    println("   The system will find its own path to awareness.")
end
