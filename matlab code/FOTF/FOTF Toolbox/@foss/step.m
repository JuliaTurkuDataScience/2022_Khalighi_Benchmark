function Y=step(G,varargin)
% step - simulation of an FOSS object driven by step inputs
%
%   step(G,t)
% 
%   G - an FOSS object
%   t- the time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if nargout==0, step(fotf(G),varargin{:});
   else, Y=step(fotf(G),varargin{:}); 
   end
end
