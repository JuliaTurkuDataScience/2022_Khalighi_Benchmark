function gershgorin(H,key)
% gershgorin - draw Nyquist plots with Gershgorin bands
%
%   gershgorin(H,key)
%
%   H - the frequency response data in FRD format
%   key - if key=1, the inverse Nyquist plots are drawn
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 28 March, 2017 
if nargin==1, key=0; end
t=[0:.1:2*pi,2*pi]'; [nr,nc]=size(H); nw=nr/nc; ii=1:nc; 
for i=1:nc, circles{i}=[]; end
for k=1:nw  % evaluate inverse Nyquist array for the frequencies
   G=H((k-1)*nc+1:k*nc,:); 
   if nargin==2 && key==1, G=inv(G); end, H1(:,:,k)=G;
   for j=1:nc, ij=find(ii~=j);
      v=min([sum(abs(G(ij,j))),sum(abs(G(j,ij)))]);
      x0=real(G(j,j)); y0=imag(G(j,j));
      r=sum(abs(v)); % compute Gershgorin circles radius
      circles{j}=[circles{j} x0+r*cos(t)+sqrt(-1)*(y0+r*sin(t))];
end, end
hold off; nyquist(tf(zeros(nc)),'w'); hold on; 
h=get(gcf,'child'); h0=h(end:-1:2); 
for i=ii, for j=ii
   axes(h0((j-1)*nc+i)); NN=H1(i,j,:); NN=NN(:);
   if i==j  % diagonal plots with Gershgorin circles
      cc=circles{i}(:);  x1=min(real(cc)); x2=max(real(cc)); 
      y1=min(imag(cc)); y2=max(imag(cc)); plot(NN) 
      plot(circles{i}), plot(0,0,'+'), axis([x1,x2,y1,y2])
   else, plot(NN), end    % non-diagonal elements
end, end, hold off
if key==1, title('Inverse Nyquist Diagram'); end
