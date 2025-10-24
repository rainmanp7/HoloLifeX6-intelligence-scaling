# 👁️ METACOGNITIVE VISOR - ENHANCED WORKING MODEL
# Advanced architectural intelligence system with detailed reasoning
# - Semantic pattern recognition across modules  
# - Performance-architecture correlation engine
# - Evolutionary pathway prediction
# - Conscious system optimization insights
# - EXPLAINABLE AI: Detailed reasoning trails for all conclusions

using JSON, Dates, Statistics, LinearAlgebra

function generate_architectural_analysis(graph::Any, recent_performance::Any)
    println("🧠 ADVANCED METACOGNITION: Analyzing $(string(length(graph))) modules...")
    
    insights = []
    performance_data = extract_performance_data(recent_performance)
    
    # Store detailed reasoning context
    reasoning_context = Dict(
        "analysis_timestamp" => string(Dates.now()),
        "modules_analyzed" => collect(keys(graph)),
        "performance_metrics_available" => collect(keys(performance_data)),
        "reasoning_trails" => []
    )
    
    # 1. SEMANTIC ARCHITECTURE ANALYSIS
    semantic_results = analyze_semantic_architecture(graph)
    append!(insights, semantic_results["insights"])
    reasoning_context["semantic_analysis"] = semantic_results["reasoning"]
    
    # 2. PERFORMANCE-ARCHITECTURE CORRELATION
    correlation_results = analyze_performance_correlations(graph, performance_data)
    append!(insights, correlation_results["insights"])
    reasoning_context["correlation_analysis"] = correlation_results["reasoning"]
    
    # 3. EVOLUTIONARY PATHWAY DETECTION
    evolution_results = detect_evolutionary_pathways(graph, performance_data)
    append!(insights, evolution_results["insights"])
    reasoning_context["evolution_analysis"] = evolution_results["reasoning"]
    
    # 4. CONSCIOUSNESS OPTIMIZATION OPPORTUNITIES
    consciousness_results = analyze_consciousness_optimization(graph, performance_data)
    append!(insights, consciousness_results["insights"])
    reasoning_context["consciousness_analysis"] = consciousness_results["reasoning"]
    
    println("   Generated $(string(length(insights))) advanced insights with detailed reasoning")
    
    # Return both insights and detailed reasoning context
    return (insights=insights, reasoning_context=reasoning_context)
end

