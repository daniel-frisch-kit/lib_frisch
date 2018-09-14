function h = scatter3Mat(XYZ,varargin)
h = scatter3(XYZ(:,1),XYZ(:,2),XYZ(:,3), varargin{:});
assert(isscalar(h)) % for *_update function
end
