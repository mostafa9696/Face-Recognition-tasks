function [result] = Mean(image,len)
sum=[0];
image=double(image);
for i =1:len 
sum(1,1)=sum(1,1)+image(i);
end
result=sum(1,1)/len;
end
