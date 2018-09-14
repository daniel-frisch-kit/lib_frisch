function camd = get_camdata(ax)

fg = ax.Parent;

fprintf('\n')
fprintf('posd = struct();\n')

fprintf('posd.figure.Units          = %s;\n',  mat2str(get(fg,'Units')))
fprintf('posd.figure.Position       = %s;\n',  mat2str(get(fg,'Position'),5))

fprintf('posd.axes.Units            = %s;\n',  mat2str(get(ax,'Units')))
fprintf('posd.axes.Position         = %s;\n',  mat2str(get(ax,'Position'),5))

fprintf('posd.axcam.CameraPosition  = %s;\n',  mat2str(get(ax,'CameraPosition' ),5))
fprintf('posd.axcam.CameraTarget    = %s;\n',  mat2str(get(ax,'CameraTarget'   ),5))
fprintf('posd.axcam.CameraUpVector  = %s;\n',  mat2str(get(ax,'CameraUpVector' ),5))
fprintf('posd.axcam.CameraViewAngle = %s;\n',  mat2str(get(ax,'CameraViewAngle'),5))

fprintf('posd.legend.Units          = %s;\n',  mat2str(ax.Legend.Units))
fprintf('posd.legend.Position       = %s;\n',  mat2str(ax.Legend.Position,5))

fprintf('\n')
end
