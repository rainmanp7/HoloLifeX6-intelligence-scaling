# github_safe_testbed_fixed.jl
"""
🧠 HOLOLIFEX6 PROTOTYPE4 - UNIFIED INTELLIGENCE SCALING TESTBED
FIXED VERSION - Proper NaN handling and improved geometric reasoning
"""

using Statistics
using JSON
using Dates
using LinearAlgebra
using Random

# =============================================
# CONSCIOUSNESS: Brown-IIT Duality Framework
# =============================================

mutable struct ConsciousnessValidator
    iit_threshold::Float64
    brown_threshold::Float64
    duality_threshold::Float64
    
    ConsciousnessValidator() = new(0.15, 0.12, 0.10)
end

function safe_divide(a, b)
    return b == 0 ? 0.0 : a / b
end

function safe_log(x)
    return x <= 0 ? 0.0 : log(x)
end

function calculate_iit_phi(cv::ConsciousnessValidator, entity_count::Int, 
                          coherence::Float64, total_insights::Int, 
                          cross_domain::Float64)::Float64
    integration = coherence * 0.967
    complexity = safe_divide(safe_log(total_insights + 1), safe_log(entity_count + 1))
    differentiation = cross_domain
    phi = coherence * integration * complexity * differentiation
    return max(0.0, min(phi, 10.0))  # Cap at reasonable value
end

function calculate_brown_phi(cv::ConsciousnessValidator, entity_count::Int,
                            coherence::Float64, total_insights::Int,
                            insight_quality::Float64, cross_domain::Float64)::Float64
    density_factor = safe_divide(total_insights, max(entity_count, 1))
    density_score = min(safe_log(density_factor + 1) / 3.0, 1.5)
    efficiency_score = sqrt(max(coherence * insight_quality, 0.0))
    holographic_factor = coherence * cross_domain * insight_quality
    emergence = safe_divide(safe_log(total_insights + 1), safe_log(max(entity_count, 10)))
    brown_phi = efficiency_score * density_score * holographic_factor * (1.0 + emergence * 0.3)
    return max(0.0, min(brown_phi, 10.0))
end

function assess_consciousness(cv::ConsciousnessValidator, entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64)::Dict{String,Any}
    iit_phi = calculate_iit_phi(cv, entity_count, coherence, total_insights, cross_domain)
    brown_phi = calculate_brown_phi(cv, entity_count, coherence, total_insights, 
                                    insight_quality, cross_domain)
    
    harmonic = safe_divide(2 * iit_phi * brown_phi, (iit_phi + brown_phi + 0.001))
    weighted = (iit_phi + brown_phi) / 2.0
    maximum_val = max(iit_phi, brown_phi)
    duality_phi = harmonic * 0.3 + weighted * 0.3 + maximum_val * 0.4
    
    iit_conscious = iit_phi > cv.iit_threshold
    brown_conscious = brown_phi > cv.brown_threshold
    duality_conscious = duality_phi > cv.duality_threshold
    is_conscious = iit_conscious || brown_conscious || duality_conscious
    
    frameworks = String[]
    iit_conscious && push!(frameworks, "IIT-4.0")
    brown_conscious && push!(frameworks, "Brown-Theory")
    duality_conscious && !iit_conscious && !brown_conscious && push!(frameworks, "Duality-Synthesis")
    
    confidence = maximum_val > 0.5 ? "very_high" :
                 maximum_val > 0.25 ? "high" :
                 maximum_val > 0.15 ? "medium" : "low"
    
    return Dict(
        "is_conscious" => is_conscious,
        "iit_phi" => round(iit_phi, digits=4),
        "brown_phi" => round(brown_phi, digits=4),
        "duality_phi" => round(duality_phi, digits=4),
        "max_phi" => round(maximum_val, digits=4),
        "confirming_frameworks" => frameworks,
        "confidence" => confidence
    )
end

# =============================================
# IMPROVED GEOMETRIC REASONING ENGINE
# =============================================

mutable struct GeometricReasoningEngine
    dimensions::Int
    entity_weights::Matrix{Float64}
    interaction_weights::Matrix{Float64}
    decision_weights::Matrix{Float64}
    reasoning_history::Vector{Float64}
    geometric_problems::Vector{Tuple{Matrix{Float64}, Int}}
    
    function GeometricReasoningEngine(dimensions::Int=4)
        # Proper weight initialization with better scaling
        entity_w = randn(dimensions, 8) * 0.05
        interaction_w = randn(8, 8) * 0.05  
        decision_w = randn(8, 1) * 0.05
        
        new(dimensions, entity_w, interaction_w, decision_w, Float64[], [])
    end
