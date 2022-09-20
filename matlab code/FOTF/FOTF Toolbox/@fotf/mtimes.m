function G=mtimes(G1,G2)
% mpower - product of two FOTF objects, series connection
%
%   G=G1*G2
% 
%   G1, G2 - FOTF objects
%   G - returns the product of the two FOTF objects

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   G1=fotf(G1); G2=fotf(G2); 
   if numel(G1)==1 && numel(G2)==1, G=sisofotftimes(G1,G2);
   else, [n1,m1]=size(G1); [n2,m2]=size(G2);
      if m1==n2, G=fotf(zeros(n1,m2)); 
         for i=1:n1, for j=1:m2
            for k=1:m1, G(i,j)=G(i,j)+sisofotftimes(G1(i,k),G2(k,j));
         end, end, end
      elseif n1*m1==1, G=fotf(zeros(n2,m2));  % if G1 is scalar
         for i=1:n2, for j=1:m2, G(i,j)=G1*G2(i,j); end, end
      elseif n2*m2==1, G=fotf(zeros(n1,m1));  % if G2 is scalar
         for i=1:n1, for j=1:m1, G(i,j)=G2*G1(i,j); end, end
      else
         error('The two matrices are incompatible for multiplication')
end, end, end
% product of two SISO FOTF objects
function G=sisofotftimes(G1,G2)
   G=fotf(G1.den*G2.den,G1.num*G2.num); G=simplify(G);
   G.ioDelay=G1.ioDelay+G2.ioDelay;
end
