function [ ans] = likelihood( x,mu,var )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ans=(1/(sqrt(2*pi)*sqrt(var)))*exp(-1*(((x-mu)^2)/(var*2)));
end

