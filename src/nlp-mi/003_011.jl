function nlp_mi_003_011(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    # Test Goals:
    # - non-linear objective and non-linear constraints
    # - NLobjective with offset
    
    m = Model(optimizer)
    
    @variable(m, 0 <= x <= 4, Int)
    @variable(m, 0 <= y <= 4, Int)
    
    @NLobjective(m, Max, sqrt(x+0.1) + pi)
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, 4.9022743473660775, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)
    
end

