function [result] = Variance(image,len,mean)
sum=[0];
image=double(image);
for i=1:len
x=image(i)-mean;    
y=x*x;
sum(1,1)=sum(1,1)+y;
end
result=sum(1,1)/len;
end

