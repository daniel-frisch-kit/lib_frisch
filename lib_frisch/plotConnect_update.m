function plotConnect_update(h,XY1,XY2,varargin)
% Plot lines between the 2D points XY1(k,:) and XY2(k,:), respectively 
assert(isscalar(h)) % for *_update function
assert(isa(h,'matlab.graphics.chart.primitive.Line'))
mat = reshape([shiftdim(XY1,-1);shiftdim(XY2,-1);shiftdim(XY1,-1)*NaN],[],2);
set(h, 'XData',mat(:,1), 'YData',mat(:,2))
end
