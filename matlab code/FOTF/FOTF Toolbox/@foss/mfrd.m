function H=mfrd(G,varargin)
% mfrd - evaluation of frequency responses of an FOSS object
%
%   H=mfrd(G,w)
% 
%   G - an FOSS object
%   w - frequency vector
%   H - frequency response of G in MFD format

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   H=mfrd(fotf(G),varargin{:}); 
end
