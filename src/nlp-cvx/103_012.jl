function nlp_cvx_103_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)

    @objective(model, Min, -x - y)
    @NLconstraint(model, x^2 <= y)
    @NLconstraint(model, -x^2 + 1 >= y)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -5 / 4, tol = objective_tol)
    return check_solution([x, y], [1 / 2, 3 / 4], tol = primal_tol)
end