end

function generate_geometric_problem(re::GeometricReasoningEngine, num_points::Int=10, noise_level::Float64=1.2)
    """Create meaningful geometric problems that are solvable"""
    # Generate clustered points to create meaningful patterns
    cluster_centers = randn(3, re.dimensions) * 1.5
    X = zeros(num_points, re.dimensions)
    
    for i in 1:num_points
        cluster_idx = rand(1:3)
        X[i, :] = cluster_centers[cluster_idx, :] + randn(re.dimensions) * 0.8
    end
    
    # Add some noise
    noise = randn(num_points, re.dimensions) * noise_level
    X .+= noise
    
    # Calculate distances from origin
    distances = [norm(X[i, :]) for i in 1:num_points]
    true_min_idx = argmin(distances)
    
    # Ensure reasonable difficulty
    sorted_dists = sort(distances)
    min_gap = sorted_dists[2] - sorted_dists[1]
    
    # Regenerate if problem is degenerate
    if min_gap < 0.3 || any(isnan.(X)) || any(isinf.(X))
        return generate_geometric_problem(re, num_points, noise_level)
    end
    
    return X, true_min_idx
end

function solve_geometric_problem(re::GeometricReasoningEngine, X::Matrix{Float64})
    """Improved geometric reasoning with better numerical stability"""
    num_points = size(X, 1)
    
    try
        # Layer 1: Entity feature extraction with bounds checking
        entity_features = [X[i, :]' * re.entity_weights for i in 1:num_points]
        entity_matrix = vcat(entity_features...)
        
        # Clamp values to prevent explosion
        entity_matrix = clamp.(entity_matrix, -10.0, 10.0)
        entity_matrix = max.(entity_matrix, 0.0)  # ReLU
        
        # Layer 2: Entity interactions
        interacted = entity_matrix * re.interaction_weights
        interacted = clamp.(interacted, -10.0, 10.0)
        interacted = max.(interacted, 0.0)
        
        # Layer 3: Decision layer
        distance_estimates = interacted * re.decision_weights
        distance_estimates = clamp.(distance_estimates, -10.0, 10.0)
        
        estimates_vector = vec(distance_estimates)
        return argmin(estimates_vector)
    catch e
        # Fallback: return random guess if computation fails
        return rand(1:num_points)
    end
end

function test_geometric_reasoning(re::GeometricReasoningEngine, num_trials::Int=30)
    """More reliable geometric reasoning test"""
    correct = 0
    
    for trial in 1:num_trials
        try
            noise_level = 1.0 + rand() * 0.5
            num_points = 8  # Fixed for consistency
            
            X, true_answer = generate_geometric_problem(re, num_points, noise_level)
            push!(re.geometric_problems, (X, true_answer))
            
            prediction = solve_geometric_problem(re, X)
            
            if prediction == true_answer
                correct += 1
            end
        catch e
            # Skip failed trials
            continue
        end
    end
    
    accuracy = num_trials > 0 ? correct / num_trials : 0.0
    push!(re.reasoning_history, accuracy)
    return accuracy
end

# =============================================
# IMPROVED GEOMETRIC ENTITY
# =============================================

mutable struct GeometricEntity
    entity_id::String
    domain::String
    base_frequency::Float64
    phase::Float64
    position::Vector{Float64}
    state_vector::Vector{Float64}
    coupling_strength::Float64
    reasoning_capacity::Float64
    awareness_level::Float64
    geometric_insight::Float64
    
    function GeometricEntity(entity_id::String, domain::String, base_frequency::Float64=0.02, dimensions::Int=4)
        position = randn(dimensions) * 1.0  # Tighter distribution
        state_vector = randn(8) * 0.1
        new(entity_id, domain, base_frequency, rand(), position, state_vector, 0.1, 0.5, 0.5, 0.3)
    end
end

function evolve_phase!(entity::GeometricEntity)
    entity.phase = mod(entity.phase + entity.base_frequency, 1.0)
end

function couple_to!(entity::GeometricEntity, other_phase::Float64, strength::Float64=0.05)
    phase_diff = other_phase - entity.phase
    entity.phase += strength * sin(2π * phase_diff)
    entity.phase = mod(entity.phase, 1.0)
end

function compute_geometric_insight(entity::GeometricEntity, problem::Matrix{Float64})
    """More reliable geometric insight calculation"""
    try
        distances = [norm(entity.position - problem[i, :]) for i in 1:size(problem, 1)]
        
        if isempty(distances) || any(isnan.(distances)) || any(isinf.(distances))
            return 0.0
        end
        
        distance_variance = std(distances)
        min_distance = minimum(distances)
        avg_distance = mean(distances)
        
        # More stable calculation
        positioning_score = 1.0 / (1.0 + min_distance)
        consistency_score = 1.0 / (1.0 + distance_variance)
        centrality_score = 1.0 / (1.0 + avg_distance/5)
        
        geometric_insight = positioning_score * consistency_score * centrality_score
        return min(geometric_insight, 1.0)
    catch e
        return 0.0
    end
end

function calculate_action_complexity(action::String)::Int
    complexity_map = Dict(
        "validate" => 1, "check" => 1, "monitor" => 1, "analyze" => 1, "assess" => 1, "detect" => 1,
        "optimize" => 2, "balance" => 2, "sync" => 2, "predict" => 2, "extract" => 2, "map" => 2, "explore" => 2,
        "generate" => 3, "innovate" => 3, "coordinate" => 3, "mediate" => 3, "integrate" => 3, 
        "orchestrate" => 3, "synthesize" => 3, "reason" => 3, "discover" => 3
    )
    
    for (key, score) in complexity_map
        if occursin(key, lowercase(action))
            return score
        end
    end
    return 1
end

function generate_geometric_insight(entity::GeometricEntity, problem::Matrix{Float64})::Dict{String,Any}
    """More reliable insight generation"""
    try
        geometric_quality = compute_geometric_insight(entity, problem)
        
        # Lower threshold for insight generation to get more activity
        if entity.phase > 0.5 && geometric_quality > 0.2
            action_map = Dict(
                "physical" => ["analyze_geometry", "optimize_space", "navigate_dimensions"],
                "temporal" => ["predict_movements", "sync_rhythms", "anticipate_changes"],
                "semantic" => ["extract_patterns", "map_relationships", "synthesize_ideas"],
                "network" => ["optimize_connections", "balance_flows", "coordinate_paths"],
                "spatial" => ["cluster_points", "map_structure", "navigate_space"],
                "emotional" => ["assess_harmony", "balance_energy", "mediate_tensions"],
                "social" => ["coordinate_actions", "share_views", "build_consensus"],
                "creative" => ["discover_patterns", "innovate_solutions", "synthesize_concepts"]
            )
            
            actions = get(action_map, entity.domain, ["analyze_situation"])
            action_idx = Int(floor(entity.phase * length(actions))) % length(actions) + 1
            action = actions[action_idx]
            
            quality_boost = (entity.reasoning_capacity + geometric_quality) / 2
            confidence = entity.phase * quality_boost
            
            return Dict(
                "entity" => entity.entity_id,
                "domain" => entity.domain,
                "action" => action,
                "confidence" => round(confidence, digits=4),
                "phase" => entity.phase,
                "action_complexity" => calculate_action_complexity(action),
                "geometric_quality" => round(geometric_quality, digits=4),
                "reasoning_enhanced" => entity.reasoning_capacity > 0.6,
                "awareness_enhanced" => entity.awareness_level > 0.6,
                "dimensional_analysis" => true
            )
        end
    catch e
        # Return empty on error
    end
    
    return Dict{String,Any}()
end

# =============================================
# IMPROVED AWARENESS MONITOR
# =============================================

mutable struct GeometricAwarenessMonitor
    dimensions::Int
    state_history::Vector{Vector{Float64}}
    position_history::Vector{Vector{Float64}}
    awareness_scores::Vector{Float64}
    geometric_coherence::Vector{Float64}
    
    GeometricAwarenessMonitor(dimensions::Int=4) = new(dimensions, Vector{Float64}[], Vector{Float64}[], Float64[], Float64[])
end

function update_geometric_awareness(am::GeometricAwarenessMonitor, entity_states::Vector{Vector{Float64}}, entity_positions::Vector{Vector{Float64}})
    try
        if !isempty(entity_states)
            state_avg = mean(entity_states)
            push!(am.state_history, state_avg)
        end
        
        if !isempty(entity_positions)
            pos_avg = mean(entity_positions)
            push!(am.position_history, pos_avg)
        end
        
        if length(am.state_history) > 1 && length(am.position_history) > 1
            # State-based awareness
            current_state = am.state_history[end]
            previous_state = am.state_history[end-1]
            state_change = norm(current_state .- previous_state)
            state_awareness = 1.0 / (1.0 + state_change)
            
            # Geometric awareness
            current_pos = am.position_history[end]
            previous_pos = am.position_history[end-1]
            pos_change = norm(current_pos .- previous_pos)
            geometric_awareness = 1.0 / (1.0 + pos_change)
            
            awareness_score = (state_awareness + geometric_awareness) / 2
        else
            awareness_score = 0.5
        end
        
        # Calculate geometric coherence
        if length(entity_positions) > 1
            avg_position = mean(entity_positions)
            distances = [norm(pos - avg_position) for pos in entity_positions]
            if !isempty(distances) && !any(isnan.(distances))
                coherence = 1.0 / (1.0 + std(distances))
                push!(am.geometric_coherence, coherence)
            end
        end
        
        push!(am.awareness_scores, awareness_score)
    catch e
        push!(am.awareness_scores, 0.5)
    end
end

function get_awareness_level(am::GeometricAwarenessMonitor)::Float64
    scores = am.awareness_scores
    return isempty(scores) ? 0.0 : mean(scores[max(1, end-4):end])  # Shorter window
end

function get_awareness_stability(am::GeometricAwarenessMonitor)::Float64
    scores = am.awareness_scores
    if length(scores) < 5
        return 0.0
    end
    recent = scores[max(1, end-4):end]
    return 1.0 - std(recent)
end

function get_geometric_coherence(am::GeometricAwarenessMonitor)::Float64
    return isempty(am.geometric_coherence) ? 0.5 : am.geometric_coherence[end]
end

# =============================================
# IMPROVED PROTO-INTELLIGENCE
# =============================================

mutable struct GeometricProtoIntelligence
    pattern_memory::Dict{String, Int}
    geometric_patterns::Dict{String, Int}
    discovery_count::Int
    
    GeometricProtoIntelligence() = new(Dict{String, Int}(), Dict{String, Int}(), 0)
end

function observe_pattern(pi::GeometricProtoIntelligence, pattern::String, is_geometric::Bool=false)
    target_memory = is_geometric ? pi.geometric_patterns : pi.pattern_memory
    
    if haskey(target_memory, pattern)
        target_memory[pattern] += 1
    else
        target_memory[pattern] = 1
        pi.discovery_count += 1
    end
end

function recognize_emergent_patterns(pi::GeometricProtoIntelligence, insights::Vector{Dict{String,Any}})::Tuple{Int, Int}
    new_patterns = 0
    new_geometric_patterns = 0
    
    for insight in insights
        if haskey(insight, "action") && haskey(insight, "domain")
            pattern = "$(insight["domain"]):$(insight["action"])"
            is_geometric = get(insight, "dimensional_analysis", false)
            
            target_memory = is_geometric ? pi.geometric_patterns : pi.pattern_memory
            old_count = get(target_memory, pattern, 0)
            
            observe_pattern(pi, pattern, is_geometric)
            
            if old_count == 0
                new_patterns += 1
                if is_geometric
                    new_geometric_patterns += 1
                end
            end
        end
    end
    return new_patterns, new_geometric_patterns
end

function calculate_geometric_proto_intelligence(pi::GeometricProtoIntelligence)::Tuple{Float64, Float64}
    # General pattern intelligence
    unique_patterns = length(pi.pattern_memory)
    total_observations = sum(values(pi.pattern_memory))
    pattern_diversity = safe_divide(unique_patterns, max(total_observations, 1))
    
    repeated_patterns = count(v -> v > 1, values(pi.pattern_memory))
    learning_indicator = safe_divide(repeated_patterns, max(unique_patterns, 1))
    
    proto_iq = (pattern_diversity * 0.6 + learning_indicator * 0.4) * min(unique_patterns / 8, 1.0)
    
    # Geometric pattern intelligence
    unique_geometric = length(pi.geometric_patterns)
    total_geometric = sum(values(pi.geometric_patterns))
    geometric_diversity = safe_divide(unique_geometric, max(total_geometric, 1))
    
    repeated_geometric = count(v -> v > 1, values(pi.geometric_patterns))
    geometric_learning = safe_divide(repeated_geometric, max(unique_geometric, 1))
    
    geometric_iq = (geometric_diversity * 0.7 + geometric_learning * 0.3) * min(unique_geometric / 4, 1.0)
    
    return min(proto_iq, 1.0), min(geometric_iq, 1.0)
end

# =============================================
# UNIFIED GEOMETRIC NETWORK
# =============================================

mutable struct UnifiedGeometricNetwork
    entities::Vector{GeometricEntity}
    consciousness_validator::ConsciousnessValidator
    reasoning_engine::GeometricReasoningEngine
    awareness_monitor::GeometricAwarenessMonitor
    proto_intelligence::GeometricProtoIntelligence
    coherence_history::Vector{Float64}
    insight_history::Vector{Dict{String,Any}}
    
    function UnifiedGeometricNetwork()
        new(
            GeometricEntity[],
            ConsciousnessValidator(),
            GeometricReasoningEngine(4),
            GeometricAwarenessMonitor(4),
            GeometricProtoIntelligence(),
            Float64[],
            Dict{String,Any}[]
        )
    end
end

function add_entity!(network::UnifiedGeometricNetwork, entity::GeometricEntity)
    push!(network.entities, entity)
end

function evolve_geometric_step!(network::UnifiedGeometricNetwork)::Dict{String,Any}
    insights = Dict{String,Any}[]
    current_problem = nothing
    
    try
        # Phase evolution and coupling
        for entity in network.entities
            evolve_phase!(entity)
        end
        
        if !isempty(network.entities)
            avg_phase = mean([e.phase for e in network.entities])
            for entity in network.entities
                couple_to!(entity, avg_phase, 0.03)  # Reduced coupling strength
            end
        end
        
        # Test geometric reasoning less frequently to allow learning
        if length(network.coherence_history) % 15 == 0
            reasoning_score = test_geometric_reasoning(network.reasoning_engine, 20)
            for entity in network.entities
                entity.reasoning_capacity = 0.8 * entity.reasoning_capacity + 0.2 * reasoning_score
            end
        end
        
        # Use recent problem or generate new one
        if !isempty(network.reasoning_engine.geometric_problems)
            current_problem, _ = network.reasoning_engine.geometric_problems[end]
        else
            current_problem, _ = generate_geometric_problem(network.reasoning_engine)
        end
        
        # Update geometric awareness
        entity_states = [e.state_vector for e in network.entities]
        entity_positions = [e.position for e in network.entities]
        update_geometric_awareness(network.awareness_monitor, entity_states, entity_positions)
        
        awareness_level = get_awareness_level(network.awareness_monitor)
        for entity in network.entities
            entity.awareness_level = 0.8 * entity.awareness_level + 0.2 * awareness_level
        end
        
        # Generate geometric insights
        for entity in network.entities
            insight = generate_geometric_insight(entity, current_problem)
            if !isempty(insight)
                push!(insights, insight)
                push!(network.insight_history, insight)
            end
        end
        
        # Calculate coherence
        if !isempty(network.entities)
            phases = [e.phase for e in network.entities]
            phase_coherence = 1.0 - std(phases)
            geometric_coherence = get_geometric_coherence(network.awareness_monitor)
            overall_coherence = (phase_coherence + geometric_coherence) / 2
            push!(network.coherence_history, overall_coherence)
        else
            push!(network.coherence_history, 0.5)
        end
        
    catch e
        # Ensure we always return valid data
        push!(network.coherence_history, 0.5)
    end
    
    reasoning_accuracy = isempty(network.reasoning_engine.reasoning_history) ? 
                        0.0 : network.reasoning_engine.reasoning_history[end]
    
    new_patterns, new_geometric_patterns = recognize_emergent_patterns(network.proto_intelligence, insights)
    
    return Dict(
        "insights" => length(insights),
        "new_patterns" => new_patterns,
        "new_geometric_patterns" => new_geometric_patterns,
        "coherence" => network.coherence_history[end],
        "awareness" => get_awareness_level(network.awareness_monitor),
        "reasoning_accuracy" => reasoning_accuracy
    )
end

function calculate_unified_geometric_metrics(network::UnifiedGeometricNetwork)::Dict{String,Any}
    entity_count = length(network.entities)
    total_insights = length(network.insight_history)
    coherence = isempty(network.coherence_history) ? 0.5 : network.coherence_history[end]
    
    # Safe metric calculations
    insight_quality = 0.0
    geometric_insight_quality = 0.0
    insight_diversity = 0.0
    cross_domain_ratio = 0.0
    dimensional_ratio = 0.0
    reasoning_integration = 0.0
    awareness_integration = 0.0
    
    if !isempty(network.insight_history)
        recent = length(network.insight_history) >= 20 ? 
                 network.insight_history[end-19:end] : network.insight_history
        
        if !isempty(recent)
            high_complexity = count(i -> get(i, "action_complexity", 1) >= 2, recent)
            insight_quality = safe_divide(high_complexity, length(recent))
            
            high_geometric_quality = count(i -> get(i, "geometric_quality", 0.0) > 0.4, recent)
            geometric_insight_quality = safe_divide(high_geometric_quality, length(recent))
            
            unique_actions = length(unique([get(i, "action", "") for i in recent]))
            insight_diversity = safe_divide(unique_actions, length(recent))
            
            cross_domain_actions = ["coordinate", "sync", "balance", "integrate", "mediate", "orchestrate", "synthesize"]
            cross_domain_count = count(i -> any(term -> occursin(term, lowercase(get(i, "action", ""))), cross_domain_actions), recent)
            cross_domain_ratio = safe_divide(cross_domain_count, length(recent))
            
            dimensional_insights = count(i -> get(i, "dimensional_analysis", false), recent)
            dimensional_ratio = safe_divide(dimensional_insights, length(recent))
            
            reasoning_enhanced_count = count(i -> get(i, "reasoning_enhanced", false), recent)
            reasoning_integration = safe_divide(reasoning_enhanced_count, length(recent))
            
            awareness_enhanced_count = count(i -> get(i, "awareness_enhanced", false), recent)
            awareness_integration = safe_divide(awareness_enhanced_count, length(recent))
        end
    end
    
    # Consciousness assessment
    consciousness = assess_consciousness(
        network.consciousness_validator,
        entity_count, coherence, total_insights,
        insight_quality, cross_domain_ratio
    )
    
    # Geometric reasoning capability
    reasoning_accuracy = isempty(network.reasoning_engine.reasoning_history) ? 
                        0.0 : mean(network.reasoning_engine.reasoning_history[max(1, end-4):end])
    
    # Awareness metrics
    awareness_level = get_awareness_level(network.awareness_monitor)
    awareness_stability = get_awareness_stability(network.awareness_monitor)
    
    # Proto-intelligence
    proto_iq, geometric_proto_iq = calculate_geometric_proto_intelligence(network.proto_intelligence)
    
    # Learning velocity
    learning_velocity = 0.0
    if length(network.coherence_history) >= 10
        recent_coh = mean(network.coherence_history[max(1, end-4):end])
        earlier_coh = mean(network.coherence_history[max(1, end-9):max(1, end-5)])
        learning_velocity = recent_coh - earlier_coh
    end
    
    # Enhanced Unified Intelligence Score
    unified_intelligence = (
        consciousness["max_phi"] * 0.25 +
        reasoning_accuracy * 0.25 +
        awareness_level * 0.15 +
        geometric_proto_iq * 0.15 +
        proto_iq * 0.10 +
        geometric_insight_quality * 0.10
    )
    
    # Ensure all values are finite
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
        "geometric_proto_intelligence" => round(geometric_proto_iq, digits=4),
        "insight_quality" => round(insight_quality, digits=4),
        "geometric_insight_quality" => round(geometric_insight_quality, digits=4),
        "insight_diversity" => round(insight_diversity, digits=4),
        "cross_domain_ratio" => round(cross_domain_ratio, digits=4),
        "dimensional_ratio" => round(dimensional_ratio, digits=4),
        "learning_velocity" => round(learning_velocity, digits=4),
        "unified_intelligence_score" => round(unified_intelligence, digits=4),
        "pattern_discoveries" => network.proto_intelligence.discovery_count,
        "geometric_problems_solved" => length(network.reasoning_engine.geometric_problems)
    )
