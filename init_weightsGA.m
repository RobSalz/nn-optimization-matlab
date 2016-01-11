function [w1, w2] = init_weightsGA(shape)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


w1 = sign(normrnd(0,1,shape(2),shape (1)+1)).*exprnd(1,shape(2),shape (1)+1);
w2 = sign(normrnd(0,1,shape(3),shape (2)+1)).*exprnd(1,shape(3),shape (2)+1);


end

