function y=c8mnlssd(u)
% c8mnlssd - MATLAB function to express the Simulink block

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last Modified 18 May, 2022
   y=[(((u(2)-0.5)*(u(3)-0.3))^(1/5)+sqrt(u(4)))/sqrt(pi);
      (u(1)-1)*gamma(2.2); (u(2)-0.5)*gamma(2.3)/gamma(2.2)];
   y=real(y); %for unknown reasons, tiny imaginary part involved
end
