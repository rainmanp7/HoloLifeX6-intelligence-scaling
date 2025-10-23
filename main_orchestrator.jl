# enhanced_main_orchestrator.jl
"""
🎯 HOLOLIFEX6 ENHANCED ORCHESTRATOR
With AST Truth Teller integration for accurate self-diagnosis
"""

using JSON
using Dates

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
include("ast_truth_teller.jl")  # NEW: AST-based analysis

# Global self-model for longitudinal tracking
const GLOBAL_SELF_MODEL = initialize_self_model()

function get_real_truth_about_architecture()
    println("\n" * "🌟"^60)
    println("🌟 GETTING REAL TRUTH FROM AST ANALYSIS")
    println("🌟"^60)
    
    ast_truth = generate_ast_second_opinion()
    prescriptions = create_health_prescription(ast_truth["modules_analyzed"])
    
    truth_report = Dict(
        "ast_truth" => ast_truth,
        "health_prescriptions" => prescriptions,
        "timestamp" => now(),
        "analysis_note" => "This report uses real AST parsing, not regex guessing"
    )
    
    json_data = JSON.json(truth_report, 2)
    open("ast_truth_report.json", "w") do file
        write(file, json_data)
    end
    
    println("✅ AST Truth Report saved: ast_truth_report.json")
    println("📊 Overall Health: $(ast_truth["summary"]["overall_assessment"])")
    println("🔍 Regex Reliability: $(round(ast_truth["comparison_with_regex"]["overall_regex_reliability"] * 100, digits=1))%")
    println("💊 Prescriptions: $(prescriptions["total_prescriptions"]) total, $(prescriptions["high_priority_fixes"]) high-priority")
    
    unreliable_modules = ast_truth["comparison_with_regex"]["unreliable_regex_modules"]
    if !isempty(unreliable_modules)
        println("\n⚠️  REGEX LIED ABOUT THESE MODULES:")
        all_comparisons = ast_truth["comparison_with_regex"]["comparisons"]
        for mod_name in unreliable_modules
            comparisons = filter(c -> get(c, "module", "") == mod_name, all_comparisons)
            if !isempty(comparisons)
                comparison = first(comparisons)
                println("   📍 $mod_name: Regex said $(get(comparison, "regex_guess", "unknown")), but AST truth is $(get(comparison, "ast_truth", "unknown"))")
            end
        end
    end
    
    return (ast_truth, prescriptions)
end

# REFACTORED: This function now simply assembles and saves the final report from pre-computed data.
# It no longer performs any analysis itself, preventing redundant work.
function execute_enhanced_meta_cognitive_evolution_cycle(
    enhanced_ast_analysis::Dict, 
    ast_truth::Dict, 
    prescriptions::Dict, 
    semantic_results::Dict,
    enhanced_diagnosis::Dict,
    evolution_insights::Dict,
    decisions::Vector{Dict}
)
    println("\n" * "🔥"^70)
    println("🔥 ASSEMBLING FINAL ENHANCED META-COGNITIVE EVOLUTION CYCLE")
    println("🔥"^70)

    evolution_cycle = Dict(
        "evolution_cycle_timestamp" => now(),
        "architectural_vision" => enhanced_ast_analysis,
        "ast_truth_analysis" => ast_truth,
        "health_prescriptions" => prescriptions,
        "semantic_analysis" => semantic_results,
        "meta_cognitive_diagnosis" => enhanced_diagnosis, 
        "temporal_evolution" => evolution_insights,
        "architectural_decisions" => decisions,
        "system_state" => "META_COGNITIVE_WITH_AST_TRUTH"
    )
    
    try
        json_data = JSON.json(evolution_cycle, 2)
        open("enhanced_evolution_cycle.json", "w") do file
            write(file, json_data)
        end
        println("💾 Enhanced evolution cycle saved: enhanced_evolution_cycle.json")
        return evolution_cycle
    catch e
        println("⚠️  Failed to save enhanced evolution cycle: $e")
        return nothing
    end
end

