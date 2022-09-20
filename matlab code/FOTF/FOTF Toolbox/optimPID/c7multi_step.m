function [sys,x0,str,ts,SSC]=c7multi_step(t,~,~,flag,tTime,yStep)
   switch flag
      case 0 % initialization
         [sys,x0,str,ts] = mdlInitializeSizes; SSC='DefaultSimState';
      case 3  % computes the outputs
          sys = mdlOutputs(t,tTime,yStep);
      case {1, 2, 4, 9} % undefined flag
          sys = [];
      otherwise % error found
          error(['Unhandled flag = ',num2str(flag)]);
   end
end
function [sys,x0,str,ts] = mdlInitializeSizes
   sizes = simsizes; 
   sizes.NumContStates = 0; sizes.NumDiscStates = 0; 
   sizes.NumOutputs = 1; sizes.NumInputs = 0;
   sizes.DirFeedthrough = 0; sizes.NumSampleTimes = 1;
   sys = simsizes(sizes);
   x0 = []; str = []; ts = [0 0]; 
end
function sys = mdlOutputs(t,tTime,yStep)
   i=find(tTime<=t); sys=yStep(i(end));
end
