function [newA,newB] = elimemptyrows(A,b)
%ELIMEMPTYROWS Summary of this function goes here
%   Detailed explanation goes here
newN = 0;
newA=zeros(size(A));
newB= zeros(size(b));
for i = 1:length(A)
    if sum(abs(A(i,:)))>0
        newN=newN+1;
        newA(newN,:)=A(i,:);
        newB(newN)=b(i);
    end
end
newA=newA(1:newN,:);
newB = newA(1:newN);
end

