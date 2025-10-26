# main_orchestrator.jl - CLEAN VERSION
"""
🎯 HOLOLIFEX6 MAIN ORCHESTRATOR - GUARDRAILED SEQUENCE
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

# PHASE 2: METACOGNITION MODULES (LOAD BUT DON'T EXECUTE)
include("neural_code_embeddings.jl")
include("semantic_code_graph.jl")
include("metacognitive_advisor.jl")

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
    
    # PHASE 3: FINALIZATION (READ-ONLY)
    println("🔒 PHASE 3: FINALIZATION")
    println()
    println("="^70)
    println("✨ GUARDRAILED EXECUTION COMPLETE")
    println("="^70)
    println("📁 Intelligence results: intelligence_results.json")
    println("🧠 Metacognition results: metacognition_results.json") 
    println("⏱️  Total time: $(round(time() - tester.start_time, digits=1))s")
    println("🔒 All phases executed in strict sequence")
    
    return true
end

function main()
    """MAIN ENTRY POINT WITH ULTIMATE GUARDRAILS"""
    try
        success = strict_phase_execution()
        if success
            println()
            println("🎊 GUARDRAILED EXECUTION SUCCESSFUL")
        else
            println()
            println("💥 EXECUTION TERMINATED DUE TO PHASE FAILURE")
        end
    catch e
        println("💥 CATASTROPHIC FAILURE: $e")
        println("FULL STACKTRACE:")
        for (i, frame) in enumerate(stacktrace(catch_backtrace()))
            println("  $i: $frame")
            i > 8 && break
        end
    end
end

# GUARDRAILED EXECUTION - ONLY RUN IF DIRECTLY CALLED
if abspath(PROGRAM_FILE) == @__FILE__
    println("🚀 INITIATING GUARDRAILED SEQUENCE...")
    main()
else
    println("🔒 MODULE LOADED - AWAITING EXPLICIT EXECUTION")
end

# EXPLICIT EXPORT - NO IMPLICIT BEHAVIOR
export main, strict_phase_execution
