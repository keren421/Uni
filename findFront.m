function [index] = findFront(cells,k,front_ratio)
    index = find(cells>k*front_ratio, 1, 'last');
    if isempty(index)
        index = 1;
    end

end