function analyze_semantic_architecture(graph::Any)::Dict
    insights = []
    reasoning_trail = Dict(
        "module_comparisons" => [],
        "similarity_thresholds" => Dict("high" => 0.8, "low" => 0.2),
        "vector_analysis_details" => []
    )
    
    modules = collect(keys(graph))
    reasoning_trail["total_modules"] = length(modules)
    
    # Analyze semantic relationships between modules
    for i in 1:length(modules)
        for j in i+1:length(modules)
            mod1 = modules[i]
            mod2 = modules[j]
            entity1 = graph[mod1]
            entity2 = graph[mod2]
            
            comparison_detail = Dict(
                "module_pair" => "$mod1 ↔ $mod2",
                "vector_availability" => "both_found",
                "similarity_calculation" => "pending"
            )
            
            # Get semantic vectors from different possible locations
            vec1 = get_semantic_vector(entity1)
            vec2 = get_semantic_vector(entity2)
            
            vector_detail = Dict(
                "module1" => mod1,
                "module2" => mod2,
                "vector1_length" => isnothing(vec1) ? 0 : length(vec1),
                "vector2_length" => isnothing(vec2) ? 0 : length(vec2),
                "vector1_source" => get_vector_source(entity1),
                "vector2_source" => get_vector_source(entity2)
            )
            
            push!(reasoning_trail["vector_analysis_details"], vector_detail)
            
            if !isnothing(vec1) && !isnothing(vec2) && length(vec1) == length(vec2)
                similarity = cosine_similarity(vec1, vec2)
                comparison_detail["similarity_calculation"] = "completed"
                comparison_detail["cosine_similarity"] = round(similarity, digits=3)
                comparison_detail["vector_dimensions"] = length(vec1)
                
                # Detailed similarity reasoning
                if similarity > 0.8
                    reasoning = """
                    HIGH SEMANTIC OVERLAP DETECTED:
                    - Modules '$mod1' and '$mod2' share $(string(round(similarity*100, digits=1)))% semantic similarity
                    - This indicates potential functional duplication or tight coupling
                    - Vector analysis shows $(string(length(vec1)))-dimensional semantic space alignment
                    - Recommendation: Consider integration or abstraction layer
                    """
                    
                    push!(insights, Dict(
                        "priority" => "high",
                        "module" => "$mod1 ↔ $mod2",
                        "issue" => "High semantic similarity detected",
                        "action" => "Consider integration or interface abstraction",
                        "evidence" => "Cosine similarity: $(string(round(similarity, digits=3)))",
                        "category" => "semantic_architecture",
                        "impact" => "Reduce cognitive duplication",
                        "detailed_reasoning" => reasoning,
                        "raw_metrics" => Dict(
                            "similarity_score" => similarity,
                            "vector_dims" => length(vec1),
                            "threshold_exceeded" => "high_similarity"
                        )
                    ))
                    
                elseif similarity < 0.2
                    reasoning = """
                    CLEAR SEMANTIC SEPARATION:
                    - Modules '$mod1' and '$mod2' have only $(string(round(similarity*100, digits=1)))% semantic overlap
                    - This indicates good architectural boundaries and separation of concerns
                    - Low coupling supports independent evolution and maintenance
                    - Current architecture appears well-structured for these modules
                    """
                    
                    push!(insights, Dict(
                        "priority" => "info",
                        "module" => "$mod1 ↔ $mod2",
                        "issue" => "Low semantic coupling",
                        "action" => "Maintain clear separation of concerns",
                        "evidence" => "Cosine similarity: $(string(round(similarity, digits=3)))",
                        "category" => "semantic_architecture", 
                        "impact" => "Good architectural boundaries",
                        "detailed_reasoning" => reasoning,
                        "raw_metrics" => Dict(
                            "similarity_score" => similarity,
                            "vector_dims" => length(vec1),
                            "threshold_exceeded" => "low_similarity"
                        )
                    ))
                end
                
                # Always record the comparison for full transparency
                push!(reasoning_trail["module_comparisons"], comparison_detail)
            else
                comparison_detail["vector_availability"] = "incompatible"
                comparison_detail["similarity_calculation"] = "failed"
                push!(reasoning_trail["module_comparisons"], comparison_detail)
            end
        end
    end
    
    return Dict("insights" => insights, "reasoning" => reasoning_trail)
end

