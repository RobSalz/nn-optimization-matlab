function y = activate(x,derivative)
%Returns activation function or its derivative for x based on boolean deriv


%Standard Sigmoid
% Returns the activation function
if derivative == false
    y = 1./(1+exp(-x));
    
%Returns the derivative of the activation function   
else
    y = 1./(1+exp(-x));
    y = y.*(1-y);
end

% %Hyperbolic tangent
% if derivative == false
%     y = 2./(1+exp(-2*x))-1;
%     
% %Returns the derivative of the activation function   
% else
% 
% end


