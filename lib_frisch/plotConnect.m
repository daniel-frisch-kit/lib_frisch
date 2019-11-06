function h = plotConnect(XY1,XY2,varargin)
% Plot lines between the 2D points XY1(k,:) and XY2(k,:), respectively 
h = plotMat(reshape([shiftdim(XY1,-1);shiftdim(XY2,-1);shiftdim(XY1,-1)*NaN],[],2),varargin{:});
%assert(isscalar(h)) % for *_update function
end
