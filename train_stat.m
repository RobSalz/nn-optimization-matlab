function [stat] = train_stat()
%Returns the stats on 60 runs of the neural network being trained

for i = 1:30
    %Specify the training algorithm to be tested train_RPROP, train_MOM,
    %train_SSAB
 result=train_MOM();
 
 %Results
 epochs(i) = result.epochs;
 relevant_epochs(i) = result.relevant_epochs;
 tr_reg_error(i) = result.tr_reg_error ;
 va_reg_error(i) = result.va_reg_error;
 te_reg_error(i) = result.te_reg_error ;
 te_cls_error(i) = result.te_cls_error;
end
result.shape;
stat.totalEpochs_mean = mean(epochs);
stat.totalEpochs_stdv = std(epochs);

stat.relevantEpochs_mean = mean(relevant_epochs);
stat.relevantEpochs_stdv = std(relevant_epochs);

stat.trainingError_mean = mean(tr_reg_error);
stat.trainingError_stdv=std(tr_reg_error);

stat.testError_mean = mean(te_reg_error);
stat.testError_stdv=std(te_reg_error);

stat.validationError_mean=mean(va_reg_error);
stat.validationError_stdv=std(va_reg_error);

stat.teClsError_mean = mean(te_cls_error);
stat.teClsError_std = std(te_cls_error);


[~,pos]=min(va_reg_error)

stat.best_test = te_cls_error(pos);

fprintf('\t & %g-%g-%g & %2.2f & %2.2f & %2.2f & %2.2f & %2.2f & %2.0f & %2.1f \t',...
    result.shape,stat.testError_mean,stat.testError_stdv,...
stat.teClsError_mean,stat.teClsError_std ,stat.best_test,...
stat.relevantEpochs_mean,stat.relevantEpochs_stdv);

end

