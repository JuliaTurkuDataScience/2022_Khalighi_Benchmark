function Ga=charef_opt(wr,n,G,wt,a,wc)
% charef_opt - design function for the optimum Charef filter
%
%    Ga=charef_opt(wr,n,G,wt,a,wc)
%   
%   wr - the selected frequency vector
%   n - the order of the filter
%   G - the frequency response data for the irrational system model
%   wt - weighting for the four terms in the formula
%   a, wc - reference parameters for the filter design process
%   Ga - the optimum Charef filter designed

% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017
% Last modified 18 May, 2022
   arguments, wr(:,1), n(1,1){mustBeInteger, mustBePositive}
      G(:,1), wt(1,4)=[1 1 1 1], a(1,1)=0.5, wc(1,1)=1
   end
   e=1; x0(1)=10^(e/(10*a*(1-a)));
   x0(2)=10^(e/(20*(1-a)))*wc*10^(e/(20*a));
   x0(3:n+3)=ones(1,n+1)/10^(e/(20*(1-a)));
   ff=optimset; ff.Display='iter'; A=[];B=[];Aeq=[];Beq=[];CF=[];
   xm=[1 0 zeros(1,n+1)]; xM=[3 10 ones(1,n+1)];
   x1=fmincon(@charef_obj,x0,A,B,Aeq,Beq,xm,xM,CF,ff,wr,G,wt);
   c=x1(1); wu0=x1(2); wu=wu0*c.^[0:n]; p=wu.*x1(3:end);
   z=wu.^2./p; k=prod(p)/prod(z); Ga=zpk(-z',-p',k);
end
% 计算目标函数值的子函数
function f=charef_obj(x,wr,G,wt)
   n=length(x)-2;
   c=x(1); wu0=x(2); wu=wu0*c.^(0:(n-1)); p=wu.*x(3:end);
   z=wu.^2./p; k=prod(p)/prod(z); Ga=zpk(-z',-p',k);
   Ga1=frd(Ga,wr); h=Ga1.ResponseData; Ga_fr=h(:);
   f=wt(1)*norm(abs(angle(Ga_fr)-angle(G)),inf)+...
       wt(2)*sum(abs(angle(Ga_fr)-angle(G)))/length(wr)+...
       wt(3)*norm(abs(abs(Ga_fr)-abs(G)),inf)+...
       wt(4)*sum(abs(abs(Ga_fr)-abs(G)))/length(wr);
end

