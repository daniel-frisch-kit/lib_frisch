function h = plotMat(XYZ,varargin)
% plotMat()
% Abbreviation function for 2D line plot 
% Input
%   - XYZ [NPoints x 2] 
%   - optional arguments, see "doc plot"
%
h = plot(XYZ(:,1),XYZ(:,2), varargin{:});
assert(isscalar(h)) % for *_update function
end
