# main_orchestrator.jl
"""
🎯 HOLOLIFEX6 MAIN ORCHESTRATOR
Modular architecture for unified intelligence testing with full meta-cognitive capabilities
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
include("meta_cognitive_engine.jl")
include("self_awareness_tracker.jl")

# Global self-model for longitudinal tracking
const GLOBAL_SELF_MODEL = initialize_self_model()

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
        
        # 🪞 FULL META-COGNITIVE SELF-REFLECTION STACK
        if !isempty(sweep_results) && length(sweep_results) >= 1
            println("\n" * "="^70)
            println("🪞 FULL META-COGNITIVE SELF-REFLECTION")
            println("="^70)
            
            try
                # Enhanced architectural scan
                enhanced_ast = generate_enhanced_ast()
                enhanced_analysis = analyze_architecture_health_v2(enhanced_ast)
                save_success = save_enhanced_blueprint(enhanced_analysis, "architecture_scan.json")
                
                if save_success
                    println("✅ Architectural scan completed")
                    
                    # META-COGNITIVE ANALYSIS
                    try
                        # Use test results as performance metrics
                        performance_metrics = Dict(
                            "test_results" => sweep_results,
                            "entities_tested" => length(sweep_results),
                            "success_rate" => count(r -> get(r, "success", false), sweep_results) / length(sweep_results)
                        )
                        
                        # Perform meta-cognitive diagnosis
                        diagnosis = perform_self_diagnosis(enhanced_analysis, performance_metrics)
                        meta_save = save_meta_cognitive_analysis(diagnosis, "meta_cognitive_analysis.json")
                        
                        if meta_save
                            println("   🧠 Meta-cognitive analysis completed:")
                            println("      📊 Self-Reflection Score: $(diagnosis["self_reflection_score"])")
                            println("      ⚠️  Bottlenecks: $(length(diagnosis["bottlenecks"]))")
                            println("      ✅ Strengths: $(length(diagnosis["strengths"]))")
                            println("      💡 Recommendations: $(length(diagnosis["recommendations"]))")
                            
                            # SELF-AWARENESS TRACKING - NEW
                            try
                                update_self_model!(GLOBAL_SELF_MODEL, enhanced_analysis, performance_metrics, diagnosis)
                                evolution_insights = generate_evolution_insights(GLOBAL_SELF_MODEL)
                                self_model_save = save_self_model(GLOBAL_SELF_MODEL, "self_awareness_model.json")
                                
                                if self_model_save
                                    println("   📈 Self-awareness tracking updated:")
                                    println("      🕰️  Total snapshots: $(evolution_insights["total_snapshots"])")
                                    println("      📈 Complexity trend: $(evolution_insights["momentum_analysis"]["complexity_trend"])")
                                    println("      🔍 Evolution insights: $(length(evolution_insights["evolution_insights"]))")
                                    println("      📁 Output: self_awareness_model.json")
                                end
                            catch e
                                println("   ⚠️  Self-awareness tracking skipped: $e")
                            end
                        end
                    catch e
                        println("   ⚠️  Meta-cognitive analysis skipped: $e")
                    end
                end
            catch e
                println("⚠️  Self-reflection skipped: $e")
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