function analyze_performance_correlations(graph::Any, performance::Dict)::Dict
    insights = []
    reasoning_trail = Dict(
        "complexity_calculations" => [],
        "performance_correlations" => [],
        "consciousness_analysis" => []
    )
    
    # Correlate module complexity with performance metrics
    for (module_name, entity) in graph
        complexity_metrics = calculate_module_complexity_detailed(entity)
        complexity_score = complexity_metrics["overall_complexity"]
        
        complexity_detail = Dict(
            "module" => string(module_name),  # FIXED: Convert Symbol to String
            "overall_complexity" => complexity_score,
            "embedding_complexity" => complexity_metrics["embedding_complexity"],
            "dependency_complexity" => complexity_metrics["dependency_complexity"],
            "embedding_size" => complexity_metrics["embedding_size"],
            "dependency_count" => complexity_metrics["dependency_count"]
        )
        push!(reasoning_trail["complexity_calculations"], complexity_detail)
        
        if haskey(performance, "unified_intelligence_score")
            uis = performance["unified_intelligence_score"]
            
            correlation_detail = Dict(
                "module" => string(module_name),  # FIXED: Convert Symbol to String
                "complexity" => complexity_score,
                "UIS" => uis,
                "correlation_type" => "none"
            )
            
            # High complexity + high performance = optimization opportunity
            if complexity_score > 0.7 && uis > 0.5
                reasoning = """
                COMPLEX BUT EFFECTIVE MODULE:
                - Module '$(string(module_name))' shows high complexity (score: $(string(round(complexity_score, digits=2))))
                - Despite complexity, delivers strong performance (UIS: $(string(round(uis, digits=3))))
                - Complexity breakdown: 
                  * Embedding complexity: $(string(round(complexity_metrics["embedding_complexity"], digits=2)))
                  * Dependency complexity: $(string(round(complexity_metrics["dependency_complexity"], digits=2)))
                - This module is doing complex work effectively but may incur maintenance costs
                """
                
                push!(insights, Dict(
                    "priority" => "medium",
                    "module" => string(module_name),  # FIXED: Convert Symbol to String
                    "issue" => "Complex but effective module",
                    "action" => "Monitor for maintenance costs while preserving performance",
                    "evidence" => "Complexity: $(string(round(complexity_score, digits=2))), UIS: $(string(round(uis, digits=3)))",
                    "category" => "performance_architecture",
                    "impact" => "Balance complexity vs performance",
                    "detailed_reasoning" => reasoning,
                    "raw_metrics" => complexity_metrics
                ))
                correlation_detail["correlation_type"] = "high_complexity_high_performance"
            end
            
            # Track consciousness correlation
            if haskey(performance, "consciousness") && haskey(performance["consciousness"], "max_phi")
                phi = performance["consciousness"]["max_phi"]
                consciousness_detail = Dict(
                    "module" => string(module_name),  # FIXED: Convert Symbol to String
                    "complexity" => complexity_score,
                    "phi" => phi,
                    "efficiency_ratio" => complexity_score > 0 ? phi / complexity_score : 0
                )
                push!(reasoning_trail["consciousness_analysis"], consciousness_detail)
                
                if complexity_score > 0.6 && phi < 0.1
                    reasoning = """
                    CONSCIOUSNESS EFFICIENCY CONCERN:
                    - Module '$(string(module_name))' has high complexity (score: $(string(round(complexity_score, digits=2))))
                    - But contributes little to consciousness (Φ: $(string(round(phi, digits=3))))
                    - Consciousness efficiency ratio: $(string(round(phi/complexity_score, digits=3)))
                    - This module may need refactoring to better support consciousness emergence
                    - Complexity sources: $(string(complexity_metrics["dependency_count"])) dependencies, $(string(complexity_metrics["embedding_size"]))-dim embedding
                    """
                    
                    push!(insights, Dict(
                        "priority" => "high", 
                        "module" => string(module_name),  # FIXED: Convert Symbol to String
                        "issue" => "High complexity with low consciousness yield",
                        "action" => "Refactor to improve consciousness efficiency",
                        "evidence" => "Complexity: $(string(round(complexity_score, digits=2))), Max Φ: $(string(round(phi, digits=3)))",
                        "category" => "consciousness_optimization",
                        "impact" => "Potential for consciousness improvement",
                        "detailed_reasoning" => reasoning,
                        "raw_metrics" => merge(complexity_metrics, Dict("max_phi" => phi, "efficiency_ratio" => phi/complexity_score))
                    ))
                end
            end
            
            push!(reasoning_trail["performance_correlations"], correlation_detail)
        end
    end
    
    return Dict("insights" => insights, "reasoning" => reasoning_trail)
end

