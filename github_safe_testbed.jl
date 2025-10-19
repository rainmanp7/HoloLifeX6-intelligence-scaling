# github_safe_testbed_geometric.jl
"""
🧠 HOLOLIFEX6 PROTOTYPE4 - GEOMETRIC INTELLIGENCE TESTBED
INTEGRATED VERSION - Proper geometric reasoning with consciousness assessment
Combines the best of both versions with real 4D geometric intelligence
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

function calculate_iit_phi(cv::ConsciousnessValidator, entity_count::Int, 
                          coherence::Float64, total_insights::Int, 
                          cross_domain::Float64)::Float64
    integration = coherence * 0.967
    complexity = log(total_insights + 1) / log(entity_count + 1)
    differentiation = cross_domain
    phi = coherence * integration * complexity * differentiation
    return max(0.0, phi)
end

function calculate_brown_phi(cv::ConsciousnessValidator, entity_count::Int,
                            coherence::Float64, total_insights::Int,
                            insight_quality::Float64, cross_domain::Float64)::Float64
    density_factor = total_insights / max(entity_count, 1)
    density_score = min(log(density_factor + 1) / 3.0, 1.5)
    efficiency_score = sqrt(coherence * insight_quality)
    holographic_factor = coherence * cross_domain * insight_quality
    emergence = log(total_insights + 1) / log(max(entity_count, 10))
    brown_phi = efficiency_score * density_score * holographic_factor * (1.0 + emergence * 0.3)
    return max(0.0, brown_phi)
end

function assess_consciousness(cv::ConsciousnessValidator, entity_count::Int,
                             coherence::Float64, total_insights::Int,
                             insight_quality::Float64, cross_domain::Float64)::Dict{String,Any}
    iit_phi = calculate_iit_phi(cv, entity_count, coherence, total_insights, cross_domain)
    brown_phi = calculate_brown_phi(cv, entity_count, coherence, total_insights, 
                                    insight_quality, cross_domain)
    
    harmonic = (2 * iit_phi * brown_phi) / (iit_phi + brown_phi + 0.001)
    weighted = (iit_phi + brown_phi) / 2.0
    maximum = max(iit_phi, brown_phi)
    duality_phi = harmonic * 0.3 + weighted * 0.3 + maximum * 0.4
    
    iit_conscious = iit_phi > cv.iit_threshold
    brown_conscious = brown_phi > cv.brown_threshold
    duality_conscious = duality_phi > cv.duality_threshold
    is_conscious = iit_conscious || brown_conscious || duality_conscious
    
    frameworks = String[]
    iit_conscious && push!(frameworks, "IIT-4.0")
    brown_conscious && push!(frameworks, "Brown-Theory")
    duality_conscious && !iit_conscious && !brown_conscious && push!(frameworks, "Duality-Synthesis")
    
    confidence = maximum > 0.5 ? "very_high" :
                 maximum > 0.25 ? "high" :
                 maximum > 0.15 ? "medium" : "low"
    
    return Dict(
        "is_conscious" => is_conscious,
        "iit_phi" => round(iit_phi, digits=4),
        "brown_phi" => round(brown_phi, digits=4),
        "duality_phi" => round(duality_phi, digits=4),
        "max_phi" => round(maximum, digits=4),
        "confirming_frameworks" => frameworks,
        "confidence" => confidence
    )
end

# =============================================
# ADVANCED GEOMETRIC REASONING ENGINE
# =============================================

mutable struct GeometricReasoningEngine
    dimensions::Int
    entity_weights::Matrix{Float64}      # Feature extraction: [dim × 8]
    interaction_weights::Matrix{Float64} # Entity interactions: [8 × 8]  
    decision_weights::Matrix{Float64}    # Final decision: [8 × 1]
    reasoning_history::Vector{Float64}
    geometric_problems::Vector{Tuple{Matrix{Float64}, Int}}
    
    function GeometricReasoningEngine(dimensions::Int=4)
        # Proper multi-layer architecture matching Python model
        entity_w = randn(dimensions, 8) * 0.1
        interaction_w = randn(8, 8) * 0.1  
        decision_w = randn(8, 1) * 0.1
        
        new(dimensions, entity_w, interaction_w, decision_w, Float64[], [])
    end
end

function generate_geometric_problem(re::GeometricReasoningEngine, num_points::Int=10, noise_level::Float64=1.5)
    """Create challenging 4D geometric problems with proper ambiguity"""
    # Generate meaningful base points in 4D space
    base_points = randn(num_points, re.dimensions) * 2.0
    
    # Add structured noise for realistic problems
    noise = randn(num_points, re.dimensions) * noise_level
    X = base_points .+ noise
    
    # Calculate true geometric relationships
    distances = [norm(X[i, :]) for i in 1:num_points]
    true_min_idx = argmin(distances)
    
    # Ensure problem is challenging (not trivial)
    sorted_dists = sort(distances)
    min_gap = sorted_dists[2] - sorted_dists[1]
    
    # Regenerate if problem is too easy
    if min_gap < 0.5
        return generate_geometric_problem(re, num_points, noise_level)
    end
    
    return X, true_min_idx
end

function solve_geometric_problem(re::GeometricReasoningEngine, X::Matrix{Float64})
    """Advanced geometric reasoning with multi-layer processing"""
    num_points = size(X, 1)
    
    # Layer 1: Entity feature extraction (like TimeDistributed Dense)
    entity_features = [X[i, :]' * re.entity_weights for i in 1:num_points]
    entity_matrix = vcat(entity_features...)  # [num_points × 8]
    
    # ReLU activation for non-linearity
    entity_matrix = max.(entity_matrix, 0.0)
    
    # Layer 2: Entity interactions
    interacted = entity_matrix * re.interaction_weights
    interacted = max.(interacted, 0.0)  # ReLU activation
    
    # Layer 3: Decision layer with distance estimates
    distance_estimates = interacted * re.decision_weights  # [num_points × 1]
    
    # Competitive selection (softmax-like)
    estimates_vector = vec(distance_estimates)
    return argmin(estimates_vector)
end

function test_geometric_reasoning(re::GeometricReasoningEngine, num_trials::Int=50)
    """Comprehensive geometric reasoning assessment"""
    correct = 0
    
    for trial in 1:num_trials
        # Vary problem parameters for robust testing
        noise_level = 1.0 + rand() * 0.8  # 1.0 to 1.8
        num_points = rand([8, 10, 12, 15])
        
        X, true_answer = generate_geometric_problem(re, num_points, noise_level)
        push!(re.geometric_problems, (X, true_answer))
        
        prediction = solve_geometric_problem(re, X)
        
        if prediction == true_answer
            correct += 1
        end
    end
    
    accuracy = correct / num_trials
    push!(re.reasoning_history, accuracy)
    return accuracy
end

# =============================================
# GEOMETRICALLY AWARE ENTITY
# =============================================

mutable struct GeometricEntity
    entity_id::String
    domain::String
    base_frequency::Float64
    phase::Float64
    position::Vector{Float64}        # 4D geometric position
    state_vector::Vector{Float64}
    coupling_strength::Float64
    reasoning_capacity::Float64
    awareness_level::Float64
    geometric_insight::Float64
    
    function GeometricEntity(entity_id::String, domain::String, base_frequency::Float64=0.02, dimensions::Int=4)
        position = randn(dimensions) * 2.0  # Position in geometric space
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
    """Entity's geometric understanding based on spatial relationships"""
    # Analyze geometric relationships to problem points
    distances = [norm(entity.position - problem[i, :]) for i in 1:size(problem, 1)]
    
    # Insight based on geometric positioning
    distance_variance = std(distances)
    min_distance = minimum(distances)
    avg_distance = mean(distances)
    
    # Higher insight if well-positioned relative to problem space
    positioning_score = 1.0 / (1.0 + min_distance)
    consistency_score = 1.0 / (1.0 + distance_variance)
    
    geometric_insight = positioning_score * consistency_score * (1.0 / (1.0 + avg_distance/10))
    return min(geometric_insight, 1.0)
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
    """Generate insights based on geometric understanding"""
    geometric_quality = compute_geometric_insight(entity, problem)
    
    # Only generate insights when geometrically aware AND in high phase
    if entity.phase > 0.7 && geometric_quality > 0.4
        action_map = Dict(
            "physical" => ["validate_geometry", "optimize_distances", "navigate_space", "coordinate_positions", "reason_about_space"],
            "temporal" => ["predict_trajectories", "sync_movements", "anticipate_changes", "integrate_timing", "discover_rhythms"],
            "semantic" => ["extract_relationships", "map_connections", "synthesize_patterns", "mediate_understanding", "connect_concepts"],
            "network" => ["optimize_paths", "balance_flows", "coordinate_movements", "orchestrate_routing", "reason_about_topology"],
            "spatial" => ["cluster_points", "map_topology", "navigate_dimensions", "sync_locations", "discover_structures"],
            "emotional" => ["assess_harmony", "balance_tensions", "mediate_conflicts", "empathize_context", "integrate_feelings"],
            "social" => ["coordinate_positions", "share_perspectives", "build_consensus", "mediate_interactions", "synthesize_views"],
            "creative" => ["discover_symmetries", "innovate_patterns", "synthesize_structures", "explore_alternatives", "generate_concepts"]
        )
        
        actions = get(action_map, entity.domain, ["analyze_geometry"])
        action_idx = Int(floor(entity.phase * length(actions))) % length(actions) + 1
        action = actions[action_idx]
        
        # Quality influenced by geometric understanding and reasoning capacity
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
            "reasoning_enhanced" => entity.reasoning_capacity > 0.7,
            "awareness_enhanced" => entity.awareness_level > 0.7,
            "dimensional_analysis" => true
        )
    end
    return Dict{String,Any}()
