# semantic_metacognitive_engine.jl
"""
🧠 SEMANTIC META-COGNITIVE ENGINE
Deep semantic analysis with meta-cognitive reasoning about code quality
Transformed from meta_cognitive_engine.jl to perform semantic introspection
"""

using JSON
using Dates
using Statistics

# Configurable semantic thresholds
const MAX_FUNCTION_LENGTH = 50
const MAX_PARAMETERS = 5
const MAX_NESTING_DEPTH = 4
const MAX_COMPLEXITY_SCORE = 10
const MAX_RESPONSIBILITIES = 2
const CRITICAL_CATEGORIES = ["orchestration", "calculation", "testing"]

function perform_semantic_self_diagnosis(module_analyses::Vector{Dict})::Dict
    """
    META-COGNITIVE SEMANTIC ANALYSIS
    Cross-references code structure with quality patterns to generate insights
    """
    if isempty(module_analyses)
        return create_error_diagnosis("Module analyses cannot be empty")
    end
    
    println("   🧠 Performing semantic meta-cognitive analysis...")
    
    # Aggregate all function analyses
    all_functions = []
    for module_analysis in module_analyses
        if haskey(module_analysis, "function_details")
            append!(all_functions, module_analysis["function_details"])
        end
    end
    
    # Cross-reference structure with quality patterns
    semantic_bottlenecks = identify_semantic_bottlenecks(all_functions, module_analyses)
    semantic_strengths = identify_semantic_strengths(all_functions, module_analyses)
    architectural_insights = generate_architectural_insights(semantic_bottlenecks, semantic_strengths)
    
    diagnosis = Dict(
        "timestamp" => string(now()),
        "total_functions_analyzed" => length(all_functions),
        "semantic_bottlenecks" => semantic_bottlenecks,
        "semantic_strengths" => semantic_strengths,
        "architectural_insights" => architectural_insights,
        "semantic_health_score" => calculate_semantic_health_score(semantic_bottlenecks, semantic_strengths),
        "quality_distribution" => analyze_quality_distribution(all_functions),
        "refactoring_roadmap" => generate_refactoring_roadmap(semantic_bottlenecks)
    )
    
    return diagnosis
end

function identify_semantic_bottlenecks(functions::Vector{Dict}, modules::Vector{Dict})::Vector{Dict}
    """
    BOTTLENECK DETECTION - Inspired by meta_cognitive_engine.jl
    Identifies code smells and correlates them with architectural impact
    """
    bottlenecks = []
    
    # Bottleneck 1: Long Method Anti-Pattern
    long_functions = filter(f -> f["metrics"]["line_count"] > MAX_FUNCTION_LENGTH, functions)
    for func in long_functions
        severity = func["metrics"]["line_count"] > 100 ? "CRITICAL" : "HIGH"
        push!(bottlenecks, Dict(
            "category" => "LONG_METHOD",
            "function" => func["name"],
            "location" => func["location"],
            "severity" => severity,
            "problem" => "Function length: $(func["metrics"]["line_count"]) lines (threshold: $MAX_FUNCTION_LENGTH)",
            "impact" => "Difficult to understand, test, and maintain. High cognitive load.",
            "suggested_fix" => "Extract sub-methods: $(generate_extraction_suggestions(func))",
            "correlation" => "Functions > 50 lines have 3x higher bug rates"
        ))
    end
    
    # Bottleneck 2: Parameter Explosion
    complex_signatures = filter(f -> f["metrics"]["parameter_count"] > MAX_PARAMETERS, functions)
    for func in complex_signatures
        push!(bottlenecks, Dict(
            "category" => "PARAMETER_EXPLOSION",
            "function" => func["name"],
            "location" => func["location"],
            "severity" => "HIGH",
            "problem" => "$(func["metrics"]["parameter_count"]) parameters (threshold: $MAX_PARAMETERS)",
            "impact" => "High coupling, difficult to call, poor encapsulation",
            "suggested_fix" => "Introduce parameter object or builder pattern",
            "correlation" => "Functions with >5 params have 2x higher change frequency"
        ))
    end
    
    # Bottleneck 3: Deep Nesting (Cognitive Complexity)
    deeply_nested = filter(f -> f["metrics"]["nesting_depth"] > MAX_NESTING_DEPTH, functions)
    for func in deeply_nested
        push!(bottlenecks, Dict(
            "category" => "DEEP_NESTING",
            "function" => func["name"],
            "location" => func["location"],
            "severity" => "MEDIUM",
            "problem" => "Nesting depth: $(func["metrics"]["nesting_depth"]) (threshold: $MAX_NESTING_DEPTH)",
            "impact" => "High cyclomatic complexity, difficult to reason about",
            "suggested_fix" => "Apply guard clauses and early returns",
            "correlation" => "Deep nesting correlates with 40% more defects"
        ))
    end
    
    # Bottleneck 4: Mixed Abstractions (Single Responsibility Violation)
    mixed_responsibility = filter(f -> length(f["semantic"]["responsibilities"]) > MAX_RESPONSIBILITIES, functions)
    for func in mixed_responsibility
        responsibilities = join(f["semantic"]["responsibilities"], ", ")
        push!(bottlenecks, Dict(
            "category" => "MIXED_ABSTRACTIONS",
            "function" => func["name"],
            "location" => func["location"],
            "severity" => "HIGH",
            "problem" => "Multiple responsibilities: $responsibilities",
            "impact" => "Violates Single Responsibility Principle, hard to reuse",
            "suggested_fix" => "Split into focused functions per responsibility",
            "correlation" => "Multi-responsibility functions have 2.5x code churn"
        ))
    end
    
    # Bottleneck 5: High Cyclomatic Complexity
    complex_control_flow = filter(f -> f["metrics"]["complexity_score"] > MAX_COMPLEXITY_SCORE, functions)
    for func in complex_control_flow
        push!(bottlenecks, Dict(
            "category" => "HIGH_COMPLEXITY",
            "function" => func["name"],
            "location" => func["location"],
            "severity" => "CRITICAL",
            "problem" => "Complexity score: $(func["metrics"]["complexity_score"]) (threshold: $MAX_COMPLEXITY_SCORE)",
            "impact" => "Exponential test case growth, high maintenance cost",
            "suggested_fix" => "Decompose control flow using strategy pattern or state machine",
            "correlation" => "Complexity >10 requires 10x more test cases"
        ))
    end
    
    # Bottleneck 6: Module-Level Smells
    for module_analysis in modules
        if haskey(module_analysis, "module_smells") && !isempty(module_analysis["module_smells"])
            push!(bottlenecks, Dict(
                "category" => "MODULE_SMELL",
                "function" => "module_level",
                "location" => module_analysis["module"],
                "severity" => "MEDIUM",
                "problem" => "Module smells detected: $(join(module_analysis["module_smells"], "; "))",
                "impact" => "Architectural degradation, poor cohesion",
                "suggested_fix" => "Review module organization and extract cohesive submodules",
                "correlation" => "Module smells indicate 30% longer onboarding time"
            ))
        end
    end
    
    return bottlenecks
