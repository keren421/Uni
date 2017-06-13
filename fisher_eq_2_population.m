function [population1,population2] = fisher_eq_2_population(eq_parm, run_parm, mutation_info)
lambda = eq_parm.lambda;
k = eq_parm.k;
D = eq_parm.D;

L = run_parm.L;
dx = run_parm.dx;
t_max = run_parm.t_max;
initial_population = run_parm.initial_population;
dt_view = run_parm.dt_view;
front_ratio = run_parm.front_ratio;

t_mutation = mutation_info.time;
mutation_placement = mutation_info.placement;
mutation_size = mutation_info.initial_size;

dt = (dx/0.6745)^2/(2*D); %hour , so that 50% of the time the bacteria will stay inside the cell, and 25% of it moving to each side

%intialize
t = 0:dt:t_max;
x_cells = 0:dx:L;
cells = zeros(length(x_cells)-1,length(t));
population1 = zeros(size(cells));
population2 = zeros(size(cells));
front_location = nan(size(t));
population1(1,1) = initial_population;

for i_t = 2:length(t)
    disp(['time is ' num2str(t(i_t))])
      
    p = dt*lambda*(k-cells(:,i_t-1))/k;
    p = min(p,ones(size(p)));
    p = max(p,zeros(size(p)));
    population1(:,i_t) = population1(:,i_t-1) + binornd(population1(:,i_t-1),p);
    population2(:,i_t) = population2(:,i_t-1) + binornd(population2(:,i_t-1),p);
    
    if (sum(isnan(cells(:,i_t))) >0)
        error('a nan appeared');
    end
    
    %Diffusion
    population1(:,i_t) = diffuse_vector(population1(:,i_t));
    population2(:,i_t) = diffuse_vector(population2(:,i_t));
    
    cells(:,i_t) = population1(:,i_t) + population2(:,i_t);
    if rem(t(i_t),dt_view) < dt 
        figure(1); clf; hold on;
        plot(x_cells(2:end),cells(:,i_t),'b-*');
        plot(x_cells(2:end),population1(:,i_t),'r-*');
        plot(x_cells(2:end),population2(:,i_t),'g-*');
        xlim([0, L]);
        ylim([0, k]);
        pause(0.01)
        
    end
    
    if abs(t(i_t)-t_mutation) < dt
        [population1(:,i_t),population2(:,i_t)] = plantMutation(cells(:,i_t),...
                                     k, mutation_size, mutation_placement);
        figure(1); clf; hold on;
        plot(x_cells(2:end),cells(:,i_t),'b-*');
        plot(x_cells(2:end),population1(:,i_t),'r-*');
        plot(x_cells(2:end),population2(:,i_t),'g-*');
        xlim([0, L]);
        ylim([0, k]);
        pause(0.01)
    end
    
    front_index = findFront(cells(:,i_t),k,front_ratio);
    front_location(i_t) = x_cells(front_index);
end

figure(2);
plot(t, front_location,'b-*');
grid on;
xlabel('t [hour]');
ylabel('x [mm]');
title('Front location');

figure(3);
plot(t(2:end), diff(front_location)./diff(t),'b-*');
grid on;
xlabel('t [hour]');
ylabel('x [mm]');
title('Front Speed');
end



