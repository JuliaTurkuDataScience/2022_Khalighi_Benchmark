function H=nichols(G,varargin)
% nichols - draw the Nichols chart of an FOSS object
%
%   nichols(G,w)
% 
%   G - an FOSS object
%   w - the frequency vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if nargout==0, nichols(fotf(G),varargin{:});
   else, H=nichols(fotf(G),varargin{:}); 
   end
end