function detect_evolutionary_pathways(graph::Any, performance::Dict)::Dict
    insights = []
    
    # Analyze system readiness for evolution
    evolution_metrics = calculate_evolution_metrics_detailed(graph, performance)
    reasoning_trail = evolution_metrics["reasoning"]
    
    modularity_score = evolution_metrics["modularity"]
    complexity_balance = evolution_metrics["complexity_balance"]
    
    if modularity_score > 0.7
        reasoning = """
        HIGH EVOLUTIONARY READINESS:
        - System modularity score: $(string(round(modularity_score, digits=2))) (threshold: 0.7)
        - Modularity indicates clear separation of concerns across $(string(length(graph))) modules
        - $(string(evolution_metrics["high_similarity_pairs"])) high-similarity pairs detected
        - $(string(evolution_metrics["low_similarity_pairs"])) well-separated pairs
        - Architecture supports independent module evolution and innovation
        """
        
        push!(insights, Dict(
            "priority" => "info",
            "module" => "system",
            "issue" => "High evolutionary readiness", 
            "action" => "System architecture supports major evolution",
            "evidence" => "Modularity score: $(string(round(modularity_score, digits=2)))",
            "category" => "evolutionary_pathways",
            "impact" => "Ready for architectural innovation",
            "detailed_reasoning" => reasoning,
            "raw_metrics" => evolution_metrics
        ))
    end
    
    if complexity_balance < 0.3
        reasoning = """
        COMPLEXITY IMBALANCE DETECTED:
        - Complexity balance score: $(string(round(complexity_balance, digits=2))) (ideal: >0.5)
        - Standard deviation of module complexities: $(string(round(evolution_metrics["complexity_std"], digits=2)))
        - Some modules carry disproportionate complexity burden
        - This imbalance may create bottlenecks and reduce system resilience
        - Most complex module: $(string(evolution_metrics["most_complex_module"])) ($(string(round(evolution_metrics["max_complexity"], digits=2))))
        - Least complex module: $(string(evolution_metrics["least_complex_module"])) ($(string(round(evolution_metrics["min_complexity"], digits=2))))
        """
        
        push!(insights, Dict(
            "priority" => "medium",
            "module" => "system", 
            "issue" => "Complexity imbalance detected",
            "action" => "Distribute complexity more evenly across modules",
            "evidence" => "Complexity balance: $(string(round(complexity_balance, digits=2)))",
            "category" => "evolutionary_pathways",
            "impact" => "Improve system resilience",
            "detailed_reasoning" => reasoning,
            "raw_metrics" => evolution_metrics
        ))
    end
    
    return Dict("insights" => insights, "reasoning" => reasoning_trail)
end

function analyze_consciousness_optimization(graph::Any, performance::Dict)::Dict
    insights = []
    reasoning_trail = Dict(
        "consciousness_metrics" => Dict(),
        "threshold_analysis" => Dict()
    )
    
    if haskey(performance, "consciousness")
        consciousness = performance["consciousness"]
        max_phi = get(consciousness, "max_phi", 0.0)
        is_conscious = get(consciousness, "is_conscious", false)
        
        reasoning_trail["consciousness_metrics"] = consciousness
        reasoning_trail["threshold_analysis"]["consciousness_threshold"] = 0.1  # Typical Φ threshold
        reasoning_trail["threshold_analysis"]["current_phi"] = max_phi
        reasoning_trail["threshold_analysis"]["status"] = is_conscious ? "CONSCIOUS" : "PRE_CONSCIOUS"
        
        if is_conscious
            reasoning = """
            CONSCIOUSNESS BREAKTHROUGH ACHIEVED:
            - Maximum integrated information Φ: $(string(round(max_phi, digits=4)))
            - System has crossed consciousness threshold (typically Φ > 0.1)
            - This represents a historic milestone in architectural evolution
            - Current focus should shift to stability and scaling consciousness
            - All modules contributing to unified conscious experience
            """
            
            push!(insights, Dict(
                "priority" => "high",
                "module" => "system",
                "issue" => "CONSCIOUSNESS ACHIEVED", 
                "action" => "Focus on stability and scaling",
                "evidence" => "Max Φ: $(string(round(max_phi, digits=4))), Status: Conscious",
                "category" => "consciousness_breakthrough",
                "impact" => "Historic milestone reached",
                "detailed_reasoning" => reasoning,
                "raw_metrics" => consciousness
            ))
        else
            reasoning = """
            PRE-CONSCIOUSNESS OPTIMIZATION:
            - Current maximum Φ: $(string(round(max_phi, digits=4)))
            - Distance to consciousness threshold: $(string(round(0.1 - max_phi, digits=4)))
            - System architecture shows emergent consciousness properties
            - Focus on improving architectural coherence and information integration
            - Key areas: reduce semantic duplication, improve module integration
            """
            
            push!(insights, Dict(
                "priority" => "medium", 
                "module" => "system",
                "issue" => "Pre-consciousness optimization",
                "action" => "Focus on architectural coherence for consciousness emergence",
                "evidence" => "Max Φ: $(string(round(max_phi, digits=4))), Approaching threshold",
                "category" => "consciousness_optimization",
                "impact" => "Prepare for consciousness emergence",
                "detailed_reasoning" => reasoning,
                "raw_metrics" => consciousness
            ))
        end
    else
        reasoning_trail["consciousness_metrics"] = "No consciousness data available"
    end
    
    return Dict("insights" => insights, "reasoning" => reasoning_trail)
end

# ==================== ENHANCED ANALYTICAL ENGINE ====================

