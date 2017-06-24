function [randomized_array] = approximate_binornd(n,p)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if length(p) ==1
    p = p*ones(size(n));
end
randomized_array = round(poissrnd(n.*p));
condition_applied = find((n>0)&(n.*p<9)&(n.*(1-p)<9));
randomized_array(condition_applied) = binornd(n(condition_applied),p(condition_applied));
if ~isempty(n(isnan(randomized_array)))
    disp('PROBLEM!')
end
end

