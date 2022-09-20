function y=c9mbvp2a(x)
% c9mbvp2a - MATLAB function to boundary value problem

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last Modified 18 May, 2022
   W=get_param(gcs,'ModelWorkspace'); 
   assignin(W,'b',x(1)), assignin(W,'a',x(2))
   try
      txy=sim('bp6a_model.slx'); y0=txy.yout;
      y=[y0(end,1)-exp(-2); y0(end,2)-y0(1,1)+exp(-2)+1];
   catch, y=[10; 10]; 
   end
end