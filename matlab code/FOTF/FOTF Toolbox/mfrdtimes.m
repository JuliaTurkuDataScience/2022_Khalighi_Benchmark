function H=mfrdtimes(H1,H2,n)
% multiply two MFD freq response arrays
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   [H1,H2,m]=mfrdmat(H1,H2,n); H=[];
   for i=1:m:size(H1,1), ix=i:i+m-1; H=[H; H1(ix,:)*H2(ix,:)]; end
end
