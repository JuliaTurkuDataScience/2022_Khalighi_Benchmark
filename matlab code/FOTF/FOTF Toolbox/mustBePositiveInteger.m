function mustBePositiveInteger(a)
%mustBePositiveInteger a function to validate the argument

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last Modified 18 May, 2022
   if a<=0
      eid='Value:Positive'; msg='Inputs must be positive.';
      throwAsCaller(MException(eid,msg))
   end
   if round(a)~=a
      eid='Value:Integer'; msg='Inputs must be an integer.';
      throwAsCaller(MException(eid,msg))
   end
end