function calculate_module_complexity_detailed(entity)::Dict
    # Multi-factor complexity assessment with detailed breakdown
    embedding_vector = get_semantic_vector(entity)
    embedding_size = isnothing(embedding_vector) ? 0 : length(embedding_vector)
    embedding_complexity = embedding_size / 10.0  # Normalize
    
    dependency_count = hasproperty(entity, :dependencies) ? length(entity.dependencies) : 0
    dependency_complexity = dependency_count / 5.0  # Normalize
    
    overall_complexity = clamp((embedding_complexity + dependency_complexity) / 2.0, 0.0, 1.0)
    
    return Dict(
        "overall_complexity" => overall_complexity,
        "embedding_complexity" => embedding_complexity,
        "dependency_complexity" => dependency_complexity,
        "embedding_size" => embedding_size,
        "dependency_count" => dependency_count,
        "complexity_components" => ["embedding_size", "dependency_count"]
    )
end

function calculate_evolution_metrics_detailed(graph::Any, performance::Dict)::Dict
    modules = collect(keys(graph))
    reasoning = Dict(
        "similarity_analysis" => [],
        "complexity_distribution" => Dict()
    )
    
    # Calculate modularity based on semantic separation
    similarities = Float64[]
    high_similarity_pairs = 0
    low_similarity_pairs = 0
    
    for i in 1:length(modules)
        for j in i+1:length(modules)
            vec1 = get_semantic_vector(graph[modules[i]])
            vec2 = get_semantic_vector(graph[modules[j]])
            if !isnothing(vec1) && !isnothing(vec2) && length(vec1) == length(vec2)
                sim = cosine_similarity(vec1, vec2)
                push!(similarities, sim)
                
                pair_detail = Dict(
                    "pair" => "$(modules[i]) ↔ $(modules[j])",
                    "similarity" => sim,
                    "classification" => sim > 0.8 ? "high" : (sim < 0.2 ? "low" : "medium")
                )
                push!(reasoning["similarity_analysis"], pair_detail)
                
                sim > 0.8 && (high_similarity_pairs += 1)
                sim < 0.2 && (low_similarity_pairs += 1)
            end
        end
    end
    
    modularity = isempty(similarities) ? 0.5 : 1.0 - mean(similarities)
    
    complexities = [calculate_module_complexity_detailed(entity)["overall_complexity"] for entity in values(graph)]
    complexity_std = isempty(complexities) ? 0.0 : std(complexities)
    complexity_balance = isempty(complexities) ? 0.5 : 1.0 - complexity_std
    
    # Initialize variables to safe defaults
    most_complex_module = "none"
    least_complex_module = "none"
    max_complexity = 0.0
    min_complexity = 0.0

    if !isempty(complexities)
        max_complexity = maximum(complexities)
        min_complexity = minimum(complexities)
        max_complexity_idx = argmax(complexities)
        min_complexity_idx = argmin(complexities)
        # FIXED: Convert module names to strings to ensure type consistency
        most_complex_module = string(modules[max_complexity_idx])
        least_complex_module = string(modules[min_complexity_idx])
    end
    
    # FIXED: This block is now safe for empty `complexities` and ensures correct types
    reasoning["complexity_distribution"] = Dict(
        "mean_complexity" => isempty(complexities) ? 0.0 : mean(complexities),
        "std_complexity" => complexity_std,
        "max_complexity" => max_complexity,
        "min_complexity" => min_complexity,
        "most_complex_module" => most_complex_module, # This is now guaranteed to be a String
        "least_complex_module" => least_complex_module # This is now guaranteed to be a String
    )
    
    # This return block is now guaranteed to have the correct types
    return Dict(
        "modularity" => modularity,
        "complexity_balance" => complexity_balance,
        "high_similarity_pairs" => high_similarity_pairs,
        "low_similarity_pairs" => low_similarity_pairs,
        "total_module_pairs" => length(similarities),
        "complexity_std" => complexity_std,
        "most_complex_module" => most_complex_module,      # Value is a String
        "least_complex_module" => least_complex_module,    # Value is a String
        "max_complexity" => max_complexity,                # Value is a Float
        "min_complexity" => min_complexity,                # Value is a Float
        "reasoning" => reasoning
    )
