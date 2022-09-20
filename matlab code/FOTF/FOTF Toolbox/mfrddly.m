function H=mfrddly(H1,D,w)
% Frequency response of MFD with delay matrix D
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   n=length(w); m=size(H1,1)/n; H=[]; 
   if length(D)==1, D=repmat(D,m,size(H1,2)); end 
   for i=1:n, H=[H; H1((i-1)*m+1:m*i,:).*exp(-1i*D*w(i))]; end    
end
