function y=bp8a_fcn(t)
   y=t^(1.5-sqrt(2))*exp(t-0.3)*...
       ml_func([1,3-sqrt(2)],-t)./ml_func([1,1.5],-t);
end
