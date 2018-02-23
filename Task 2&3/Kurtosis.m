function [result] = Kurtosis(image,len,mean,StandardDevValue)
sum=[0];
image=double(image);
for i =1:len 
x=image(i)-mean;
y=x.^4;
sum(1,1)=sum(1,1)+y;
end
z=len*(StandardDevValue.^4);
result=(sum(1,1)/z)-3;

end

