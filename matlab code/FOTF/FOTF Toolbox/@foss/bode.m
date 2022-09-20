function H=bode(G,varargin)
% bode - draw Bode diagram for an FOSS object
%
%    bode(G,w)
%    H=bode(G,w)
%
%   G - the FOSS object
%   w - the frequency vector
%   H - the frequency response data in FRD format

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   if nargout==0, bode(fotf(G),varargin{:});
   else, H=bode(fotf(G),varargin{:}); end
end
