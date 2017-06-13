%dn/dt - d(D dn/dx)/dx = lambda*n(k-n)/k
close all; clear all;
lambda = 10; %1/hour 
k = 100;  %HOW DOES CELL SIZE AFFECT K 1e9 bacteria l ml, radius 0.55 cm
D = 1e1; %mm^2/hour

L = 1e3; %mm
dx = L/1000; %0 dimension
t_max = 24; %hour
dt_view = 0.01;
dt = (dx/0.6745)^2/(2*D); %hour , so that 50% of the time the bacteria will stay inside the cell, and 25% of it moving to each side

%intialize
t = 0:dt:t_max;
x_cells = 0:dx:L;
cells = zeros(length(x_cells)-1,length(t));
population1 = zeros(size(cells));
population2 = zeros(size(cells));
population1(1,1) = 10;
population2(1,1) = 0;

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
    if rem(i_t,dt_view) < dt 
        figure(1); clf; hold on;
        plot(x_cells(2:end),cells(:,i_t),'b-*');
        plot(x_cells(2:end),population1(:,i_t),'r-*');
        plot(x_cells(2:end),population2(:,i_t),'g-*');
        xlim([0, L]);
        ylim([0, k]);
        pause(0.01)
    end
end