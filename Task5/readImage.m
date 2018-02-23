function [NumberOfImages] = readImage(Input_directory,filenamePar)

Images=[];
imagesSum=zeros(50,50);
NumberOfImages=zeros(28,1);
fileResult=[;];
numOfImages=0;
for i = 1:28
    tmp=Input_directory;
    tmp=strcat(tmp,'\');
    tmp=strcat(tmp,num2str(i));
    filenames = dir(fullfile(tmp, '*.jpg'));
    num_images = length(filenames);
    NumberOfImages(i,1)=num_images;
    for j = 1:num_images
        numOfImages=numOfImages+1;
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
    r=[i meanResult variance standardDev smoth skewness kurtosis uniformity entropy contrastGLCM energyGLCM entopyGLCM homogeneityGLCM];
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

if(isequal(filenamePar,'training_images.xlsx'))
imagesSum=imagesSum/(275);
imagesSum=uint8(imagesSum);
% figure
% imshow(imagesSum);    
meanAdjustedDataset=ImagesMean(Images);
meanAdjustedDataset=meanAdjustedDataset';
xlswrite('meanFace.xlsx',imagesSum);
[FinalData]=calcTrainingPCAs(meanAdjustedDataset);
else
    meanF = xlsread('meanFace.xlsx');   
    meanF = reshape(meanF,2500,1);
    meanAdjustedDataset=[];
    Images=double(Images);
    meanF=double(meanF);
    for k=1:174
     q=Images(:,k)- meanF(:,1);  
     meanAdjustedDataset=[meanAdjustedDataset q]; 
    end
eigenVectors = xlsread('training_eigenVectors.xlsx');
FinalData=eigenVectors'*meanAdjustedDataset;  
FinalData=FinalData';
end
[h w]=size(FinalData);
finalResult=[];
for i=1 : numOfImages
    imageFeature1=fileResult(i,:);
    imageFeature2=FinalData(i,:);
   features=[imageFeature1 imageFeature2];
    finalResult=[finalResult; features];
end
    xlswrite(filenamePar,finalResult);
end


