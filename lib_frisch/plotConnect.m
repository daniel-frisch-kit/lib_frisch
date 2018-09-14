function h = plotConnect(XYZ1,XYZ2,varargin)
h = plotMat(reshape([shiftdim(XYZ1,-1);shiftdim(XYZ2,-1);shiftdim(XYZ1,-1)*NaN],[],2),varargin{:});
%assert(isscalar(h)) % for *_update function
end
