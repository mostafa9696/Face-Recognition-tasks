function [out] =getPCs(ediagonal,orderedVectors)
ediagonal=double(ediagonal);
CumProb = cumsum(ediagonal/sum(ediagonal));
j=1;
y=[];
while CumProb(j)<=0.9
    out(:,j)=orderedVectors(:,j);
    y=[y CumProb(j)];
    j=j+1;
end
X=[1:1:j-1];
figure
plot(X,y);

end

