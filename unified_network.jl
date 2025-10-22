# unified_network.jl
"""
🌐 UNIFIED NETWORK MODULE (REFACTORED)
Orchestrates all intelligence components into a unified, modular system.
"""

using Statistics
using LinearAlgebra

# ==============================================================================
# 1. CORE DATA STRUCTURE AND SETUP
# The UnifiedNetwork struct and its setup functions.
# ==============================================================================

safe_divide(a, b) = b == 0 ? 0.0 : a / b

mutable struct UnifiedNetwork
    entities::Vector{EfficientEntity}
    consciousness_validator::ConsciousnessValidator
    reasoning_engine::GeometricReasoningEngine
    awareness_monitor::AwarenessMonitor
    proto_intelligence::ProtoIntelligence
    coherence_history::Vector{Float64}
    insight_history::Vector{Dict{String,Any}}
    coupling_matrix::Matrix{Float64}
    effective_information::Vector{Float64}
    
    function UnifiedNetwork()
        new(
            EfficientEntity[],
            ConsciousnessValidator(),
            GeometricReasoningEngine(4),
            AwarenessMonitor(),
            ProtoIntelligence(),
            Float64[],
            Dict{String,Any}[],
            zeros(0, 0),
            Float64[]
        )
    end
end

function add_entity!(network::UnifiedNetwork, entity::EfficientEntity)
    push!(network.entities, entity)
    n = length(network.entities)
    
    # In-place resizing is complex; recreating the matrix is clear for this use case.
    new_coupling_matrix = zeros(n, n)
    if n > 1
        old_size = size(network.coupling_matrix, 1)
        if old_size > 0
            new_coupling_matrix[1:old_size, 1:old_size] = network.coupling_matrix
        end
        
        last_entity = network.entities[n]
        for i in 1:(n-1)
            strength = network.entities[i].domain == last_entity.domain ? 0.08 : 0.04
            new_coupling_matrix[i, n] = strength
            new_coupling_matrix[n, i] = strength
        end
    end
    network.coupling_matrix = new_coupling_matrix
end

# ==============================================================================
# 2. REFACTORED EVOLUTION STEP
# `evolve_step!` is now a clean orchestrator that delegates tasks.
# ==============================================================================

function _evolve_entity_phases!(network::UnifiedNetwork)
    entity_phases = [e.phase for e in network.entities]
    for entity in network.entities
        evolve_phase!(entity)
        kuramoto_coupling!(entity, entity_phases, network.coupling_matrix)
    end
end

function _update_reasoning_and_awareness!(network::UnifiedNetwork)
    # Update reasoning capacity periodically
    if mod(length(network.coherence_history), 8) == 0 && !isempty(network.entities)
        reasoning_score = test_geometric_reasoning(network.reasoning_engine, 12)
        # Pass score directly for clarity and to avoid action-at-a-distance
        _update_reasoning_capacity!(network, reasoning_score)
    end

    # Update awareness for all entities based on current network state
    current_phases = [e.phase for e in network.entities]
    update_awareness(network.awareness_monitor, current_phases)
    awareness_level = get_awareness_level(network.awareness_monitor)
    for entity in network.entities
        entity.awareness_level = 0.8 * entity.awareness_level + 0.2 * awareness_level
    end
end

function _update_reasoning_capacity!(network::UnifiedNetwork, score::Float64)
    if score > 0.0
        for entity in network.entities
            # Exponential moving average for smooth learning
            entity.reasoning_capacity = 0.7 * entity.reasoning_capacity + 0.3 * score
            entity.reasoning_capacity = clamp(entity.reasoning_capacity, 0.0, 1.0)
        end
    end
end

function _generate_and_process_insights!(network::UnifiedNetwork)
    current_phases = [e.phase for e in network.entities]
    new_insights = Dict{String,Any}[]
    
    for entity in network.entities
        insight = generate_insight(entity, current_phases)
        if !isempty(insight)
            push!(new_insights, insight)
        end
    end

    append!(network.insight_history, new_insights)
    
    # Return count of new insights and patterns for the step result
    new_pattern_count = recognize_emergent_patterns(network.proto_intelligence, new_insights)
    return length(new_insights), new_pattern_count
end

"""
The main orchestrator for a single time step in the simulation.
Delegates to focused helper functions to keep complexity low.
"""
function evolve_step!(network::UnifiedNetwork)::Dict{String,Any}
    _evolve_entity_phases!(network)
    _update_reasoning_and_awareness!(network)
    
    insight_count, new_patterns = _generate_and_process_insights!(network)
    
    # Calculate and store summary metrics for the step
    current_phases = [e.phase for e in network.entities]
    coherence = calculate_phase_coherence(current_phases)
    push!(network.coherence_history, coherence)
    
    ei = calculate_effective_information(network)
    push!(network.effective_information, ei)
    
    # Compile results for this step
    reasoning_history = network.reasoning_engine.reasoning_history
    last_reasoning_acc = isempty(reasoning_history) ? 0.0 : last(reasoning_history)
    
    return Dict(
        "insights" => insight_count,
        "new_patterns" => new_patterns,
        "coherence" => coherence,
        "awareness" => get_awareness_level(network.awareness_monitor),
        "reasoning_accuracy" => last_reasoning_acc,
        "effective_information" => ei
    )
