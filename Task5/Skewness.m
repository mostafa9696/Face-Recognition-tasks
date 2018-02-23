function [result] = Skewness(image,len,mean,StandardDevValue)
sum=[0];
image=double(image);
for i=1:len 
x=image(i)-mean;
y=x.^3;
sum(1,1)=sum(1,1)+y;
end
z=len*(StandardDevValue.^3);
result=sum(1,1)/z;

end