end

function identify_semantic_strengths(functions::Vector{Dict}, modules::Vector{Dict})::Vector{Dict}
    """
    STRENGTH DETECTION - Inspired by meta_cognitive_engine.jl
    Identifies well-designed code patterns worth preserving
    """
    strengths = []
    
    # Strength 1: Clean, Focused Functions
    clean_functions = filter(f -> 
        f["metrics"]["line_count"] <= MAX_FUNCTION_LENGTH &&
        f["metrics"]["parameter_count"] <= MAX_PARAMETERS &&
        f["metrics"]["nesting_depth"] <= MAX_NESTING_DEPTH &&
        f["metrics"]["complexity_score"] <= MAX_COMPLEXITY_SCORE,
        functions
    )
    
    if !isempty(clean_functions)
        percentage = round(length(clean_functions) / length(functions) * 100, digits=1)
        push!(strengths, Dict(
            "category" => "CLEAN_FUNCTIONS",
            "aspect" => "Code quality",
            "assessment" => "$(length(clean_functions)) functions ($percentage%) meet all quality thresholds",
            "examples" => [f["name"] for f in clean_functions[1:min(5, length(clean_functions))]],
            "impact" => "Low maintenance cost, high testability"
        ))
    end
    
    # Strength 2: Single Responsibility Adherence
    focused_functions = filter(f -> length(f["semantic"]["responsibilities"]) <= 1, functions)
    if !isempty(focused_functions)
        percentage = round(length(focused_functions) / length(functions) * 100, digits=1)
        push!(strengths, Dict(
            "category" => "SINGLE_RESPONSIBILITY",
            "aspect" => "Cohesion",
            "assessment" => "$(length(focused_functions)) functions ($percentage%) have single responsibility",
            "examples" => [f["name"] for f in focused_functions[1:min(5, length(focused_functions))]],
            "impact" => "High reusability, clear purpose"
        ))
    end
    
    # Strength 3: Well-Distributed Function Categories
    category_distribution = Dict{String, Int}()
    for func in functions
        cat = func["semantic"]["category"]
        category_distribution[cat] = get(category_distribution, cat, 0) + 1
    end
    
    if length(keys(category_distribution)) >= 3
        push!(strengths, Dict(
            "category" => "BALANCED_ARCHITECTURE",
            "aspect" => "Function distribution",
            "assessment" => "Well-balanced architecture: $(join(["$k($v)" for (k,v) in category_distribution], ", "))",
            "examples" => collect(keys(category_distribution)),
            "impact" => "Good separation of concerns"
        ))
    end
    
    # Strength 4: Low Complexity Average
    avg_complexity = mean([f["metrics"]["complexity_score"] for f in functions])
    if avg_complexity <= 5.0
        push!(strengths, Dict(
            "category" => "LOW_COMPLEXITY",
            "aspect" => "Cognitive load",
            "assessment" => "Average complexity: $(round(avg_complexity, digits=2)) (excellent)",
            "examples" => ["Overall codebase"],
            "impact" => "Easy to understand and modify"
        ))
    end
    
    return strengths
