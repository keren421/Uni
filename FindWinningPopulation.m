function [ winningPopulation ] = FindWinningPopulation(cells,populations_array,k,precentage)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
first_index = findFront(cells,k,1.5);
last_index = findFront(cells,k,0.0);
tot_front_population = sum(cells(first_index:last_index));
winningPopulation = nan;
for i = 1:size(populations_array,2)
    if sum(populations_array(first_index:last_index,i))>precentage*tot_front_population
        winningPopulation = i;
    end
end

end

