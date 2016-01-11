function [fitness] = update_fitness(swarm,data_sets)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:swarm.size
    fitness(i) = regression_error(data_sets.training,swarm.pos{i}.w1,swarm.pos{i}.w2);
end

end

