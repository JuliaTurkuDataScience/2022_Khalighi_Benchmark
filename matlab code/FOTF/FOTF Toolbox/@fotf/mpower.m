function G1=mpower(G,n) 
% mpower - power of an FOTF object
%
%   G1=G^n
% 
%   G - an FOTF object
%   n - power.  If G is s or constant, n can be any real number, 
%       If G is an FOSS, n should be integers
%   G1 - returns G^n, and an FOSS object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n1,m1]=size(G);
   if n==fix(n)
      if n1==m1
         if n>=0, G1=fotf(eye(n1)); for i=1:n, G1=G1*G; end
         else, G1=inv(G)^(-n); end
      elseif n==1, G1=G;
      else, error('G must be a square matrix'); 
      end
   elseif n1==1 && m1==1
      if length(G.num)==1 && length(G.den)==1 
         [a,na,b,nb,L]=fotfdata(G);
         G1=fotf(a^n,na*n,b^n,nb*n,L*n);   
      else, error('mpower: power must be an integer.'); 
      end
   else, error('mpower: power must be an integer.'); 
   end
end