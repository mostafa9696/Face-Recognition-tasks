function [ output_args ] = Test()
Training_matrix=readImagesFeatures('training_images.txt');
Testing_matrix=readImagesFeatures('testing_images.txt');
for i=2:13
    mx=-1e14;
    mn=1e14;
    avg=0;
    for j=1:174
        if mx<Testing_matrix(j,i)
            mx=Testing_matrix(j,i);
        end
        if mn>Testing_matrix(j,i)
            mn=Testing_matrix(j,i);
        end
        avg=avg+Testing_matrix(j,i);
    end
    avg=avg/174;
    for j=1:174
        Testing_matrix(j,i)=(Testing_matrix(j,i)-avg)/(mx-mn);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=2:13
    mx=-1e14;
    mn=1e14;
    avg=0;
    for j=1:275
        if mx<Training_matrix(j,i)
            mx=Training_matrix(j,i);
        end
        if mn>Training_matrix(j,i)
            mn=Training_matrix(j,i);
        end
        avg=avg+Training_matrix(j,i);
    end
    avg=avg/275;
    for j=1:275
        Training_matrix(j,i)=(Training_matrix(j,i)-avg)/(mx-mn);
    end
end
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
figure
plot(K,Errors);
output_args=KvsAcuracy;
end

