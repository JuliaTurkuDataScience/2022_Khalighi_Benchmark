function h=mfrdget(H,i,j,m)
% Extract MFD freq response array from MV MFD
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   h=[]; for k=1:length(i), h=[h; H(i(k):m:end,j)]; end
end