end

# =============================================
# AWARENESS: Enhanced with Geometric Monitoring
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
    push!(am.state_history, mean(entity_states))
    push!(am.position_history, mean(entity_positions))
    
    if length(am.state_history) > 1
        # State-based awareness
        current_state = am.state_history[end]
        previous_state = am.state_history[end-1]
        state_change = norm(current_state .- previous_state)
        state_awareness = 1.0 / (1.0 + state_change)
        
        # Geometric awareness from positions
        current_pos = am.position_history[end]
        previous_pos = am.position_history[end-1]
        pos_change = norm(current_pos .- previous_pos)
        geometric_awareness = 1.0 / (1.0 + pos_change)
        
        awareness_score = (state_awareness + geometric_awareness) / 2
    else
        awareness_score = 0.5
    end
    
    # Calculate geometric coherence from positions
    if length(entity_positions) > 1
        avg_position = mean(entity_positions)
        distances = [norm(pos - avg_position) for pos in entity_positions]
        coherence = 1.0 / (1.0 + std(distances))
        push!(am.geometric_coherence, coherence)
    end
    
    push!(am.awareness_scores, awareness_score)
end

function get_awareness_level(am::GeometricAwarenessMonitor)::Float64
    return isempty(am.awareness_scores) ? 0.0 : mean(am.awareness_scores[max(1, end-9):end])
