function [populations,t,front_location,winning_pop] = find_winning_location(eq_parm, run_parm, initial_profile)
lambda = eq_parm.lambda;
k = eq_parm.k;
D = eq_parm.D;

L = run_parm.L;
dx = run_parm.dx;
t_max = run_parm.t_max;
dt_view = run_parm.dt_view;
front_ratio = run_parm.front_ratio;
max_p = run_parm.max_p;

dt = find_dt(dx,D,lambda,max_p);

%intialize
t = 0:dt:t_max;
x_cells = 0:dx:L;
cells = initial_profile;
front_location = nan(size(t));

populations = divideToSections(cells,k);

for i_t = 2:length(t)
    disp(['time is ' num2str(t(i_t))])
      
    p = dt*lambda*(k-cells(:))/k;
    p = min(p,ones(size(p)));
    p = max(p,zeros(size(p)));
    if sum(p<0)~=0
        disp('PROBLEM!')
    end
    populations = populations + approximate_binornd(populations,p);
    
    if (sum(isnan(cells)) >0)
        error('a nan appeared');
    end
    
    %Diffusion
    p_diffuse = 2*D*dt/(dx^2);
    populations = diffuse_vector(populations,p_diffuse);
    
    cells = sum(populations,2);
    
    if rem(t(i_t),dt_view) < dt 
        figure(1); clf;
        plot(x_cells(2:end),cells,'*');
        xlim([0, L]);
        ylim([0, 2*k]);
        pause(0.1)
    end

    winning_pop = FindWinningPopulation(cells, populations, k, 0.99);
    if ~isnan(winning_pop)
        disp(num2str(winning_pop));
        figure(1); clf; hold on;
        plot(x_cells(2:end),populations,'*');
        xlim([0, L]);
        ylim([0, 2*k]);
        pause(0.01)
        break;
    end
        
    
    front_index = findFront(cells,k,front_ratio);
    front_location(i_t) = x_cells(front_index);
end

end



