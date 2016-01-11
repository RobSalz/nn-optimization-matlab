clc;clear all;close all

S6B=xlsread('6B.xlsx');
N6B=xlsread('6BN.xlsx');
x = [S6B;N6B]';
t = [ones(size(S6B,1),1),zeros(size(S6B,1),1);zeros(size(N6B,1),1),ones(size(N6B,1),1)]';

size(x)
size(t)


net =patternnet(10);
view(net);

[net,tr] =train(net,x,t);
nntraintool

 