function [ Accuray_KNN,Accuracy_Bayesian ] = Compare_KNN_VS_Bayesian()
Accuray_KNN=Test_KNN();
Accuray_KNN
Accuracy_Bayesian=BayesianClassifier();
Accuracy_Bayesian
end

