function G=exp(del)
% exp - express delay term exp(-tau*s)
%only works for SISO FOTF model

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 May, 2022 
   try
      T=double(del/fotf('s'));
      if T>0, error('Delay must be negative'), else, T=-T; end
      G=fotf(1); G.ioDelay=T;
   catch, error('Error in extracting delay constant'); 
   end
end