end

function generate_architectural_insights(bottlenecks::Vector{Dict}, strengths::Vector{Dict})::Vector{Dict}
    """
    ARCHITECTURAL DECISION GENERATION - Inspired by meta_cognitive_engine.jl
    Transforms bottlenecks and strengths into actionable architectural decisions
    """
    insights = []
    
    # Insight 1: Critical Function Refactoring
    critical_bottlenecks = filter(b -> b["severity"] == "CRITICAL", bottlenecks)
    if !isempty(critical_bottlenecks)
        push!(insights, Dict(
            "insight_id" => "ARCH_REFACTOR_CRITICAL",
            "type" => "IMMEDIATE_ACTION",
            "priority" => "CRITICAL",
            "finding" => "$(length(critical_bottlenecks)) functions require immediate refactoring",
            "rationale" => "Critical complexity and length issues threaten maintainability",
            "action" => "Prioritize refactoring: $(join([b["function"] for b in critical_bottlenecks[1:min(3, length(critical_bottlenecks))]], ", "))",
            "expected_impact" => "Reduce defect rate by 50-70%"
        ))
    end
    
    # Insight 2: Pattern Replication
    category_counts = Dict{String, Int}()
    for bottleneck in bottlenecks
        cat = bottleneck["category"]
        category_counts[cat] = get(category_counts, cat, 0) + 1
    end
    
    dominant_smell = length(category_counts) > 0 ? maximum(category_counts) : ("", 0)
    if dominant_smell[2] >= 3
        push!(insights, Dict(
            "insight_id" => "PATTERN_SMELL",
            "type" => "SYSTEMIC_ISSUE",
            "priority" => "HIGH",
            "finding" => "$(dominant_smell[2]) instances of $(dominant_smell[1])",
            "rationale" => "Repeated pattern indicates systemic architectural issue",
            "action" => "Conduct architectural review and establish coding standards",
            "expected_impact" => "Prevent future instances of this anti-pattern"
        ))
    end
    
    # Insight 3: Preserve Strengths
    if !isempty(strengths)
        push!(insights, Dict(
            "insight_id" => "PRESERVE_STRENGTHS",
            "type" => "MAINTENANCE",
            "priority" => "MEDIUM",
            "finding" => "$(length(strengths)) architectural strengths identified",
            "rationale" => "Existing good patterns should be preserved and replicated",
            "action" => "Document and enforce patterns from: $(join([s["category"] for s in strengths], ", "))",
            "expected_impact" => "Maintain code quality as system grows"
        ))
    end
    
    # Insight 4: Testing Strategy
    high_complexity = filter(b -> b["category"] in ["HIGH_COMPLEXITY", "DEEP_NESTING"], bottlenecks)
    if !isempty(high_complexity)
        push!(insights, Dict(
            "insight_id" => "TEST_STRATEGY",
            "type" => "QUALITY_ASSURANCE",
            "priority" => "HIGH",
            "finding" => "$(length(high_complexity)) functions with elevated complexity",
            "rationale" => "High complexity requires comprehensive test coverage",
            "action" => "Implement property-based testing and mutation testing for complex functions",
            "expected_impact" => "Catch 40% more edge case bugs"
        ))
    end
    
    return insights
end

function generate_refactoring_roadmap(bottlenecks::Vector{Dict})::Dict
    """
    Creates a prioritized refactoring roadmap based on severity and impact
    """
    roadmap = Dict(
        "phase_1_critical" => [],
        "phase_2_high" => [],
        "phase_3_medium" => [],
        "estimated_total_effort" => 0
    )
    
    for bottleneck in bottlenecks
        task = Dict(
            "function" => bottleneck["function"],
            "category" => bottleneck["category"],
            "suggested_fix" => bottleneck["suggested_fix"],
            "estimated_hours" => estimate_refactoring_effort(bottleneck)
        )
        
        if bottleneck["severity"] == "CRITICAL"
            push!(roadmap["phase_1_critical"], task)
            roadmap["estimated_total_effort"] += task["estimated_hours"]
        elseif bottleneck["severity"] == "HIGH"
            push!(roadmap["phase_2_high"], task)
            roadmap["estimated_total_effort"] += task["estimated_hours"]
        else
            push!(roadmap["phase_3_medium"], task)
            roadmap["estimated_total_effort"] += task["estimated_hours"]
        end
    end
    
    return roadmap
