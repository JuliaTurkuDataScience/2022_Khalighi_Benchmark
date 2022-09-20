function H1=mfrd(G,w)
% mfrd - frequency response of an FOTF object
%
%   H=mfrd(G,w)
%
%   G, w - the FOTF object and the frequency vector
%   H - the frequency response data in MFD format
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   H=frd(G,w); h=H.ResponseData; H1=[];
   for i=1:length(w); H1=[H1; h(:,:,i)]; end
end