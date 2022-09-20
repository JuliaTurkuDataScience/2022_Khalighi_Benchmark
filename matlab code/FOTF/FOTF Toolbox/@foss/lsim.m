function Y=lsim(G,varargin)
% lsim - simulation of an FOSS object driven by given inputs
%
%   lsim(G,u,t)
% 
%   G - an FOSS object
%   u, t- input samples and time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if nargout==0, lsim(fotf(G),varargin{:});
   else, Y=lsim(fotf(G),varargin{:}); 
   end
end
