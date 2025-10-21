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
include("light_reflector.jl")

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
        sweep_results = run_scaling_sweep(tester)
        results_file = save_results(tester)
        print_summary(tester)
        
        # 🪞 LIGHTWEIGHT SELF-REFLECTION - GitHub Remote Compatible
        if !isempty(sweep_results) && length(sweep_results) >= 1
            println("\n" * "="^70)
            println("🪞 GITHUB-OPTIMIZED SELF-REFLECTION")
            println("="^70)
            
            try
                # Quick AST analysis without heavy computation
                quick_ast_map = generate_quick_ast()
                ast_summary = analyze_architecture_health(quick_ast_map)
                
                # Save lightweight blueprint
                save_light_blueprint(ast_summary, "light_architecture_scan.json")
                
                println("✅ Lightweight self-reflection completed")
                println("   📊 Modules: $(ast_summary["module_count"])")
                println("   🛠️  Functions: $(ast_summary["total_functions"])")
                println("   📁 Output: light_architecture_scan.json")
                
            catch e
                println("⚠️  Light self-reflection skipped: $e")
                # Non-fatal - intelligence tests are primary
            end
        end
        
        println("\n" * "="^70)
        println("✨ MODULAR TESTING COMPLETE")
        println("="^70)
        println("📁 Results saved to: $results_file")
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
