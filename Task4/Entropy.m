function [result] = Entropy(image,len)
sum=[0];
uniquePixelCount=1;
image=double(image);
uniquePixelsOccure=zeros(256);
finalPixels=zeros(256);
for i =1:len
pixel=image(i)+1;    
if(uniquePixelsOccure(pixel)==0)
    finalPixels(uniquePixelCount)=pixel;
    uniquePixelCount=uniquePixelCount+1;
end
uniquePixelsOccure(pixel)=uniquePixelsOccure(pixel)+1;
end
uniquePixelCount=uniquePixelCount-1;
for i =1:uniquePixelCount
pixel=finalPixels(i); 
pixelCount=uniquePixelsOccure(pixel);
ans=(pixelCount/len);
ansLog=log2(ans);
sum(1,1)=sum(1,1)+(ans*ansLog);
end
result=sum(1,1)*-1;
end