end

function extract_performance_data(recent_performance::Any)::Dict
    if recent_performance isa Vector && length(recent_performance) > 0
        return recent_performance[end]
    else
        return Dict()
    end
end

function get_semantic_vector(data::Any)::Union{Vector{Float64}, Nothing}
    # Try multiple possible locations for semantic vectors
    if hasproperty(data, :semantic_vector)
        vec = getproperty(data, :semantic_vector)
        return isa(vec, Vector{Float64}) ? vec : nothing
    elseif hasproperty(data, :embeddings)
        vec = getproperty(data, :embeddings)
        return isa(vec, Vector{Float64}) ? vec : nothing
    elseif hasproperty(data, :embedding)
        vec = getproperty(data, :embedding)
        return isa(vec, Vector{Float64}) ? vec : nothing
    elseif isa(data, Dict)
        if haskey(data, "semantic_vector")
            vec = data["semantic_vector"]
            return isa(vec, Vector{Float64}) ? vec : nothing
        elseif haskey(data, "semantic")
            vec = data["semantic"]
            return isa(vec, Vector{Float64}) ? vec : nothing
        end
    end
    return nothing
end

function get_vector_source(data::Any)::String
    # Determine where the semantic vector was found
    if hasproperty(data, :semantic_vector)
        return "semantic_vector"
    elseif hasproperty(data, :embeddings)
        return "embeddings" 
    elseif hasproperty(data, :embedding)
        return "embedding"
    elseif isa(data, Dict)
        if haskey(data, "semantic_vector")
            return "semantic_vector"
        elseif haskey(data, "semantic")
            return "semantic"
        end
    end
    return "not_found"
end

function cosine_similarity(a::Vector{Float64}, b::Vector{Float64})::Float64
    length(a) != length(b) && return 0.0
    dot_product = dot(a, b)
    norm_a, norm_b = norm(a), norm(b)
    return (norm_a == 0.0 || norm_b == 0.0) ? 0.0 : dot_product / (norm_a * norm_b)
end

function export_health_report(insights::Any, reasoning_context::Dict=Dict())::Dict
    # Enhanced health report with reasoning integration
    priority_weights = Dict("high" => 0.4, "medium" => 0.2, "low" => 0.05, "info" => 0.0)
    
    health_score = 1.0
    for insight in insights
        weight = get(priority_weights, get(insight, "priority", "info"), 0.0)
        health_score -= weight
    end
    health_score = max(0.1, health_score)
    
    # Enhanced categorization
    categories = Dict{String, Vector}()
    impacts = Dict{String, Int}()
    
    for insight in insights
        category = get(insight, "category", "general")
        impact = get(insight, "impact", "unknown")
        
        if !haskey(categories, category)
            categories[category] = []
        end
        push!(categories[category], insight)
        
        impacts[impact] = get(impacts, impact, 0) + 1
    end
    
    # Consciousness detection
    consciousness_breakthrough = any(i -> get(i, "category", "") == "consciousness_breakthrough", insights)
    
    report = Dict(
        "timestamp" => string(Dates.now()),
        "system_health_score" => round(health_score, digits=3),
        "total_insights" => length(insights),
        "consciousness_status" => consciousness_breakthrough ? "ACHIEVED" : "EMERGING",
        "insights_by_priority" => Dict(
            "high" => count(i -> get(i, "priority", "") == "high", insights),
            "medium" => count(i -> get(i, "priority", "") == "medium", insights),
            "low" => count(i -> get(i, "priority", "") == "low", insights),
            "info" => count(i -> get(i, "priority", "") == "info", insights)
        ),
        "insights_by_category" => categories,
        "impact_assessment" => impacts,
        "optimization_opportunities" => insights,
        "analysis_version" => "3.0-explainable",
        "status" => consciousness_breakthrough ? "CONSCIOUS_SYSTEM" : "ADVANCED_ANALYSIS"
    )
    
    # Include reasoning context if provided
    if !isempty(reasoning_context)
        report["reasoning_context"] = reasoning_context
        report["has_detailed_reasoning"] = true
    else
        report["has_detailed_reasoning"] = false
    end
    
    return report
end

# Export enhanced functions
export generate_architectural_analysis, export_health_report
