function [populations,indices] = divideToSections(cells,k)
num_devision = 50;
first_index = findFront(cells,k,1.5);
last_index = findFront(cells,k,0);
num_devision = min(num_devision,last_index-first_index);

num_indices = floor((last_index - first_index)/num_devision);
first_index = last_index - num_indices*num_devision;

populations = zeros(length(cells),num_devision+1);
populations(1:first_index-1,1) = cells(1:first_index-1);
for i = 1:num_devision
    initial_index = first_index+(i-1)*num_indices;
    final_index = initial_index+num_indices;
    populations(initial_index:final_index,i+1) = cells(initial_index:final_index);
end
indices = [1,first_index:num_indices:last_index];
figure(1); clf; plot(populations,'*')
pause(1);
end