function generate_ast_informed_decisions(diagnosis::Dict, evolution::Dict, prescriptions::Dict)::Vector{Dict}
    decisions = Dict[]
    
    for prescription in get(prescriptions, "prescriptions", [])
        priority = get(prescription, "priority", "MEDIUM")
        if priority == "HIGH"
            push!(decisions, Dict(
                "decision_id" => "AST_FIX_$(length(decisions)+1)",
                "type" => "AST_GUIDED_FIX",
                "target_module" => prescription["module"],
                "target_function" => prescription["function"],
                "action" => prescription["prescribed_fix"],
                "rationale" => "AST analysis identified: $(prescription["description"])",
                "expected_impact" => "Resolve structural issue with high confidence",
                "priority" => "HIGH",
                "estimated_effort" => "MEDIUM",
                "confidence" => "HIGH",
                "source" => "AST_TRUTH_TELLER"
            ))
        end
    end
    
    regex_bottlenecks = filter(b -> occursin("unified_network", get(b, "module", "")), get(diagnosis, "bottlenecks", []))
    if !isempty(regex_bottlenecks)
        regex_reliability = get(diagnosis, "regex_reliability", 0.0)
        
        if regex_reliability > 0.7
            push!(decisions, Dict(
                "decision_id" => "ARCH_REFACTOR_001",
                "type" => "COMPLEXITY_REDUCTION",
                "target_module" => "unified_network.jl", 
                "action" => "Decompose orchestration logic into specialized sub-modules",
                "rationale" => "Regex and AST both indicate complexity issues",
                "expected_impact" => "Reduce maintenance complexity",
                "priority" => "MEDIUM",
                "estimated_effort" => "MEDIUM",
                "confidence" => "MEDIUM",
                "source" => "REGEX_WITH_AST_CONFIRMATION"
            ))
        end
    end
    
    low_coupling_strengths = filter(s -> occursin("LOW_COUPLING", get(s, "assessment", "")), get(diagnosis, "strengths", []))
    if !isempty(low_coupling_strengths)
        push!(decisions, Dict(
            "decision_id" => "ARCH_PRESERVE_001",
            "type" => "ARCHITECTURAL_PRESERVATION", 
            "target_module" => "system_architecture",
            "action" => "Maintain current modular design with zero dependencies",
            "rationale" => "Both AST and regex analysis confirm low coupling is a strength",
            "expected_impact" => "Preserve system stability and testability",
            "priority" => "HIGH",
            "estimated_effort" => "NONE",
            "confidence" => "HIGH",
            "source" => "DUAL_ANALYSIS_CONFIRMATION"
        ))
    end
    
    return decisions
end