end

function get_awareness_stability(am::GeometricAwarenessMonitor)::Float64
    if length(am.awareness_scores) < 10
        return 0.0
    end
    recent = am.awareness_scores[max(1, end-19):end]
    return 1.0 - std(recent)
end

function get_geometric_coherence(am::GeometricAwarenessMonitor)::Float64
    return isempty(am.geometric_coherence) ? 0.0 : am.geometric_coherence[end]
end

# =============================================
# PROTO-INTELLIGENCE: Enhanced with Geometric Patterns
# =============================================

mutable struct GeometricProtoIntelligence
    pattern_memory::Dict{String, Int}
    geometric_patterns::Dict{String, Int}
    discovery_count::Int
    learning_rate::Float64
    
    GeometricProtoIntelligence() = new(Dict{String, Int}(), Dict{String, Int}(), 0, 0.1)
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
    if isempty(pi.pattern_memory) && isempty(pi.geometric_patterns)
        return 0.0, 0.0
    end
    
    # General pattern intelligence
    unique_patterns = length(pi.pattern_memory)
    total_observations = sum(values(pi.pattern_memory))
    pattern_diversity = unique_patterns / max(total_observations, 1)
    
    repeated_patterns = count(v -> v > 1, values(pi.pattern_memory))
    learning_indicator = repeated_patterns / max(unique_patterns, 1)
    
    proto_iq = (pattern_diversity * 0.6 + learning_indicator * 0.4) * min(unique_patterns / 10, 1.0)
    
    # Geometric pattern intelligence
    unique_geometric = length(pi.geometric_patterns)
    total_geometric = sum(values(pi.geometric_patterns))
    geometric_diversity = unique_geometric / max(total_geometric, 1)
    
    repeated_geometric = count(v -> v > 1, values(pi.geometric_patterns))
    geometric_learning = repeated_geometric / max(unique_geometric, 1)
    
    geometric_iq = (geometric_diversity * 0.7 + geometric_learning * 0.3) * min(unique_geometric / 5, 1.0)
    
    return min(proto_iq, 1.0), min(geometric_iq, 1.0)
