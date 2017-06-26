load('nominal_run_50.mat');
initial_profile = population1;
clear ('mutation_info' ,'population1')

run_parm.t_max = 20; %hour
run_parm.dt_view = 0.4;
run_parm.front_ratio = 0.9;
run_parm.max_p = 0.25;
num_contests = 50;
winners = nan(num_contests,1);

for i = 1:num_contests
    [populations,t,front_location,winner] = find_winning_location(eq_parm, run_parm, initial_profile);
    winners(i) = winner;
end

%%
load('winners.mat')
[populations,indices] = divideToSections(initial_profile,eq_parm.k);

L = run_parm.L;
dx = run_parm.dx;
x_cells = 0:dx:L;
x_pop = x_cells(indices);
average_x = 0.5*(x_pop(1:end-1)+x_pop(2:end));
pop_size = sum(populations,1);
percentages = nan(size(populations,2),1);
for i =1:length(percentages)
    percentages(i) = sum(winners==i)/sum(winners>0);
    if pop_size(i)>0
        %percentages(i) = percentages(i)/pop_size(i);
    else
        %percentages(i) = nan;
    end
end

plot(average_x,percentages,'*')