function [f,t]=num_diff(y,h,n,p)
% num_diff integer-order numerical differentiation

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   arguments, y(:,1), h(1,1) {mustBePositive}
      n(1,1){mustBeInteger,mustBePositive}
      p(1,1){mustBeInteger,mustBePositive}
   end
   m=n+p; alpha=0:m; c=double(fdcoef(n,m,alpha)); 
   t=(0:length(y)-m)'*h; 
   for i=1:length(y)-m+1, yy=y(i:i+m-1); f(i,1)=c*yy/h^n; end
end
