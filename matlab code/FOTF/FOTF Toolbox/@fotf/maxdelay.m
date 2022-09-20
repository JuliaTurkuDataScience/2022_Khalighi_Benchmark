function T=maxdelay(G)
% maxdelay - extract the maximum delay from an FOTF object
%
%   T=maxdelay(G)
% 
%   G - an FOTF object
%   T - the maximum delay of the system

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   T=0; [n,m]=size(G); 
   for i=1:n, for j=1:m, T=max(T,G(i,j).ioDelay); end, end
end