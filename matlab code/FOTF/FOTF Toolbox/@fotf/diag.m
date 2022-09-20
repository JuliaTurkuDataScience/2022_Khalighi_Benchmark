function G=diag(G1)
% diag - diagonal matrix manipulation of an FOTF object
%
%    G=diag(G1)
%
%   G - the FOTF object
%   G1 - if G is a vector, configurate a matrix G1, otherwise extract its
%        diagonal elements to form G1

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G1); nm=max(n,m); nm1=min(n,m); 
   if m==1 || n==1 
      G=fotf(zeros(nm,nm)); for i=1:nm, G(i,i)=G1(i); end
   else
      G=fotf(zeros(nm1,1)); for i=1:nm1, G(i)=G1(i,i); end 
end, end
