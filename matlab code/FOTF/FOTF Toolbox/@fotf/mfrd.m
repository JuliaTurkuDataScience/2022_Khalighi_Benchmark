function H1=mfrd(G,w)
% mfrd - evaluation of frequency responses of an FOTF object
%
%   H=mfrd(G,w)
% 
%   G - an FOTF object
%   w - frequency vector
%   H - frequency response of G in MFD format

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   H=bode(G,w); h=H.ResponseData; H1=[];
   for i=1:length(w); H1=[H1; h(:,:,i)]; end
end
