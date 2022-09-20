function [H1,H2,m]=mfrdmat(H1,H2,n)
% Add up two MFD freq response arrays
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   if size(H1,1)<size(H2,1), m=size(H1,1); H1=repmat(H1,n,1); 
   elseif size(H1,1)>size(H2,1), m=size(H2,1); H2=repmat(H2,n,1); 
   else, m=size(H1,1)/n; end
end
