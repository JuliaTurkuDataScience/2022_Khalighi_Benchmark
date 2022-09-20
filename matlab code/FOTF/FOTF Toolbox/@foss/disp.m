function disp(G)
% display - display an FOSS.  This function will be called automatically

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   disp('E*(d^alpha*X)(t)=A*X(t)+B*U(t-T)'), T=G.ioDelay;
   disp('Y(t)=C*X(t)+D*U(t-T)'); ss(G.a,G.b,G.c,G.d)
   if ~isempty(G.E), disp('Descriptor matrix'), E=G.E, end
   if sum(T(:)), disp(['Time Delay is = ' mat2str(T)]); end
   disp(['alpha = ',num2str(G.alpha)]);
   if ~isempty(G.x0), x0=G.x0;
   disp(['Initil state vector x0 = [' num2str(x0(:).'),']'])
end, end
