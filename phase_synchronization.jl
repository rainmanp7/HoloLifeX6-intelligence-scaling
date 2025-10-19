# phase_synchronization.jl
"""
🔄 PHASE SYNCHRONIZATION MODULE
Real Kuramoto model for entity synchronization
"""

using LinearAlgebra
using Random

mutable struct EfficientEntity
    entity_id::String
    domain::String
    base_frequency::Float64
    phase::Float64
    natural_frequency::Float64
    reasoning_capacity::Float64
    awareness_level::Float64
    coupling_strength::Float64
    phase_history::Vector{Float64}
    
    function EfficientEntity(entity_id::String, domain::String, base_frequency::Float64=0.02)
        natural_freq = 0.01 + rand() * 0.03  # Unique natural frequency
        new(entity_id, domain, base_frequency, rand(), natural_freq, 0.5, 0.5, 0.05, Float64[])
    end
end

function evolve_phase!(entity::EfficientEntity)
    # Real phase evolution with natural frequency
    entity.phase = mod(entity.phase + entity.natural_frequency, 1.0)
    push!(entity.phase_history, entity.phase)
    if length(entity.phase_history) > 100
        entity.phase_history = entity.phase_history[end-99:end]
    end
end

function kuramoto_coupling!(entity::EfficientEntity, network_phases::Vector{Float64}, coupling_matrix::Matrix{Float64})
    # Real Kuramoto model coupling
    if isempty(network_phases)
        return
    end
    
    # Extract entity index safely
    entity_parts = split(entity.entity_id, "-")
    entity_idx = 1
    try
        if length(entity_parts) >= 2
            entity_idx = parse(Int, entity_parts[end])
        end
    catch
        entity_idx = 1
    end
    
    phase_sum = 0.0
    weight_sum = 0.0
    n_entities = length(network_phases)
    
    for j in 1:n_entities
        if j != entity_idx && j <= size(coupling_matrix, 2) && entity_idx <= size(coupling_matrix, 1)
            coupling_strength = coupling_matrix[entity_idx, j]
            phase_diff = network_phases[j] - entity.phase
            phase_sum += coupling_strength * sin(2π * phase_diff)
            weight_sum += coupling_strength
        end
    end
    
    if weight_sum > 0
        entity.phase += entity.coupling_strength * (phase_sum / weight_sum)
        entity.phase = mod(entity.phase, 1.0)
    end
end
