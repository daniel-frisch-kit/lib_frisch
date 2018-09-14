function h = plotMat(XYZ,varargin)
h = plot(XYZ(:,1),XYZ(:,2), varargin{:});
assert(isscalar(h)) % for *_update function
end
