function y=c7mchua(~,x,k)
% C7MCHUA the function describing fractional Chua circuit
% Copyright (c) Dingyu Xue, Northeastern University, China

% Last Modified 18 May, 2022
   a=10.725; b=10.593; c=0.268; m0=-1.1726; m1=-0.7872;
   switch k
      case 1
         f=m1*x(1)+0.5*(m0-m1)*(abs(x(1)+1)-abs(x(1)-1));
         y=a*(x(2)-x(1)-f);
      case 2, y=x(1)-x(2)+x(3);
      case 3, y=-b*x(2)-c*x(3);
   end
end
