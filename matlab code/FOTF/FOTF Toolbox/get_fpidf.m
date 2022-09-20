function Gf=get_fpidf(x,G,key1), x=[x(:).',1 1];
% get_fpidf - build string expression of the open-loop model 
%
%   Gf=get_fpidf(x,G,key1)
%
%   x - the decision variable of FOPID controllers
%   
%   key - if key=1, the inverse Nyquist plots are drawn
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
x1=num2str(x(1)); x2=num2str(x(2)); x4=num2str(x(4));
x3=num2str(x(3)); x5=num2str(x(5));
switch key1
   case {'fpid',1}
      Gc=['(' x1 '+' x2 '*s^-' x4 '+' x3 '*s^' x5 ')'];
   case {'fpi',2}, Gc=['(' x1 '+' x2 '*s^-' x3 ')'];
   case {'fpd',3}, Gc=['(' x1 '+' x2 '*s^' x3 ')'];
   case {'fpidx',4}, Gc=['(' x1 '+' x2 '/s+' x3 '*s^' x4 ')'];
   case {'pid',5}, Gc=['(' x1 '+' x2 '/s+' x3 '*s)'];
end
G=strrep(G,'+-','-'); Gf=[G '*' Gc];
