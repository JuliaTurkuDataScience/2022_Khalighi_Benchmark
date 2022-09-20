function n=numel(G)
% numel - the number of FOTF objects in G
%
%   n=numel(G)
% 
%   G - FOTF object
%   n - returns the number of FOTF objects in G

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   [n,m]=size(G); n=n*m;
end
