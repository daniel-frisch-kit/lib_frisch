function h = scatterMat(XYZ,varargin)
% scatterMat()
% Abbreviation function for 2D scatter plot
% Input
%   - XYZ [NPoints x 2] 
%   - optional arguments, see "doc scatter"
%
h = scatter(XYZ(:,1),XYZ(:,2), varargin{:});
assert(isscalar(h)) % for *_update function
end
