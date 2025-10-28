# calculus_optimizer.jl
"""
🧮 SELF-LEARNING CALCULUS OPTIMIZER v4.0
v4.0: Rearchitected for memory-efficient, streaming analysis to support large-scale runs.
"""

using JSON
using Dates
using LinearAlgebra
using Statistics

mutable struct LearningCalculusOptimizer
    knowledge_base::Dict{String, Any}
    # These now live here to aggregate results before the final report
    all_entity_analyses::Vector{Dict{String, Any}}
    all_anomalies::Vector{Dict{String, Any}}
    all_recommendations::Vector{Dict{String, Any}}
    
    function LearningCalculusOptimizer()
        knowledge = load_knowledge_base()
        # Initialize empty vectors for aggregation
        new(knowledge, [], [], [])
    end
end

# --- load_knowledge_base, save_knowledge_base, safe_derivative, extract_consciousness_dataUNCHANGED ---
# (These functions are fine and don't need modification)
function load_knowledge_base()::Dict{String, Any}
    knowledge_file = "calculus_knowledge_base.json"
    if isfile(knowledge_file); try; return JSON.parsefile(knowledge_file); catch e; println("⚠️ Could not load knowledge base, creating new: $e"); end; end
    return Dict("version" => "2.0-tunable", "created" => string(Dates.now()), "consciousness_patterns" => Dict("consciousness_collapse" => Dict("description" => "Sharp drop after peak...", "peak_phi_threshold" => 0.2, "drop_ratio_threshold" => 0.7, "detection_count" => 0, "historical_drops" => []), "meta_cognitive_instability" => Dict("description" => "High volatility in meta-cognitive scores...", "volatility_threshold" => 0.15, "detection_count" => 0), "persistent_decline" => Dict("description" => "More negative than positive derivatives...", "negative_derivative_threshold" => -0.05, "positive_derivative_threshold" => 0.05, "neg_to_pos_ratio_threshold" => 2.0, "detection_count" => 0)), "meta_cognitive_insights" => Dict("optimal_range" => [0.2, 0.4], "volatility_issues" => [], "stability_correlations" => []), "entity_scaling_patterns" => Dict(), "total_analyses" => 0, "anomalies_detected_total" => 0, "knowledge_maturity" => 0.0)
end
function save_knowledge_base(optimizer::LearningCalculusOptimizer)
    knowledge_file = "calculus_knowledge_base.json"; optimizer.knowledge_base["last_updated"] = string(Dates.now()); optimizer.knowledge_base["total_analyses"] += 1; total_analyses = optimizer.knowledge_base["total_analyses"]; optimizer.knowledge_base["knowledge_maturity"] = min(1.0, total_analyses / 25.0); open(knowledge_file, "w") do f; JSON.print(f, optimizer.knowledge_base, 4); end; println("   💾 Knowledge base updated: $knowledge_file")
end
function safe_derivative(x::Vector{Float64}, y::Vector{Float64})::Vector{Float64}
    n = length(x); if n < 2 || length(y) != n; return zeros(n); end; derivatives = zeros(n); if n >= 2; dx = x[2] - x[1]; if dx > 0; derivatives[1] = (y[2] - y[1]) / dx; end; end; for i in 2:n-1; dx = x[i+1] - x[i-1]; if dx > 0; derivatives[i] = (y[i+1] - y[i-1]) / dx; else; dx_b = x[i] - x[i-1]; if dx_b > 0; derivatives[i] = (y[i] - y[i-1]) / dx_b; end; end; end; if n >= 2; dx = x[n] - x[n-1]; if dx > 0; derivatives[n] = (y[n] - y[n-1]) / dx; end; end; return derivatives
