eq_parm.lambda = 10; %1/hour 
eq_parm.k = 200;
eq_parm.D = 10; %mm^2/hour

run_parm.L = 1e3; %mm
run_parm.dx = 0.25; %mm
run_parm.t_max = 20; %hour
run_parm.initial_population = 50;
run_parm.dt_view = 0.5;
run_parm.front_ratio = 0.9;
run_parm.max_p = 0.25;

mutation_info.time = 2;
mutation_info.placement = 0.6;
mutation_info.initial_size = 'all'; %  10;

[population1,population2,t,front_location] = fisher_eq_2_population(eq_parm, run_parm, mutation_info);

expected_velocity = 2*sqrt(eq_parm.lambda*eq_parm.D)