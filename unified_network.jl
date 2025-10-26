# unified_network.jl
"""
🌐 UNIFIED NETWORK MODULE
Orchestrates all intelligence components into unified system
"""

using Statistics
using LinearAlgebra

safe_divide(a, b) = b == 0 ? 0.0 : a / b

function calculate_phase_coherence(phases::Vector{Float64})::Float64
    if isempty(phases)
        return 0.0
    end
    complex_phases = exp.(2π * im .* phases)
    return abs(mean(complex_phases))
end

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
        
        # Initialize with empty coupling matrix (will be resized)
        coupling_matrix = zeros(0, 0)
        effective_information = Float64[]
        
        new(entities, validator, reasoning_engine, awareness_monitor, 
            proto_intelligence, Float64[], Dict{String,Any}[], 
            coupling_matrix, effective_information)
    end
end

function add_entity!(network::UnifiedNetwork, entity::EfficientEntity)
    push!(network.entities, entity)
    # Update coupling matrix with new entity
    n = length(network.entities)
    new_coupling_matrix = zeros(n, n)
    
    if n > 1
        # Copy old matrix and add new row/column
        old_size = size(network.coupling_matrix, 1)
        if old_size > 0
            new_coupling_matrix[1:old_size, 1:old_size] = network.coupling_matrix
        end
        
        # Initialize new couplings based on domain similarity
        for i in 1:n
            if i != n
                # Coupling strength based on domain compatibility
                strength = network.entities[i].domain == entity.domain ? 0.08 : 0.04
                new_coupling_matrix[i, n] = strength
                new_coupling_matrix[n, i] = strength
            end
        end
    end
    
    network.coupling_matrix = new_coupling_matrix
end

# 🎯 CRITICAL FIX: Add reasoning capacity update function
function update_reasoning_capacity!(network::UnifiedNetwork)
    # Only update if we have recent reasoning results
    if !isempty(network.reasoning_engine.reasoning_history)
        recent_reasoning = network.reasoning_engine.reasoning_history[end]
        
        # Only update if we have meaningful reasoning scores
        if recent_reasoning > 0.0
            for entity in network.entities
                # Real learning: entities improve reasoning based on network performance
                entity.reasoning_capacity = 0.7 * entity.reasoning_capacity + 0.3 * recent_reasoning
                # Ensure it stays in valid range
                entity.reasoning_capacity = max(0.0, min(1.0, entity.reasoning_capacity))
            end
        end
    end
end

function evolve_step!(network::UnifiedNetwork)::Dict{String,Any}
    insights = Dict{String,Any}[]
    entity_phases = [e.phase for e in network.entities]
    
    # Real phase evolution with Kuramoto coupling
    for entity in network.entities
        evolve_phase!(entity)
        kuramoto_coupling!(entity, entity_phases, network.coupling_matrix)
    end
    
    # 🎯 CRITICAL FIX: Update reasoning capacity with REAL geometric reasoning
    if length(network.coherence_history) % 8 == 0
        reasoning_score = test_geometric_reasoning(network.reasoning_engine, 12)
        update_reasoning_capacity!(network)  # Call the new function
    end
    
    # Update awareness with real phase coherence
    current_phases = [e.phase for e in network.entities]
    update_awareness(network.awareness_monitor, current_phases)
    awareness_level = get_awareness_level(network.awareness_monitor)
    
    for entity in network.entities
        entity.awareness_level = 0.8 * entity.awareness_level + 0.2 * awareness_level
    end
    
    # Generate insights with real network context
    for entity in network.entities
        insight = generate_insight(entity, current_phases)
        if !isempty(insight)
            push!(insights, insight)
            push!(network.insight_history, insight)
        end
    end
    
    # Real pattern recognition
    new_patterns = recognize_emergent_patterns(network.proto_intelligence, insights)
    
    # Calculate real coherence using order parameter
    coherence = calculate_phase_coherence(current_phases)
    push!(network.coherence_history, coherence)
    
    # Calculate real effective information
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

# 🎯 CRITICAL FIX: Updated signature to accept smoother
function calculate_unified_metrics(network::UnifiedNetwork, smoother::ConsciousnessSmoother)::Dict{String,Any}
    entity_count = length(network.entities)
    total_insights = length(network.insight_history)
    coherence = isempty(network.coherence_history) ? 0.5 : network.coherence_history[end]
    effective_info = isempty(network.effective_information) ? 0.0 : network.effective_information[end]
    
    insight_quality = 0.0
    insight_diversity = 0.0
    cross_domain_ratio = 0.0
    reasoning_integration = 0.0
    awareness_integration = 0.0
    
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
    
    # Calculate reasoning and awareness first (needed for adaptive thresholds)
    reasoning_accuracy = isempty(network.reasoning_engine.reasoning_history) ? 
                        0.0 : mean(network.reasoning_engine.reasoning_history[max(1, end-4):end])
    awareness_level = get_awareness_level(network.awareness_monitor)
    
    # 🎯 CRITICAL FIX: Pass smoother and system state for emergent recognition
    consciousness = assess_consciousness(
        smoother,  # Pass the smoother FIRST
        network.consciousness_validator,
        entity_count, coherence, total_insights,
        insight_quality, cross_domain_ratio, effective_info;
        awareness_level=awareness_level,
        reasoning_accuracy=reasoning_accuracy
    )
    
    awareness_stability = get_awareness_stability(network.awareness_monitor)
    
    proto_iq = calculate_proto_intelligence(network.proto_intelligence)
    
    learning_velocity = 0.0
    if length(network.coherence_history) >= 10
        recent_coh = mean(network.coherence_history[max(1, end-4):end])
        earlier_coh = mean(network.coherence_history[max(1, end-9):max(1, end-5)])
        learning_velocity = recent_coh - earlier_coh
    end
    
    unified_intelligence = (
        consciousness["max_phi"] * 0.25 +
        reasoning_accuracy * 0.25 +
        awareness_level * 0.20 +
        proto_iq * 0.15 +
        insight_quality * 0.15
    )
    
    unified_intelligence = isfinite(unified_intelligence) ? unified_intelligence : 0.0
    
    return Dict(
        "entity_count" => entity_count,
        "coherence" => round(coherence, digits=4),
        "total_insights" => total_insights,
        "consciousness" => consciousness,
        "reasoning_accuracy" => round(reasoning_accuracy, digits=4),
        "reasoning_integration" => round(reasoning_integration, digits=4),
        "awareness_level" => round(awareness_level, digits=4),
        "awareness_stability" => round(awareness_stability, digits=4),
        "awareness_integration" => round(awareness_integration, digits=4),
        "proto_intelligence" => round(proto_iq, digits=4),
        "insight_quality" => round(insight_quality, digits=4),
        "insight_diversity" => round(insight_diversity, digits=4),
        "cross_domain_ratio" => round(cross_domain_ratio, digits=4),
        "learning_velocity" => round(learning_velocity, digits=4),
        "unified_intelligence_score" => round(unified_intelligence, digits=4),
        "pattern_discoveries" => network.proto_intelligence.discovery_count,
        "effective_information" => round(effective_info, digits=4)
    )
end
