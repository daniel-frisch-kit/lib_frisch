function h = scatterMat(XYZ,varargin)
h = scatter(XYZ(:,1),XYZ(:,2), varargin{:});
assert(isscalar(h)) % for *_update function
end
