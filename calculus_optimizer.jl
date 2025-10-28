# calculus_optimizer.jl
"""
🧮 SELF-LEARNING CALCULUS OPTIMIZER v2.0
Learns from each run to detect patterns and anomalies
Builds cumulative knowledge about consciousness emergence
Refactored for improved learning, accuracy, and clarity.
"""

using JSON
using Dates
using LinearAlgebra
using Statistics

mutable struct LearningCalculusOptimizer
    knowledge_base::Dict{String, Any}
    # Removed unused fields: pattern_library, anomaly_history, optimization_cycles
    
    function LearningCalculusOptimizer()
        knowledge = load_knowledge_base()
        new(knowledge)
    end
end

function load_knowledge_base()::Dict{String, Any}
    knowledge_file = "calculus_knowledge_base.json"
    if isfile(knowledge_file)
        try
            return JSON.parsefile(knowledge_file)
        catch e
            println("⚠️  Could not load knowledge base, creating new: $e")
        end
    end
    
    # Initial knowledge: Thresholds are now part of the knowledge base to be learned/tuned.
    return Dict(
        "version" => "2.0-tunable",
        "created" => string(Dates.now()),
        "consciousness_patterns" => Dict(
            "consciousness_collapse" => Dict(
                "description" => "Sharp drop after peak, a key instability indicator.",
                "peak_phi_threshold" => 0.2, # moved from hardcode
                "drop_ratio_threshold" => 0.7, # i.e., drops below 70% of peak
                "detection_count" => 0,
                "historical_drops" => []
            ),
            "meta_cognitive_instability" => Dict(
                "description" => "High volatility in meta-cognitive scores, often precedes collapse.",
                "volatility_threshold" => 0.15, # moved from hardcode
                "detection_count" => 0
            ),
            "persistent_decline" => Dict(
                "description" => "Trajectory has significantly more negative than positive derivatives.",
                "negative_derivative_threshold" => -0.05,
                "positive_derivative_threshold" => 0.05,
                "neg_to_pos_ratio_threshold" => 2.0, # moved from hardcode
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
        "anomalies_detected_total" => 0,
        # Renamed for clarity. This is a measure of experience, not statistical confidence.
        "knowledge_maturity" => 0.0 
    )
end

function save_knowledge_base(optimizer::LearningCalculusOptimizer)
    knowledge_file = "calculus_knowledge_base.json"
    optimizer.knowledge_base["last_updated"] = string(Dates.now())
    optimizer.knowledge_base["total_analyses"] += 1
    
    # Update maturity score
    total_analyses = optimizer.knowledge_base["total_analyses"]
    # A slightly more nuanced maturity curve that requires more data to reach 100%
    optimizer.knowledge_base["knowledge_maturity"] = min(1.0, total_analyses / 25.0)

    open(knowledge_file, "w") do f
        JSON.print(f, optimizer.knowledge_base, 4)
    end
    println("   💾 Knowledge base updated: $knowledge_file")
end

function safe_derivative(x::Vector{Float64}, y::Vector{Float64})::Vector{Float64}
    """
    Calculate derivative safely, with improved handling for endpoints.
    Uses central difference for interior points, and forward/backward difference for edges.
    """
    n = length(x)
    if n < 2 || length(y) != n
        return zeros(n)
    end
    
    derivatives = zeros(n)
    
    # Forward difference for the first point
    if n >= 2
        dx = x[2] - x[1]
        if dx > 0
            derivatives[1] = (y[2] - y[1]) / dx
        end
    end
    
    # Central difference for interior points
    for i in 2:n-1
        dx = x[i+1] - x[i-1]
        if dx > 0
            derivatives[i] = (y[i+1] - y[i-1]) / dx
        else # Fallback to backward difference if points are not monotonic
            dx_b = x[i] - x[i-1]
            if dx_b > 0
                derivatives[i] = (y[i] - y[i-1]) / dx_b
            end
        end
    end
    
    # Backward difference for the last point
    if n >= 2
        dx = x[n] - x[n-1]
        if dx > 0
            derivatives[n] = (y[n] - y[n-1]) / dx
        end
    end

    return derivatives
end

# This function was already well-written and robust. No changes needed.
function extract_consciousness_data(snapshots::Vector{Dict{String,Any}})
    cycles, phi_values, intelligence_scores, meta_scores, coherence_values = Float64[], Float64[], Float64[], Float64[], Float64[]
    for snapshot in snapshots
        haskey(snapshot, "cycle") && push!(cycles, Float64(snapshot["cycle"]))
        if haskey(snapshot, "consciousness") && haskey(snapshot["consciousness"], "max_phi")
            push!(phi_values, Float64(snapshot["consciousness"]["max_phi"]))
        end
        haskey(snapshot, "unified_intelligence_score") && push!(intelligence_scores, Float64(snapshot["unified_intelligence_score"]))
        if haskey(snapshot, "consciousness") && haskey(snapshot["consciousness"]["hot_metrics"], "meta_cognitive_score")
            push!(meta_scores, Float64(snapshot["consciousness"]["hot_metrics"]["meta_cognitive_score"]))
        end
        haskey(snapshot, "coherence") && push!(coherence_values, Float64(snapshot["coherence"]))
    end
    return (cycles, phi_values, intelligence_scores, meta_scores, coherence_values)
end

function detect_consciousness_anomalies(optimizer::LearningCalculusOptimizer, analysis::Dict, entity_count::Int)
    """Use learned patterns and THRESHOLDS from the knowledge base to detect anomalies."""
    anomalies = []
    kb_patterns = optimizer.knowledge_base["consciousness_patterns"]
    
    phi_values = get(analysis, "phi_trajectory", [])
    derivatives = get(analysis, "phi_derivatives", [])
    meta_scores = get(analysis, "meta_cognitive_trajectory", [])
    
    if length(phi_values) >= 3
        # ANOMALY 1: Consciousness Collapse (using learned thresholds)
        p_collapse = kb_patterns["consciousness_collapse"]
        final_phi, max_phi = phi_values[end], maximum(phi_values)
        
        if max_phi > p_collapse["peak_phi_threshold"] && final_phi < max_phi * p_collapse["drop_ratio_threshold"]
            push!(anomalies, Dict(
                "type" => "consciousness_collapse",
                "message" => "Consciousness dropped by >$(round((1-p_collapse["drop_ratio_threshold"])*100, digits=0))% after peaking above $(p_collapse["peak_phi_threshold"])",
                "details" => Dict("max_phi" => round(max_phi, 4), "final_phi" => round(final_phi, 4)),
                "recommendation" => "Investigate resource allocation or feedback loops during late cycles."
            ))
        end
        
        # ANOMALY 2: Meta-Cognitive Instability (using learned thresholds)
        if length(meta_scores) >= 3
            p_meta = kb_patterns["meta_cognitive_instability"]
            meta_volatility = std(meta_scores)
            if meta_volatility > p_meta["volatility_threshold"]
                push!(anomalies, Dict(
                    "type" => "meta_cognitive_instability",
                    "message" => "Meta-cognitive score volatility ($(round(meta_volatility, 3))) exceeds threshold ($(p_meta["volatility_threshold"])).",
                    "details" => Dict("volatility" => round(meta_volatility, 4), "range" => [round(minimum(meta_scores), 3), round(maximum(meta_scores), 3)]),
                    "recommendation" => "Implement smoothing (e.g., rolling average) for meta-cognitive inputs."
                ))
            end
        end
        
        # ANOMALY 3: Persistent Decline (using learned thresholds)
        if length(derivatives) >= 3
            p_decline = kb_patterns["persistent_decline"]
            neg_derivs = count(d -> d < p_decline["negative_derivative_threshold"], derivatives)
            pos_derivs = count(d -> d > p_decline["positive_derivative_threshold"], derivatives)
            
            if pos_derivs > 0 && neg_derivs / pos_derivs > p_decline["neg_to_pos_ratio_threshold"]
                 push!(anomalies, Dict(
                    "type" => "persistent_decline",
                    "message" => "Found $(neg_derivs) cycles of significant decline vs. $(pos_derivs) cycles of growth.",
                    "details" => Dict("neg_count" => neg_derivs, "pos_count" => pos_derivs, "ratio" => round(neg_derivs/pos_derivs, 2)),
                    "recommendation" => "Check for systemic decay or cascading failures in entity communication."
                ))
            end
        end
    end
    
    return anomalies
end

function update_pattern_knowledge(optimizer::LearningCalculusOptimizer, analysis::Dict, anomalies::Vector)
    """Update knowledge base with new patterns, insights, and potentially tune thresholds."""
    kb = optimizer.knowledge_base
    
    # Update detection counts
    for anomaly in anomalies
        anomaly_type = get(anomaly, "type", "")
        if haskey(kb["consciousness_patterns"], anomaly_type)
            kb["consciousness_patterns"][anomaly_type]["detection_count"] += 1
        end
    end
    
    # --- Active Learning Example: Log data for future tuning ---
    # For any detected collapse, log the specific drop ratio. Over time, we could
    # use the average/median of these to refine the `drop_ratio_threshold`.
    if any(a -> a["type"] == "consciousness_collapse", anomalies)
        max_phi = get(analysis, "max_phi", 0.0)
        final_phi = get(analysis, "final_phi", 0.0)
        if max_phi > 0
            drop_ratio = final_phi / max_phi
            push!(kb["consciousness_patterns"]["consciousness_collapse"]["historical_drops"], Dict(
                "timestamp" => string(Dates.now()),
                "entity_count" => get(analysis, "entity_count", 0),
                "drop_ratio" => round(drop_ratio, 4)
            ))
        end
    end
    
    # Learn entity scaling patterns (this was already well-implemented)
    entity_count = get(analysis, "entity_count", 0)
    if entity_count > 0
        scaling_patterns = kb["entity_scaling_patterns"]
        entity_key = string(entity_count)
        if !haskey(scaling_patterns, entity_key)
            scaling_patterns[entity_key] = []
        end
        push!(scaling_patterns[entity_key], Dict(
            "timestamp" => string(Dates.now()),
            "final_phi" => get(analysis, "final_phi", 0.0),
            "max_phi" => get(analysis, "max_phi", 0.0),
            "volatility" => get(analysis, "phi_volatility", 0.0)
        ))
    end
    
    # Update total anomalies detected
    kb["anomalies_detected_total"] += length(anomalies)
end

function generate_learned_recommendations(optimizer::LearningCalculusOptimizer, analysis::Dict, anomalies::Vector)
    """Generate recommendations based on both current anomalies and historical knowledge."""
    recommendations = []
    kb = optimizer.knowledge_base
    
    # 1. Recommendations from anomalies detected in THIS run
    for anomaly in anomalies
        push!(recommendations, Dict(
            "priority" => "high",
            "source" => "current_run_anomaly",
            "type" => get(anomaly, "type", "unknown"),
            "action" => get(anomaly, "recommendation", "Review system behavior"),
            "evidence" => get(anomaly, "message", "Pattern detected")
        ))
    end
    
    # 2. Recommendations from HISTORICAL knowledge (meta-learning)
    if kb["total_analyses"] > 5 # Only give historical advice after some experience
        # Recurring collapse pattern
        collapse_pattern = kb["consciousness_patterns"]["consciousness_collapse"]
        if collapse_pattern["detection_count"] >= 3
            push!(recommendations, Dict(
                "priority" => "critical",
                "source" => "historical_pattern",
                "type" => "recurring_consciousness_collapse",
                "action" => "This is a systemic issue. Implement automated stability protocols when Φ derivative turns sharply negative after a peak. Consider a 'cooling off' period for entity interactions.",
                "evidence" => "Detected $(collapse_pattern["detection_count"]) collapse events across $(kb["total_analyses"]) analyses."
            ))
        end
        
        # Meta-cognitive instability pattern
        meta_pattern = kb["consciousness_patterns"]["meta_cognitive_instability"]
        if meta_pattern["detection_count"] > kb["total_analyses"] * 0.4 # If it happens in >40% of runs
             push!(recommendations, Dict(
                "priority" => "high",
                "source" => "historical_pattern", 
                "type" => "persistent_meta_cognitive_instability",
                "action" => "The meta-cognitive scoring is fundamentally unstable. Prioritize redesigning its feedback mechanism. It is likely too sensitive.",
                "evidence" => "Detected in $(meta_pattern["detection_count"]) of $(kb["total_analyses"]) analyses."
            ))
        end
    end
    
    return recommendations
end

function analyze_with_learning(optimizer::LearningCalculusOptimizer, snapshots::Vector{Dict{String,Any}}, entity_count::Int)
    cycles, phi_values, intelligence_scores, meta_scores, _ = extract_consciousness_data(snapshots)
    if length(cycles) < 3
        return Dict("status" => "insufficient_data"), [], []
    end
    
    # Calculate derivatives and integrals
    phi_derivatives = safe_derivative(cycles, phi_values)
    total_phi_integral = sum((phi_values[i] + phi_values[i-1]) / 2 * (cycles[i] - cycles[i-1]) for i in 2:length(cycles))
    
    analysis = Dict(
        "entity_count" => entity_count,
        "cycles_analyzed" => length(cycles),
        "phi_trajectory" => phi_values,
        "meta_cognitive_trajectory" => meta_scores,
        "phi_derivatives" => phi_derivatives,
        "total_phi_integral" => total_phi_integral,
        "phi_volatility" => std(phi_derivatives),
        "average_phi_growth" => mean(phi_derivatives),
        "max_phi" => isempty(phi_values) ? 0.0 : maximum(phi_values),
        "final_phi" => isempty(phi_values) ? 0.0 : phi_values[end]
    )
    
    anomalies = detect_consciousness_anomalies(optimizer, analysis, entity_count)
    recommendations = generate_learned_recommendations(optimizer, analysis, anomalies)
    
    return analysis, anomalies, recommendations
end

function run_learning_calculus_analysis(optimizer::LearningCalculusOptimizer, intelligence_results_path::String="intelligence_results.json")
    println("🧮 SELF-LEARNING CALCULUS OPTIMIZER v2.0 STARTING...")
    println("   🧠 LEARNING FROM: $(optimizer.knowledge_base["total_analyses"]) previous analyses")
    println("   📈 KNOWLEDGE MATURITY: $(round(optimizer.knowledge_base["knowledge_maturity"] * 100, digits=1))%")
    
    if !isfile(intelligence_results_path)
        println("❌ No intelligence results found at '$intelligence_results_path'")
        return false
    end
    
    try
        results_data = JSON.parsefile(intelligence_results_path)
        if isempty(results_data)
            println("❌ Results file is empty. Nothing to analyze.")
            return false
        end
        
        all_analyses, all_anomalies, all_recommendations = [], [], []
        
        for result in results_data
            entity_count = get(result, "entity_count", 0)
            snapshots = get(result, "snapshots", [])
            
            println("   🔍 Analyzing run for $entity_count entities...")
            analysis, anomalies, recommendations = analyze_with_learning(optimizer, snapshots, entity_count)
            
            if get(analysis, "status", "success") != "insufficient_data"
                push!(all_analyses, analysis)
                append!(all_anomalies, anomalies)
                append!(all_recommendations, recommendations)
                
                # Update knowledge base with this analysis
                update_pattern_knowledge(optimizer, analysis, anomalies)
            else
                println("     ⚠️  Insufficient data for $entity_count entities, skipping.")
            end
        end
        
        # Create comprehensive learning report
        report_filename = "learning_calculus_report_$(Dates.format(now(), "yyyymmdd_HHMMSS")).json"
        open(report_filename, "w") do f
            JSON.print(f, Dict(
                "timestamp" => string(Dates.now()),
                "analysis_version" => "4.0-self-learning-tunable",
                "learning_summary" => Dict(
                    "knowledge_maturity" => optimizer.knowledge_base["knowledge_maturity"],
                    "total_anomalies_this_run" => length(all_anomalies),
                    "total_recommendations" => length(all_recommendations)
                ),
                "all_entity_analyses" => all_analyses,
                "detected_anomalies_summary" => all_anomalies,
                "final_recommendations" => all_recommendations,
                "knowledge_base_snapshot" => optimizer.knowledge_base
            ), 4)
        end
        
        # Save updated knowledge base for the next run
        save_knowledge_base(optimizer)
        
        println("✅ SELF-LEARNING ANALYSIS COMPLETE")
        println("   📁 Report saved: $report_filename")
        println("   🧠 Anomalies detected: $(length(all_anomalies))")
        println("   🎯 Recommendations generated: $(length(all_recommendations))")
        println("   📈 New knowledge maturity: $(round(optimizer.knowledge_base["knowledge_maturity"] * 100, digits=1))%")
        
        return true
        
    catch e
        println("❌ Learning analysis failed (non-critical): $e")
        showerror(stdout, e, catch_backtrace())
        return false
    end
end

# Keep this for integration
function integrate_with_main_orchestrator()
    println("\n" * "="^70)
    println("🧮 INITIATING SELF-LEARNING CALCULUS OPTIMIZATION (v2.0)")
    println("   🔒 LIVE SYSTEM COMPLETED - ANALYSIS ONLY")
    println("="^70)
    
    optimizer = LearningCalculusOptimizer()
    success = run_learning_calculus_analysis(optimizer)
    
    if success
        println("🎉 SELF-LEARNING OPTIMIZATION COMPLETE")
    else
        println("⚠️  Learning analysis skipped or failed. Main system results are safe.")
    end
    
    return success
end

# Keep this for standalone execution
if abspath(PROGRAM_FILE) == @__FILE__
    println("🧮 SELF-LEARNING CALCULUS OPTIMIZER - STANDALONE MODE")
    optimizer = LearningCalculusOptimizer()
    run_learning_calculus_analysis(optimizer)
end
