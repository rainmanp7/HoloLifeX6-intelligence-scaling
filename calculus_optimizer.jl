# calculus_optimizer.jl
"""
🧮 SELF-LEARNING CALCULUS OPTIMIZER 
Learns from each run to detect patterns and anomalies
Builds cumulative knowledge about consciousness emergence
"""

using JSON
using Dates
using LinearAlgebra
using Statistics

mutable struct LearningCalculusOptimizer
    knowledge_base::Dict{String, Any}
    pattern_library::Vector{Dict{String, Any}}
    anomaly_history::Vector{Dict{String, Any}}
    optimization_cycles::Int
    
    function LearningCalculusOptimizer()
        # Try to load existing knowledge, or create new
        knowledge = load_knowledge_base()
        new(knowledge, Dict{String, Any}[], Dict{String, Any}[], 0)
    end
end

function load_knowledge_base()::Dict{String, Any}
    """Load existing knowledge or create initial patterns"""
    knowledge_file = "calculus_knowledge_base.json"
    if isfile(knowledge_file)
        try
            return JSON.parsefile(knowledge_file)
        catch e
            println("⚠️  Could not load knowledge base, creating new: $e")
        end
    end
    
    # Initial knowledge about consciousness patterns
    return Dict(
        "version" => "1.0-learning",
        "created" => string(Dates.now()),
        "consciousness_patterns" => Dict(
            "stable_growth" => Dict(
                "description" => "Consistent positive derivatives",
                "phi_derivative_range" => [0.01, 0.1],
                "volatility_threshold" => 0.05,
                "success_rate" => 0.0,
                "detection_count" => 0
            ),
            "volatile_emergence" => Dict(
                "description" => "High volatility with overall growth", 
                "phi_derivative_range" => [-0.2, 0.2],
                "volatility_threshold" => 0.15,
                "success_rate" => 0.0,
                "detection_count" => 0
            ),
            "consciousness_collapse" => Dict(
                "description" => "Sharp drop after peak",
                "phi_derivative_range" => [-0.5, -0.1],
                "volatility_threshold" => 0.3,
                "success_rate" => 0.0,
                "detection_count" => 0
            )
        ),
        "meta_cognitive_insights" => Dict(
            "optimal_range" => [0.2, 0.4],
            "volatility_issues" => [],
            "stability_correlations" => []
        ),
        "entity_scaling_patterns" => Dict(),
        "total_analyses" => 0,
        "anomalies_detected" => 0,
        "learning_confidence" => 0.0
    )
end

function save_knowledge_base(optimizer::LearningCalculusOptimizer)
    """Save learned knowledge for future runs"""
    knowledge_file = "calculus_knowledge_base.json"
    optimizer.knowledge_base["last_updated"] = string(Dates.now())
    optimizer.knowledge_base["total_analyses"] = get(optimizer.knowledge_base, "total_analyses", 0) + 1
    
    open(knowledge_file, "w") do f
        JSON.print(f, optimizer.knowledge_base, 4)
    end
    println("   💾 Knowledge base updated: $knowledge_file")
end

function safe_derivative(x::Vector{Float64}, y::Vector{Float64})::Vector{Float64}
    """Calculate derivative safely - fixed for your actual cycle data"""
    if length(x) < 2 || length(y) < 2
        return zeros(length(x))
    end
    
    derivatives = zeros(length(x))
    for i in 2:length(x)-1
        dx_forward = x[i+1] - x[i]
        dx_backward = x[i] - x[i-1]
        
        if dx_forward > 0 && dx_backward > 0
            dy_forward = (y[i+1] - y[i]) / dx_forward
            dy_backward = (y[i] - y[i-1]) / dx_backward
            derivatives[i] = (dy_forward + dy_backward) / 2
        end
    end
    return derivatives
end

