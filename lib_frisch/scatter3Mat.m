function h = scatter3Mat(XYZ,varargin)
% scatter3Mat()
% Abbreviation function for 3D scatter plot
% Input
%   - XYZ [NPoints x 3] 
%   - optional arguments, see "doc scatter"
%
h = scatter3(XYZ(:,1),XYZ(:,2),XYZ(:,3), varargin{:});
assert(isscalar(h)) % for *_update function
end
