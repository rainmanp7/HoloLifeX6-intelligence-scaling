# geometric_reasoning.jl - v2.0 with RNG Isolation
"""
🎯 BASIC GEOMETRIC REASONING MODULE
v2.0: Implemented RNG isolation for scientific reproducibility.
"""

using LinearAlgebra
using Random

mutable struct GeometricReasoningEngine
    dimensions::Int
    reasoning_history::Vector{Float64}
    
    function GeometricReasoningEngine(dimensions::Int=4)
        new(dimensions, Float64[])
    end
end

# --- STEP 2: MODIFY this helper function to accept `rng` ---
# We put `rng` before the optional `num_points` argument.
function generate_geometric_problem(re::GeometricReasoningEngine, rng::AbstractRNG, num_points::Int=8)
    # Simple: random points in unit cube
    # --- STEP 3: USE the private `rng` object ---
    X = rand(rng, num_points, re.dimensions)
    
    # Simple problem: find point closest to origin
    distances = [norm(X[i, :]) for i in 1:num_points]
    true_min_idx = argmin(distances)
    
    return X, true_min_idx, ones(Int, num_points)  # dummy clusters
end

function solve_geometric_problem(re::GeometricReasoningEngine, X::Matrix{Float64})
    # This function is deterministic (no randomness), so it does not need changes.
    num_points = size(X, 1)
    distances = [norm(X[i, :]) for i in 1:num_points]
    return argmin(distances)
end

# --- STEP 1: MODIFY the main entry point to accept `rng` ---
function test_geometric_reasoning(re::GeometricReasoningEngine, num_trials::Int, rng::AbstractRNG)
    correct = 0
    
    for trial in 1:num_trials
        try
            # --- STEP 4: PASS the `rng` object down to the helper function ---
            X, true_answer, clusters = generate_geometric_problem(re, rng)
            prediction = solve_geometric_problem(re, X)
            
            if prediction == true_answer
                correct += 1
            end
        catch e
            # Count errors as wrong
        end
    end
    
    accuracy = num_trials > 0 ? correct / num_trials : 0.0
    push!(re.reasoning_history, accuracy)
    
    # 🎯 DEBUG OUTPUT
    # This can be noisy, so I'll comment it out, but you can re-enable it.
    # println("🔍 GEOMETRIC DEBUG: $correct/$num_trials correct = $accuracy")
    
    return accuracy
end
