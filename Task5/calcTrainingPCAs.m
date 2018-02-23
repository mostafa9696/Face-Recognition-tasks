function [ FinalData] = calcTrainingPCAs(meanAdjustedDataset)
CovarianceMatrix= (meanAdjustedDataset'*meanAdjustedDataset)/274;
[eigenVector ,eigenValue]=eig(CovarianceMatrix);
ediagonal = diag(eigenValue);
orderedVectors=SortEigen(eigenVector,eigenValue);
ediagonalSorted = sort(ediagonal,'descend');
finalEigenVectors=getPCs(ediagonalSorted ,orderedVectors);
xlswrite('training_eigenVectors.xlsx',finalEigenVectors);
FinalData=finalEigenVectors'*meanAdjustedDataset';
FinalData=FinalData';
end

