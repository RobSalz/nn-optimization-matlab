function [w1,w2,error] = trainEpoch(input,target,training_rate,w1,w2)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here



lnCases = length(input);


%Run the network
[input_h, output_h, input_o, output_o] = feedforward(w1,w2,input);
output_o'

%Compute delta's
        %compare to the target values
        delta_o = output_o - target;
        %Sum of sqaures of differences of all the outputs and targets
        error = sum(sum(delta_o.^2))/lnCases;
        delta_out = (activate(input_o,true).*delta_o);

        %compare to the output layer delta
        delta_h = (w2')*delta_out;
        delta_hid = delta_h(1:end-1,:).*activate(input_h,true);
        
 %Compute weight delta's

        wd1 = w1*0;
        wd2 = w2*0;
        output_i = [input'; ones(1,lnCases)]';
        output_hid = [output_h ; ones(1,lnCases)]';
        
 %Weight Delta Between i - h       
        for i = 1:lnCases
            wd1 =   wd1+delta_hid(:,i)*output_i(i,:);
        end
        
%Weight Delta between h - o
        for i = 1:lnCases
          wd2 =   wd2+delta_out(:,i)*output_hid(i,:);
        end
        
%Update weights
w1 = w1 - training_rate * wd1;
w2 = w2 - training_rate*wd2;

end



 