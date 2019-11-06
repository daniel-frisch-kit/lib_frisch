function h = plot3Mat(XYZ,varargin)
% plot3Mat()
% Abbreviation function for 3D line plot 
% Input
%   - XYZ [NPoints x 3] 
%   - optional arguments, see "doc plot"
%
h = plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3), varargin{:});
assert(isscalar(h)) % for *_update function
end
