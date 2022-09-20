function blkStruct = slblocks
%SLBLOCKS Defines the block library for FOTF Toolbox or Blockset.

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   blkStruct.Name = sprintf('%s\n%s','FOTF Blockset','Toolbox');
   blkStruct.OpenFcn = 'fotflib';
   blkStruct.IsFlat  = 1;
end