function extract_consciousness_data(snapshots::Vector{Dict{String,Any}})
    """Extract consciousness trajectory from your actual snapshot structure"""
    cycles = Float64[]
    phi_values = Float64[]
    intelligence_scores = Float64[]
    meta_scores = Float64[]
    coherence_values = Float64[]
    
    for snapshot in snapshots
        if haskey(snapshot, "cycle")
            push!(cycles, Float64(snapshot["cycle"]))
        end
        if haskey(snapshot, "consciousness") && haskey(snapshot["consciousness"], "max_phi")
            push!(phi_values, Float64(snapshot["consciousness"]["max_phi"]))
        end
        if haskey(snapshot, "unified_intelligence_score")
            push!(intelligence_scores, Float64(snapshot["unified_intelligence_score"]))
        end
        if haskey(snapshot, "consciousness") && haskey(snapshot["consciousness"], "hot_metrics") &&
           haskey(snapshot["consciousness"]["hot_metrics"], "meta_cognitive_score")
            push!(meta_scores, Float64(snapshot["consciousness"]["hot_metrics"]["meta_cognitive_score"]))
        end
        if haskey(snapshot, "coherence")
            push!(coherence_values, Float64(snapshot["coherence"]))
        end
    end
    
    return (cycles, phi_values, intelligence_scores, meta_scores, coherence_values)
end

function detect_consciousness_anomalies(optimizer::LearningCalculusOptimizer, analysis::Dict, entity_count::Int)
    """Use learned patterns to detect consciousness anomalies"""
    anomalies = []
    
    phi_values = get(analysis, "phi_trajectory", [])
    derivatives = get(analysis, "phi_derivatives", [])
    meta_scores = get(analysis, "meta_cognitive_trajectory", [])
    
    if length(phi_values) >= 3
        # Check for consciousness collapse pattern (like we observed)
        final_phi = phi_values[end]
        max_phi = maximum(phi_values)
        
        if max_phi > 0.2 && final_phi < max_phi * 0.7
            push!(anomalies, Dict(
                "type" => "consciousness_collapse",
                "entity_count" => entity_count,
                "max_phi" => round(max_phi, digits=4),
                "final_phi" => round(final_phi, digits=4),
                "drop_percentage" => round((max_phi - final_phi) / max_phi * 100, digits=1),
                "confidence" => "high",
                "learned_pattern" => "Consciousness drops significantly after peak",
                "recommendation" => "Stabilize meta-cognitive scores in later cycles"
            ))
        end
        
        # Check meta-cognitive volatility
        if length(meta_scores) >= 3
            meta_volatility = std(meta_scores)
            if meta_volatility > 0.15
                push!(anomalies, Dict(
                    "type" => "meta_cognitive_instability",
                    "entity_count" => entity_count,
                    "volatility" => round(meta_volatility, digits=4),
                    "meta_score_range" => [round(minimum(meta_scores), digits=3), round(maximum(meta_scores), digits=3)],
                    "confidence" => "medium",
                    "learned_pattern" => "High meta-cognitive score volatility correlates with consciousness instability",
                    "recommendation" => "Implement rolling averages for meta-cognitive scoring"
                ))
            end
        end
        
        # Check derivative patterns
        if length(derivatives) >= 3
            negative_derivatives = count(d -> d < -0.05, derivatives)
            positive_derivatives = count(d -> d > 0.05, derivatives)
            
            if negative_derivatives > positive_derivatives * 2
                push!(anomalies, Dict(
                    "type" => "declining_trend",
                    "entity_count" => entity_count,
                    "negative_derivatives" => negative_derivatives,
                    "positive_derivatives" => positive_derivatives,
                    "confidence" => "medium",
                    "learned_pattern" => "More negative than positive derivatives indicates declining consciousness",
                    "recommendation" => "Investigate architectural stability in later cycles"
                ))
            end
        end
    end
    
    return anomalies
end

