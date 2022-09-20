function Y=impulse(G,varargin)
% impulse - impulse response evaluation of an FOSS object
%
%   impulse(G,t)
% 
%   G - an FOSS object
%   t - the time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if nargout==0, impulse(fotf(G),varargin{:});
   else, Y=impulse(fotf(G),varargin{:}); 
   end
end
