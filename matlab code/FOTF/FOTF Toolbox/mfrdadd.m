function H=mfrdadd(H1,H2,n)
% Add up two MFD freq response arrays
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   [H1,H2]=mfrdmat(H1,H2,n); H=H1+H2;
end
    