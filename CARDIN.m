eq_parm.lambda = 1; %1/hour 
eq_parm.k = 100;
eq_parm.D = 1e1; %mm^2/hour

run_parm.L = 1e3; %mm
run_parm.dx = 0.5; %mm
run_parm.t_max = 40; %hour
run_parm.initial_population = 50;
run_parm.dt_view = 0.1;
run_parm.front_ratio = 0.5;

mutation_info.time = 6;
mutation_info.placement = 0.6;
mutation_info.initial_size = 'all'; %  10;

[population1,population2] = fisher_eq_2_population(eq_parm, run_parm, mutation_info);
