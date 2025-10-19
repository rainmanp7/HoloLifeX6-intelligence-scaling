# utils.jl
"""
🛠️ UTILS MODULE
Shared utility functions for all modules
"""

module Utils
    export safe_divide, calculate_phase_coherence
    
    function safe_divide(a, b)
        return b == 0 ? 0.0 : a / b
    end
    
    function calculate_phase_coherence(phases::Vector{Float64})::Float64
        if isempty(phases)
            return 0.0
        end
        
        complex_phases = exp.(2π * im .* phases)
        order_parameter = abs(mean(complex_phases))
        return order_parameter
    end
    
    function safe_log(x)
        return x <= 0 ? 0.0 : log(x + 1.0)
    end
end