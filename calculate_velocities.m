function [] = calculate_velocities() 
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

global swarm

for i = 1:swarm.size
  r1 = rand(swarm.shape(2),swarm.shape (1)+1);
  r2 = rand(swarm.shape(3),swarm.shape (2)+1);
  
swarm.vel{i}.w1 = swarm.w*swarm.vel{i}.w1...
    +swarm.c1*r1.*(swarm.pb{i}.w1-swarm.pos{i}.w1)...
    +swarm.c2*r1.*(swarm.gb.w1-swarm.pos{i}.w1);

swarm.vel{i}.w2 = swarm.w*swarm.vel{i}.w2...
    +swarm.c1.*r2.*(swarm.pb{i}.w2-swarm.pos{i}.w2)...
    +swarm.c2.*r2.*(swarm.gb.w2-swarm.pos{i}.w2);

end

