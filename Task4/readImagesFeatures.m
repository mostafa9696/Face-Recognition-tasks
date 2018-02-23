function [ImageFeatures] = readImagesFeatures()
fileName='finalResult.xlsx';
ImageFeatures = xlsread(fileName);

end

