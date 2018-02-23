function [ Sorted_matrix ] = Sort_matrices( Training_matrix , Testing_matrix )
[a b L] = size(Training_matrix);
[x y S] = size(Testing_matrix);
for i=1 :x
    for j=1 :a
        m=0;
        for n=13 :b
          m=m+((Testing_matrix(i,n)-Training_matrix(j,n))*(Testing_matrix(i,n)-Training_matrix(j,n)));
        end
        Sorted_matrix{i,j}=[sqrt(m),Training_matrix(j,1)];
    end
    for j=1 :a-1
        for n=1 :a-j-1
            x=Sorted_matrix{i,n};
            y=Sorted_matrix{i,n+1};
            if x(1)>y(1)
                g=Sorted_matrix{i,n};
                Sorted_matrix{i,n}=Sorted_matrix{i,n+1};
                Sorted_matrix{i,n+1}=g;
            end
        end
    end
end
end