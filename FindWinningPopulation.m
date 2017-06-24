function [ winningPopulation ] = FindWinningPopulation(cells,populations_array,k,precentage)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
first_index = findFront(cells,k,0.99);
last_index = findFront(cells,k,0.01);
tot_front_population = sum(cells(first_index:last_index));
winningPopulation = nan;
for i = 1:length(populations_array)
    if sum(populations_array{i}(first_index:last_index))>precentage*tot_front_population
        winningPopulation = i;
    end
end

end

