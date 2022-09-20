function fotfpath
% fotfpath - set path after FOTF installation, for Simulink path

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   v=version; key=strfind(v,'.'); vers=eval(v(1:key(2)-1));
   p=path;
   if vers>=9.12
      p=strrep(p,'FOTF Toolbox\simulink2019b\','FOTF Toolbox\Simulink\');
      p=strrep(p,'FOTF Toolbox\simulink2019b;','FOTF Toolbox\Simulink;');
   else
      p=strrep(p,'FOTF Toolbox\Simulink\','FOTF Toolbox\simulink2019b\');
      p=strrep(p,'FOTF Toolbox\Simulink;','FOTF Toolbox\simulink2019b;');
   end
   path(p); savepath
end
 