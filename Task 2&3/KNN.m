function [ Confusion_matrix ] = KNN( K , Sorted_Matrix,Testing_matrix )
Confusion_matrix=zeros(28,28);
[h w z]=size(Testing_matrix);
for i=1 :h
    freq=zeros(28);
    mx=0;
    res=0;
    for j=1 :K
        x=Sorted_Matrix{i,j};
        freq(x(2))=freq(x(2))+1;
        if(freq(x(2))>mx)
            mx=freq(x(2));
        end
    end
    mn=1e9;
    for j=1 :K
        x=Sorted_Matrix{i,j};
        if(freq(x(2))==mx)
            if(x(1)<mn)
                mn=x(1);
                res=x(2);
            end
        end
    end
    Confusion_matrix(Testing_matrix(i,1),res)=Confusion_matrix(Testing_matrix(i,1),res)+1;
end
end