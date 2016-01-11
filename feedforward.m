function [input_h, output_h, input_o, output_o] = feedforward(w1,w2,input)
%This funciton runs the network forward


% shape = [2,10,1];
% [w1,w2] = init_weights(0.1,shape)
% input = [ 0 1; 1 0; 0 0; 1 1]

lnCases = length(input);

%Create empty array that we will store the input and output of each layer
%in

LayerIn_ = {};
LayerOut_ = {};

%This is for a i - h - 0 network

        %Assuming all inputs will be row vectors for readability, thus will
        %handle the transposition of this vector in the function, will
        %also append the bias node to the input int this function
        input_h = w1*([input'; ones(1,lnCases)]);
        output_h = activate(input_h,false);
    
        input_o = w2*([output_h ; ones(1,lnCases)]);
        output_o = activate(input_o,false);
        


      