end

# ==============================================================================
# 3. REFACTORED METRICS CALCULATION
# `calculate_unified_metrics` is now a clean orchestrator for metrics.
# ==============================================================================

function _calculate_insight_metrics(insight_history::Vector{Dict{String,Any}})
    if isempty(insight_history)
        return Dict("quality"=>0.0, "diversity"=>0.0, "cross_domain"=>0.0, "reasoning_int"=>0.0, "awareness_int"=>0.0)
    end
    
    recent_insights = insight_history[max(1, end-9):end]
    len_recent = length(recent_insights)
    
    quality = safe_divide(count(i -> get(i, "action_complexity", 1) >= 2, recent_insights), len_recent)
    diversity = safe_divide(length(unique(get.(recent_insights, "action", ""))), len_recent)
    
    cross_domain_actions = ["coordinate", "sync", "integrate", "synthesize"]
    cross_domain_count = count(i -> any(term -> occursin(term, lowercase(get(i, "action", ""))), cross_domain_actions), recent_insights)
    cross_domain = safe_divide(cross_domain_count, len_recent)
    
    reasoning_int = safe_divide(count(i -> get(i, "reasoning_enhanced", false), recent_insights), len_recent)
    awareness_int = safe_divide(count(i -> get(i, "awareness_enhanced", false), recent_insights), len_recent)
    
    return Dict(
        "quality" => quality, "diversity" => diversity, "cross_domain" => cross_domain,
        "reasoning_int" => reasoning_int, "awareness_int" => awareness_int
    )
end

function _calculate_learning_velocity(coherence_history::Vector{Float64})
    if length(coherence_history) < 10 return 0.0 end
    
    recent_coh = mean(coherence_history[end-4:end])
    earlier_coh = mean(coherence_history[end-9:end-5])
    return recent_coh - earlier_coh
end

"""
Calculates a comprehensive set of metrics about the network's current state.
Delegates complex sub-calculations to helper functions.
"""
function calculate_unified_metrics(network::UnifiedNetwork)::Dict{String,Any}
    # --- Delegate Sub-calculations ---
    insight_metrics = _calculate_insight_metrics(network.insight_history)
    learning_velocity = _calculate_learning_velocity(network.coherence_history)
    
    # --- Gather Raw Metrics ---
    coherence = isempty(network.coherence_history) ? 0.0 : last(network.coherence_history)
    effective_info = isempty(network.effective_information) ? 0.0 : last(network.effective_information)
    reasoning_history = network.reasoning_engine.reasoning_history
    reasoning_accuracy = isempty(reasoning_history) ? 0.0 : mean(reasoning_history[max(1, end-4):end])
    awareness_level = get_awareness_level(network.awareness_monitor)
    proto_iq = calculate_proto_intelligence(network.proto_intelligence)

    # --- Calculate Primary Metrics ---
    consciousness = assess_consciousness(
        network.consciousness_validator,
        length(network.entities), coherence, length(network.insight_history),
        insight_metrics["quality"], insight_metrics["cross_domain"], effective_info
    )

    unified_intelligence = (
        get(consciousness, "max_phi", 0.0) * 0.25 +
        reasoning_accuracy * 0.25 +
        awareness_level * 0.20 +
        (proto_iq / 100) * 0.15 + # Normalize proto_iq
        insight_metrics["quality"] * 0.15
    )
    unified_intelligence = isfinite(unified_intelligence) ? unified_intelligence : 0.0

    # --- Assemble Final Dictionary ---
    return Dict(
        "entity_count" => length(network.entities),
        "coherence" => round(coherence, digits=4),
        "total_insights" => length(network.insight_history),
        "consciousness" => consciousness,
        "reasoning_accuracy" => round(reasoning_accuracy, digits=4),
        "reasoning_integration" => round(insight_metrics["reasoning_int"], digits=4),
        "awareness_level" => round(awareness_level, digits=4),
        "awareness_stability" => round(get_awareness_stability(network.awareness_monitor), digits=4),
        "awareness_integration" => round(insight_metrics["awareness_int"], digits=4),
        "proto_intelligence" => round(proto_iq, digits=4),
        "insight_quality" => round(insight_metrics["quality"], digits=4),
        "insight_diversity" => round(insight_metrics["diversity"], digits=4),
        "cross_domain_ratio" => round(insight_metrics["cross_domain"], digits=4),
        "learning_velocity" => round(learning_velocity, digits=4),
        "unified_intelligence_score" => round(unified_intelligence, digits=4),
        "pattern_discoveries" => network.proto_intelligence.discovery_count,
        "effective_information" => round(effective_info, digits=4)
    )
end

# The phase coherence function is a utility and can remain top-level
function calculate_phase_coherence(phases::Vector{Float64})::Float64
    if isempty(phases) return 0.0 end
    # Note: Original code had phases from 0 to 1, this assumes 0 to 2π. If phases are 0-1, remove 2π.
    complex_phases = exp.(im .* phases) 
    return abs(mean(complex_phases))
end
