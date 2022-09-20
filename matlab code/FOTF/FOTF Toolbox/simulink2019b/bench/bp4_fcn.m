function y=bp4_fcn(t)
   y=1/8*t*(ml_func([1,1.8],-t/2)*ml_func([1,1.2],-t/2)+...
       ml_func([1,1.7],-t/2)*ml_func([1,1.3],-t/2));
end
