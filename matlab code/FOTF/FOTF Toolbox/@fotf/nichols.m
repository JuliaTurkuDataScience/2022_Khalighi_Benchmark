function nichols(G,w)
% nichols - draw the Nichols chart of an FOTF object
%
%   nichols(G,w)
% 
%   G - an FOTF object
%   w - the frequency vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   arguments, G, w=logspace(-4,4); end
   H=bode(G,w); nichols(H);
end
