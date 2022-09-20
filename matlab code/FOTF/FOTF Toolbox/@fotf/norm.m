function n=norm(G,eps0)
% norm -= norms of an FOTF object
%
%   norm(G), norm(G,inf)
% 
%   G - an FOTF object
%   The 2-norm and infinity-norm of G can be evaluated, respectively

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G); if nargin==1, eps0=1e-6; end
   for i=1:n, for j=1:m, A(i,j)=snorm(G(i,j),eps0); end, end
   n=norm(A);
end
% norm of a SISO FOTF object
function n=snorm(G,eps0)
   j=sqrt(-1);  
   if nargin==2 && ~isfinite(eps0) % H infinity norm, find the maximum value
      f=@(w)-abs(freqresp(j*w,G));
      w=fminsearch(f,0); n=abs(freqresp(j*w,G));
   else % H2 norm, numerical integration
      f=@(s)freqresp(s,G).*freqresp(-s,G); 
      n=integral(f,-inf,inf)/(2*pi*j);
   end   
end
