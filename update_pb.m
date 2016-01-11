function [ ] = update_pb( )
%Updates the personal best of each particle in a swarm
%The personal best for each particle in the swarm is updated based on the 
%fitness of the current position and personal best. The weights are bounded by a max and
%min value.

global swarm

for i = 1:swarm.size
    if swarm.pos{i}.fitness<swarm.pb{i}.fitness
    swarm.pb{i} = swarm.pos{i};
    end
end


end

