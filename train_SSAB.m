function [result] = train_SSAB()

clc
clear all

data_sets = load('cancer1');

%Network Parameters

%No Hidden Nodes
hidden_nodes= 32;

%i-h-o 
shape = [data_sets.input_count,hidden_nodes,data_sets.output_count];

%Initialize network weights
[w1,w2] = init_weights(shape);

%Training input and target values from data
input = data_sets.training.inputs;
target = data_sets.training.outputs';


%Set the gradient(t-1) = 0;
pdEdw1 = w1*0;
pdEdw2 = w2*0;

%Set the weight delta (t-1) = 0;
pwd1 = w1*0;
pwd2 = w2*0;

%Initialize the per weight learning rates
nw1 = w1*0 + 0.005;
nw2 = w2*0 + 0.005;
pnw1 = w1*0 + 0.005;
pnw2 = w2*0 + 0.005;
%Learning rate increase and deacrease Values
n_neg = 0.2;
n_pos = 1.2;

%Momentum value
momentum = 0.5;

wd1 = [];
wd2 = [];

max_epochs = 1000;
lnCases = length(input);


%Train 
pE_opt = 100;
P_k(1) =10;
for epoch = 1:max_epochs
%RPROP weight update
%Run the network
[input_h, output_h, input_o, output_o] = feedforward(w1,w2,input);

%Compute delta's
        delta_o = output_o - target;
        delta_out = (activate(input_o,true).*delta_o);

        %compare to the output layer delta
        delta_h = (w2')*delta_out;
        delta_hid = delta_h(1:end-1,:).*activate(input_h,true);
        
 %Compute weight gradients
        dEdw1 = w1*0;
        dEdw2 = w2*0;
        output_i = [input'; ones(1,lnCases)]';
        output_hid = [output_h ; ones(1,lnCases)]';
        
 %Weight Delta gradient i - h       
        for i = 1:lnCases
            dEdw1 =   dEdw1+delta_hid(:,i)*output_i(i,:);
        end
        
%Weight gradient h - o (for the whole dataset
        for i = 1:lnCases
          dEdw2 =   dEdw2+delta_out(:,i)*output_hid(i,:);
        end
        
%Update the weight update values with per weight learning rate
        wd1 = nw1.*dEdw1 + momentum*pwd1;
        wd2 = nw2.*dEdw2 + momentum*pwd2;
        
        pwd1 = wd1;
        pwd2 = wd2;
        
%Run through all the rows of the weight matrix
for i = 1: size(w1,1)
    
    %Runs through all the columns of the i - o weight matrix
    for j = 1:size(w1,2)
        %if there is no sign change in the gradient, increase per weight learning rate
        if dEdw1(i,j)*pdEdw1(i,j)>0
            nw1(i,j) = pnw1(i,j)*n_pos; 
            pnw1(i,j) = nw1(i,j);
            pdEdw1(i,j)=dEdw1(i,j);
            
            % if there is a sign change, reduce per weight learning rate,
            % revert weight update, and set previous weight update to zero.
        elseif dEdw1(i,j)*pdEdw1(i,j)<0
            nw1(i,j) = pnw1(i,j)*n_neg;
            pnw1(i,j) = nw1(i,j);
            wd1(i,j) = pwd1(i,j);
            pwd1(i,j) = 0;
            
            pdEdw1(i,j)=dEdw1(i,j);
        else
            pdEdw1(i,j)=dEdw1(i,j);
        end 
    end
end

%Run through all the rows of the weight matrix
for i = 1: size(w2,1)
    
    %Runs through all the columns of the i - o weight matrix
    for j = 1:size(w2,2)
        %if there is no sign change in the gradient, increase per weight learning rate
        if dEdw2(i,j)*pdEdw2(i,j)>0
            nw2(i,j) = pnw2(i,j)*n_pos; 
            pnw2(i,j) = nw2(i,j);
            pdEdw2(i,j)=dEdw2(i,j);
            
            % if there is a sign change, reduce per weight learning rate,
            % revert weight update, and set previous weight update to zero.
        elseif dEdw2(i,j)*pdEdw2(i,j)<0
            nw2(i,j) = pnw2(i,j)*n_neg;
            pnw2(i,j) = nw2(i,j);
            wd2(i,j) = -pwd2(i,j);
            pwd2(i,j) = 0;
            
            pdEdw1(i,j)=dEdw2(i,j);
        else
            pdEdw1(i,j)=dEdw2(i,j);
        end 
    end
end

%Update weights
w1 = w1-wd1;
w2 = w2-wd2;

%Evaluate network at each epoch
tr_reg_error(epoch) = regression_error(data_sets.training,w1,w2);
va_reg_error (epoch) = regression_error(data_sets.validation,w1,w2);
te_reg_error(epoch) = regression_error(data_sets.test,w1,w2);
te_class_error(epoch) = classification_error(data_sets.test,w1,w2);
        

%Determing position and value of smallest validation error
[E_opt,epoch_opt] = min(va_reg_error);

%Generalization loss using stip length 5 epochs
GL=0;
if epoch>=5
    GL = ((va_reg_error(epoch))/(E_opt)-1)*100;
end

%Training Progress in strip length k 
k = 5;

if (rem(epoch,k)) == 0
    P_k(end) = 1000*((mean(tr_reg_error(epoch-k+1:epoch)))...
        /(min(tr_reg_error(epoch-k+1:epoch)))-1);
end


if GL/P_k > 0.5 || min(P_k) < 1;
    break
end
        
end


result.shape = shape;
result.n_pos = n_pos;
result.n_neg = n_neg;
result.epochs = epoch;
result.relevant_epochs = epoch_opt;
result.tr_reg_error = tr_reg_error(epoch_opt);
result.va_reg_error = va_reg_error(epoch_opt);
result.te_reg_error =te_reg_error(epoch_opt);
result.te_cls_error = te_class_error(epoch_opt);

% %Plotting Results
x = 1:1:epoch;
figure (1)
axis
plot(x,tr_reg_error,x,va_reg_error,x,te_reg_error);
ylabel('Error (%)','fontsize',14);
xlabel('Epochs','fontsize',14);
h_legend=legend('training regression error', 'validation regression error', 'test regression error')
set(h_legend,'FontSize',14); 




