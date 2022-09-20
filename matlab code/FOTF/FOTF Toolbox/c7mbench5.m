function y=c7mbench5(t,x,k)
% C7MBENCH the function describing Benchmark Problem 5
% Copyright (c) Dingyu Xue, Northeastern University, China

% Last Modified 18 May, 2022
   switch k
      case 1
         y=(((x(2)-0.5)*(x(3)-0.3))^(1/5)+sqrt(t))/sqrt(pi);
      case 2, y=(x(1)-1)*gamma(2.2);
      case 3, y=(x(2)-0.5)*gamma(2.3)/gamma(2.2);
   end 
end
