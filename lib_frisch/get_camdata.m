function camd = get_camdata(ax)
% get_camdata(ax)
% Prints Matlab code to reproduce the current camera settings

assert(isscalar(ax))
assert(isa(ax,'matlab.graphics.axis.Axes'), 'Please specify an axes object.')

fg = ax.Parent;

% Print code how to show camera toolbar automatically
fprintf('\n')
fprintf('%% Show camera toolbar \n')
fprintf('cameratoolbar(fig, ''Show'');\n')
fprintf('cameratoolbar(fig, ''SetMode'',''orbit'');\n')
fprintf('cameratoolbar(fig, ''SetCoordSys'',''none'')\n')

% Print code that can reproduce camera settings 
fprintf('\n')
fprintf('%% Reproduce camera settings \n')
fprintf('%% get_camdata(gca) \n')
fprintf('posd = struct();\n')

fprintf('posd.figure.Units          = %s;\n',  mat2str(get(fg,'Units')))
fprintf('posd.figure.Position       = %s;\n',  mat2str(get(fg,'Position'),5))

fprintf('posd.axes.Units            = %s;\n',  mat2str(get(ax,'Units')))
fprintf('posd.axes.Position         = %s;\n',  mat2str(get(ax,'Position'),5))

fprintf('posd.axcam.CameraPosition  = %s;\n',  mat2str(get(ax,'CameraPosition' ),5))
fprintf('posd.axcam.CameraTarget    = %s;\n',  mat2str(get(ax,'CameraTarget'   ),5))
fprintf('posd.axcam.CameraUpVector  = %s;\n',  mat2str(get(ax,'CameraUpVector' ),5))
fprintf('posd.axcam.CameraViewAngle = %s;\n',  mat2str(get(ax,'CameraViewAngle'),5))

if ~isempty(ax.Legend)
  fprintf('posd.legend.Units          = %s;\n',  mat2str(ax.Legend.Units))
  fprintf('posd.legend.Position       = %s;\n',  mat2str(ax.Legend.Position,5))
end

fprintf('\n')

% Print code that can apply the saved camera positions
fprintf('%% Apply positioning \n')
fprintf('set(fig, posd.figure) \n')
fprintf('set(ax, posd.axes) \n')
fprintf('set(ax, posd.axcam) \n')
%fprintf('set(lg, posd.legend) \n')


end
