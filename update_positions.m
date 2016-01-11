function [ ] = update_positions(data_sets)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

global swarm

for i = 1:swarm.size
swarm.pos{i}.w1 = swarm.pos{i}.w1+swarm.vel{i}.w1;
swarm.pos{i}.w2 = swarm.pos{i}.w2+swarm.vel{i}.w2;
swarm.pos{i}.fitness = regression_error(data_sets.training,swarm.pos{i}.w1,swarm.pos{i}.w2);

end

end

