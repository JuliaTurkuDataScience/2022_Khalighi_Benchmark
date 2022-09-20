function key=isfoss(G)
% isfoss - check whether input is an FOSS object
%
%   key=isfoss(G)
% 
%   G - an FOSS object 

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   key=strcmp(class(G),'foss');
end
