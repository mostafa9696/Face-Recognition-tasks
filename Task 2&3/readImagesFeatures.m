function [imagesFeatures] = readImagesFeatures(fileDirectory)       % take paramter (testing_images) or (training_image) to get images features and put it in imagesFeatures
fid = fopen(fileDirectory);
tline = fgetl(fid);
row=1;
while ischar(tline)
    x=tline;
     features= strsplit(x,'     ');
    [h w]=size(features);
    if(w==14)
     for i =2 :14
       f=features(i);
       features(i) = strrep(features(i),' ','');
       imagesFeatures(row,i-1)=str2double(features(i));
     end
     row=row+1;
    end
    tline = fgetl(fid);
end
fclose(fid);
end

