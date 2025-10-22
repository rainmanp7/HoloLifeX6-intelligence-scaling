# meta_cognitive_engine.jl
"""
ðŸ§  META-COGNITIVE ENGINE
Analyzes architecture-performance correlations and generates improvement insights
"""

using JSON
using Dates
using Statistics

# Configurable thresholds
const COMPLEXITY_THRESHOLD = 3.0
const MIN_COMMENT_COVERAGE = 0.01
const MAX_CYCLOMATIC = 20
const CRITICAL_MODULES = ["unified_network.jl", "consciousness_core.jl", "safe_tester.jl"]

function perform_self_diagnosis(architecture_scan::Dict, performance_metrics::Dict)::Dict
    # Input validation
    if isempty(architecture_scan)
        return create_error_diagnosis("Architecture scan cannot be empty")
    end
    if isempty(performance_metrics)
        return create_error_diagnosis("Performance metrics cannot be empty")
    end
    
    println("   ðŸ” Performing meta-cognitive analysis...")
    
    # Cross-reference architecture with performance
    bottlenecks = identify_bottlenecks(architecture_scan, performance_metrics)
    strengths = identify_strengths(architecture_scan, performance_metrics)
    recommendations = generate_improvement_recommendations(bottlenecks, strengths)
    
    diagnosis = Dict(
        "timestamp" => string(now()),
        "bottlenecks" => bottlenecks,
        "strengths" => strengths, 
        "recommendations" => recommendations,
        "self_reflection_score" => calculate_self_reflection_score(bottlenecks, strengths)
    )
    
    return diagnosis
end

function create_error_diagnosis(message::String)::Dict
    return Dict(
        "timestamp" => string(now()),
        "error" => message,
        "bottlenecks" => [],
        "strengths" => [],
        "recommendations" => [],
        "self_reflection_score" => 0.0
    )
end

function identify_bottlenecks(arch::Dict, perf::Dict)::Vector{Dict}
    bottlenecks = []
    
    # Analyze unified_network.jl - high complexity
    if get(arch, "average_complexity", 0.0) > COMPLEXITY_THRESHOLD
        push!(bottlenecks, Dict(
            "module" => "unified_network.jl",
            "function" => "orchestration_logic",
            "problem" => "High control flow density ($(get(arch, "average_complexity", 0.0)))",
            "impact" => "Potential maintenance complexity in core orchestrator",
            "suggested_fix" => "Consider breaking into smaller, focused functions"
        ))
    end
    
    # Analyze safe_tester.jl - low comment coverage
    if haskey(arch, "modules_analyzed") && haskey(arch["modules_analyzed"], "safe_tester.jl")
        tester_metrics = arch["modules_analyzed"]["safe_tester.jl"]
        if haskey(tester_metrics, "complexity_metrics")
            comment_cov = get(tester_metrics["complexity_metrics"], "comment_coverage", 1.0)
            if comment_cov < MIN_COMMENT_COVERAGE
                push!(bottlenecks, Dict(
                    "module" => "safe_tester.jl", 
                    "function" => "test_infrastructure",
                    "problem" => "Extremely low comment coverage ($(round(comment_cov * 100, digits=1))%)",
                    "impact" => "Difficult to maintain and extend test infrastructure",
                    "suggested_fix" => "Add comprehensive documentation for test functions"
                ))
            end
        end
    end
    
    # Check for high cyclomatic complexity
    if haskey(arch, "modules_analyzed")
        for (module_name, module_data) in arch["modules_analyzed"]
            if haskey(module_data, "complexity_metrics")
                cyclomatic = get(module_data["complexity_metrics"], "cyclomatic_indicators", 0)
                if cyclomatic > MAX_CYCLOMATIC
                    push!(bottlenecks, Dict(
                        "module" => module_name,
                        "function" => "multiple_functions",
                        "problem" => "High cyclomatic complexity ($cyclomatic indicators)",
                        "impact" => "Increased testing burden and potential bugs",
                        "suggested_fix" => "Refactor complex control flows into simpler functions"
                    ))
                end
            end
        end
    end
    
    return bottlenecks
end

function identify_strengths(arch::Dict, perf::Dict)::Vector{Dict}
    strengths = []
    
    # Low coupling architecture
    if get(arch, "system_cohesion", "") == "LOW_COUPLING"
        push!(strengths, Dict(
            "module" => "system_architecture",
            "aspect" => "Modular design",
            "assessment" => "Excellent separation of concerns with zero module dependencies"
        ))
    end
    
    # Well-balanced complexity
    avg_complexity = get(arch, "average_complexity", 0.0)
    if 1.0 <= avg_complexity <= 3.0
        push!(strengths, Dict(
            "module" => "codebase",
            "aspect" => "Complexity distribution", 
            "assessment" => "Well-balanced complexity across modules (avg: $(round(avg_complexity, digits=2)))"
        ))
    end
    
    # Consciousness core efficiency
    if haskey(arch, "modules_analyzed") && haskey(arch["modules_analyzed"], "consciousness_core.jl")
        core_metrics = arch["modules_analyzed"]["consciousness_core.jl"]
        if haskey(core_metrics, "complexity_metrics")
            core_complexity = get(core_metrics["complexity_metrics"], "control_flow_density", 10.0)
            if core_complexity < 1.0
                push!(strengths, Dict(
                    "module" => "consciousness_core.jl",
                    "aspect" => "Brown-IIT calculation",
                    "assessment" => "Highly efficient and mathematically clean implementation"
                ))
            end
        end
    end
    
    # Good function distribution
    total_funcs = get(arch, "total_functions", 0)
    module_count = get(arch, "module_count", 1)
    avg_funcs_per_module = module_count > 0 ? total_funcs / module_count : 0.0
    if 3.0 <= avg_funcs_per_module <= 8.0
        push!(strengths, Dict(
            "module" => "system_architecture", 
            "aspect" => "Function distribution",
            "assessment" => "Well-distributed responsibilities across modules"
        ))
    end
    
    return strengths