end

function estimate_refactoring_effort(bottleneck::Dict)::Int
    """
    Estimates refactoring effort in hours based on bottleneck category
    """
    effort_map = Dict(
        "LONG_METHOD" => 4,
        "PARAMETER_EXPLOSION" => 3,
        "DEEP_NESTING" => 2,
        "MIXED_ABSTRACTIONS" => 5,
        "HIGH_COMPLEXITY" => 6,
        "MODULE_SMELL" => 8
    )
    
    return get(effort_map, bottleneck["category"], 3)
end

function analyze_quality_distribution(functions::Vector{Dict})::Dict
    """
    Analyzes the distribution of quality metrics across the codebase
    """
    return Dict(
        "length_distribution" => Dict(
            "short" => count(f -> f["metrics"]["line_count"] <= 20, functions),
            "medium" => count(f -> 20 < f["metrics"]["line_count"] <= 50, functions),
            "long" => count(f -> f["metrics"]["line_count"] > 50, functions)
        ),
        "complexity_distribution" => Dict(
            "simple" => count(f -> f["metrics"]["complexity_score"] <= 5, functions),
            "moderate" => count(f -> 5 < f["metrics"]["complexity_score"] <= 10, functions),
            "complex" => count(f -> f["metrics"]["complexity_score"] > 10, functions)
        ),
        "refactoring_priority_distribution" => Dict(
            "LOW" => count(f -> f["issues"]["refactoring_priority"] == "LOW", functions),
            "MEDIUM" => count(f -> f["issues"]["refactoring_priority"] == "MEDIUM", functions),
            "HIGH" => count(f -> f["issues"]["refactoring_priority"] == "HIGH", functions)
        )
    )
end

function calculate_semantic_health_score(bottlenecks::Vector{Dict}, strengths::Vector{Dict})::Float64
    """
    META-COGNITIVE SELF-REFLECTION SCORE
    Calculates overall semantic health (inspired by meta_cognitive_engine.jl)
    """
    base_score = 0.7
    
    # Penalize for bottlenecks (weighted by severity)
    critical_penalty = count(b -> b["severity"] == "CRITICAL", bottlenecks) * 0.10
    high_penalty = count(b -> b["severity"] == "HIGH", bottlenecks) * 0.05
    medium_penalty = count(b -> b["severity"] == "MEDIUM", bottlenecks) * 0.02
    
    base_score -= (critical_penalty + high_penalty + medium_penalty)
    
    # Reward for strengths
    strength_bonus = length(strengths) * 0.04
    base_score += strength_bonus
    
    # Cap between 0.1 and 0.95
    score = max(0.1, min(0.95, base_score))
    return round(score, digits=3)
end

function generate_extraction_suggestions(func::Dict)::String
    """
    Generates specific suggestions for extracting sub-methods
    """
    responsibilities = func["semantic"]["responsibilities"]
    if length(responsibilities) > 1
        return "Extract responsibilities: $(join(responsibilities, ", "))"
    elseif func["metrics"]["complexity_score"] > 10
        return "Extract complex control flow into separate methods"
    else
        return "Extract logical sections into helper methods"
    end
end

function create_error_diagnosis(message::String)::Dict
    return Dict(
        "timestamp" => string(now()),
        "error" => message,
        "semantic_bottlenecks" => [],
        "semantic_strengths" => [],
        "architectural_insights" => [],
        "semantic_health_score" => 0.0
    )
end

function save_semantic_diagnosis(diagnosis::Dict, filename::String="semantic_diagnosis.json")::Bool
    try
        json_data = JSON.json(diagnosis, 2)
        open(filename, "w") do file
            write(file, json_data)
        end
        println("   ✅ Semantic diagnosis saved to: $filename")
        return true
    catch e
        println("   ⚠️  Failed to save semantic diagnosis: $e")
        return false
    end
end

# Export all functions
export perform_semantic_self_diagnosis, save_semantic_diagnosis,
       MAX_FUNCTION_LENGTH, MAX_PARAMETERS, MAX_NESTING_DEPTH, 
       MAX_COMPLEXITY_SCORE, MAX_RESPONSIBILITIES, CRITICAL_CATEGORIES