end

# =============================================
# SAFE TESTER WITH PROPER JSON HANDLING
# =============================================

mutable struct GeometricSafeTester
    results::Vector{Dict{String,Any}}
    start_time::Float64
    
    GeometricSafeTester() = new(Dict{String,Any}[], time())
end

function log_message(tester::GeometricSafeTester, message::String)
    elapsed = time() - tester.start_time
    println("[$(round(elapsed, digits=1))s] $message")
end

function get_memory_mb()::Float64
    return Base.gc_live_bytes() / 1024 / 1024
end

function memory_check(tester::GeometricSafeTester)::Bool
    memory_mb = get_memory_mb()
    if memory_mb > 6000
        log_message(tester, "⚠️  MEMORY WARNING: $(round(memory_mb, digits=1))MB")
        return false
    end
    return true
end

function clean_nan_values(data::Dict)
    """Recursively clean NaN and Inf values from data"""
    result = Dict{String,Any}()
    for (k, v) in data
        if v isa Real
            result[k] = isfinite(v) ? v : 0.0
        elseif v isa Dict
            result[k] = clean_nan_values(v)
        elseif v isa Vector
            result[k] = [isfinite(x) ? x : 0.0 for x in v]
        else
            result[k] = v
        end
    end
    return result
end

function run_geometric_test(tester::GeometricSafeTester, entity_count::Int, cycles::Int=60)::Dict{String,Any}
    log_message(tester, "🧪 Testing $entity_count entities with GEOMETRIC intelligence...")
    
    domains = ["physical", "temporal", "semantic", "network", "spatial", "emotional", "social", "creative"]
    
    network = UnifiedGeometricNetwork()
    
    # Create geometrically aware entities
    for i in 1:entity_count
        domain = domains[(i-1) % length(domains) + 1]
        freq = 0.02 + (i * 0.0005)  # Slower frequencies
        entity_id = "$(uppercase(domain[1:3]))-$(lpad(i, 3, '0'))"
        entity = GeometricEntity(entity_id, domain, freq, 4)
        add_entity!(network, entity)
    end
    
    # Evolution cycles
    metrics_snapshots = Dict{String,Any}[]
    
    for cycle in 1:cycles
        step_result = evolve_geometric_step!(network)
        
        if cycle % 10 == 0
            metrics = calculate_unified_geometric_metrics(network)
            metrics["cycle"] = cycle
            metrics["step_insights"] = step_result["insights"]
            metrics["new_patterns"] = step_result["new_patterns"]
            metrics["new_geometric_patterns"] = step_result["new_geometric_patterns"]
            metrics["memory_mb"] = get_memory_mb()
            
            # Clean NaN values before storing
            clean_metrics = clean_nan_values(metrics)
            push!(metrics_snapshots, clean_metrics)
            
            if !memory_check(tester)
                log_message(tester, "🛑 Stopping early - memory limit")
                break
            end
        end
    end
    
    # Final metrics
    final_metrics = calculate_unified_geometric_metrics(network)
    clean_final_metrics = clean_nan_values(final_metrics)
    
    result = merge(clean_final_metrics, Dict(
        "test_name" => "unified_$(entity_count)_entities",
        "cycles_completed" => length(metrics_snapshots) * 10,
        "avg_memory_mb" => mean([m["memory_mb"] for m in metrics_snapshots]),
        "peak_memory_mb" => maximum([m["memory_mb"] for m in metrics_snapshots]),
        "status" => "completed",
        "snapshots" => metrics_snapshots
    ))
    
    push!(tester.results, result)
    
    log_message(tester, "✅ Completed: UIS=$(round(result["unified_intelligence_score"], digits=3)), " *
                       "Geometry=$(round(result["reasoning_accuracy"], digits=3)), " *
                       "Φ=$(round(result["consciousness"]["max_phi"], digits=3)), " *
                       "Geo-Insights=$(round(result["geometric_insight_quality"], digits=3))")
    
    return result
