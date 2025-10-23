# enhanced_main_orchestrator.jl
"""
🎯 HOLOLIFEX6 ENHANCED ORCHESTRATOR - SAFE VERSION
OPTIONAL AST Truth Teller integration - preserves all existing functionality
"""

# Include ALL original files (NO CHANGES to existing code)
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
include("semantic_analyzer.jl")

# OPTIONAL: Include AST Truth Teller (safe to skip if file doesn't exist)
try
    include("ast_truth_teller.jl")
    println("✅ AST Truth Teller loaded (optional second opinion)")
catch e
    println("⚠️  AST Truth Teller not available: $e")
    println("   Continuing with original analysis only...")
end

# Global self-model for longitudinal tracking (EXACTLY AS ORIGINAL)
const GLOBAL_SELF_MODEL = initialize_self_model()

# ORIGINAL FUNCTION: Completely unchanged
function execute_meta_cognitive_evolution_cycle()
    println("\n" * "🔥"^70)
    println("🔥 META-COGNITIVE EVOLUTION CYCLE INITIATED")
    println("🔥"^70)
    
    # 1. ARCHITECTURAL VISION PHASE
    println("🔮 PHASE 1: Architectural Vision")
    enhanced_ast = generate_enhanced_ast()
    
    # 2. PERFORMANCE CORRELATION PHASE  
    println("🔮 PHASE 2: Performance Correlation")
    performance_metrics = Dict(
        "test_results" => ["intelligence_emergence_detected"],
        "success_rate" => 0.85,
        "entities_tested" => 64
    )
    
    # 3. SEMANTIC ANALYSIS PHASE
    println("🔮 PHASE 3: Semantic Analysis")
    semantic_results = Dict()
    for module_file in ["safe_tester.jl", "unified_network.jl", "consciousness_core.jl"]
        if isfile(module_file)
            semantic_results[module_file] = analyze_module_semantics(module_file)
        end
    end
    
    # 4. META-COGNITIVE ANALYSIS PHASE
    println("🔮 PHASE 4: Meta-Cognitive Analysis")
    diagnosis = perform_enhanced_self_diagnosis(enhanced_ast, performance_metrics, semantic_results)
    
    # 5. TEMPORAL EVOLUTION PHASE
    println("🔮 PHASE 5: Temporal Evolution Tracking")
    update_self_model!(GLOBAL_SELF_MODEL, enhanced_ast, performance_metrics, diagnosis)
    evolution_insights = generate_evolution_insights(GLOBAL_SELF_MODEL)
    
    # 6. ARCHITECTURAL DECISION PHASE
    println("🔮 PHASE 6: Architectural Decision Generation")
    decisions = generate_architectural_decisions(diagnosis, evolution_insights)
    
    # Save evolution cycle results (ORIGINAL FORMAT)
    evolution_cycle = Dict(
        "evolution_cycle_timestamp" => now(),
        "architectural_vision" => enhanced_ast,
        "semantic_analysis" => semantic_results,
        "meta_cognitive_diagnosis" => diagnosis, 
        "temporal_evolution" => evolution_insights,
        "architectural_decisions" => decisions,
        "system_state" => "META_COGNITIVE_ACTIVE"
    )
    
    # Save evolution cycle to file (ORIGINAL)
    try
        json_data = JSON.json(evolution_cycle, 2)
        open("evolution_cycle.json", "w") do file
            write(file, json_data)
        end
        println("💾 Evolution cycle saved: evolution_cycle.json")
    catch e
        println("⚠️  Failed to save evolution cycle: $e")
    end
    
    return evolution_cycle
end

