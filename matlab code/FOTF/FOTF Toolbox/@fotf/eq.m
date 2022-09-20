function key=eq(G1,G2)
% eq - test whether two FOTF objects are equal or not
%
%    key=G1==G2
%
%   G1, G2 - the two FOTF objects
%   key = 1 for equal, otherwise key = 0

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n1,m1]=size(G1); [n2,m2]=size(G2);
   if n1~=n2 || m1~=m2, key=0; 
   else
      G=G1-G2; [n,m]=size(G); key=0; kk=0;
      for i=1:n, for j=1:m, kk=kk+(G(i,j).num==0);
   end, end, end
   key=(kk==n1*m1);
end
