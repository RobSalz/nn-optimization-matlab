function [vel] = init_velocities( swarm )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:swarm.size
    vel{i}.w1 = swarm.v*sign(normrnd(0,1,swarm.shape(2),swarm.shape (1)+1)).*exprnd(1,swarm.shape(2),swarm.shape (1)+1);
    vel{i}.w2 = swarm.v*sign(normrnd(0,1,swarm.shape(3),swarm.shape (2)+1)).*exprnd(1,swarm.shape(3),swarm.shape (2)+1);
end

end



