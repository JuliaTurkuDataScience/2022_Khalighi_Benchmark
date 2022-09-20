function y=c9mbvp3(x)
% c9mbvp3 - MATLAB function to boundary value problem

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last Modified 18 May, 2022
   W=get_param(gcs,'ModelWorkspace'); 
   assignin(W,'b',x(1)), assignin(W,'a',x(2))
   try
      txy=sim('bp7a_model.slx'); y0=txy.yout;
      y=[y0(end,1)-exp(-2); y0(end,2)+0.5*exp(-2)];
   catch, y=[10; 10]; 
   end
end
