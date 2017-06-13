function [population1, population2] = plantMutation(cells,k,mutation_size,mutation_placement)
eps = 2;
front_index = find(cells>eps, 1, 'last');
sat_index = find(cells>k-eps, 1, 'last');

mutation_index = round(front_index + (sat_index-front_index)*mutation_placement);
population1=cells;
population2 = zeros(size(cells));

if mutation_size == 'all'
    population2(mutation_index) = population1(mutation_index);
    population1(mutation_index) = 0;
else
    population1(mutation_index) = population1(mutation_index)-mutation_size;
    population2(mutation_index) = mutation_size;
end

end

