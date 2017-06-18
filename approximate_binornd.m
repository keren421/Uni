function [randomized_array] = approximate_binornd(n,p)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

randomized_array = round(poissrnd(n.*p));
if ~isempty(n(isnan(randomized_array)))
    disp('PROBLEM!')
end
% randomized_array = nan(size(n));
% condition_applied = find((n.*p>5)&(n.*(1-p)>9));
% condition_not_applied = setdiff(1:length(n),condition_applied);
% 
% if ~isempty(condition_applied)
%     n1 = n(condition_applied);
%     randomized_array(condition_applied) = round(normrnd(n1.*p, sqrt(n1.*p.*(1-p))));
% end
% if ~isempty(condition_not_applied)
%     n2 = n(condition_not_applied);
%     randomized_array(condition_not_applied) = binornd(n2,p);
% end
end