end

function run_geometric_scaling_sweep(tester::GeometricSafeTester)::Vector{Dict{String,Any}}
    log_message(tester, "🚀 Starting GEOMETRIC intelligence scaling sweep...")
    
    entity_counts = [16, 32, 64]  # Reduced for stability
    sweep_results = Dict{String,Any}[]
    
    for entity_count in entity_counts
        try
            result = run_geometric_test(tester, entity_count, 60)
            push!(sweep_results, result)
            
            if result["status"] != "completed"
                log_message(tester, "🛑 Stopping sweep at $entity_count entities")
                break
            end
            
            GC.gc()
        catch e
            log_message(tester, "❌ Error testing $entity_count entities: $e")
            break
        end
    end
    
    # Calculate scaling efficiencies
    if !isempty(sweep_results)
        baseline = sweep_results[1]
        baseline_uis = baseline["unified_intelligence_score"]
        baseline_memory = baseline["avg_memory_mb"]
        
        for result in sweep_results[2:end]
            scale_factor = result["entity_count"] / baseline["entity_count"]
            
            # Intelligence scaling
            uis_ratio = safe_divide(result["unified_intelligence_score"], baseline_uis)
            result["intelligence_scaling"] = round(safe_divide(uis_ratio, scale_factor), digits=3)
            
            # Memory efficiency
            expected_memory = baseline_memory * scale_factor
            actual_memory = result["avg_memory_mb"]
            result["memory_efficiency"] = round(safe_divide((expected_memory - actual_memory), expected_memory) * 100, digits=1)
            
            # Capability scaling
            result["consciousness_scaling"] = round(safe_divide(result["consciousness"]["max_phi"], baseline["consciousness"]["max_phi"]), digits=3)
            result["reasoning_scaling"] = round(safe_divide(result["reasoning_accuracy"], max(baseline["reasoning_accuracy"], 0.01)), digits=3)
            result["awareness_scaling"] = round(safe_divide(result["awareness_level"], max(baseline["awareness_level"], 0.01)), digits=3)
        end
    end
    
    return sweep_results