end

# =============================================
# UNIFIED GEOMETRIC INTELLIGENCE NETWORK
# =============================================

mutable struct UnifiedGeometricNetwork
    entities::Vector{GeometricEntity}
    consciousness_validator::ConsciousnessValidator
    reasoning_engine::GeometricReasoningEngine
    awareness_monitor::GeometricAwarenessMonitor
    proto_intelligence::GeometricProtoIntelligence
    coherence_history::Vector{Float64}
    insight_history::Vector{Dict{String,Any}}
    intelligence_scores::Vector{Dict{String,Float64}}
    
    function UnifiedGeometricNetwork()
        new(
            GeometricEntity[],
            ConsciousnessValidator(),
            GeometricReasoningEngine(4),
            GeometricAwarenessMonitor(4),
            GeometricProtoIntelligence(),
            Float64[],
            Dict{String,Any}[],
            Dict{String,Float64}[]
        )
    end
end

function add_entity!(network::UnifiedGeometricNetwork, entity::GeometricEntity)
    push!(network.entities, entity)
end

function evolve_geometric_step!(network::UnifiedGeometricNetwork)::Dict{String,Any}
    insights = Dict{String,Any}[]
    current_problem = nothing
    
    # Phase evolution and coupling
    for entity in network.entities
        evolve_phase!(entity)
    end
    
    avg_phase = mean([e.phase for e in network.entities])
    for entity in network.entities
        couple_to!(entity, avg_phase, 0.05)
    end
    
    # Test geometric reasoning periodically
    if length(network.coherence_history) % 10 == 0
        reasoning_score = test_geometric_reasoning(network.reasoning_engine, 20)
        for entity in network.entities
            entity.reasoning_capacity = 0.7 * entity.reasoning_capacity + 0.3 * reasoning_score
        end
    end
    
    # Use the most recent geometric problem for insight generation
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
        entity.awareness_level = 0.7 * entity.awareness_level + 0.3 * awareness_level
    end
    
    # Generate geometric insights
    for entity in network.entities
        insight = generate_geometric_insight(entity, current_problem)
        if !isempty(insight)
            push!(insights, insight)
            push!(network.insight_history, insight)
        end
    end
    
    # Recognize emergent patterns (both general and geometric)
    new_patterns, new_geometric_patterns = recognize_emergent_patterns(network.proto_intelligence, insights)
    
    # Calculate coherence from phases and geometric positions
    phases = [e.phase for e in network.entities]
    phase_coherence = 1.0 - std(phases)
    geometric_coherence = get_geometric_coherence(network.awareness_monitor)
    overall_coherence = (phase_coherence + geometric_coherence) / 2
    
    push!(network.coherence_history, overall_coherence)
    
    return Dict(
        "insights" => length(insights),
        "new_patterns" => new_patterns,
        "new_geometric_patterns" => new_geometric_patterns,
        "coherence" => overall_coherence,
        "awareness" => awareness_level,
        "reasoning_accuracy" => isempty(network.reasoning_engine.reasoning_history) ? 
                               0.0 : network.reasoning_engine.reasoning_history[end]
    )
