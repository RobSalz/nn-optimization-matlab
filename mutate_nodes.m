function [ w1,w2 ] = mutate_nodes(shape,w1,w2,n)
%Mutates the input weightsinto n randomly selected non_input nodes

hidden_nodes = shape(2);
output_nodes = shape(3);

%Create a new weight chromosone to sample our mutations from
[w1_mutate,w2_mutate] = init_weightsGA(shape);

non_input_nodes = hidden_nodes+output_nodes;

%Randomly select the first of n nodes from all the non-input nodes
node = ceil(rand(1)*non_input_nodes);

for i = 1:n
%Need to evaluate if the node is a hidden or output node and make sure we
%dont replace the same nodes input weights twice
if node <= hidden_nodes
    
    %Biased mutation
    w1(node,:) = w1(node,:) + w1_mutate(node,:);
    
    %Set that mutation schema to zero to avoid double biased mutations
    w1_mutate(node,:) = 0;
    
elseif node > hidden_nodes
    w2(node-hidden_nodes,:) = w2(node-hidden_nodes,:)+w2_mutate(node-hidden_nodes,:);
    
    w2_mutate(node-hidden_nodes,:) = 0;
end

node = ceil(rand(1)*non_input_nodes);
end
%end

