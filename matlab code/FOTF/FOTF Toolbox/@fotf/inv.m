function G1=inv(G)
% inv - inverse of a multivariable FOTF system
%
%   G1=inv(G)
% 
%   G, G1 - an FOTF object and its inverse system
%   not recommended for MIMO FOTFs, use fotf2sym and work the
%   model G under symbolic framework

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G);
   if n*m==1
      if G.ioDelay>0, error('Delay terms are not allowed');
      else, G1=fotf(G.num,G.den); end
   elseif n~=m
      error('Error: non-square matrix, not invertible')
   else, G1=fotfinv(G); end
end
function G1=fotfinv(G)
   [n,~]=size(G); A1=G; E0=fotf(eye(n)); A3=E0;
   for i=1:n, ij=1:n; ij=ij(ij~=i);
      E=fotf(eye(n)); a0=inv(A1(i,i));
      for k=ij, E(k,i)=-A1(k,i)*a0; end
      E0=E*E0; A1=E*A1; A3(i,i)=a0;
   end, G1=A3*E0;
end
