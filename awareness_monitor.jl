# awareness_monitor.jl
"""
👁️ AWARENESS MONITOR MODULE
Dimensional state monitoring and awareness tracking
"""

using Statistics

function calculate_phase_coherence(phases::Vector{Float64})::Float64
    if isempty(phases)
        return 0.0
    end
    complex_phases = exp.(2π * im .* phases)
    return abs(mean(complex_phases))
end

mutable struct AwarenessMonitor
    awareness_scores::Vector{Float64}
    
    AwarenessMonitor() = new(Float64[])
end

function update_awareness(am::AwarenessMonitor, entity_phases::Vector{Float64})
    if isempty(entity_phases)
        push!(am.awareness_scores, 0.5)
        return
    end
    
    try
        coherence = calculate_phase_coherence(entity_phases)
        awareness_score = coherence
        
        if length(am.awareness_scores) > 100
            am.awareness_scores = am.awareness_scores[end-99:end]
        end
        
        push!(am.awareness_scores, awareness_score)
    catch e
        push!(am.awareness_scores, 0.5)
    end
end

function get_awareness_level(am::AwarenessMonitor)::Float64
    scores = am.awareness_scores
    return isempty(scores) ? 0.5 : mean(scores[max(1, end-4):end])
end

function get_awareness_stability(am::AwarenessMonitor)::Float64
    scores = am.awareness_scores
    if length(scores) < 5
        return 0.0
    end
    recent = scores[max(1, end-4):end]
    return 1.0 - std(recent)
end
