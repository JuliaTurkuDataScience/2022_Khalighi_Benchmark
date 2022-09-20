function G1=mpower(G,n)
% mpower - power of an FOSS object
%
%   G1=G^n
% 
%   G - an FOSS object
%   n - power.  If G is s or constant, n can be any real number, 
%       If G is an FOSS, n should be integers
%   G1 - returns G^n, and an FOSS object

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if n==fix(n), [n1,m1]=size(G); if n<0, G=inv(G); end
      if n1==m1 
         G1=foss(eye(n1)); for i=1:abs(n), G1=G1*G; end
      else, error('matrix must be square'); end
   else, error('mpower: power must be an integer.'); 
   end
end