# ORIGINAL FUNCTION: Completely unchanged
function generate_architectural_decisions(diagnosis::Dict, evolution::Dict)::Vector{Dict}
    decisions = []
    
    # Decision 1: Address high complexity in unified_network.jl
    high_complexity_bottlenecks = filter(b -> occursin("unified_network", get(b, "module", "")), get(diagnosis, "bottlenecks", []))
    if !isempty(high_complexity_bottlenecks)
        push!(decisions, Dict(
            "decision_id" => "ARCH_REFACTOR_001",
            "type" => "COMPLEXITY_REDUCTION",
            "target_module" => "unified_network.jl", 
            "action" => "Decompose orchestration logic into specialized sub-modules",
            "rationale" => "High control flow density indicates architectural bottleneck",
            "expected_impact" => "Reduce maintenance complexity by 40%",
            "priority" => "HIGH",
            "estimated_effort" => "MEDIUM"
        ))
    end
    
    # Decision 2: Enhance documentation based on low comment coverage
    low_doc_bottlenecks = filter(b -> occursin("safe_tester", get(b, "module", "")), get(diagnosis, "bottlenecks", []))
    if !isempty(low_doc_bottlenecks)
        push!(decisions, Dict(
            "decision_id" => "DOC_IMPROVE_001", 
            "type" => "DOCUMENTATION_ENHANCEMENT",
            "target_module" => "safe_tester.jl",
            "action" => "Add comprehensive function documentation and test cases",
            "rationale" => "Critical test infrastructure has low comment coverage",
            "expected_impact" => "Improve maintainability and onboarding efficiency",
            "priority" => "MEDIUM", 
            "estimated_effort" => "LOW"
        ))
    end
    
    # Decision 3: Preserve architectural strengths
    low_coupling_strengths = filter(s -> occursin("LOW_COUPLING", get(s, "assessment", "")), get(diagnosis, "strengths", []))
    if !isempty(low_coupling_strengths)
        push!(decisions, Dict(
            "decision_id" => "ARCH_PRESERVE_001",
            "type" => "ARCHITECTURAL_PRESERVATION", 
            "target_module" => "system_architecture",
            "action" => "Maintain current modular design with zero dependencies",
            "rationale" => "Low coupling architecture enables emergent intelligence scaling",
            "expected_impact" => "Preserve system stability and testability",
            "priority" => "HIGH",
            "estimated_effort" => "NONE"
        ))
    end
    
    # Decision 4: Monitor complexity trends
    momentum = get(evolution, "momentum_analysis", Dict())
    if get(momentum, "complexity_trend", "") == "INCREASING"
        push!(decisions, Dict(
            "decision_id" => "MONITOR_001",
            "type" => "COMPLEXITY_MONITORING",
            "target_module" => "all_modules",
            "action" => "Implement automated complexity tracking with alerts",
            "rationale" => "Complexity trending upward requires proactive monitoring",
            "expected_impact" => "Early detection of architectural degradation",
            "priority" => "MEDIUM",
            "estimated_effort" => "LOW"
        ))
    end
    
    return decisions
end

# NEW OPTIONAL FUNCTION: Only runs if AST Truth Teller is available
function get_ast_second_opinion()
    try
        println("\n" * "🌟"^60)
        println("🌟 OPTIONAL: AST TRUTH TELLER SECOND OPINION")
        println("🌟"^60)
        
        # Get second opinion from AST parser
        ast_truth = generate_ast_second_opinion()
        
        # Get actual prescriptions based on real code structure
        prescriptions = create_health_prescription(ast_truth["modules_analyzed"])
        
        # Save the truth as SEPARATE file (doesn't interfere with original)
        truth_report = Dict(
            "ast_truth" => ast_truth,
            "health_prescriptions" => prescriptions,
            "timestamp" => now(),
            "analysis_note" => "OPTIONAL second opinion - original analysis remains unchanged"
        )
        
        json_data = JSON.json(truth_report, 2)
        open("ast_truth_report.json", "w") do file
            write(file, json_data)
        end
        
        println("✅ AST Truth Report saved: ast_truth_report.json")
        println("📊 Overall Health: $(ast_truth["summary"]["overall_assessment"])")
        println("🔍 Regex Reliability: $(round(ast_truth["comparison_with_regex"]["overall_regex_reliability"] * 100, digits=1))%")
        println("💊 Prescriptions: $(prescriptions["total_prescriptions"]) total, $(prescriptions["high_priority_fixes"]) high-priority")
        
        # Print critical differences
        unreliable_modules = ast_truth["comparison_with_regex"]["unreliable_regex_modules"]
        if !isempty(unreliable_modules)
            println("\n⚠️  REGEX MAY BE INACCURATE FOR:")
            for module in unreliable_modules
                comparison = filter(c -> c["module"] == module, ast_truth["comparison_with_regex"]["comparisons"])[1]
                println("   📍 $module: Regex said $(comparison["regex_guess"]), but AST truth is $(comparison["ast_truth"])")
            end
        end
        
        return (ast_truth, prescriptions)
    catch e
        println("⚠️  AST Truth Teller unavailable: $e")
        println("   Continuing with original analysis only...")
        return (Dict(), Dict())
    end
