function [y,h,n]=fdiffcom(f,t)
% commonly used file by many fractional differentiators

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022
   y=f; if strcmp(class(f),'function_handle'), y=f(t); end
   h=t(2)-t(1); n=length(t); 
end
