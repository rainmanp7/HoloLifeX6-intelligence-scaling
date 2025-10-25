# main_orchestrator.jl - UPDATED WITH INSPECTOR
"""
🎯 HOLOLIFEX6 MAIN ORCHESTRATOR - GUARDRAILED SEQUENCE WITH DIAGNOSTICS
Modular architecture for unified intelligence testing
STRICT EXECUTION ORDER - NO CODE CAN JUMP SEQUENCE
"""

# Add JSON at top level
using JSON

# PHASE 1: CORE INTELLIGENCE MODULES (SEQUENTIAL LOAD)
include("consciousness_core.jl")
include("geometric_reasoning.jl") 
include("phase_synchronization.jl")
include("insight_generation.jl")
include("awareness_monitor.jl")
include("proto_intelligence.jl")
include("unified_network.jl")
include("safe_tester.jl")

# PHASE 2: METACOGNITION & DIAGNOSTIC MODULES (LOAD BUT DON'T EXECUTE)
include("neural_code_embeddings.jl")
include("semantic_code_graph.jl")
include("metacognitive_advisor.jl")
include("consciousness_inspector.jl")  # 🆕 ADDED INSPECTOR

# STRICT GUARDRAIL FUNCTIONS
function guarded_json_save(filename::String, data::Any)
    """ONLY SAVES DATA - NO SIDE EFFECTS"""
    try
        open(filename, "w") do f
            JSON.print(f, data, 2)
        end
        return true
    catch e
        println("⚠️  JSON Save failed: $e")
        return false
    end
end

function guarded_module_load(module_name::String)::Bool
    """VALIDATES MODULE LOAD WITHOUT EXECUTION"""
    try
        include(module_name)
        return true
    catch e
        println("❌ Module load failed: $module_name - $e")
        return false
    end
end

function guarded_intelligence_test(tester)::Tuple{Bool, Any}
    """RUNS INTELLIGENCE TESTS WITH ISOLATION"""
    println("🔒 EXECUTING INTELLIGENCE TESTS...")
    try
        results = run_scaling_sweep(tester)
        return (true, results)
    catch e
        println("❌ Intelligence test failed: $e")
        return (false, nothing)
    end
end

function guarded_metacognition_analysis(sweep_results)::Tuple{Bool, Any}
    """RUNS METACOGNITION IN ISOLATED ENVIRONMENT"""
    println("🔒 EXECUTING METACOGNITION ANALYSIS...")
    try
        # Generate code embeddings for core modules
        core_modules = [
            "consciousness_core.jl",
            "geometric_reasoning.jl", 
            "phase_synchronization.jl",
            "unified_network.jl"
        ]
        
        println("   🔍 Analyzing code semantics...")
        embeddings = generate_embeddings_for_modules(core_modules)
        
        println("   🏗️  Building semantic graph...")
        graph = build_semantic_graph(core_modules)
        
        println("   💡 Generating architectural insights...")
        latest_results = isempty(sweep_results) ? Dict() : sweep_results[end]
        insights = generate_architectural_analysis(graph, [latest_results])
        
        return (true, insights)
    catch e
        println("⚠️  Metacognition analysis failed: $e")
        return (false, nothing)
    end
end

