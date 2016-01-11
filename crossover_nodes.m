function [w1,w2] = crossover_nodes(shape,w1,w2,w1_crossover,w2_crossover,n)
%Selects n random nodes from the one parent to replace in the other

hidden_nodes = shape(2);
output_nodes = shape(3);

%Specify crossover parent


non_input_nodes = hidden_nodes+output_nodes;

%Randomly select the first of n nodes from all the non-input nodes
node = ceil(rand(1)*non_input_nodes);

for i = 1:n
%Need to evaluate if the node is a hidden or output node and make sure we
%dont replace the same nodes input weights twice
if node <= hidden_nodes
    
    % Crossover
    w1(node,:) = w1_crossover(node,:);

    
elseif node > hidden_nodes
    w2(node-hidden_nodes,:) = w2_crossover(node-hidden_nodes,:);
    
end

node = ceil(rand(1)*non_input_nodes);
end
%end