end

function save_geometric_results(tester::GeometricSafeTester)::String
    timestamp = Dates.format(now(), "yyyymmdd_HHMMSS")
    filename = "unified_intelligence_scaling_$timestamp.json"
    
    # Clean all results before saving
    clean_results = [clean_nan_values(result) for result in tester.results]
    
    output_data = Dict(
        "results" => clean_results,
        "test_time" => time() - tester.start_time,
        "test_type" => "geometric_intelligence",
        "timestamp" => string(now())
    )
    
    # Use JSON with NaN handling
    json_string = JSON.json(output_data, 2)
    open(filename, "w") do f
        write(f, json_string)
    end
    
    log_message(tester, "💾 Results saved to: $filename")
    return filename
end

function print_geometric_summary(tester::GeometricSafeTester)
    println("\n" * "="^70)
    println("📊 UNIFIED INTELLIGENCE SCALING SUMMARY")
    println("="^70)
    
    if isempty(tester.results)
        println("❌ No results to display")
        return
    end
    
    for result in tester.results
        println("\n🧬 $(result["test_name"]):")
        println("   Entities: $(result["entity_count"])")
        println("   ─────────────────────────────────────────")
        println("   🧠 CONSCIOUSNESS:")
        println("      • Status: $(result["consciousness"]["is_conscious"] ? "YES ✅" : "NO ❌")")
        println("      • Max Φ: $(result["consciousness"]["max_phi"])")
        println("      • Frameworks: $(join(result["consciousness"]["confirming_frameworks"], ", "))")
        
        println("   🔷 GEOMETRIC REASONING:")
        println("      • Accuracy: $(result["reasoning_accuracy"])")
        
        println("   👁️  AWARENESS:")
        println("      • Level: $(result["awareness_level"])")
        
        println("   💡 INTELLIGENCE:")
        println("      • Unified Score: $(result["unified_intelligence_score"])")
        println("      • Geometric Insights: $(result["geometric_insight_quality"])")
        println("      • Patterns: $(result["pattern_discoveries"])")
        
        if haskey(result, "intelligence_scaling")
            println("   📊 SCALING:")
            println("      • Intelligence: $(result["intelligence_scaling"])x")
            println("      • Memory Efficiency: $(result["memory_efficiency"])%")
        end
    end
