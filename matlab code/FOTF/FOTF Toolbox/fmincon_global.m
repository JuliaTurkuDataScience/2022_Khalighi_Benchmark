function [x,f0]=fmincon_global(f,a,b,n,N,varargin), f0=Inf;
% fmincon_global - a possible global solver for constrained optimization problems
%
%   [x,f0]=fmincon_global(f,a,b,n,N,varargin)
%   
%   f - the objective function
%   (a,b) - the interval for the decision variables
%   n - the number of decision variables
%   N - the number of runs of fmincon function
%   x, f0 - the optimal decision variable and objective function

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   for i=1:N
      x0=a+(b-a).*rand(n,1); [x1,f1,key]=fmincon(f,x0,varargin{:}); 
      if key>0 && f1<f0, x=x1; f0=f1; end
   end
end
