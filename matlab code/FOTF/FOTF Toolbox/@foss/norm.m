function n=norm(G,varargin)
% norm -= norms of an FOSS object
%
%   norm(G), norm(G,inf)
% 
%   G - an FOSS object
%   The 2-norm and infinity-norm of G can be evaluated, respectively

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   n=norm(fotf(G),varargin{:});
end
