function [p,q,n]=size(G)
% size - extract the numbers of inputs, outputs and states of an FOSS object
%
%   [p,q,n]=size(G)
%
%   G - an FOSS object 
%   n, m - the numbers of the inputs and outputs
%   n - the number of states

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   q=size(G.c,1); p=size(G.b,2); n=length(G.a);
end
