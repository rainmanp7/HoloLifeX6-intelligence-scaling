# geometric_reasoning.jl - SIMPLIFIED WORKING VERSION
using LinearAlgebra
using Random
using Statistics

mutable struct GeometricReasoningEngine
    dimensions::Int
    feature_weights::Matrix{Float64}  # Simple feature extractor
    decision_weights::Vector{Float64} # Simple decision maker
    reasoning_history::Vector{Float64}
    learning_rate::Float64
    
    function GeometricReasoningEngine(dimensions::Int=4)
        # Simple but effective weights
        feature_weights = randn(dimensions, 4) * 0.1
        decision_weights = randn(4) * 0.1
        new(dimensions, feature_weights, decision_weights, Float64[], 0.05)
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

function extract_features(re::GeometricReasoningEngine, X::Matrix{Float64})
    num_points = size(X, 1)
    features = zeros(num_points, 4)
    
    for i in 1:num_points
        # Extract geometric features
        point = X[i, :]
        
        # Feature 1: Distance to origin
        features[i, 1] = norm(point)
        
        # Feature 2: Distance to centroid (learned)
        centroid = mean(X, dims=1)
        features[i, 2] = norm(point .- centroid)
        
        # Feature 3: Local density (learned)
        local_dists = [norm(point .- X[j, :]) for j in 1:num_points if j != i]
        features[i, 3] = 1.0 / (mean(local_dists) + 0.001)
        
        # Feature 4: Cluster alignment (learned)
        features[i, 4] = sum(point .* centroid) / (norm(point) * norm(centroid) + 0.001)
    end
    
    return features
end

function solve_geometric_problem(re::GeometricReasoningEngine, X::Matrix{Float64})
    num_points = size(X, 1)
    
    try
        # Extract features
        features = extract_features(re, X)
        
        # Score each point using learned weights
        scores = zeros(num_points)
        for i in 1:num_points
            # Apply feature weights
            weighted_features = re.feature_weights' * features[i, :]
            # Apply decision weights
            scores[i] = sum(weighted_features .* re.decision_weights)
        end
        
        # Choose point with minimum score (closest to ideal)
        return argmin(scores)
        
    catch e
        # Fallback: simple distance-based reasoning
        distances = [norm(X[i, :]) for i in 1:num_points]
        return argmin(distances)
    end
end

function learn_from_experience!(re::GeometricReasoningEngine, X::Matrix{Float64}, chosen_idx::Int, correct_idx::Int)
    # SIMPLE BUT EFFECTIVE LEARNING
    if chosen_idx != correct_idx
        # Get features for both chosen and correct points
        features = extract_features(re, X)
        chosen_features = features[chosen_idx, :]
        correct_features = features[correct_idx, :]
        
        # Calculate error (we want correct point to have lower score)
        chosen_score = sum((re.feature_weights' * chosen_features) .* re.decision_weights)
        correct_score = sum((re.feature_weights' * correct_features) .* re.decision_weights)
        
        error = chosen_score - correct_score
        
        if error > 0  # Only learn if we made a mistake
            # Update weights to favor correct point
            learning_strength = re.learning_rate * error
            
            # Update feature weights
            for j in 1:size(re.feature_weights, 2)
                feature_error = correct_features[j] - chosen_features[j]
                re.feature_weights[:, j] .+= learning_strength * feature_error * 0.1
            end
            
            # Update decision weights
            re.decision_weights .+= learning_strength * 0.1
            
            # Decay learning rate
            re.learning_rate *= 0.999
        end
    end
end

function test_geometric_reasoning(re::GeometricReasoningEngine, num_trials::Int=20)
    correct = 0
    
    for trial in 1:num_trials
        try
            X, true_answer, clusters = generate_geometric_problem(re, 8)
            prediction = solve_geometric_problem(re, X)
            
            # LEARN FROM EXPERIENCE
            learn_from_experience!(re, X, prediction, true_answer)
            
            if prediction == true_answer
                correct += 1
            end
        catch e
            # Continue with other trials
        end
    end
    
    accuracy = num_trials > 0 ? correct / num_trials : 0.0
    
    # Store result
    push!(re.reasoning_history, accuracy)
    
    # Keep history manageable
    if length(re.reasoning_history) > 100
        re.reasoning_history = re.reasoning_history[end-99:end]
    end
    
    # DEBUG OUTPUT
    println("🧠 GEOMETRIC REASONING: Accuracy = $accuracy, Learning Rate = $(re.learning_rate)")
    
    return accuracy
end
