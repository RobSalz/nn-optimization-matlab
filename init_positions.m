function [ pos] = init_positions(swarm,data_sets)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:swarm.size
    pos{i}.w1 = sign(normrnd(0,1,swarm.shape(2),swarm.shape (1)+1)).*exprnd(1,swarm.shape(2),swarm.shape (1)+1);
    pos{i}.w2 = sign(normrnd(0,1,swarm.shape(3),swarm.shape (2)+1)).*exprnd(1,swarm.shape(3),swarm.shape (2)+1);
    pos{i}.fitness = regression_error(data_sets.training,pos{i}.w1,pos{i}.w2);
end 

end



