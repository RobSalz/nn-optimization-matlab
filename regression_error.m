function [ error ] = regression_error(data_set,w1,w2)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

[~, ~, ~, output] = feedforward(w1,w2,data_set.inputs);

%Number of outputs nodes
output_count = size(w2,1);

%Number of patterns presented
lncases=length(data_set.inputs);

error = sum(sum((output - data_set.outputs') .^2)) ...
    / ( lncases * output_count)*100;

end

