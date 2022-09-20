function y=c8mfss3a(u)
   y=[2/sqrt(pi)*(((u(2)-0.3)*(u(3)-0.5*u(1)))^(1/5)+sqrt(u(5)));
      gamma(1.4)/gamma(1.3)*((u(1)-1)/2)^0.3;
      u(4); gamma(3.1)/gamma(1.6)*sqrt((u(2)-0.3)^3)];
   y=real(y);   %{\kaishu\,因未知原因混入微小的虚数，所以需要提取实部}
end
