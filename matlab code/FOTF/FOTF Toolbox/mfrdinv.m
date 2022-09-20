function H=mfrdinv(H1,n)
% Inverse of a MFD freq response array
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   m=size(H1,1)/n; H=[]; 
   if m==size(H1,2), for i=1:n, H=[H; inv(H1((i-1)*m+1:m*i,:))]; end
   else, error('system matrix is not square, no inverse found'); end
end
