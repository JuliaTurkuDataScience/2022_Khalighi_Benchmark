function A2=new_inv(A)
% new_inv - a simple matrix inverse function
%
%    A2=new_inv(A)
%
%   A, A2 - the matrix and its inverse
%
%   not recommended, try symbolic version for FOTF matrices
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   A1=A; [n,~]=size(A); E0=eye(n); aa=[];
   for i=1:n, ij=1:n; ij=ij(ij~=i); E=eye(n); a0=A1(i,i);
      aa=[aa,a0]; E(ij,i)=-A1(ij,i)/a0; E0=E*E0; A1=E*A1;
   end
   A2=diag(1./aa)*E0;
end
