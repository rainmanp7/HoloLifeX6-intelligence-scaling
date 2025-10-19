# geometric_reasoning.jl - DEBUG VERSION
using LinearAlgebra
using Random
using Statistics

mutable struct GeometricReasoningEngine
    dimensions::Int
    weights_input::Matrix{Float64}
    weights_hidden::Matrix{Float64}
    weights_output::Matrix{Float64}
    reasoning_history::Vector{Float64}
    learning_rate::Float64
    exploration_rate::Float64
    debug_scores::Vector{Float64}  # Track actual scores
    
    function GeometricReasoningEngine(dimensions::Int=4)
        weights_input = randn(dimensions, 8) * 0.1
        weights_hidden = randn(8, 4) * 0.1  
        weights_output = randn(4, 1) * 0.1
        
        new(dimensions, weights_input, weights_hidden, weights_output, Float64[], 0.01, 0.2, Float64[])
    end
end

function generate_geometric_problem(re::GeometricReasoningEngine, num_points::Int=8)
    cluster_centers = randn(3, re.dimensions) * 2.0
    X = zeros(num_points, re.dimensions)
    cluster_assignments = Int[]
    
    for i in 1:num_points
        cluster_idx = rand(1:3)
        push!(cluster_assignments, cluster_idx)
        noise_scale = 0.3 + 0.2 * sin(i * π / 4)
        X[i, :] = cluster_centers[cluster_idx, :] + randn(re.dimensions) * noise_scale
    end
    
    cluster_sizes = [sum(cluster_assignments .== i) for i in 1:3]
    largest_cluster = argmax(cluster_sizes)
    cluster_points = X[cluster_assignments .== largest_cluster, :]
    centroid = mean(cluster_points, dims=1)
    
    distances = [norm(X[i, :] - centroid) for i in 1:num_points]
    true_min_idx = argmin(distances)
    
    return X, true_min_idx, cluster_assignments
end

function neural_forward_pass(re::GeometricReasoningEngine, X::Matrix{Float64})
    num_points = size(X, 1)
    scores = zeros(num_points)
    
    for i in 1:num_points
        input_vec = X[i, :]
        
        # Forward pass through network
        hidden1 = max.(0.0, re.weights_input' * input_vec)
        hidden2 = max.(0.0, re.weights_hidden' * hidden1)
        scores[i] = (re.weights_output' * hidden2)[1]
    end
    
    return scores
end

function solve_geometric_problem(re::GeometricReasoningEngine, X::Matrix{Float64})
    num_points = size(X, 1)
    
    try
        if num_points == 0
            return 1
        end
        
        # Get neural network scores
        neural_scores = neural_forward_pass(re, X)
        
        # Simple selection - always choose minimum score
        return argmin(neural_scores)
        
    catch e
        # Fallback
        distances = [norm(X[i, :]) for i in 1:num_points]
        return argmin(distances)
    end
end

function test_geometric_reasoning(re::GeometricReasoningEngine, num_trials::Int=20)
    correct = 0
    total_trials = 0
    
    println("🧠 GEOMETRIC REASONING DEBUG:")
    
    for trial in 1:num_trials
        try
            X, true_answer, clusters = generate_geometric_problem(re, 8)
            prediction = solve_geometric_problem(re, X)
            
            # Simple learning: just track accuracy
            if prediction == true_answer
                correct += 1
                println("  ✅ Trial $trial: CORRECT (predicted $prediction, true $true_answer)")
            else
                println("  ❌ Trial $trial: WRONG (predicted $prediction, true $true_answer)")
            end
            
            total_trials += 1
            
        catch e
            println("  💥 Trial $trial: ERROR - $e")
        end
    end
    
    accuracy = total_trials > 0 ? correct / total_trials : 0.0
    println("  📊 Final Accuracy: $accuracy")
    
    # Store the result
    push!(re.reasoning_history, accuracy)
    push!(re.debug_scores, accuracy)
    
    # Keep history manageable
    if length(re.reasoning_history) > 100
        re.reasoning_history = re.reasoning_history[end-99:end]
    end
    
    return accuracy
end
