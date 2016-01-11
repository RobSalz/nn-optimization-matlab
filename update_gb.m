function [] = update_gb()
%Updates the global best of the swarm 
%This function returns the personal best of the fittest particle in the
%swarm
global swarm
for i = 1:swarm.size
    if swarm.pb{i}.fitness<=swarm.gb.fitness
        swarm.gb = swarm.pb{i};
    end
end

end

