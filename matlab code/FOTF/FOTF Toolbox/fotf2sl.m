function key=fotf2sl(G,str0)
% fotf2sl - construct multivariable FOTF block, called internally
%           in FOTFLIB blockset

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
ik=strfind(str0,'|'); sG=str0(1:ik(1)-1);
key=1; M=[gcb '/FOTF_matx'];
if exist('G') & strcmp(class(G),'fotf')
   [m,n]=size(G); open_system(M,'loadonly');
   set_param(M,'Location',[100,100,500,400]);
   ll=get_param(M,'lines');
   bb=get_param(M,'blocks');
   for i=1:length(ll), delete_line(ll(i).Handle); end
   for i=1:length(bb), str=char(bb(i));
      if ~strcmp(str,'In1') & ~strcmp(str,'Out1'),
         delete_block([M,'/',str]);
   end, end
   set_param([M '/In1'],'Position',[40,80,70,94]);
   add_block('built-in/Demux',[M '/Demux'],...
        'Position',[140,80,145,120],...
        'Outputs',int2str(n));
   add_block('built-in/Mux',[M '/Mux'],...
        'Position',[170+200*n,80,175+200*n,120],...
        'Inputs',int2str(m));
   set_param([M '/Out1'],'Position',...
        [200+200*n,80,230+200*n,94]);
   pos=zeros(n*m,4); s='+'; ss=repmat(s,1,n);
   add_line(M,'In1/1','Demux/1','autorouting','on');
   add_line(M,'Mux/1','Out1/1','autorouting','on');
   for i=1:m, i1=int2str(i);
      add_block('built-in/Sum',[M '/Add' i1],...
         'Inputs',ss,'Position',[110+200*n,...
         100+80*(i-1),125+200*n,100+80*(i-1)+10*n]);
      for j=1:n, j1=int2str(j);
         blkname=[M,'/' sG,i1,j1];
         pos(i+(j-1)*n,:)=[180+10*n+160*(j-1),...
            80+80*(i-1)+40*(j-1),300+10*n+160*(j-1),...
            120+80*(i-1)+40*(j-1)];
         add_block('fotflib/Approximate FOTF model',...
            blkname,'Position',pos(i+(j-1)*n,:));
         str=get_param(blkname,'MaskValueString');
         ii=strfind(str,'|');
         str=[sG '(' i1,',',j1 ')' str(ii(1):ii(4)),... 
             str0(ik(1)+1:end) str(ii(7):end)]; 
         set_param(blkname,'MaskValueString',str)
         add_line(M,['Demux/',j1],[sG i1 j1 '/1'],...
             'autorouting','on')
         add_line(M,[sG i1 j1 '/1'],...
             ['Add' i1 '/',j1],'autorouting','on')
      end
      add_line(M,['Add' i1 '/1'],['Mux/' i1],...
          'autorouting','on')
   end
else, key=0; end