end

# ORIGINAL MAIN FUNCTION: Completely unchanged until the very end where we optionally add AST
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
        
        # 🪞 FULL META-COGNITIVE SELF-REFLECTION STACK (ORIGINAL)
        if !isempty(sweep_results) && length(sweep_results) >= 1
            println("\n" * "="^70)
            println("🪞 FULL META-COGNITIVE SELF-REFLECTION")
            println("="^70)
            
            try
                # Enhanced architectural scan (ORIGINAL)
                enhanced_ast = generate_enhanced_ast()
                enhanced_analysis = analyze_architecture_health_v2(enhanced_ast)
                save_success = save_enhanced_blueprint(enhanced_analysis, "architecture_scan.json")
                
                if save_success
                    println("✅ Architectural scan completed")
                    
                    # META-COGNITIVE ANALYSIS (ORIGINAL)
                    try
                        # Use test results as performance metrics
                        performance_metrics = Dict(
                            "test_results" => sweep_results,
                            "entities_tested" => length(sweep_results),
                            "success_rate" => count(r -> get(r, "success", false), sweep_results) / length(sweep_results)
                        )
                        
                        # SEMANTIC ANALYSIS (ORIGINAL)
                        semantic_results = Dict()
                        try
                            println("   🔬 Running semantic analysis on core modules...")
                            for module_file in ["safe_tester.jl", "unified_network.jl", "consciousness_core.jl"]
                                if isfile(module_file)
                                    semantic_results[module_file] = analyze_module_semantics(module_file)
                                    println("      📊 $(module_file): $(semantic_results[module_file]["functions_analyzed"]) functions analyzed")
                                end
                            end
                        catch e
                            println("   ⚠️  Semantic analysis skipped: $e")
                        end
                        
                        # Perform enhanced meta-cognitive diagnosis (ORIGINAL)
                        diagnosis = perform_enhanced_self_diagnosis(enhanced_analysis, performance_metrics, semantic_results)
                        meta_save = save_meta_cognitive_analysis(diagnosis, "meta_cognitive_analysis.json")
                        
                        if meta_save
                            println("   🧠 Enhanced meta-cognitive analysis completed:")
                            println("      📊 Self-Reflection Score: $(diagnosis["self_reflection_score"])")
                            println("      ⚠️  Bottlenecks: $(length(diagnosis["bottlenecks"]))")
                            println("      ✅ Strengths: $(length(diagnosis["strengths"]))")
                            println("      💡 Recommendations: $(length(diagnosis["recommendations"]))")
                            
                            # SELF-AWARENESS TRACKING (ORIGINAL)
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
                                    
                                    # META-COGNITIVE EVOLUTION CYCLE (ORIGINAL)
                                    try
                                        evolution_cycle = execute_meta_cognitive_evolution_cycle()
                                        println("   🚀 Meta-cognitive evolution cycle completed:")
                                        println("      🔥 Architectural decisions: $(length(evolution_cycle["architectural_decisions"]))")
                                        println("      📊 System state: $(evolution_cycle["system_state"])")
                                        println("      📁 Output: evolution_cycle.json")
                                        
                                        # OPTIONAL: AST SECOND OPINION (NEW - SAFE ADDITION)
                                        try
                                            ast_truth, prescriptions = get_ast_second_opinion()
                                            if !isempty(ast_truth)
                                                println("   🔮 AST Second Opinion Available: ast_truth_report.json")
                                            end
                                        catch e
                                            println("   💡 AST Second Opinion skipped: $e")
                                        end
                                        
                                    catch e
                                        println("   ⚠️  Evolution cycle skipped: $e")
                                    end
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
