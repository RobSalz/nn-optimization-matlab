clc;clear all; close all;

S1=xlsread('6B.xlsx');
S1(:,1)=S1(:,1)/100; S1(:,2)=S1(:,2)/10; S1(:,3)=S1(:,3)/100; ...
    S1(:,4)=S1(:,4)/100; S1(:,5)=S1(:,5)/10000;S1(:,6)=S1(:,6)/10000;...
    S1(:,7)=S1(:,7)/100;S1(:,8)=S1(:,8)/100;
    
S2=xlsread('STALL_2.xlsx');
S2(:,1)=S2(:,1)/100; S2(:,2)=S2(:,2)/10; S2(:,3)=S2(:,3)/100; ...
    S2(:,4)=S2(:,4)/100; S2(:,5)=S2(:,5)/10000;S2(:,6)=S2(:,6)/10000;...
    S2(:,7)=S2(:,7)/100;S2(:,8)=S2(:,8)/100;

S3=xlsread('STALL_3.xlsx');
S3(:,1)=S3(:,1)/100; S3(:,2)=S3(:,2)/10; S3(:,3)=S3(:,3)/100; ...
    S3(:,4)=S3(:,4)/100; S3(:,5)=S3(:,5)/10000;S3(:,6)=S3(:,6)/10000;...
    S3(:,7)=S3(:,7)/100;S3(:,8)=S3(:,8)/100;

S4=xlsread('STALL_2.xlsx');
S4(:,1)=S4(:,1)/100; S4(:,2)=S4(:,2)/10; S4(:,3)=S4(:,3)/100; ...
    S4(:,4)=S4(:,4)/100; S4(:,5)=S4(:,5)/10000;S4(:,6)=S4(:,6)/10000;...
    S4(:,7)=S4(:,7)/100;S4(:,8)=S4(:,8)/100;

S5=xlsread('STALL_2.xlsx');
S5(:,1)=S5(:,1)/100; S5(:,2)=S5(:,2)/10; S5(:,3)=S5(:,3)/100; ...
    S5(:,4)=S5(:,4)/100; S5(:,5)=S5(:,5)/10000;S5(:,6)=S5(:,6)/10000;...
    S5(:,7)=S5(:,7)/100;S5(:,8)=S5(:,8)/100;

N1A=xlsread('NOC_1A.xlsx');
N1B=xlsread('NOC_1B.xlsx');
N1C=xlsread('NOC_1C.xlsx');
N1D=xlsread('NOC_1D.xlsx');
N1 = [N1A(end-100:end,:);N1B(end-100:end,:);N1C(end-100:end,:);N1D(end-100:end,:)];

N2B=xlsread('NOC_2B.xlsx');
N2E=xlsread('NOC_2E.xlsx');

N2 = [N2B(end-100:end,:);N2E(end-100:end,:)];

N3=xlsread('6BN.xlsx');
N4=xlsread('6BN.xlsx');

NOC_prior = [];

NOC_1 = N1;
NOC_1(:,1)=NOC_1(:,1)/100; NOC_1(:,2)=NOC_1(:,2)/10; NOC_1(:,3)=NOC_1(:,3)/100; ...
    NOC_1(:,4)=NOC_1(:,4)/100; NOC_1(:,5)=NOC_1(:,5)/10000;NOC_1(:,6)=NOC_1(:,6)/10000;...
    NOC_1(:,7)=NOC_1(:,7)/100;NOC_1(:,8)=NOC_1(:,8)/100;

NOC_2 = N2(end-300:end,:);
NOC_2(:,1)=NOC_2(:,1)/100; NOC_2(:,2)=NOC_2(:,2)/10; NOC_2(:,3)=NOC_2(:,3)/100; ...
    NOC_2(:,4)=NOC_2(:,4)/100; NOC_2(:,5)=NOC_2(:,5)/10000;NOC_2(:,6)=NOC_2(:,6)/10000;...
    NOC_2(:,7)=NOC_2(:,7)/100;NOC_2(:,8)=NOC_2(:,8)/100;

NOC_3 = N3(end-300:end,:);
NOC_4 = N4(end-300:end,:);

STALL_1 = S1(end-300:end,:);
STALL_2 = S2(end-300:end,:);
STALL_3 = S3(end-300:end,:);
STALL_4 = S4(end-300:end,:);
STALL_5 = S5(end-300:end,:);

CASE1.in = [NOC_prior;NOC_1;STALL_1];
CASE1.out = [ones(size([NOC_prior;NOC_1],1),1),zeros(size([NOC_prior;NOC_1],1),1)...
    ;zeros(size(STALL_1,1),1),ones(size(STALL_1,1),1)];
    
CASE2.in = [NOC_prior;NOC_1;NOC_2;STALL_1;STALL_2];
CASE2.out = [ones(size([NOC_prior;NOC_1;NOC_2],1),1),zeros(size([NOC_prior;NOC_1;NOC_2],1),1)...
    ;zeros(size([STALL_1;STALL_2],1),1),ones(size([STALL_1;STALL_2],1),1)];

CASE3 = [NOC_prior;NOC_1;NOC_2;NOC_3;STALL_1;STALL_2;STALL_3];

CASE4 = [NOC_prior;NOC_1;NOC_2;NOC_3;NOC_4;STALL_1;STALL_2;STALL_3;STALL_4];

input_count = size(NOC_1,2);
output_count = 2;

%Make every fourth element a validation point
validation.inputs = CASE1.in(1:4:end,:); 
validation.outputs = CASE1.out(1:4:end,:);
validation.classes = classes_from_outputs(validation.outputs);
validation_count = length(validation.classes);

%Remove all the validations from training set
CASE1.in(1:4:end,:) = []; 
CASE1.out(1:4:end,:)= [];
training.inputs =  CASE1.in;
training.outputs = CASE1.out;
training.classes = classes_from_outputs(training.outputs);
training_count = length(training.classes);

test.inputs = [NOC_2;STALL_2];
test.outputs = [ones(size(NOC_2,1),1),zeros(size(NOC_2,1),1)...
    ;zeros(size(STALL_2,1),1),ones(size(STALL_2,1),1)];
test.classes = classes_from_outputs(test.outputs);
test_count = length(test.classes);
sample_count = training_count + validation_count + test_count;

save('case1', 'training', 'validation', 'test', ...
    'input_count', 'output_count', ...
    'training_count', 'validation_count', 'test_count');

%CASE2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Make every fourth element a validation point
validation.inputs = CASE2.in(1:4:end,:); 
validation.outputs = CASE2.out(1:4:end,:);
validation.classes = classes_from_outputs(validation.outputs);
validation_count = length(validation.classes);

%Remove all the validations from training set
CASE2.in(1:4:end,:) = []; 
CASE2.out(1:4:end,:)= [];
training.inputs =  CASE2.in;
training.outputs = CASE2.out;
training.classes = classes_from_outputs(training.outputs);
training_count = length(training.classes);

test.inputs = [NOC_3;STALL_3];
test.outputs = [ones(size(NOC_3,1),1),zeros(size(NOC_3,1),1)...
    ;zeros(size(STALL_3,1),1),ones(size(STALL_3,1),1)];
test.classes = classes_from_outputs(test.outputs);
test_count = length(test.classes);
sample_count = training_count + validation_count + test_count;

save('case2', 'training', 'validation', 'test', ...
    'input_count', 'output_count', ...
    'training_count', 'validation_count', 'test_count');