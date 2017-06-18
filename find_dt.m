function [dt] = find_dt(dx,D,lambda,max_p)
dt_reproduce = max_p/lambda;
dt_diffuse = dx^2*max_p/(2*D);

dt = min(dt_diffuse, dt_reproduce);
end