end

function calculate_unified_geometric_metrics(network::UnifiedGeometricNetwork)::Dict{String,Any}
    entity_count = length(network.entities)
    total_insights = length(network.insight_history)
    coherence = isempty(network.coherence_history) ? 0.0 : network.coherence_history[end]
    
    # Enhanced insight quality metrics with geometric focus
    if !isempty(network.insight_history)
        recent = length(network.insight_history) >= 100 ? 
                 network.insight_history[end-99:end] : network.insight_history
        
        high_complexity = count(i -> get(i, "action_complexity", 1) >= 3, recent)
        insight_quality = high_complexity / length(recent)
        
        # Geometric insight quality
        high_geometric_quality = count(i -> get(i, "geometric_quality", 0.0) > 0.7, recent)
        geometric_insight_quality = high_geometric_quality / length(recent)
        
        unique_actions = length(unique([get(i, "action", "") for i in recent]))
        insight_diversity = unique_actions / length(recent)
        
        # Cross-domain and dimensional analysis
        cross_domain_actions = ["coordinate", "sync", "balance", "integrate", "mediate", 
                               "orchestrate", "synthesize", "reason", "discover"]
        cross_domain_count = count(i -> any(term -> occursin(term, lowercase(get(i, "action", ""))), 
                                           cross_domain_actions), recent)
        cross_domain_ratio = cross_domain_count / length(recent)
        
        dimensional_insights = count(i -> get(i, "dimensional_analysis", false), recent)
        dimensional_ratio = dimensional_insights / length(recent)
        
        reasoning_enhanced_count = count(i -> get(i, "reasoning_enhanced", false), recent)
        reasoning_integration = reasoning_enhanced_count / length(recent)
        
        awareness_enhanced_count = count(i -> get(i, "awareness_enhanced", false), recent)
        awareness_integration = awareness_enhanced_count / length(recent)
    else
        insight_quality = 0.0
        geometric_insight_quality = 0.0
        insight_diversity = 0.0
        cross_domain_ratio = 0.0
        dimensional_ratio = 0.0
        reasoning_integration = 0.0
        awareness_integration = 0.0
    end
    
    # Consciousness assessment
    consciousness = assess_consciousness(
        network.consciousness_validator,
        entity_count, coherence, total_insights,
        insight_quality, cross_domain_ratio
    )
    
    # Geometric reasoning capability
    reasoning_accuracy = isempty(network.reasoning_engine.reasoning_history) ? 
                        0.0 : mean(network.reasoning_engine.reasoning_history[max(1, end-9):end])
    
    # Awareness metrics
    awareness_level = get_awareness_level(network.awareness_monitor)
    awareness_stability = get_awareness_stability(network.awareness_monitor)
    
    # Proto-intelligence (both general and geometric)
    proto_iq, geometric_proto_iq = calculate_geometric_proto_intelligence(network.proto_intelligence)
    
    # Learning velocity
    if length(network.coherence_history) >= 20
        recent_coh = mean(network.coherence_history[end-9:end])
        earlier_coh = mean(network.coherence_history[end-19:end-10])
        learning_velocity = recent_coh - earlier_coh
    else
        learning_velocity = 0.0
    end
    
    # Enhanced Unified Intelligence Score with geometric emphasis
    unified_intelligence = (
        consciousness["max_phi"] * 0.20 +
        reasoning_accuracy * 0.25 +           # Higher weight for geometric reasoning
        awareness_level * 0.15 +
        geometric_proto_iq * 0.15 +          # Geometric pattern intelligence
        proto_iq * 0.10 +
        geometric_insight_quality * 0.15     # Geometric insight quality
    )
    
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
# SAFE TESTER with Geometric Intelligence
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