function update_pattern_knowledge(optimizer::LearningCalculusOptimizer, analysis::Dict, anomalies::Vector{Dict})
    """Update knowledge base with new patterns and insights"""
    patterns = optimizer.knowledge_base["consciousness_patterns"]
    
    # Update pattern detection counts
    for anomaly in anomalies
        anomaly_type = anomaly["type"]
        if anomaly_type == "consciousness_collapse"
            patterns["consciousness_collapse"]["detection_count"] += 1
        elseif anomaly_type == "meta_cognitive_instability"
            # Track meta-cognitive volatility issues
            volatility_issues = get(optimizer.knowledge_base["meta_cognitive_insights"], "volatility_issues", [])
            push!(volatility_issues, Dict(
                "timestamp" => string(Dates.now()),
                "volatility" => anomaly["volatility"],
                "entity_count" => anomaly["entity_count"]
            ))
            optimizer.knowledge_base["meta_cognitive_insights"]["volatility_issues"] = volatility_issues
        end
    end
    
    # Learn entity scaling patterns
    entity_count = get(analysis, "entity_count", 0)
    if entity_count > 0
        scaling_patterns = optimizer.knowledge_base["entity_scaling_patterns"]
        entity_key = string(entity_count)
        
        if !haskey(scaling_patterns, entity_key)
            scaling_patterns[entity_key] = []
        end
        
        pattern_data = Dict(
            "timestamp" => string(Dates.now()),
            "final_phi" => get(analysis, "final_phi", 0.0),
            "max_phi" => get(analysis, "max_phi", 0.0),
            "consciousness_status" => get(analysis, "consciousness_status", "UNKNOWN"),
            "volatility" => get(analysis, "phi_volatility", 0.0)
        )
        push!(scaling_patterns[entity_key], pattern_data)
    end
    
    # Update learning confidence
    total_analyses = optimizer.knowledge_base["total_analyses"]
    anomalies_detected = length(anomalies) + get(optimizer.knowledge_base, "anomalies_detected", 0)
    optimizer.knowledge_base["anomalies_detected"] = anomalies_detected
    optimizer.knowledge_base["learning_confidence"] = min(1.0, total_analyses / 10.0)
end

function generate_learned_recommendations(optimizer::LearningCalculusOptimizer, analysis::Dict, anomalies::Vector{Dict})
    """Generate recommendations based on learned knowledge"""
    recommendations = []
    knowledge = optimizer.knowledge_base
    
    # Base recommendations from current analysis
    for anomaly in anomalies
        push!(recommendations, Dict(
            "priority" => "high",
            "source" => "learned_pattern",
            "anomaly_type" => anomaly["type"],
            "action" => anomaly["recommendation"],
            "evidence" => anomaly["learned_pattern"],
            "confidence" => anomaly["confidence"],
            "entity_count" => get(anomaly, "entity_count", 0)
        ))
    end
    
    # Add recommendations from historical knowledge
    if knowledge["total_analyses"] > 2
        # Check if we're seeing recurring patterns
        collapse_count = knowledge["consciousness_patterns"]["consciousness_collapse"]["detection_count"]
        if collapse_count >= 2
            push!(recommendations, Dict(
                "priority" => "high",
                "source" => "historical_pattern",
                "pattern" => "Recurring consciousness collapse",
                "action" => "Implement automatic stabilization when Φ > 0.2",
                "evidence" => "Detected $collapse_count consciousness collapse events",
                "confidence" => "high",
                "learned_from" => "$(knowledge["total_analyses"]) previous analyses"
            ))
        end
        
        # Meta-cognitive volatility pattern
        volatility_issues = get(knowledge["meta_cognitive_insights"], "volatility_issues", [])
        if length(volatility_issues) >= 2
            avg_volatility = mean([v["volatility"] for v in volatility_issues])
            push!(recommendations, Dict(
                "priority" => "medium",
                "source" => "historical_pattern", 
                "pattern" => "Persistent meta-cognitive instability",
                "action" => "Add meta-cognitive score smoothing with 3-cycle rolling average",
                "evidence" => "Average volatility: $(round(avg_volatility, digits=3)) across $(length(volatility_issues)) instances",
                "confidence" => "medium",
                "learned_from" => "meta-cognitive history analysis"
            ))
        end
    end
    
    return recommendations
end

