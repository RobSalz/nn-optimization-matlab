function [result] = train_PSO()
clc
clear all
global swarm

 data_sets = load('cancer1');

% %Initialize NN parameters
hidden_nodes= 32;

% %Initialize the GA parameters
swarm.size = 100;
swarm.shape = [data_sets.input_count,hidden_nodes,data_sets.output_count];
swarm.epoch = 0;
swarm.w = 0.729; % inertia weight
swarm.c1 = 0.9; % cognitive weight
swarm.c2 = 0.91; % social weight
swarm.v = 0; % scales the magnitude of the initrrial velocity

% %Initialization of particle swarm
init_swarm(data_sets);

% % %Train the swarm
pE_opt = 100;
P_k(1) =10;
for epoch = 1:100
calculate_velocities();
update_positions(data_sets);
update_pb();
update_gb();

tr_reg_error(epoch) = swarm.gb.fitness;
va_reg_error(epoch) = regression_error(data_sets.validation,swarm.gb.w1, swarm.gb.w2);
te_reg_error(epoch) = regression_error(data_sets.test,swarm.gb.w1, swarm.gb.w2);
te_class_error(epoch) = classification_error(data_sets.test,swarm.gb.w1, swarm.gb.w2);

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


if GL/P_k > 1 || min(P_k) < 1;
    break
end
     
end

result.shape = swarm.shape;
result.swarm_size = swarm.size;
result.c1 = swarm.c1;
result.c2 = swarm.c2;
result.w = swarm.w;
result.epochs = epoch;
result.relevant_epochs = epoch_opt;
result.tr_reg_error = tr_reg_error(epoch_opt);
result.va_reg_error = va_reg_error(epoch_opt);
result.te_reg_error = te_reg_error(epoch_opt);
result.te_cls_error = te_class_error(epoch_opt);

x = 1:1:epoch;
plot(x,tr_reg_error,x,va_reg_error,x,te_reg_error);
ylabel('Error (%)','fontsize',14);
xlabel('Epochs','fontsize',14);
h_legend=legend('training regression error', 'validation regression error', 'test regression error')
set(h_legend,'FontSize',12)



