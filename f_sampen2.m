function e = f_sampen2(y,M,r)
%function e=f_sampen(y,M,r);
%
%Input Parameters
%
%y  input signal vector
%M  maximum template length (default M=5)
%r  matching threshold (default r=.2)
%
%Output Parameters
%
%e sample entropy estimates for m=0,1,...,M-1
%
%Full usage:
%
%[e,se,A,B]=f_sampen(y,m,r,sflag,cflag,vflag)
%
%Input Parameters
%
%sflag    flag to standardize signal(default yes/sflag=1) 
%cflag    flag to use fast C code (default yes/cflag=1) 
%vflag    flag to calculate standard errors (default no/vflag=0) 
%
%Output Parameters
%e sample entropy estimates for m=0,1,...,M-1
%se standard error estimates for m=0,1,...,M-1
%A number of matches for m=1,...,M
%B number of matches for m=0,...,M-1
%  (excluding last point in Matlab version)

y=y(:);
n=length(y);

y=y-mean(y);
s=sqrt(mean(y.^2));   
y=y/s;

 
% if cflag>0
%    [match,R]=cmatches(y,n,r);
%    match=double(match);
% else   
[e,A,B] = f_sampenc(y,M,r);
e=e(end); % add by Mario V
end
