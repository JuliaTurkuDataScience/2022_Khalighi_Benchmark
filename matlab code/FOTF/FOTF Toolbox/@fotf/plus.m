function G=plus(G1,G2)
% plus - evaluate the sum of two FOTF objects, parallel connection
%
%   G=G1+G2
% 
%   G1, G2 - the two FOTF objects in parallel connection
%   G - the sum of G1 and G2

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   G1=fotf(G1); G2=fotf(G2);
   [n1,m1]=size(G1); [n2,m2]=size(G2);
   if n1==n2 && m1==m2, G=G1;
      for i=1:n1, for j=1:m1
         G(i,j)=sisofotfplus(G1(i,j),G2(i,j));
      end, end
   elseif n1*m1==1, G1=G1*fotf(ones(n2,m2)); G=G1+G2;
   elseif n2*m2==1, G2=G2*fotf(ones(n1,m1)); G=G1+G2;
   else
      error('Error: the sizes of the two FOTF matrices mismatch');
   end
% sum of two SISO FOTF objects
   function G=sisofotfplus(G1,G2)
      if G1.ioDelay==G2.ioDelay
         G=fotf(G1.den*G2.den,G1.num*G2.den+G2.num*G1.den); 
         G=simplify(G); G.ioDelay=G1.ioDelay;
      else, error('Error: cannot handle different delays'); 
   end, end
end
