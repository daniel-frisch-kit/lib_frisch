function h = plot3Connect(XYZ1,XYZ2,varargin)
% Plot lines between the 3D points XYZ1(k,:) and XYZ2(k,:), respectively 
h = plot3Mat(reshape([shiftdim(XYZ1,-1);shiftdim(XYZ2,-1);shiftdim(XYZ1,-1)*NaN],[],3),varargin{:});
%assert(isscalar(h)) % for *_update function
end
