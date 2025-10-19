# awareness_monitor.jl
"""
👁️ AWARENESS MONITOR MODULE
Dimensional state monitoring and awareness tracking
"""

using Statistics

include("utils.jl")
using .Utils: calculate_phase_coherence

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
            am.awareness_s