end

function generate_improvement_recommendations(bottlenecks::Vector{Dict}, strengths::Vector{Dict})::Vector{Dict}
    recommendations = []
    
    # Prioritize based on bottleneck severity and critical modules
    for bottleneck in bottlenecks
        module_name = get(bottleneck, "module", "")
        priority = "MEDIUM"
        
        if any(critical -> occursin(critical, module_name), CRITICAL_MODULES)
            priority = "HIGH"
        end
        
        push!(recommendations, Dict(
            "priority" => priority,
            "action" => get(bottleneck, "suggested_fix", "Review code structure"),
            "expected_impact" => get(bottleneck, "impact", "Improved maintainability"),
            "estimated_effort" => priority == "HIGH" ? "Medium" : "Low"
        ))
    end
    
    # Add strategic recommendations based on strengths
    if any(s -> occursin("LOW_COUPLING", get(s, "assessment", "")), strengths)
        push!(recommendations, Dict(
            "priority" => "LOW",
            "action" => "Maintain current modular architecture",
            "expected_impact" => "Preserve system stability and testability",
            "estimated_effort" => "None"
        ))
    end
    
    return recommendations
end

function calculate_self_reflection_score(bottlenecks::Vector{Dict}, strengths::Vector{Dict})::Float64
    base_score = 0.7  # Starting assumption
    
    # Penalize for bottlenecks
    bottleneck_penalty = length(bottlenecks) * 0.05
    base_score -= bottleneck_penalty
    
    # Reward for strengths  
    strength_bonus = length(strengths) * 0.03
    base_score += strength_bonus
    
    # Cap between 0.3 and 0.95
    score = max(0.3, min(0.95, base_score))
    return round(score, digits=3)
end

function save_meta_cognitive_analysis(diagnosis::Dict, filename::String="meta_cognitive_analysis.json")::Bool
    try
        json_data = JSON.json(diagnosis, 2)
        open(filename, "w") do file
            write(file, json_data)
        end
        return true
    catch e
        println("   âš ï¸  Failed to save meta-cognitive analysis: $e")
        return false
    end
end

function generate_architectural_decisions(diagnosis::Dict, evolution::Dict)::Vector{Dict}
    decisions = []
    
    # Decision 1: Address high complexity in unified_network.jl
    high_complexity_bottlenecks = filter(b -> occursin("unified_network", get(b, "module", "")), get(diagnosis, "bottlenecks", []))
    if !isempty(high_complexity_bottlenecks)
        push!(decisions, Dict(
            "decision_id" => "ARCH_REFACTOR_001",
            "type" => "COMPLEXITY_REDUCTION",
            "target_module" => "unified_network.jl", 
            "action" => "Decompose orchestration logic into specialized sub-modules",
            "rationale" => "High control flow density indicates architectural bottleneck",
            "expected_impact" => "Reduce maintenance complexity by 40%",
            "priority" => "HIGH",
            "estimated_effort" => "MEDIUM"
        ))
    end
    
    # Decision 2: Enhance documentation based on low comment coverage
    low_doc_bottlenecks = filter(b -> occursin("safe_tester", get(b, "module", "")), get(diagnosis, "bottlenecks", []))
    if !isempty(low_doc_bottlenecks)
        push!(decisions, Dict(
            "decision_id" => "DOC_IMPROVE_001", 
            "type" => "DOCUMENTATION_ENHANCEMENT",
            "target_module" => "safe_tester.jl",
            "action" => "Add comprehensive function documentation and test cases",
            "rationale" => "Critical test infrastructure has low comment coverage",
            "expected_impact" => "Improve maintainability and onboarding efficiency",
            "priority" => "MEDIUM", 
            "estimated_effort" => "LOW"
        ))
    end
    
    # Decision 3: Preserve architectural strengths
    low_coupling_strengths = filter(s -> occursin("LOW_COUPLING", get(s, "assessment", "")), get(diagnosis, "strengths", []))
    if !isempty(low_coupling_strengths)
        push!(decisions, Dict(
            "decision_id" => "ARCH_PRESERVE_001",
            "type" => "ARCHITECTURAL_PRESERVATION", 
            "target_module" => "system_architecture",
            "action" => "Maintain current modular design with zero dependencies",
            "rationale" => "Low coupling architecture enables emergent intelligence scaling",
            "expected_impact" => "Preserve system stability and testability",
            "priority" => "HIGH",
            "estimated_effort" => "NONE"
        ))
    end
    
    # Decision 4: Monitor complexity trends
    momentum = get(evolution, "momentum_analysis", Dict())
    if get(momentum, "complexity_trend", "") == "INCREASING"
        push!(decisions, Dict(
            "decision_id" => "MONITOR_001",
            "type" => "COMPLEXITY_MONITORING",
            "target_module" => "all_modules",
            "action" => "Implement automated complexity tracking with alerts",
            "rationale" => "Complexity trending upward requires proactive monitoring",
            "expected_impact" => "Early detection of architectural degradation",
            "priority" => "MEDIUM",
            "estimated_effort" => "LOW"
        ))
    end
    
    return decisions
end

# Export ALL functions and constants
export perform_self_diagnosis, save_meta_cognitive_analysis, generate_architectural_decisions,
       COMPLEXITY_THRESHOLD, MIN_COMMENT_COVERAGE, MAX_CYCLOMATIC, CRITICAL_MODULES
