function y=lsim(G,u,t)
% lsim - simulation of an FOTFS object driven by given inputs
%
%   lsim(G,u,t)
% 
%   G - an FOTF object
%   u, t- input samples and time vector

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
% Last modified 18 May, 2022 
   [n,m]=size(G); t0=t(1); t1=t(end); [nu,mu]=size(u); 
   if nu==m && mu==length(t), u=u.'; end
   if nargout==0, lsim(tf(zeros(n,m)),'w',zeros(size(u)),t); end
   for i=1:n, y1=0;
      for j=1:m, g=G(i,j); uu=u(:,j); 
         y2=fode_sol9(g.den.a,g.den.na,g.num.a,g.num.na,uu,t,3);
         ii=find(t>=g.ioDelay); lz=zeros(1,ii(1)-1);
         y2=[lz, y2(1:end-length(lz))]; y(:,i)=y1+y2;
   end, end
   if nargout==0, khold=ishold; hold on
      h=get(gcf,'child'); h0=h(end:-1:2);
      for i=1:n, axes(h0(i)); 
         plot(t,y(:,i),t,u,'--'), xlim([t0,t1])
   end, if khold==0, hold off, end, end
end
