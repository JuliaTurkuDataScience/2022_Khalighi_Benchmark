function H=nyquist(G,varargin)
% nyquist - draw the Nyquist plot of an FOSS object
%
%   nyquist(G,w)
% 
%   G - an FOSS object
%   w - the frequency vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if nargout==0, nyquist(fotf(G),varargin{:});
   else, H=nyquist(fotf(G),varargin{:}); 
   end
end
