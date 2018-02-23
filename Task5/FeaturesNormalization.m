function [Features ] = FeaturesNormalization( Features,NumberOfImages )
%normalization 
% for i=2:w
%  sm=sum(Features(:,i));
%  sm=sm/h;
%  Features(:,i)=Features(:,i)-sm;
%  [mx,~]=max(Features(:,i));
%  Features(:,i)=Features(:,i)./(mx-sm);
%  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mx=1000000;
Features(:,2:71)=Features(:,2:71)/mx;
end

