function [out] = ImagesMean(Images)
mean=zeros(2500);
mx=zeros(2500);
Images=double(Images);
[h w]=size(Images);

for i = 1:h
    q=0.0;
    for j = 1:w
      q=q+Images(i,j);  
    end
    mean(i)=(q/w);
end

for i = 1:h
    tmp=-1e9;
    for j = 1:w
        out(i,j)=Images(i,j)-mean(i);
        if(out(i,j)>tmp)
            tmp=out(i,j);
        end
    end
    mx(i)=tmp;
end

% for i = 1:h                 % Normalization
%     for j = 1:w
%         out(i,j)=out(i,j)/mx(i);    
%     end
% end

end