function main()
    println("🌌 HOLOLIFEX6 ENHANCED PROTOTYPE - WITH AST TRUTH TELLER")
    println("="^70)
    println("🎯 Testing REAL Intelligence Pillars:")
    println("   1. 🧠 Consciousness (Real Brown-IIT Duality)")
    println("   2. 🎯 REAL Geometric Reasoning") 
    println("   3. 👁️  REAL Phase Synchronization")
    println("   4. 💡 REAL Proto-Intelligence")
    println("   5. 🔮 AST TRUTH TELLER (Accurate Self-Diagnosis)")
    println()
    println("📊 Scaling Test: 16 → 32 → 64 entities")
    println("🎪 Measuring REAL intelligence emergence")
    println("="^70)
    
    tester = SafeTester()
    
    try
        sweep_results = run_scaling_sweep(tester)
        results_file = save_results(tester)
        print_summary(tester)
        
        if !isempty(sweep_results)
            println("\n" * "="^70)
            println("🪞 ENHANCED META-COGNITIVE SELF-REFLECTION WITH AST TRUTH")
            println("="^70)
            
            # --- START OF UNIFIED ANALYSIS PIPELINE ---
            try
                # 1. Regex-based scan (for comparison)
                regex_ast = generate_enhanced_ast()
                enhanced_analysis = analyze_architecture_health_v2(regex_ast)
                save_enhanced_blueprint(enhanced_analysis, "architecture_scan.json")
                println("✅ Architectural scan (regex-based) saved: architecture_scan.json")
                
                # 2. AST-based scan (The "Truth")
                ast_truth, prescriptions = get_real_truth_about_architecture()
                
                # 3. Performance & Semantic Data
                performance_metrics = Dict(
                    "test_results" => sweep_results,
                    "entities_tested" => length(sweep_results),
                    "success_rate" => count(r -> get(r, "success", false), sweep_results) / length(sweep_results)
                )
                
                semantic_results = Dict()
                println("   🔬 Running semantic analysis on core modules...")
                for module_file in ["safe_tester.jl", "unified_network.jl", "consciousness_core.jl"]
                    if isfile(module_file)
                        semantic_results[module_file] = analyze_module_semantics(module_file)
                        println("      📊 $(module_file): $(semantic_results[module_file]["functions_analyzed"]) functions analyzed")
                    end
                end
                
                # 4. Perform Meta-Cognitive Diagnosis
                diagnosis = perform_enhanced_self_diagnosis(enhanced_analysis, performance_metrics, semantic_results)
                enhanced_diagnosis = merge(diagnosis, Dict(
                    "ast_truth_integrated" => true,
                    "ast_health_assessment" => ast_truth["summary"]["overall_assessment"],
                    "regex_reliability" => ast_truth["comparison_with_regex"]["overall_regex_reliability"],
                    "ast_prescriptions" => prescriptions
                ))
                save_meta_cognitive_analysis(enhanced_diagnosis, "enhanced_meta_cognitive_analysis.json")
                println("   🧠 Enhanced meta-cognitive analysis saved: enhanced_meta_cognitive_analysis.json")
                
                # 5. Update Self-Awareness Model
                update_self_model!(GLOBAL_SELF_MODEL, enhanced_analysis, performance_metrics, enhanced_diagnosis)
                evolution_insights = generate_evolution_insights(GLOBAL_SELF_MODEL)
                save_self_model(GLOBAL_SELF_MODEL, "enhanced_self_awareness_model.json")
                println("   📈 Enhanced self-awareness model saved: enhanced_self_awareness_model.json")
                
                # 6. Generate Architectural Decisions
                decisions = generate_ast_informed_decisions(enhanced_diagnosis, evolution_insights, prescriptions)
                println("   💡 Generated $(length(decisions)) architectural decisions.")

                # 7. Assemble the Final Evolution Cycle Report
                evolution_cycle = execute_enhanced_meta_cognitive_evolution_cycle(
                    enhanced_analysis,
                    ast_truth,
                    prescriptions,
                    semantic_results,
                    enhanced_diagnosis,
                    evolution_insights,
                    decisions
                )
                if !isnothing(evolution_cycle)
                    println("   🚀 Enhanced meta-cognitive evolution cycle completed successfully.")
                end
                
            catch e
                println("⚠️  Enhanced self-reflection pipeline failed: $e")
                println("Stacktrace:")
                for (i, frame) in enumerate(stacktrace(catch_backtrace()))
                    println("  $i: $frame")
                    i > 5 && break
                end
            end
            # --- END OF UNIFIED ANALYSIS PIPELINE ---
        end
        
        println("\n" * "="^70)
        println("✨ ENHANCED MODULAR TESTING COMPLETE")
        println("="^70)
        println("All reports generated:")
        println("  📁 Test Results: $results_file")
        println("  📁 Regex Scan: architecture_scan.json")
        println("  🔮 AST Truth Report: ast_truth_report.json")
        println("  🧠 Meta-Cognitive Analysis: enhanced_meta_cognitive_analysis.json")
        println("  📈 Self-Awareness Model: enhanced_self_awareness_model.json")
        println("  💾 Final Evolution Cycle: enhanced_evolution_cycle.json")
        println("\n⏱️  Total time: $(round(time() - tester.start_time, digits=1))s")
        
    catch e
        println("❌ FATAL ERROR in main orchestrator: $e")
        println("Stacktrace:")
        for (i, frame) in enumerate(stacktrace(catch_backtrace()))
            println("  $i: $frame")
            i > 5 && break
        end
        try
            save_results(tester)
        catch
            println("⚠️  Could not save results after fatal error.")
        end
    end
    
    println("\n🎊 ENHANCED MODULAR TESTING COMPLETE")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
