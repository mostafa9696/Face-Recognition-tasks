function [accuracy] = BayesianClassifier(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%
PriorProbability=readImage('F:\4th year\First semester\Pattern recognition\Labs\Lab5\Task3\Final Images\Training','training_images.xlsx'); %directory for training images
[NumberOfClasses,~]=size(PriorProbability);
TrainingFeatures=readImagesFeatures('training_images.xlsx');
TrainingFeatures=FeaturesNormalization(TrainingFeatures,PriorProbability);
[h,w]=size(TrainingFeatures);
TrainingMean=zeros(NumberOfClasses,w);
TrainingVaraince=zeros(NumberOfClasses,w);
%training phase
for i=2:w
    total=1;
    for j=1:NumberOfClasses
        sm=sum(TrainingFeatures(total:PriorProbability(j,1)+total-1,i));
        TrainingMean(j,i)=sm/PriorProbability(j,1);
        sm1=0;
        for k=1:PriorProbability(j,1)
            sm1=sm1+(TrainingFeatures(total+k-1,i)-TrainingMean(j,i))^2;
        end
        TrainingVaraince(j,i)=sm1/(PriorProbability(j,1)-1);
         total=total+PriorProbability(j,1);
    end
end
%testing phase
PriorProbability1=readImage('F:\4th year\First semester\Pattern recognition\Labs\Lab5\Task3\Final Images\Testing','testing_images.xlsx'); %directory for testing images
TestingFeatures=readImagesFeatures('testing_images.xlsx');
TestingFeatures=FeaturesNormalization(TestingFeatures,PriorProbability1);
[h w]=size(TestingFeatures);
TotalNumberOfImages=sum(PriorProbability);
PriorProbability=PriorProbability/TotalNumberOfImages;
confusion=zeros(28,28);
for i=1:h
        Alllikelihood=ones(NumberOfClasses,1);
    for j=13:w
        for k=1:NumberOfClasses
            Alllikelihood(k,1)=Alllikelihood(k,1)*likelihood(TestingFeatures(i,j),TrainingMean(k,j),TrainingVaraince(k,j));
        end
    end  
        for k=1:NumberOfClasses
         posterior(k,1)=Alllikelihood(k,1)*PriorProbability(k,1);
         if isnan(posterior(k,1))==1 % have 0 varaince
             posterior(k,1)=0;
         end
        end       
        evidence=sum(posterior(:,1));
        posterior=posterior/evidence;
        [~,class]=max(posterior);
        confusion(TestingFeatures(i,1),class)= confusion(TestingFeatures(i,1),class)+1;      
end
accuracy=100*(sum(diag(confusion))/sum(sum(confusion)));
end