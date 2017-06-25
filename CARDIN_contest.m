load('nominal_run_50.mat');
initial_profile = population1;
clear ('mutation_info' ,'population1')

run_parm.t_max = 10; %hour
run_parm.dt_view = 0.4;
run_parm.front_ratio = 0.9;
run_parm.max_p = 0.25;
num_contests = 10;
winners = nan(num_contests,1);

for i = 1:num_contests
    [populations,t,front_location,winner] = find_winning_location(eq_parm, run_parm, initial_profile);
    winners(i) = winner;
end
