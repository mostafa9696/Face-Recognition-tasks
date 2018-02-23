function [] = readImage(Input_directory)

fid = fopen('training_images.txt', 'wt');
fprintf(fid,'%8s %4s %4s %3s %4s %4s %4s %4s %4s %4s %4s %4s %4s \n \n ','CategoryNum','       mean','            variance','          SD','          Smoothness','      Skewness','       Kurtosis','      Uniformity','      Entropy','        Contrast','     EntropyGLCM','      Energy','       Homogeneity');
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
    imagesName=num2str(i);
    fprintf(fid,'%8s %15f %15f %15f %15f %15f %15f %15f %15f %15f %15f %15f %15f \n\n',imagesName,meanResult,variance,standardDev,smoth,skewness,kurtosis,uniformity,entropy,contrastGLCM,entopyGLCM,energyGLCM,homogeneityGLCM);
    
    end
end
fclose(fid);

%readImagesFeatures('training_images.txt');
%type('results.txt')
end