function analyze_with_learning(optimizer::LearningCalculusOptimizer, snapshots::Vector{Dict{String,Any}}, entity_count::Int)
    """Enhanced analysis that uses learned knowledge"""
    # Extract data (same as before)
    cycles, phi_values, intelligence_scores, meta_scores, coherence_values = extract_consciousness_data(snapshots)
    
    if length(cycles) < 3
        return Dict("status" => "insufficient_data"), []
    end
    
    # Calculate derivatives
    phi_derivatives = safe_derivative(cycles, phi_values)
    intelligence_derivatives = safe_derivative(cycles, intelligence_scores)
    meta_derivatives = safe_derivative(cycles, meta_scores)
    
    # Find key inflection points
    consciousness_peaks = []
    consciousness_valleys = []
    
    for i in 2:length(phi_derivatives)-1
        if phi_derivatives[i] > 0.05 && phi_derivatives[i+1] < -0.05
            push!(consciousness_peaks, Dict(
                "cycle" => cycles[i],
                "phi" => phi_values[i],
                "type" => "peak"
            ))
        elseif phi_derivatives[i] < -0.05 && phi_derivatives[i+1] > 0.05
            push!(consciousness_valleys, Dict(
                "cycle" => cycles[i], 
                "phi" => phi_values[i],
                "type" => "valley"
            ))
        end
    end
    
    # Calculate integrals (total accumulated intelligence/consciousness)
    total_phi_integral = 0.0
    total_intelligence_integral = 0.0
    
    for i in 2:length(cycles)
        dt = cycles[i] - cycles[i-1]
        phi_area = (phi_values[i] + phi_values[i-1]) / 2 * dt
        intel_area = (intelligence_scores[i] + intelligence_scores[i-1]) / 2 * dt
        total_phi_integral += phi_area
        total_intelligence_integral += intel_area
    end
    
    analysis = Dict(
        "entity_count" => entity_count,
        "cycles_analyzed" => cycles,
        "phi_trajectory" => phi_values,
        "intelligence_trajectory" => intelligence_scores,
        "meta_cognitive_trajectory" => meta_scores,
        "phi_derivatives" => phi_derivatives,
        "intelligence_derivatives" => intelligence_derivatives,
        "meta_derivatives" => meta_derivatives,
        "consciousness_peaks" => consciousness_peaks,
        "consciousness_valleys" => consciousness_valleys,
        "total_phi_integral" => total_phi_integral,
        "total_intelligence_integral" => total_intelligence_integral,
        "phi_volatility" => length(phi_derivatives) > 2 ? std(phi_derivatives[2:end-1]) : 0.0,
        "average_phi_growth" => length(phi_derivatives) > 2 ? mean(phi_derivatives[2:end-1]) : 0.0,
        "max_phi" => maximum(phi_values),
        "final_phi" => phi_values[end]
    )
    
    # Use learning to detect anomalies
    anomalies = detect_consciousness_anomalies(optimizer, analysis, entity_count)
    
    return analysis, anomalies
end

