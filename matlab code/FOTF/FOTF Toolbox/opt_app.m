function Gr=opt_app(G,r,k,key,G0)
   arguments
      G, r(1,1) {mustBePositiveInteger}
      k(1,1) {mustBePositiveInteger}
      key(1,1){mustBeMember(key,[0,1])}=0, G0=0
   end
   GS=tf(G); Td=totaldelay(GS);
   GS.ioDelay=0; GS.InputDelay=0; GS.OutputDelay=0; s=tf('s');
   if nargin<5, G0=(s+1)^r/(s+1)^k; end
   beta=G0.num{1}(k+1-r:k+1); alph=G0.den{1}; Tau=1.5*Td;
   x=[beta(1:r),alph(2:k+1)]; if abs(Tau)<1e-5, Tau=0.5; end
   dc=dcgain(GS); if key==1, x=[x,Tau]; end
   y=opt_fun(x,GS,key,r,k,dc);
   x=fminsearch(@opt_fun,x,[],GS,key,r,k,dc);
   alph=[1,x(r+1:r+k)]; beta=x(1:r+1); if key==0, Td=0; end
   beta(r+1)=alph(end)*dc; if key==1, Tau=x(end)+Td; else, Tau=0; end
   Gr=tf(beta,alph,'ioDelay',Tau);
end
function y=opt_fun(x,G,key,r,k,dc)
   ff0=1e10; a=[1,x(r+1:r+k)]; b=x(1:r+1); b(end)=a(end)*dc;
   if key==1, tau=x(end);
   if tau<=0, tau=eps; end, [n,d]=pade(tau,3); gP=tf(n,d);
   else, gP=1; end
   G_e=G-tf(b,a)*gP; G_e.num{1}=[0,G_e.num{1}(1:end-1)];
   [y,ierr]=geth2(G_e); if ierr==1, y=10*ff0; else, ff0=y; end
end
function [v,ierr]=geth2(G)
   G=tf(G); num=G.num{1}; den=G.den{1}; ierr=0; v=0; n=length(den);
   if abs(num(1))>eps
      disp('System not strictly proper');
      ierr=1; return
   else, a1=den; b1=num(2:length(num)); end
   for k=1:n-1
      if (a1(k+1)<=eps), ierr=1; return
      else
         aa=a1(k)/a1(k+1); bb=b1(k)/a1(k+1); v=v+bb*bb/aa; k1=k+2;
            for i=k1:2:n-1, a1(i)=a1(i)-aa*a1(i+1); b1(i)=b1(i)-bb*a1(i+1);
   end, end, end, v=sqrt(0.5*v);
end
