function y=c7mbench5a(t,x)
% C7MBENCHa the function describing Benchmark Problem 5a
% Copyright (c) Dingyu Xue, Northeastern University, China

% Last Modified 18 May, 2022
   y=[(((x(2)-0.5)*(x(3)-0.3))^(1/5)+sqrt(t))/sqrt(pi);
      (x(1)-1)*gamma(2.2);
      (x(2)-0.5)*gamma(2.3)/gamma(2.2)];
end