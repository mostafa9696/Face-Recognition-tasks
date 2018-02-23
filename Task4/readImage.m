function [] = readImage(Input_directory)

Images=[];
imagesSum=zeros(50,50);
fileResult=[;];
for i = 1:28
    tmp=Input_directory;
    tmp=strcat(tmp,'\');
    tmp=strcat(tmp,num2str(i));
    filenames = dir(fullfile(tmp, '*.jpg'));
    num_images = length(filenames);
    for j = 1:num_images
    filename = fullfile(tmp, filenames(j).name);
    image = imread(filename);
    GImg = rgb2gray(image);
    [h,w] = size(GImg);
    n = h*w;
    newImage = reshape(GImg,1,n);
    meanResult=Mean(newImage,n);
    variance=Variance(newImage,n,meanResult);
    standardDev=StandardDev(variance);
    smoth=Smoothness(variance);
    skewness=Skewness(newImage,n,meanResult,standardDev);
    kurtosis=Kurtosis(newImage,n,meanResult,standardDev);
    uniformity=Uniformity(newImage,n);
    entropy=Entropy(newImage,n);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  GLCM features
    MatrixGLCM=GLCM(image);
    contrastGLCM=ContrastGLCM(MatrixGLCM);
    energyGLCM=EnergyGLCM(MatrixGLCM);
    entopyGLCM=EntropyGLCM(MatrixGLCM);
    homogeneityGLCM=HomogeneityGLCM(MatrixGLCM);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% save results
    r=[meanResult variance standardDev smoth skewness kurtosis uniformity entropy contrastGLCM energyGLCM entopyGLCM homogeneityGLCM];
    fileResult=[fileResult;r];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    GImg = imresize(image,[50 50]);
    GImg = rgb2gray(GImg);
    ImgTmp=double(GImg);
    newImage2 = reshape(GImg,2500,1);
    Images=[Images newImage2];
    imagesSum=imagesSum+ImgTmp;
    end
end

meanAdjustedDataset=ImagesMean(Images);
meanAdjustedDataset=meanAdjustedDataset';
CovarianceMatrix= (meanAdjustedDataset'*meanAdjustedDataset)/274;
[eigenVector ,eigenValue]=eig(CovarianceMatrix);
ediagonal = diag(eigenValue);
orderedVectors=SortEigen(eigenVector,eigenValue);
ediagonalSorted = sort(ediagonal,'descend');
PCs=getPCs(ediagonalSorted ,orderedVectors);
FinalData=PCs'*meanAdjustedDataset';
FinalData=FinalData';
[h w]=size(FinalData);
h
w
imagesSum=imagesSum/(275);
imagesSum=uint8(imagesSum);
figure
imshow(imagesSum);
finalResult=[];
for i=1 : 275
    imageFeature1=fileResult(i,:);
    imageFeature2=FinalData(i,:);
    features=[imageFeature1 imageFeature2];
    finalResult=[finalResult; features];
end
    xlswrite('finalResult.xlsx',finalResult);
end


