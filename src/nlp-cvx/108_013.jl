function nlp_cvx_108_013(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, x >= 0)
    @variable(model, y >= 0)

    @objective(model, Min, x^2 + y^2)
    @NLconstraint(model, 2 * x^2 - 4x * y - 4 * x + 4 <= y)
    @NLconstraint(model, y^2 <= -x + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0.8112507770394088, tol = objective_tol)
    return check_solution(
        [x, y],
        [0.6557120892286371, 0.6174888121082234],
        tol = primal_tol,
    )
end
