% Impulse response invariant discretization of fractional order 
% low-pass filters
% 
% irid_folpf function is prepared to compute a discrete-time finite 
% dimensional (z) transfer function to approximate a continuous-time 
% fractional order low-pass filter (LPF) [1/(\tau s +1)]^r, where "s" is 
% the Laplace transform variable, and "r" is a real number in the range of 
% (0,1), \tau is the time constant of LPF [1/(\tau s +1)]. 
%
% The proposed approximation keeps the impulse response "invariant"
%
% IN: 
%       tau: the time constant of (the first order) LPF
%       r: the fractional order \in (0,1)
%       Ts: the sampling period
%       norder: the finite order of the approximate z-transfer function 
%       (the orders of denominator and numerator z-polynomial are the same)
% OUT: 
%       sr: returns the LTI object that approximates the [1/(\tau s +1)]^r
%           in the sense of invariant impulse response. 
% TEST CODE
% dfod=irid_folpf(.01,0.5,.001,5);figure;pzmap(dfod)
%
% Reference: YangQuan Chen. "Impulse-invariant discretization of fractional
% order low-pass filters".
% Sept. 2008. CSOIS AFC (Applied Fractional Calculus) Seminar.
% http://fractionalcalculus.googlepages.com/
% --------------------------------------------------------------------
% YangQuan Chen, Ph.D, Associate Professor and Graduate Coordinator
% Department of Electrical and Computer Engineering,
% Director, Center for Self-Organizing and Intelligent Systems (CSOIS)
% Utah State University, 4120 Old Main Hill, Logan, UT 84322-4120, USA
% E: yqchen@ece.usu.edu or yqchen@ieee.org, T/F: 1(435)797-0148/3054; 
% W: http://www.csois.usu.edu or http://yangquan.chen.googlepages.com 
% --------------------------------------------------------------------
%
% 9/7/2009 
% Only supports when r in (0,1). That is fractional order low pass filter.
% HOWEVER, if r is in (-1,0), we call this is a "fractional order
% (proportional and derivative controller)" - we call it FO(PD).
% Note: it may be needed to make FO-LPF discretization minimum phase first.
% 
% See also irid_fod.m 
%          at http://www.mathworks.com/matlabcentral/files/21342/irid_fod.m
% See also srid_fod.m 
%          (See how the nonminimum phase zeros are handled)
% See also gml_fun.m 
%          at http://www.mathworks.com/matlabcentral/files/20849/gml_fun.m

function [sr]=irid_folpf(tau,r,Ts,norder)

if nargin<4; norder=5; end
% if tau < 0 , sprintf('%s','Time constant has to be positive'),     return, end
% if Ts < 0 , sprintf('%s','Sampling period has to be positive'),     return, end
% if r>=1 | r<= 0, sprintf('%s','The fractional order should be in (0,1)'), return, end
% if norder<2, sprintf('%s','The order of the approximate transfer function has to be greater than 1'), return, end
 
wmax0=2*pi/Ts/2; % rad./sec. Nyquist frequency
L=abs(tau)*4/Ts; % decides the number of points of the impulse response function h(n)
Taxis=[0:L-1]*Ts;
ha0=(7.0*Ts/8)^r;
n=1:L-1; n=n*Ts;  
h1=gml_fun(1,r,r,-1/tau*n); % http://www.mathworks.com/matlabcentral/files/20849/gml_fun.m
h2=(1/tau)^r*h1.*(n.^(r-1)); 
h0= ha0*(1/(tau+ (7.0*Ts/8)))^r; 
h=[h0,h2*Ts]; %% [ha0, (Ts^r)*(n.^(r-1))/gamma(r)]; 
q=norder;p=norder;
[b,a]=prony((h),q,p);
sr=tf(b,a,Ts);