end
function extract_consciousness_data(snapshots::Vector{Dict{String,Any}})
    cycles, phi_values, intelligence_scores, meta_scores, coherence_values = Float64[], Float64[], Float64[], Float64[], Float64[]; for snapshot in snapshots; haskey(snapshot, "cycle") && push!(cycles, Float64(snapshot["cycle"])); if haskey(snapshot, "consciousness") && haskey(snapshot["consciousness"], "max_phi"); push!(phi_values, Float64(snapshot["consciousness"]["max_phi"])); end; haskey(snapshot, "unified_intelligence_score") && push!(intelligence_scores, Float64(snapshot["unified_intelligence_score"])); if haskey(snapshot, "consciousness") && haskey(snapshot["consciousness"], "hot_metrics") && haskey(snapshot["consciousness"]["hot_metrics"], "meta_cognitive_score"); push!(meta_scores, Float64(snapshot["consciousness"]["hot_metrics"]["meta_cognitive_score"])); end; haskey(snapshot, "coherence") && push!(coherence_values, Float64(snapshot["coherence"])); end; return (cycles, phi_values, intelligence_scores, meta_scores, coherence_values)
end
# (detect_consciousness_anomalies, update_pattern_knowledge, generate_learned_recommendations, analyze_with_learning are also unchanged)
function detect_consciousness_anomalies(optimizer::LearningCalculusOptimizer, analysis::Dict, entity_count::Int)
    anomalies, kb_patterns = [], optimizer.knowledge_base["consciousness_patterns"]; phi_values, derivatives, meta_scores = get(analysis, "phi_trajectory", []), get(analysis, "phi_derivatives", []), get(analysis, "meta_cognitive_trajectory", []); if length(phi_values) >= 3; p_collapse = kb_patterns["consciousness_collapse"]; final_phi, max_phi = phi_values[end], maximum(phi_values); if max_phi > p_collapse["peak_phi_threshold"] && final_phi < max_phi * p_collapse["drop_ratio_threshold"]; push!(anomalies, Dict("type" => "consciousness_collapse", "message" => "Consciousness dropped by >$(round((1-p_collapse["drop_ratio_threshold"])*100, digits=0))% after peaking above $(p_collapse["peak_phi_threshold"])", "details" => Dict("max_phi" => round(max_phi, digits=4), "final_phi" => round(final_phi, digits=4)), "recommendation" => "Investigate... late cycles.")); end; if length(meta_scores) >= 3; p_meta = kb_patterns["meta_cognitive_instability"]; meta_volatility = std(meta_scores); if meta_volatility > p_meta["volatility_threshold"]; push!(anomalies, Dict("type" => "meta_cognitive_instability", "message" => "Meta-cognitive volatility ($(round(meta_volatility, digits=3))) exceeds threshold ($(p_meta["volatility_threshold"])).", "details" => Dict("volatility" => round(meta_volatility, digits=4), "range" => [round(minimum(meta_scores), digits=3), round(maximum(meta_scores), digits=3)]), "recommendation" => "Implement smoothing...")); end; end; if length(derivatives) >= 3; p_decline = kb_patterns["persistent_decline"]; neg_derivs, pos_derivs = count(d -> d < p_decline["negative_derivative_threshold"], derivatives), count(d -> d > p_decline["positive_derivative_threshold"], derivatives); if pos_derivs > 0 && neg_derivs / pos_derivs > p_decline["neg_to_pos_ratio_threshold"]; push!(anomalies, Dict("type" => "persistent_decline", "message" => "Found $(neg_derivs) decline vs. $(pos_derivs) growth cycles.", "details" => Dict("neg_count" => neg_derivs, "pos_count" => pos_derivs, "ratio" => round(neg_derivs/pos_derivs, digits=2)), "recommendation" => "Check for systemic decay...")); end; end; end; return anomalies
