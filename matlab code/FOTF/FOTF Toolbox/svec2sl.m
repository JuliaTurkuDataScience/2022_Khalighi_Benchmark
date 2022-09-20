function key=svec2sl(v)
% svec2sl - construct vectorized s operator block, called internally
%           in FOTFLIB blockset

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 18 May, 2022 
   key=1; M=gcb;
   m=length(v); open_system(M,'loadonly');
   set_param(M,'Location',[100,100,800,500]);
   ll=get_param(M,'lines');
   bb=get_param(M,'blocks');
   for i=1:length(ll), delete_line(ll(i).Handle); end
   for i=1:length(bb), str=char(bb(i)); 
      if ~strcmp(str,'In1') && ~strcmp(str,'Out1')
         delete_block([M,'/',str]);
   end, end
   add_block('built-in/Demux',[M '/Demux'],'Position',[100,40,105,60],...
       'Outputs',int2str(m));
   add_block('built-in/Mux',[M '/Mux'],'Position',[200,40,205,60],...
       'Inputs',int2str(m));
   for k=1:length(v)
      blk=[M '/G' int2str(k)];
      add_block('cstblocks/LTI System',blk,...
            'Position',[60,50+k*30,90,70+k*30],'sys',['G(' int2str(k) ')']);
      add_line(M,['Demux/' int2str(k)],['G' int2str(k) ,'/1'],'autorouting','on')
      add_line(M,['G' int2str(k) '/1'],['Mux/' int2str(k)],'autorouting','on')
   end
   add_block('built-in/Integrator',[M '/Integrator'],...
           'Position',[250,80,275,120],...
           'InitialCondition','x0');
   add_line(M,'Integrator/1','Out1/1','autorouting','on')
   add_line(M,'Mux/1','Integrator/1','autorouting','on')
   add_line(M,'In1/1','Demux/1','autorouting','on')
end
