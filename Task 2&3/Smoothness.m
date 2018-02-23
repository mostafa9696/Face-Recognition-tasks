function [result] = Smoothness(VarianceValue)
x=1+VarianceValue;
result=1-(1/x);
end

