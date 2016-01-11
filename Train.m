clc;
clear all;

data_sets = load('mushroom1');



shape = [data_sets.input_count,125,data_sets.output_count];

[w1,w2] = init_weights(shape);



input = data_sets.training.inputs;
target = (data_sets.training.outputs'+0.05)*0.9;
training_rate = 0.00003;

for i = 1:100
[w1 w2 error] = Backprop(input,target,training_rate,w1,w2);

errorp(i) = error;

end

error

plot(errorp)

