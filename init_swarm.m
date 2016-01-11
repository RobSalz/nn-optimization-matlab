function [] = init_swarm(data_sets)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

global swarm

for i = 1:swarm.size
    swarm.pos{i}.w1 = sign(normrnd(0,1,swarm.shape(2),swarm.shape (1)+1)).*exprnd(1,swarm.shape(2),swarm.shape (1)+1);
    swarm.pos{i}.w2 = sign(normrnd(0,1,swarm.shape(3),swarm.shape (2)+1)).*exprnd(1,swarm.shape(3),swarm.shape (2)+1);
    swarm.pos{i}.fitness = regression_error(data_sets.training,swarm.pos{i}.w1,swarm.pos{i}.w2);
end 

swarm.pb = swarm.pos; %Initialize the first personal best to the first position

swarm.gb = swarm.pb{1};%Randomly set the personal best then imediately update
update_gb();

swarm.vel = init_velocities(swarm); %Initialize random intital velocities


end

