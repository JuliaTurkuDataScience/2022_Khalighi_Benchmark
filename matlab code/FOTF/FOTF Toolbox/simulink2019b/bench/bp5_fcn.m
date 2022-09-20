function y=bp5_fcn(u)
   y=[(((u(2)-0.5)*(u(3)-0.3))^(1/5)+sqrt(u(4)))/sqrt(pi);
      (u(1)-1)*gamma(2.2); (u(2)-0.5)*gamma(2.3)/gamma(2.2)];
   y=real(y);   %{\kaishu\,因未知原因混入微小的虚数，所以需要提取实部}
end