function y=impulse(G,t)
% impulse - impulse response evaluation of an FOTF object
%
%   impulse(G,t)
% 
%   G - an FOTF object
%   t - the time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   G1=G*fotf('s');
   if nargout==0, step(G1,t,1); title('Impulse Response')
   else, y=step(G1,t,1); end
end
