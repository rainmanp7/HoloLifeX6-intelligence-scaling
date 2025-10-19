# unified_network.jl
"""
🌐 UNIFIED NETWORK MODULE
Orchestrates all intelligence components into a unified system.
This version is designed for a multi-file project and does not redefine components.
"""

using Statistics
using LinearAlgebra

# This utility function might be useful if not defined elsewhere
safe_divide(num, den) = den == 0 ? 0.0 : num / den

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
        entities = EfficientEntity[]
        validator = ConsciousnessValidator()
        reasoning_engine = GeometricReasoningEngine(4)
        awareness_monitor = AwarenessMonitor()
        proto_intelligence = ProtoIntelligence()
        
        coupling_matrix = zeros(0, 0)
        effective_information = Float64[]
        
        new(entities, validator, reasoning_engine, awareness_monitor, 
            proto_intelligence, Float64[], Dict{String,Any}[], 
            coupling_matrix, effective_information)
    end
end

function add_entity!(network::UnifiedNetwork, entity::EfficientEntity)
    push!(network.entities, entity)
    n = length(network.entities)
    new_coupling_matrix = zeros(n, n)
    
    if n > 1
        old_size = size(network.coupling_matrix, 1)
        if old_size > 0
            new_coupling_matrix[1:old_size, 1:old_size] = network.coupling_matrix
        end
        
        # Assuming entity has an `id` field for correct indexing
        last_entity = network.entities[n]
        for i in 1:n-1
            strength = network.entities[i].domain == last_entity.domain ? 0.08 : 0.04
            new_coupling_matrix[i, n] = strength
            new_coupling_matrix[n, i] = strength
        end
    end
    
    network.coupling_matrix = new_coupling_matrix
end

# ⭐ FIX 1: Refactored function for clearer logic. Pass the score directly.
function update_reasoning_capacity!(network::UnifiedNetwork, recent_reasoning_score::Float64)
    if recent_reasoning_score > 0.0
        for entity in network.entities
            # Exponential moving average for learning
            entity.reasoning_capacity = 0.7 * entity.reasoning_capacity + 0.3 * recent_reasoning_score
            # Ensure it stays in valid range [0, 1]
            entity.reasoning_capacity = clamp(entity.reasoning_capacity, 0.0, 1.0)
        end
    end
end

function evolve_step!(network::UnifiedNetwork)::Dict{String,Any}
    insights = Dict{String,Any}[]
    # This assumes entities have a stable `id` field for matrix indexing
    entity_phases = [e.phase for e in network.entities]
    
    for entity in network.entities
        evolve_phase!(entity)
        kuramoto_coupling!(entity, entity_phases, network.coupling_matrix)
    end
    
    # ⭐ FIX 1 (continued): Use the refactored update function
    if length(network.coherence_history) % 8 == 0 && !isempty(network.entities)
        reasoning_score = test_geometric_reasoning(network.reasoning_engine, 12)
        update_reasoning_capacity!(network, reasoning_score) # Pass the score directly
    end
    
    current_phases = [e.phase for e in network.entities]
    update_awareness(network.awareness_monitor, current_phases)
    awareness_level = get_awareness_level(network.awareness_monitor)
    
    for entity in network.entities
        entity.awareness_level = 0.8 * entity.awareness_level + 0.2 * awareness_level
    end
    
    for entity in network.entities
        # ⭐ FIX 2: This relies on your external `generate_insight` function now producing the correct keys.
        insight = generate_insight(entity, current_phases)
        if !isempty(insight)
            push!(insights, insight)
            push!(network.insight_history, insight)
        end
    end
    
    new_patterns = recognize_emergent_patterns(network.proto_intelligence, insights)
    coherence = calculate_phase_coherence(current_phases)
    push!(network.coherence_history, coherence)
    
    ei = calculate_effective_information(network)
    push!(network.effective_information, ei)
    
    reasoning_accuracy = isempty(network.reasoning_engine.reasoning_history) ? 
                        0.0 : network.reasoning_engine.reasoning_history[end]
    
    return Dict(
        "insights" => length(insights),
        "new_patterns" => new_patterns,
        "coherence" => coherence,
        "awareness" => awareness_level,
        "reasoning_accuracy" => reasoning_accuracy,
        "effective_information" => ei
    )
