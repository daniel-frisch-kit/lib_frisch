function h = plot3Mat(XYZ,varargin)
h = plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3), varargin{:});
assert(isscalar(h)) % for *_update function
end