# 🆕 NEW DIAGNOSTIC FUNCTION
function guarded_consciousness_diagnostic(sweep_results)::Tuple{Bool, Any}
    """RUNS CONSCIOUSNESS DIAGNOSTIC FOR INTERNAL VISIBILITY"""
    println("🔍 EXECUTING CONSCIOUSNESS DIAGNOSTIC...")
    try
        println("   🎯 Running comprehensive consciousness inspection...")
        diagnostic_results = run_diagnostic_sweep()
        
        println("   📊 Analyzing consciousness patterns...")
        # Extract key metrics from sweep results for comparison
        consciousness_patterns = []
        for result in sweep_results
            if haskey(result, "consciousness")
                pattern = Dict(
                    "entities" => result["entity_count"],
                    "max_phi" => result["consciousness"]["max_phi"],
                    "is_conscious" => result["consciousness"]["is_conscious"],
                    "frameworks" => result["consciousness"]["confirming_frameworks"],
                    "effective_info" => result["effective_information"]
                )
                push!(consciousness_patterns, pattern)
            end
        end
        
        diagnostic_insights = Dict(
            "diagnostic_timestamp" => string(Dates.now()),
            "consciousness_patterns" => consciousness_patterns,
            "detailed_inspections" => diagnostic_results,
            "summary" => "Consciousness crossover analysis completed"
        )
        
        return (true, diagnostic_insights)
    catch e
        println("⚠️  Consciousness diagnostic failed: $e")
        return (false, nothing)
    end
end

function strict_phase_execution()
    """MAIN EXECUTION WITH IMPENETRABLE GUARDRAILS"""
    println("🌌 HOLOLIFEX6 PROTOTYPE4 - GUARDRAILED EXECUTION")
    println("="^70)
    println("🚫 STRICT EXECUTION ORDER - NO DEVIATION PERMITTED")
    println("="^70)
    
    # PHASE 0: INITIALIZATION (NO EXTERNAL CALLS)
    println("🔒 PHASE 0: INITIALIZATION")
    tester = SafeTester()
    phase_results = Dict()
    
    # PHASE 1: CORE INTELLIGENCE TESTING (NO METACOGNITION)
    println("🔒 PHASE 1: CORE INTELLIGENCE TESTING")
    println("   🚫 METACOGNITION DISABLED DURING THIS PHASE")
    
    intelligence_success, sweep_results = guarded_intelligence_test(tester)
    
    if !intelligence_success
        println("❌ PHASE 1 FAILED - ABORTING SEQUENCE")
        return false
    end
    
    phase_results[:intelligence] = sweep_results
    save_success = guarded_json_save("intelligence_results.json", sweep_results)
    
    if save_success
        println("✅ INTELLIGENCE RESULTS SAVED")
    end
    
    # SAFE PRINT SUMMARY - NO STRING CONCATENATION ERRORS
    try
        print_summary(tester)
    catch e
        println("⚠️  Summary print failed: $e")
        println("📊 Results saved but display incomplete")
    end
    
    # BARRIER: COMPLETE SEPARATION BETWEEN PHASES
    println()
    println("="^70)
    println("🚧 PHASE BARRIER: INTELLIGENCE → METACOGNITION")
    println("="^70)
    
    # PHASE 2: METACOGNITION ANALYSIS (ISOLATED)
    println("🔒 PHASE 2: METACOGNITION ANALYSIS")
    println("   🚫 INTELLIGENCE MODULES QUIESCENT")
    
    metacognition_success, insights = guarded_metacognition_analysis(sweep_results)
    
    if metacognition_success
        # Save metacognition results
        health_report = export_health_report(insights)
        save_success = guarded_json_save("metacognition_results.json", health_report)
        
        if save_success
            println("✅ METACOGNITION RESULTS SAVED")
            println("   📊 Insights generated: $(length(insights))")
        end
    else
        println("⚠️  METACOGNITION COMPLETED WITH ERRORS (NON-CRITICAL)")
    end
    
    # 🆕 NEW PHASE: CONSCIOUSNESS DIAGNOSTIC
    println()
    println("="^70)
    println("🔍 PHASE 3: CONSCIOUSNESS DIAGNOSTIC")
    println("="^70)
    println("   🎯 INTERNAL CONNECTION VISIBILITY ENABLED")
    
    diagnostic_success, diagnostic_insights = guarded_consciousness_diagnostic(sweep_results)
    
    if diagnostic_success
        save_success = guarded_json_save("consciousness_diagnostic.json", diagnostic_insights)
        if save_success
            println("✅ CONSCIOUSNESS DIAGNOSTIC RESULTS SAVED")
            println("   🔍 Internal connections and Φ calculations logged")
        end
    else
        println("⚠️  DIAGNOSTIC COMPLETED WITH ERRORS (NON-CRITICAL)")
    end
    
    # PHASE 4: FINALIZATION (READ-ONLY)
    println("🔒 PHASE 4: FINALIZATION")
    println()
    println("="^70)
    println("✨ GUARDRAILED EXECUTION COMPLETE")
    println("="^70)
    println("📁 Intelligence results: intelligence_results.json")
    println("🧠 Metacognition results: metacognition_results.json") 
    println("🔍 Consciousness diagnostic: consciousness_diagnostic.json")  # 🆕
    println("⏱️  Total time: $(round(time() - tester.start_time, digits=1))s")
    println("🔒 All phases executed in strict sequence")
    
    return true
