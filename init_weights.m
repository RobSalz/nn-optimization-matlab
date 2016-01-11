function [w1,w2] = init_weights(shape)
%This function initializes the two weight matrices for a i-h-o network 
%for a specified shape, with aditional weights for bias nodes on i and h
%with in a range which is +-1/sqrt(No_nodes)

w1 =  (2*rand (shape(2),shape (1)+1)-1)*(1/sqrt(shape(1)));
w2 = (2*rand (shape(3),shape(2)+1)-1)*(1/sqrt(shape(2)));

end