end
function update_pattern_knowledge(optimizer::LearningCalculusOptimizer, analysis::Dict, anomalies::Vector)
    kb = optimizer.knowledge_base; for anomaly in anomalies; anomaly_type = get(anomaly, "type", ""); if haskey(kb["consciousness_patterns"], anomaly_type); kb["consciousness_patterns"][anomaly_type]["detection_count"] += 1; end; end; if any(a -> a["type"] == "consciousness_collapse", anomalies); max_phi, final_phi = get(analysis, "max_phi", 0.0), get(analysis, "final_phi", 0.0); if max_phi > 0; drop_ratio = final_phi / max_phi; push!(kb["consciousness_patterns"]["consciousness_collapse"]["historical_drops"], Dict("timestamp" => string(Dates.now()), "entity_count" => get(analysis, "entity_count", 0), "drop_ratio" => round(drop_ratio, digits=4))); end; end; entity_count = get(analysis, "entity_count", 0); if entity_count > 0; scaling_patterns = kb["entity_scaling_patterns"]; entity_key = string(entity_count); if !haskey(scaling_patterns, entity_key); scaling_patterns[entity_key] = []; end; push!(scaling_patterns[entity_key], Dict("timestamp" => string(Dates.now()), "final_phi" => get(analysis, "final_phi", 0.0), "max_phi" => get(analysis, "max_phi", 0.0), "volatility" => get(analysis, "phi_volatility", 0.0))); end; kb["anomalies_detected_total"] += length(anomalies)
end
function generate_learned_recommendations(optimizer::LearningCalculusOptimizer, analysis::Dict, anomalies::Vector)
    recommendations, kb = [], optimizer.knowledge_base; for anomaly in anomalies; push!(recommendations, Dict("priority" => "high", "source" => "current_run_anomaly", "type" => get(anomaly, "type", "unknown"), "action" => get(anomaly, "recommendation", "Review..."), "evidence" => get(anomaly, "message", "Pattern detected"))); end; if kb["total_analyses"] > 5; collapse_pattern = kb["consciousness_patterns"]["consciousness_collapse"]; if collapse_pattern["detection_count"] >= 3; push!(recommendations, Dict("priority" => "critical", "source" => "historical_pattern", "type" => "recurring_consciousness_collapse", "action" => "This is a systemic issue...", "evidence" => "Detected $(collapse_pattern["detection_count"]) collapse events...")); end; meta_pattern = kb["consciousness_patterns"]["meta_cognitive_instability"]; if meta_pattern["detection_count"] > kb["total_analyses"] * 0.4; push!(recommendations, Dict("priority" => "high", "source" => "historical_pattern", "type" => "persistent_meta_cognitive_instability", "action" => "The meta-cognitive scoring is fundamentally unstable...", "evidence" => "Detected in $(meta_pattern["detection_count"]) of $(kb["total_analyses"]) analyses.")); end; end; return recommendations
end
function analyze_with_learning(optimizer::LearningCalculusOptimizer, snapshots::Vector{Dict{String,Any}}, entity_count::Int)
    cycles, phi_values, _, meta_scores, _ = extract_consciousness_data(snapshots); if length(cycles) < 3; return Dict("status" => "insufficient_data"), [], []; end; phi_derivatives = safe_derivative(cycles, phi_values); total_phi_integral = isempty(cycles) ? 0.0 : sum((phi_values[i] + phi_values[i-1]) / 2 * (cycles[i] - cycles[i-1]) for i in 2:length(cycles)); analysis = Dict("entity_count" => entity_count, "cycles_analyzed" => length(cycles), "phi_trajectory" => phi_values, "meta_cognitive_trajectory" => meta_scores, "phi_derivatives" => phi_derivatives, "total_phi_integral" => total_phi_integral, "phi_volatility" => isempty(phi_derivatives) ? 0.0 : std(phi_derivatives), "average_phi_growth" => isempty(phi_derivatives) ? 0.0 : mean(phi_derivatives), "max_phi" => isempty(phi_values) ? 0.0 : maximum(phi_values), "final_phi" => isempty(phi_values) ? 0.0 : phi_values[end]); anomalies = detect_consciousness_anomalies(optimizer, analysis, entity_count); recommendations = generate_learned_recommendations(optimizer, analysis, anomalies); return analysis, anomalies, recommendations
