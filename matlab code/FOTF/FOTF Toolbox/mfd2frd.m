function H=mfd2frd(H1,w)
% mfd2frd - conversion from MFD data type to FRD
%
%   H=mfd2frd(H1,w)
%
%   H1, w - the frequency response and frequency vector to be approximated
%   H - the frequency response data in FRD format
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [nr,~]=size(H1); nw=length(w); nr=nr/nw;
   for i=1:nw, H(:,:,i)=H1((i-1)*nr+(1:nr),:); end, H=frd(H,w);
end