end

function calculate_unified_metrics(network::UnifiedNetwork)::Dict{String,Any}
    entity_count = length(network.entities)
    total_insights = length(network.insight_history)
    coherence = isempty(network.coherence_history) ? 0.0 : network.coherence_history[end]
    effective_info = isempty(network.effective_information) ? 0.0 : network.effective_information[end]
    
    insight_quality, insight_diversity, cross_domain_ratio = 0.0, 0.0, 0.0
    reasoning_integration, awareness_integration = 0.0, 0.0
    
    if !isempty(network.insight_history)
        recent = length(network.insight_history) >= 10 ? 
                 network.insight_history[end-9:end] : network.insight_history
        
        if !isempty(recent)
            high_complexity = count(i -> get(i, "action_complexity", 1) >= 2, recent)
            insight_quality = safe_divide(high_complexity, length(recent))
            
            unique_actions = length(unique([get(i, "action", "") for i in recent]))
            insight_diversity = safe_divide(unique_actions, length(recent))
            
            cross_domain_actions = ["coordinate", "sync", "balance", "integrate", "synthesize"]
            cross_domain_count = count(i -> any(term -> occursin(term, lowercase(get(i, "action", ""))), cross_domain_actions), recent)
            cross_domain_ratio = safe_divide(cross_domain_count, length(recent))
            
            reasoning_enhanced_count = count(i -> get(i, "reasoning_enhanced", false), recent)
            reasoning_integration = safe_divide(reasoning_enhanced_count, length(recent))
            
            awareness_enhanced_count = count(i -> get(i, "awareness_enhanced", false), recent)
            awareness_integration = safe_divide(awareness_enhanced_count, length(recent))
        end
    end
    
    consciousness = assess_consciousness(
        network.consciousness_validator,
        entity_count, coherence, total_insights,
        insight_quality, cross_domain_ratio, effective_info
    )
    
    reasoning_accuracy = isempty(network.reasoning_engine.reasoning_history) ? 
                        0.0 : mean(network.reasoning_engine.reasoning_history[max(1, end-4):end])
    
    awareness_level = get_awareness_level(network.awareness_monitor)
    awareness_stability = get_awareness_stability(network.awareness_monitor)
    
    proto_iq = calculate_proto_intelligence(network.proto_intelligence)
    
    learning_velocity = 0.0
    if length(network.coherence_history) >= 10
        recent_coh = mean(network.coherence_history[max(1, end-4):end])
        earlier_coh = mean(network.coherence_history[max(1, end-9):max(1, end-5)])
        learning_velocity = recent_coh - earlier_coh
    end
    
    unified_intelligence = (
        get(consciousness, "max_phi", 0.0) * 0.25 +
        reasoning_accuracy * 0.25 +
        awareness_level * 0.20 +
        (proto_iq / 100) * 0.15 + # Normalize proto_iq from a base of 100
        insight_quality * 0.15
    )
    
    unified_intelligence = isfinite(unified_intelligence) ? unified_intelligence : 0.0
    
    # Renamed some keys for clarity
    return Dict(
        "entity_count" => entity_count,
        "coherence" => round(coherence, digits=4),
        "total_insights" => total_insights,
        "consciousness_phi" => round(get(consciousness, "max_phi", 0.0), digits=4),
        "reasoning_accuracy" => round(reasoning_accuracy, digits=4),
        "reasoning_integration" => round(reasoning_integration, digits=4),
        "awareness_level" => round(awareness_level, digits=4),
        "awareness_stability" => round(awareness_stability, digits=4),
        "awareness_integration" => round(awareness_integration, digits=4),
        "proto_intelligence_iq" => round(proto_iq, digits=4),
        "insight_quality" => round(insight_quality, digits=4),
        "insight_diversity" => round(insight_diversity, digits=4),
        "cross_domain_ratio" => round(cross_domain_ratio, digits=4),
        "learning_velocity" => round(learning_velocity, digits=4),
        "effective_information" => round(effective_info, digits=4),
        "UNIFIED_INTELLIGENCE_SCORE" => round(unified_intelligence, digits=4)
    )
end
