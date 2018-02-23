function [ output_args ] = Test_KNN()
Training_matrix=readImagesFeatures('training_images.xlsx');
Testing_matrix=readImagesFeatures('testing_images.xlsx');
[h w z]=size(Training_matrix);
[a b c]=size(Testing_matrix);
for i=2:b
    mx=-1e9;
    mn=1e9;
    avg=0;
    for j=1:a
        avg=avg+Testing_matrix(j,i);
        if mx<Testing_matrix(j,i)
            mx=Testing_matrix(j,i);
        end
        if(mn>Testing_matrix(j,i))
            mn=Testing_matrix(j,i);
        end
    end
    avg=avg/a;
    for j=1:a
        if(mx-mn~=0)
        Testing_matrix(j,i)=(Testing_matrix(j,i)-avg)/(mx-mn);
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=2:w
    mx=-1e9;
    mn=1e9;
    avg=0;
    for j=1:h
        avg=avg+Training_matrix(j,i);
        if mx<Training_matrix(j,i)
            mx=Training_matrix(j,i);
        end
        if(mn>Training_matrix(j,i))
            mn=Training_matrix(j,i);
        end
    end
    avg=avg/h;
    for j=1:h
        if(mx-mn~=0)
        Training_matrix(j,i)=(Training_matrix(j,i)-avg)/(mx-mn);
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
Sorted_matrix=Sort_matrices(Training_matrix,Testing_matrix);
KvsAcuracy=zeros(276,2,'double');
Errors=zeros(275,'double');
K=zeros(275);
bestaccuracy=0;
mxk=0;
for i=1 :275
    Confusion_matrix=KNN(i,Sorted_matrix,Testing_matrix);
    KvsAcuracy(i,1)=i;
    K(i)=i;
    KvsAcuracy(i,2)=100*sum(diag(Confusion_matrix))/sum(sum(Confusion_matrix));
    if(KvsAcuracy(i,2)>bestaccuracy)
        bestaccuracy=KvsAcuracy(i,2);
        mxk=i;
    end
    Errors(i)=100*(sum(sum(Confusion_matrix))-sum(diag(Confusion_matrix)))/sum(sum(Confusion_matrix));
end
KvsAcuracy(276,1)=mxk;
KvsAcuracy(276,2)=bestaccuracy;
%figure
%plot(K,Errors);
output_args=KvsAcuracy(276,2);
end

