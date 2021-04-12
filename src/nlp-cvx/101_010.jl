function nlp_cvx_101_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - linear objective
    # - single convex quadratic constraint
    # Variants
    #   010 - binding constraint (both variables non-zero)
    #   011 - binding constraint (one variable non-zero)
    #   012 - max objective

    model = Model(optimizer)

    @variable(model, -2 <= x <= 2)
    @variable(model, -2 <= y <= 2)

    @objective(model, Min, -x - y)
    @NLconstraint(model, x^2 + y^2 <= 1.0)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -2 / sqrt(2), tol = objective_tol)
    return check_solution([x, y], [1 / sqrt(2), 1 / sqrt(2)], tol = primal_tol)
end
