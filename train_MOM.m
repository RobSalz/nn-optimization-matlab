function [result] = train_MOM()
clc
clear all

%Load data
data_sets = load('cancer3');


%Choose network paramters
training_rate = 0.005;
momentum = 0;
hidden_nodes = 32;

%Setting network shape i-h-o
shape = [data_sets.input_count,hidden_nodes,data_sets.output_count];


%Initialize weights, and setting previous weight updates to zero
[w1,w2] = init_weights (shape);
pwd1 = w1*0;
pwd2 = w2*0;

%Training input and target values from data
input = data_sets.training.inputs;
target = data_sets.training.outputs';

%Train momentum
pE_opt = 100;
P_k(1) =10;
for epoch = 1:1000
[w1 w2 pwd1 pwd2 error] = MOM(input,target,training_rate,w1,w2,pwd1,pwd2,momentum);

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

if GL/P_k > 5 || min(P_k) < 1;
    break
end
end
result.training_rate = training_rate;
result.momentum = momentum;
result.shape = shape;
result.epochs = epoch;
result.relevant_epochs = epoch_opt;
result.tr_reg_error = tr_reg_error(epoch_opt);
result.va_reg_error = va_reg_error(epoch_opt);
result.te_reg_error =te_reg_error(epoch_opt);
result.te_cls_error = te_class_error(epoch_opt);


x = 1:1:epoch;
plot(x,tr_reg_error,x,va_reg_error,x,te_reg_error);
ylabel('Error (%)','fontsize',14);
xlabel('Epochs','fontsize',14);
h_legend=legend('training regression error', 'validation regression error', 'test regression error')
set(h_legend,'FontSize',12); 

print -dpng mhorse09