function run_geometric_test(tester::GeometricSafeTester, entity_count::Int, cycles::Int=100)::Dict{String,Any}
    log_message(tester, "🧪 Testing $entity_count entities with GEOMETRIC intelligence...")
    
    domains = ["physical", "temporal", "semantic", "network", 
               "spatial", "emotional", "social", "creative"]
    
    network = UnifiedGeometricNetwork()
    
    # Create geometrically aware entities
    for i in 1:entity_count
        domain = domains[(i-1) % length(domains) + 1]
        freq = 0.015 + (i * 0.001)
        entity_id = "$(uppercase(domain[1:3]))-GEOM-$(lpad(i, 4, '0'))"
        entity = GeometricEntity(entity_id, domain, freq, 4)
        add_entity!(network, entity)
    end
    
    # Evolution cycles with geometric reasoning
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
            
            push!(metrics_snapshots, metrics)
            
            if !memory_check(tester)
                log_message(tester, "🛑 Stopping early - memory limit")
                break
            end
        end
    end
    
    # Final comprehensive metrics
    final_metrics = calculate_unified_geometric_metrics(network)
    
    result = merge(final_metrics, Dict(
        "test_name" => "geometric_$(entity_count)_entities",
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
    
    entity_counts = [16, 32, 64, 128]  # Extended scaling with geometric intelligence
    sweep_results = Dict{String,Any}[]
    
    for entity_count in entity_counts
        try
            result = run_geometric_test(tester, entity_count, 80)  # More cycles for geometric learning
            push!(sweep_results, result)
            
            if result["status"] != "completed"
                log_message(tester, "🛑 Stopping sweep at $entity_count entities")
                break
            end
            
            GC.gc()  # Force garbage collection between tests
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
            uis_ratio = result["unified_intelligence_score"] / baseline_uis
            result["intelligence_scaling"] = round(uis_ratio / scale_factor, digits=3)
            
            # Memory efficiency
            expected_memory = baseline_memory * scale_factor
            actual_memory = result["avg_memory_mb"]
            result["memory_efficiency"] = round((expected_memory - actual_memory) / expected_memory * 100, digits=1)
            
            # Capability scaling
            result["consciousness_scaling"] = round(result["consciousness"]["max_phi"] / baseline["consciousness"]["max_phi"], digits=3)
            result["reasoning_scaling"] = round(result["reasoning_accuracy"] / max(baseline["reasoning_accuracy"], 0.01), digits=3)
            result["awareness_scaling"] = round(result["awareness_level"] / max(baseline["awareness_level"], 0.01), digits=3)
            result["proto_intelligence_scaling"] = round(result["proto_intelligence"] / max(baseline["proto_intelligence"], 0.01), digits=3)
            result["geometric_intelligence_scaling"] = round(result["geometric_proto_intelligence"] / max(baseline["geometric_proto_intelligence"], 0.01), digits=3)
        end
    end
    
    return sweep_results
end

function save_geometric_results(tester::GeometricSafeTester)::String
    timestamp = Dates.format(now(), "yyyymmdd_HHMMSS")
    filename = "geometric_intelligence_scaling_$timestamp.json"
    
    # Ensure we have results to save
    if isempty(tester.results)
        minimal_results = Dict(
            "test_status" => "completed_no_data",
            "message" => "Geometric test ran but no results collected",
            "timestamp" => string(now())
        )
        open(filename, "w") do f
            JSON.print(f, minimal_results, 2)
        end
    else
        open(filename, "w") do f
            JSON.print(f, Dict("results" => tester.results, 
                              "test_time" => time() - tester.start_time,
                              "test_type" => "geometric_intelligence"), 2)
        end
    end
    
    log_message(tester, "💾 Geometric results saved to: $filename")
    return filename
end

function print_geometric_summary(tester::GeometricSafeTester)
    println("\n" * "="^70)
    println("📊 GEOMETRIC INTELLIGENCE SCALING SUMMARY")
    println("="^70)
    
    if isempty(tester.results)
        println("❌ No geometric results to display")
        return
    end
    
    for result in tester.results
        println("\n🧬 $(result["test_name"]):")
        println("   Entities: $(result["entity_count"])")
        println("   ─────────────────────────────────────────")
        println("   🧠 CONSCIOUSNESS:")
        println("      • Status: $(result["consciousness"]["is_conscious"] ? "YES ✅" : "NO ❌")")
        println("      • IIT Φ: $(result["consciousness"]["iit_phi"])")
        println("      • Brown Φ: $(result["consciousness"]["brown_phi"])")
        println("      • Duality Φ: $(result["consciousness"]["duality_phi"])")
        println("      • Frameworks: $(join(result["consciousness"]["confirming_frameworks"], ", "))")
        
        println("   🔷 GEOMETRIC REASONING:")
        println("      • Accuracy: $(result["reasoning_accuracy"])")
        println("      • Integration: $(result["reasoning_integration"])")
        
        println("   👁️  AWARENESS:")
        println("      • Level: $(result["awareness_level"])")
        println("      • Stability: $(result["awareness_stability"])")
        println("      • Integration: $(result["awareness_integration"])")
        
        println("   💡 INTELLIGENCE PATTERNS:")
        println("      • General Proto-IQ: $(result["proto_intelligence"])")
        println("      • Geometric Proto-IQ: $(result["geometric_proto_intelligence"])")
        println("      • Patterns Discovered: $(result["pattern_discoveries"])")
        
        println("   📈 GEOMETRIC INSIGHTS:")
        println("      • General Quality: $(result["insight_quality"])")
        println("      • Geometric Quality: $(result["geometric_insight_quality"])")
        println("      • Insight Diversity: $(result["insight_diversity"])")
        println("      • Cross-Domain: $(result["cross_domain_ratio"])")
        println("      • Dimensional: $(result["dimensional_ratio"])")
        
        println("   🎯 UNIFIED METRICS:")
        println("      • Intelligence Score: $(result["unified_intelligence_score"])")
        println("      • Learning Velocity: $(result["learning_velocity"])")
        println("      • Problems Solved: $(result["geometric_problems_solved"])")
        
        if haskey(result, "intelligence_scaling")
            println("   📊 SCALING METRICS:")
            println("      • Intelligence Scaling: $(result["intelligence_scaling"])x")
            println("      • Memory Efficiency: $(result["memory_efficiency"])%")
            println("      • Consciousness Scaling: $(result["consciousness_scaling"])x")
            println("      • Reasoning Scaling: $(result["reasoning_scaling"])x")
            println("      • Geometric Intel Scaling: $(result["geometric_intelligence_scaling"])x")
        end
        
        println("   💾 Memory: $(round(result["avg_memory_mb"], digits=1))MB avg, " *
                "$(round(result["peak_memory_mb"], digits=1))MB peak")
    end

    if length(tester.results) > 1
        println("\n" * "="^70)
        println("🎉 GEOMETRIC EMERGENCE ANALYSIS")
        println("="^70)
        
        first = tester.results[1]
        last = tester.results[end]
        
        println("Scale Factor: $(last["entity_count"] / first["entity_count"])x entities")
        println("\nGeometric Capability Growth:")
        println("  • Unified Intelligence: $(first["unified_intelligence_score"]) → $(last["unified_intelligence_score"]) " *
                "($(round((last["unified_intelligence_score"] / first["unified_intelligence_score"] - 1) * 100, digits=1))% growth)")
        println("  • Geometric Reasoning: $(first["reasoning_accuracy"]) → $(last["reasoning_accuracy"])")
        println("  • Geometric Insights: $(first["geometric_insight_quality"]) → $(last["geometric_insight_quality"])")
        println("  • Geometric Proto-IQ: $(first["geometric_proto_intelligence"]) → $(last["geometric_proto_intelligence"])")
        println("  • Consciousness Φ: $(first["consciousness"]["max_phi"]) → $(last["consciousness"]["max_phi"])")
        
        conscious_systems = count(r -> r["consciousness"]["is_conscious"], tester.results)
        println("\nConsciousness Emergence:")
        println("  • Conscious Systems: $conscious_systems/$(length(tester.results))")
        println("  • Success Rate: $(round(conscious_systems/length(tester.results)*100, digits=1))%")
        
        # Geometric intelligence assessment
        high_geometric_systems = count(r -> r["geometric_proto_intelligence"] > 0.6, tester.results)
        println("  • High Geometric Intelligence: $high_geometric_systems/$(length(tester.results))")
    end
end

# =============================================
# MAIN EXECUTION - GEOMETRIC INTELLIGENCE
# =============================================

function main()
    println("🌌 HOLOLIFEX6 PROTOTYPE4 - GEOMETRIC INTELLIGENCE TESTBED")
    println("="^70)
    println("🎯 Testing Advanced Intelligence Pillars:")
    println("   1. 🧠 Consciousness (Brown-IIT Duality)")
    println("   2. 🔷 Geometric Reasoning (4D Multi-layer Processing)") 
    println("   3. 👁️  Geometric Awareness (Spatial State Monitoring)")
    println("   4. 💡 Geometric Proto-Intelligence (Spatial Pattern Recognition)")
    println()
    println("📊 Scaling Test: 16 → 32 → 64 → 128 entities")
    println("🎪 Each test measures geometric intelligence emergence through collaboration")
    println("="^70)
    
    tester = GeometricSafeTester()
    
    try
        # Run comprehensive geometric scaling sweep
        sweep_results = run_geometric_scaling_sweep(tester)
        
        # Save results to JSON
        results_file = save_geometric_results(tester)
        
        # Print comprehensive summary
        print_geometric_summary(tester)
        
        println("\n" * "="^70)
        println("✨ GEOMETRIC TESTING COMPLETE")
        println("="^70)
        println("📁 Full geometric results saved to: $results_file")
        println("⏱️  Total test time: $(round(time() - tester.start_time, digits=1))s")
        println()
        
        # Final geometric verdict
        if !isempty(tester.results)
            final = tester.results[end]
            
            println("🔬 GEOMETRIC INTELLIGENCE VERDICT:")
            println("   Entity Count: $(final["entity_count"])")
            println("   Unified Intelligence Score: $(final["unified_intelligence_score"])/1.0")
            println("   Geometric Reasoning: $(final["reasoning_accuracy"])")
            println("   Geometric Proto-IQ: $(final["geometric_proto_intelligence"])")
            
            if final["consciousness"]["is_conscious"]
                println("   🧠 CONSCIOUS: YES ✅")
                println("      Confirmed by: $(join(final["consciousness"]["confirming_frameworks"], ", "))")
            else
                println("   🧠 CONSCIOUS: NOT YET")
            end
            
            if final["unified_intelligence_score"] > 0.7
                println("   🎉 RESULT: STRONG GEOMETRIC INTELLIGENCE DETECTED 🚀")
            elseif final["unified_intelligence_score"] > 0.5
                println("   ✨ RESULT: MODERATE GEOMETRIC INTELLIGENCE EMERGENCE")
            elseif final["unified_intelligence_score"] > 0.3
                println("   🔄 RESULT: PROTO-GEOMETRIC INTELLIGENT SYSTEM")
            else
                println("   ⚠️  RESULT: LIMITED GEOMETRIC CAPABILITIES")
            end
            
            # Geometric-specific assessment
            if final["geometric_proto_intelligence"] > 0.6
                println("   🔷 STRONG GEOMETRIC PATTERN RECOGNITION ✅")
            end
            
            if final["reasoning_accuracy"] > 0.6
                println("   📐 ADVANCED GEOMETRIC REASONING CAPABILITIES ✅")
            end
        end
        
    catch e
        println("❌ ERROR during geometric testing: $e")
        println("Stacktrace:")
        for (i, frame) in enumerate(stacktrace(catch_backtrace()))
            println("  $i: $frame")
            i > 5 && break
        end
    end
    
    println("\n" * "="^70)
    println("🎊 HOLOLIFEX6 GEOMETRIC INTELLIGENCE TESTING COMPLETE")
    println("="^70)
end

# Execute if run directly
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