end


# --- NEW FUNCTION for memory-efficient processing ---
function analyze_single_run_and_learn(optimizer::LearningCalculusOptimizer, result::Dict{String, Any})
    """Analyzes a single simulation result dictionary without reading from disk."""
    entity_count = get(result, "entity_count", 0)
    # The snapshots are already Dicts, no conversion needed when passed directly
    snapshots = get(result, "snapshots", [])
    
    println("   🧠 Learning Calculus: Analyzing results for $entity_count entities...")
    analysis, anomalies, recommendations = analyze_with_learning(optimizer, snapshots, entity_count)
    
    if get(analysis, "status", "success") != "insufficient_data"
        entity_analysis_report = Dict(
            "entity_count" => entity_count,
            "analysis" => analysis,
            "anomalies_detected" => length(anomalies),
            "recommendations" => recommendations,
            "consciousness_status" => get(get(result, "consciousness", Dict()), "is_conscious", false) ? "CONSCIOUS" : "DEVELOPING",
            "final_phi" => get(get(result, "consciousness", Dict()), "max_phi", 0.0)
        )
        # Aggregate results into the optimizer struct
        push!(optimizer.all_entity_analyses, entity_analysis_report)
        append!(optimizer.all_anomalies, anomalies)
        append!(optimizer.all_recommendations, recommendations)
        
        # Update knowledge base with this single analysis
        update_pattern_knowledge(optimizer, analysis, anomalies)
        println("      ...analysis complete. Knowledge updated.")
    else
        println("     ⚠️  Learning Calculus: Insufficient data for $entity_count entities, skipping.")
    end
end

# --- NEW FUNCTION for saving the final aggregated report ---
function finalize_and_save_report(optimizer::LearningCalculusOptimizer)
    """Saves the final aggregated report and knowledge base after all runs are analyzed."""
    if isempty(optimizer.all_entity_analyses)
        println("   💾 No calculus analyses were performed, skipping report.")
        return
    end

    report_filename = "learning_calculus_report_$(Dates.format(now(), "yyyymmdd_HHMMSS")).json"
    open(report_filename, "w") do f
        JSON.print(f, Dict(
            "timestamp" => string(Dates.now()),
            "analysis_version" => "4.0-streaming",
            "learning_summary" => Dict(
                "knowledge_maturity" => optimizer.knowledge_base["knowledge_maturity"],
                "total_anomalies_this_run" => length(optimizer.all_anomalies),
                "total_recommendations" => length(optimizer.all_recommendations)
            ),
            "all_entity_analyses" => optimizer.all_entity_analyses,
            "detected_anomalies_summary" => optimizer.all_anomalies,
            "final_recommendations" => optimizer.all_recommendations,
            "knowledge_base_snapshot" => optimizer.knowledge_base
        ), 4)
    end
    
    # Save the updated knowledge base for the next orchestrator run
    save_knowledge_base(optimizer)
    
    println("✅ LEARNING CALCULUS ANALYSIS COMPLETE")
    println("   📁 Report saved: $report_filename")
    println("   🧠 Total anomalies detected: $(length(optimizer.all_anomalies))")
    println("   📈 New knowledge maturity: $(round(optimizer.knowledge_base["knowledge_maturity"] * 100, digits=1))%")
end

# The old entry point is now a legacy function for standalone use if needed
function run_legacy_file_analysis(optimizer::LearningCalculusOptimizer, intelligence_results_path::String="intelligence_results.json")
    # ... This would contain the old, inefficient file-based logic ...
    println("⚠️  This is a legacy function and is not memory-efficient for large files.")
end

# Export the new functions to be used by the orchestrator/tester
export LearningCalculusOptimizer, analyze_single_run_and_learn, finalize_and_save_report
