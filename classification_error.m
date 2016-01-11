function [error] = classification_error(data_set,w1,w2)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here



%Number of patterns presented
lncases=length(data_set.inputs);

[~, ~, ~, output] = feedforward(w1,w2,data_set.inputs);
output = output';
classes = classes_from_outputs(output);
error = 100* sum(classes ~= data_set.classes) / lncases;


end

