# main_orchestrator.jl
"""
🎯 HOLOLIFEX6 MAIN ORCHESTRATOR
Modular architecture for unified intelligence testing
"""

include("consciousness_core.jl")
include("geometric_reasoning.jl") 
include("phase_synchronization.jl")
include("insight_generation.jl")
include("awareness_monitor.jl")
include("proto_intelligence.jl")
include("unified_network.jl")
include("safe_tester.jl")

# ADD THE 3 METACOGNITION FILES
include("neural_code_embeddings.jl")
include("semantic_code_graph.jl")
include("metacognitive_advisor.jl")

function main()
    println("🌌 HOLOLIFEX6 PROTOTYPE4 - MODULAR UNIFIED INTELLIGENCE TESTBED")
    println("="^70)
    println("🎯 Testing REAL Intelligence Pillars:")
    println("   1. 🧠 Consciousness (Real Brown-IIT Duality)")
    println("   2. 🎯 REAL Geometric Reasoning") 
    println("   3. 👁️  REAL Phase Synchronization")
    println("   4. 💡 REAL Proto-Intelligence")
    println()
    println("📊 Scaling Test: 16 → 32 → 64 entities")
    println("🎪 Measuring REAL intelligence emergence")
    println("="^70)
    
    tester = SafeTester()
    
    try
        # RUN MAIN INTELLIGENCE TESTS FIRST
        sweep_results = run_scaling_sweep(tester)
        results_file = save_results(tester)
        print_summary(tester)
        
        # 🧠 ADD METACOGNITION AFTER MAIN TESTS COMPLETE
        println("\n" * "="^70)
        println("🧠 INITIATING METACOGNITION ANALYSIS")
        println("="^70)
        
        try
            # Run the 3-pillar metacognition system
            println("📁 Loading metacognition engine...")
            
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
            insights = generate_architectural_insights(graph, latest_results)
            
            # Save metacognition results
            metacognition_file = "metacognition_results.json"
            save_json(metacognition_file, insights)
            
            println("✅ METACOGNITION COMPLETE")
            println("   📊 Insights generated: $(length(get(insights, "insights", [])))")
            println("   💾 Saved to: $metacognition_file")
            
        catch e
            println("⚠️  Metacognition failed (non-critical): $e")
            # MAIN SYSTEM UNAFFECTED - continue normally
        end
        
        println("\n" * "="^70)
        println("✨ MODULAR TESTING COMPLETE")
        println("="^70)
        println("📁 Intelligence results: $results_file")
        println("🧠 Metacognition results: metacognition_results.json")
        println("⏱️  Total time: $(round(time() - tester.start_time, digits=1))s")
        
    catch e
        println("❌ ERROR in main: $e")
        println("Stacktrace:")
        for (i, frame) in enumerate(stacktrace(catch_backtrace()))
            println("  $i: $frame")
            i > 5 && break
        end
        try
            save_results(tester)
        catch
            println("⚠️  Could not save results")
        end
    end
    
    println("\n🎊 MODULAR TESTING COMPLETE")
end

# Execute if run directly
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