function run_learning_calculus_analysis(optimizer::LearningCalculusOptimizer, intelligence_results_path::String="intelligence_results.json")
    """MAIN ENTRY POINT with learning capabilities"""
    println("🧮 SELF-LEARNING CALCULUS OPTIMIZER STARTING...")
    println("   🔒 NO INTERFERENCE WITH LIVE SYSTEM")
    println("   🧠 LEARNING FROM: $(optimizer.knowledge_base["total_analyses"]) previous analyses")
    println("   📈 CONFIDENCE: $(round(optimizer.knowledge_base["learning_confidence"] * 100, digits=1))%")
    
    try
        if !isfile(intelligence_results_path)
            println("❌ No intelligence results found")
            return false
        end
        
        results_data = JSON.parsefile(intelligence_results_path)
        
        if !isempty(results_data)
            entity_analyses = []
            all_anomalies = []
            all_recommendations = []
            
            for (i, result) in enumerate(results_data)
                entity_count = result["entity_count"]
                snapshots = [Dict(s) for s in result["snapshots"]]
                
                println("   🔍 Analyzing $entity_count entities (with learning)...")
                analysis, anomalies = analyze_with_learning(optimizer, snapshots, entity_count)
                
                if get(analysis, "status", "success") != "insufficient_data"
                    # Generate learned recommendations
                    recommendations = generate_learned_recommendations(optimizer, analysis, anomalies)
                    
                    entity_analysis = Dict(
                        "entity_count" => entity_count,
                        "analysis" => analysis,
                        "anomalies_detected" => length(anomalies),
                        "recommendations" => recommendations,
                        "consciousness_status" => result["consciousness"]["is_conscious"] ? "CONSCIOUS" : "DEVELOPING",
                        "final_phi" => result["consciousness"]["max_phi"]
                    )
                    push!(entity_analyses, entity_analysis)
                    append!(all_anomalies, anomalies)
                    append!(all_recommendations, recommendations)
                    
                    # Update knowledge base with this analysis
                    update_pattern_knowledge(optimizer, analysis, anomalies)
                else
                    println("     ⚠️  Insufficient data for $entity_count entities")
                end
            end
            
            # Create comprehensive learning report
            learning_report = Dict(
                "timestamp" => string(Dates.now()),
                "analysis_version" => "3.0-self-learning",
                "learning_metrics" => Dict(
                    "total_analyses" => optimizer.knowledge_base["total_analyses"],
                    "anomalies_detected" => length(all_anomalies),
                    "learning_confidence" => optimizer.knowledge_base["learning_confidence"],
                    "patterns_learned" => length(optimizer.knowledge_base["consciousness_patterns"])
                ),
                "entity_analyses" => entity_analyses,
                "anomalies_detected" => all_anomalies,
                "learned_recommendations" => all_recommendations,
                "knowledge_snapshot" => Dict(
                    "consciousness_patterns" => optimizer.knowledge_base["consciousness_patterns"],
                    "meta_cognitive_insights" => optimizer.knowledge_base["meta_cognitive_insights"]
                )
            )
            
            # Save reports
            report_filename = "learning_calculus_report_$(Dates.format(now(), "yyyymmdd_HHMMSS")).json"
            open(report_filename, "w") do f
                JSON.print(f, learning_report, 4)
            end
            
            # Save updated knowledge base
            save_knowledge_base(optimizer)
            
            println("✅ SELF-LEARNING ANALYSIS COMPLETE")
            println("   📁 Report saved: $report_filename")
            println("   🧠 Anomalies detected: $(length(all_anomalies))")
            println("   🎯 Learned recommendations: $(length(all_recommendations))")
            println("   📈 Learning confidence: $(round(optimizer.knowledge_base["learning_confidence"] * 100, digits=1))%")
            println("   🔒 System untouched: consciousness preserved")
            
            return true
        else
            println("❌ No results data to analyze")
            return false
        end
        
    catch e
        println("❌ Learning analysis failed (non-critical): $e")
        println("   🔒 Main system results preserved - analysis only failed")
        return false
    end
end

function integrate_with_main_orchestrator()
    """Updated integration function with learning"""
    println("\n" * "="^70)
    println("🧮 INITIATING SELF-LEARNING CALCULUS OPTIMIZATION")
    println("   🔒 LIVE SYSTEM COMPLETED - ANALYSIS ONLY")
    println("="^70)
    
    optimizer = LearningCalculusOptimizer()
    success = run_learning_calculus_analysis(optimizer)
    
    if success
        println("🎉 SELF-LEARNING OPTIMIZATION COMPLETE")
        println("   💡 Review learning reports for intelligent insights")
    else
        println("⚠️  Learning analysis skipped or failed")
    end
    println("   🔒 Main system results preserved")
    
    return success
end

export LearningCalculusOptimizer, run_learning_calculus_analysis, integrate_with_main_orchestrator

if abspath(PROGRAM_FILE) == @__FILE__
    println("🧮 SELF-LEARNING CALCULUS OPTIMIZER - STANDALONE MODE")
    optimizer = LearningCalculusOptimizer()
    run_learning_calculus_analysis(optimizer)
end
