function H=bode(G,w)
% bode - draw Bode diagram for an FOTF object
%
%    bode(G,w)
%    H=bode(G,w)
%
%   G - the FOTF object
%   w - the frequency vector
%   H - the frequency response data in FRD format

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, G, w=logspace(-4,4); end
   H1=freqresp(1j*w,G); H1=frd(H1,w);
   if nargout==0, subplot(111), bode(H1); else, H=H1; end
end