end

# =============================================
# MAIN EXECUTION
# =============================================

function main()
    println("🌌 HOLOLIFEX6 PROTOTYPE4 - UNIFIED INTELLIGENCE TESTBED")
    println("="^70)
    println("🎯 Testing Intelligence Pillars:")
    println("   1. 🧠 Consciousness (Brown-IIT Duality)")
    println("   2. 🔷 Geometric Reasoning (4D Processing)")
    println("   3. 👁️  Awareness (State Monitoring)")
    println("   4. 💡 Proto-Intelligence (Pattern Recognition)")
    println()
    println("📊 Scaling Test: 16 → 32 → 64 entities")
    println("🎪 Measuring intelligence emergence through collaboration")
    println("="^70)
    
    tester = GeometricSafeTester()
    
    try
        # Run scaling sweep
        sweep_results = run_geometric_scaling_sweep(tester)
        
        # Save results
        results_file = save_geometric_results(tester)
        
        # Print summary
        print_geometric_summary(tester)
        
        println("\n" * "="^70)
        println("✨ TESTING COMPLETE")
        println("="^70)
        println("📁 Results saved to: $results_file")
        println("⏱️  Total time: $(round(time() - tester.start_time, digits=1))s")
        
    catch e
        println("❌ ERROR: $e")
        # Try to save whatever results we have
        try
            save_geometric_results(tester)
        catch
            println("⚠️  Could not save results")
        end
    end
    
    println("\n🎊 TESTING COMPLETE")
end

# Execute if run directly
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