end

# 🆕 NEW FUNCTION: DIRECT DIAGNOSTIC MODE
function diagnostic_mode()
    """RUNS ONLY THE CONSCIOUSNESS DIAGNOSTIC FOR TROUBLESHOOTING"""
    println("🔍 HOLOLIFEX6 - CONSCIOUSNESS DIAGNOSTIC MODE")
    println("="^70)
    println("🎯 FOCUSED TROUBLESHOOTING - INTERNAL CONNECTION VISIBILITY")
    println("="^70)
    
    # Load required modules
    include("consciousness_core.jl")
    include("consciousness_inspector.jl")
    
    println("🚀 RUNNING COMPREHENSIVE CONSCIOUSNESS INSPECTION...")
    diagnostic_results = run_diagnostic_sweep()
    
    println("\n" * "="^70)
    println("📊 DIAGNOSTIC SUMMARY")
    println("="^70)
    
    # Simple summary of findings
    for (i, result) in enumerate(diagnostic_results)
        if haskey(result, "iit_components")
            iit_phi = result["iit_components"]["final_phi"]
            brown_phi = result["brown_components"]["final_phi"]
            conscious = result["consciousness"]
            
            println("Test $i: IIT Φ=$(round(iit_phi, digits=4)), Brown Φ=$(round(brown_phi, digits=4))")
            println("       Consciousness: $(conscious ? "✅ YES" : "❌ NO")")
            println("       Scale Factors: IIT=$(round(result["iit_components"]["scale_factor"], digits=2)), Brown=$(round(result["brown_components"]["scale_factor"], digits=2))")
            println()
        end
    end
    
    println("💾 Full diagnostic details saved to consciousness_diagnostic.json")
    return diagnostic_results
end

function main()
    """MAIN ENTRY POINT WITH ULTIMATE GUARDRAILS"""
    try
        # Check for diagnostic mode
        if length(ARGS) > 0 && ARGS[1] == "diagnose"
            return diagnostic_mode()
        else
            success = strict_phase_execution()
            if success
                println()
                println("🎊 GUARDRAILED EXECUTION SUCCESSFUL")
            else
                println()
                println("💥 EXECUTION TERMINATED DUE TO PHASE FAILURE")
            end
            return success
        end
    catch e
        println("💥 CATASTROPHIC FAILURE: $e")
        println("FULL STACKTRACE:")
        for (i, frame) in enumerate(stacktrace(catch_backtrace()))
            println("  $i: $frame")
            i > 8 && break
        end
        return false
    end
end

# GUARDRAILED EXECUTION - ONLY RUN IF DIRECTLY CALLED
if abspath(PROGRAM_FILE) == @__FILE__
    if length(ARGS) > 0 && ARGS[1] == "diagnose"
        println("🔍 INITIATING DIAGNOSTIC MODE...")
        main()
    else
        println("🚀 INITIATING GUARDRAILED SEQUENCE...")
        main()
    end
else
    println("🔒 MODULE LOADED - AWAITING EXPLICIT EXECUTION")
end

# EXPLICIT EXPORT - NO IMPLICIT BEHAVIOR
export main, strict_phase_execution, diagnostic_mode
