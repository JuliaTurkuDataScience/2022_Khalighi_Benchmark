function Y=step(G,t,key)
% step - simulation of an FOTF object driven by step inputs
%
%   step(G,t)
% 
%   G - an FOTF object
%   t- the time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G); M=tf(zeros(n,m)); 
   if nargin==1, t=(0:0.2:10)'; elseif length(t)==1, t=0:t/100:t; end
   if nargout==0, t0=t(1); t1=t(end); 
      if nargin<=2, step(M,'w'); else, impulse(M,'w'); 
   end, end
   for i=1:n, for j=1:m
      g=G(i,j); y1=g_step(g,t); y(i,j,:)=y1';
   end, end
   if nargout==0, khold=ishold; hold on 
      h=get(gcf,'child'); h0=h(end:-1:2); 
      for i=1:n, for j=1:m, axes(h0((i-1)*n+j)); 
         yy=y(i,j,:); plot(t,yy(:)), xlim([t0,t1])
      end, end
      if khold==0, hold off, end
   elseif n*m==1, Y=y1; else, Y=y; end
end
%subfunction to evaluate step response of SISO model
function y=g_step(g,t,key)
   u=ones(size(t));
   [a,na,b,nb,T]=fotfdata(g); y1=fode_sol(a,na,b,nb,u,t);
   ii=find(t>=T); lz=zeros(1,ii(1)-1); y=[lz, y1(1:end-length(lz))];
end