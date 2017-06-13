function [ diffused_vector ] = diffuse_vector(population_vector)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    move_cells = binornd(population_vector,0.5); %amount of bacteria that will move because of diffursion
    diffused_vector = population_vector - move_cells; %all moved bacteria are reduced
    
    move_right = binornd(move_cells,0.5); %move right or left
    diffused_vector(2:end) = diffused_vector(2:end) + move_right(1:end-1);
    
    move_left = move_cells - move_right;
    diffused_vector(1:end-1) = diffused_vector(1:end-1) + move_left(2:end);
    
    diffused_vector(end) = diffused_vector(end) +  move_right(end);
    diffused_vector(1) = diffused_vector(1) + move_left(1);       
end

