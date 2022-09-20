function varargout=default_vals(vals,varargin)
%no longer used in the new version
if nargout~=length(vals), error('number of arguments mismatch'); 
else, nn=length(varargin)+1;
    varargout=varargin; for i=nn:nargout, varargout{i}=vals{i};
end, end, end