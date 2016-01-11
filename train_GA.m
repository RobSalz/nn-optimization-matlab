function [result] = train_GA()
clc
clear all

data_sets = load('cancer1');

%Initialize the GA parameters
population = 100;

generation = 1;

%No Hidden Nodes
hidden_nodes= 32;

%i-h-o 
shape = [data_sets.input_count,hidden_nodes,data_sets.output_count];

%Initialize the population
for i = 1:population
    [individual{i}.w1,individual{i}.w2] = init_weightsGA(shape);
    fitness(i) = regression_error(data_sets.training,individual{i}.w1,individual{i}.w2);
    individual{i}.fitness = fitness(i);
end

%Sort and rank the individuals in the population
[a , b] = sort(fitness);

 for i = 1:population
     s_individual{(i)} = individual{b(i)};
 end
 

 %Parent Scalar
 PS = 0.91;
 
 %Select parents based on parent scalar
 x_0 = 0.1;
 for i = 1:population
     p_x(i) = x_0*PS.^(i-1);
 end
 
 %Normalize PDF
 PDF = p_x / sum(p_x);
 
 %Creat discrete CDF
 CDF = cumsum(PDF);
 
 for generation = 1:700
 %Randomly sample from CDF
 parent_index1 = knnsearch (CDF',rand(1));
 parent_index2 = knnsearch (CDF',rand(1));
 
 %Creat a child
 Genetic_operator = rand(1);
 
 if  Genetic_operator <=0.8; %Mutate performs better than crossover
 [child.w1,child.w2] = mutate_nodes(shape,s_individual{parent_index1}.w1,...
     s_individual{parent_index1}.w2,2);
 child.fitness = regression_error(data_sets.training,child.w1,child.w2);
 
 else %Crossover
     [child.w1,child.w2] = crossover_nodes(shape,s_individual{parent_index1}.w1,...
     s_individual{parent_index1}.w2,s_individual{parent_index2}.w1, ...
     s_individual{parent_index2}.w2,3);
 child.fitness = regression_error(data_sets.training,child.w1,child.w2);
     
 end
 %Evaluate the child against the population of individuals and place in the
 %child in the correct position in the population. Remove the worst individual
 updated = false;
 for i = 1:population 
     if child.fitness > s_individual{i}.fitness 
         sc_individual{i} = s_individual{i};
     elseif child.fitness < s_individual{i}.fitness && ~updated  
         sc_individual{i} = child;
         updated = true;
     elseif child.fitness < s_individual{i}.fitness && updated  
         sc_individual{i} = s_individual{i-1};
     end
     
     fitness(i) = sc_individual{i}.fitness;
 end
 mean_fitness(generation) = mean(fitness);
 
s_individual = sc_individual;

%Evaluate network at each epoch
tr_reg_error(generation) = regression_error(data_sets.training,s_individual{1}.w1,s_individual{1}.w2);
va_reg_error (generation) = regression_error(data_sets.validation,s_individual{1}.w1,s_individual{1}.w2);
te_reg_error(generation) = regression_error(data_sets.test,s_individual{1}.w1,s_individual{1}.w2);
te_class_error(generation) = classification_error(data_sets.training,s_individual{1}.w1,s_individual{1}.w2);


 end 
 
          

result.shape = shape;
result.population = population;
result.epochs=generation;
result.relevant_epochs = generation;
result.tr_reg_error = tr_reg_error(generation);
result.va_reg_error = va_reg_error(generation);
result.te_reg_error =te_reg_error(generation);
result.te_cls_error = te_class_error(generation);

x = 1:1:generation;
plot(x,tr_reg_error,x,va_reg_error,x,te_reg_error);
ylabel('Error (%)','fontsize',14);
xlabel('Epochs','fontsize',14);
h_legend=legend('training regression error', 'validation regression error', 'test regression error')
set(h_legend,'FontSize',12); 

