%% ForwardInference

% Code for the plots in ISAS-Blog Entry
% https://isas-blog.iar.kit.edu/author/frisch/

clear classes


%% Find dependencies
% [flist,plist] = matlab.codetools.requiredFilesAndProducts('ForwardInferene.m'); [flist'; {plist.Name}']
% get_camdata.m (optional)
% export_fig (optional) https://de.mathworks.com/matlabcentral/fileexchange/23629-export_fig
% Statistics and Machine Learning Toolbox

addpath('../../lib_frisch')


%% Definitions

sigma = .4;
dt = 1;
uh = 1;
x0h = 0;

intval = [-1,2, 0,2, 0,1.1];


%% Calculations

dens_tran = @(x0,x1) normpdf(x1, x0+dt*uh, dt*sigma);

dens_x0_surf = @(x0,x1,f) x0-x0h;

dens_res = @(x1) normpdf(x1, x0h+dt*uh, dt*sigma);

dens_res_surf = @(x0,x1) dens_res(x1);



%% Plot Results - Density

name = 'Forward-Inference_Transition-Density';

fig = figure(139232);
clf(fig)
set(fig, 'Color','white', 'NumberTitle','off', 'Name',name, 'DefaultTextInterpreter','LaTeX')
ax = axes(fig);
set(ax, 'NextPlot','add', 'DataAspectRatio',[1,1,1], 'LabelFontSizeMultiplier',1.5)
cols = ax.ColorOrder;

fs = fsurf(ax, dens_tran, intval(1:4));
set(fs, 'DisplayName','$f(x_{k+1}\,|\,x_k)$', 'FaceColor',cols(3,:))

f0_plane = fimplicit3(ax, dens_x0_surf, intval);
set(f0_plane, 'DisplayName','$f_0^e(x_0)$', 'FaceColor',cols(1,:), 'FaceAlpha',0.3)

f0 = plot3(ax, [x0h,x0h], [0,0], intval(5:6));
set(f0, 'DisplayName','$f_0^e(x_0)$', 'Color',cols(1,:), 'LineWidth',5)

f1 = fplot3(ax, @(x1) intval(1)*ones(size(x1)), @(x1) x1, @(x1) dens_res(x1), intval(3:4));
set(f1, 'DisplayName','$f_1^p(x_{1})$', 'Color',cols(2,:), 'LineWidth',5)

f1_plane = fsurf(ax, dens_res_surf, intval(1:4));
set(f1_plane, 'DisplayName','$f_1^p(x_{1})$', 'FaceColor',cols(2,:), 'FaceAlpha',0.3)


set(ax, 'XGrid','on', 'YGrid','on', 'ZGrid','on')
set(ax, 'XMinorGrid','on', 'YMinorGrid','on', 'ZMinorGrid','on')
ax.XTick = -1:2;
xlabel(ax, '$x_0$')
ylabel(ax, '$x_1$')
zlabel(ax, '$f$')

lg = legend(ax, [f0, fs, f1]);
set(lg, 'Interpreter','latex', 'FontSize',ax.XLabel.FontSize)
lg.Location = 'EastOutside';

%cm = colorbar(ax);
%set(cm.Label, 'String','$f(x_{k+1}\,|\,x_k)$', 'Interpreter','LaTeX', 'FontSize',ax.XLabel.FontSize)


% get_camdata(ax)
posd = struct();
posd.axes.CameraPosition  = [-12.155 -11.051 7.6106];
posd.axes.CameraTarget    = [0.5 1 0.55];
posd.axes.CameraUpVector  = [0 0 1];
posd.axes.CameraViewAngle = 7.1357;
posd.figure.Units         = 'pixels';
posd.figure.Position      = [94 481 694 322];
set(fig, posd.figure)
set(ax, posd.axes)
movegui(fig)

% % print(fig, '-dsvg', fullfile('Figures',[name,'.svg'])) % too large files

% export_fig(fullfile('Figures',[name,'.png']), fig, '-m3' )



%% Plot Results - Prediction

name = 'Forward-Inference_Prediction';

fig = figure(3828483);
clf(fig)
set(fig, 'Color','white', 'NumberTitle','off', 'Name',name, 'DefaultTextInterpreter','LaTeX')
ax = axes(fig);
set(ax, 'NextPlot','add', 'DataAspectRatio',[1,.2,1], 'LabelFontSizeMultiplier',1.5)

% cols = ax.ColorOrder;
cols = ax.Colormap;

% Plot initial Dirac delta
p0 = plot(ax, [x0h,x0h], [0,1], 'DisplayName','$f^e_0(x_0)$');
set(p0, 'Color','black', 'LineWidth',3)

% Plot the following predicted Gaussian densities 
ph = matlab.graphics.function.FunctionLine.empty;
for k = 1:12
  fun = @(x1) normpdf(x1, k*dt*uh + x0h, dt*sigma*sqrt(k));
  ph(k) = fplot(ax, fun, [-1,15], 'DisplayName',sprintf('$f^p_{%u}(x_{%u})$',k,k), 'Color',cols(5*k,:));
end
set(ph, 'LineWidth',3)

set(ax, 'XGrid','on', 'YGrid','on', 'ZGrid','on')
set(ax, 'XMinorGrid','on', 'YMinorGrid','on', 'ZMinorGrid','on')
xlabel(ax, '$x_k$')
ylabel(ax, '$f^p_k(x_k)$')
xlim(ax, ph(1).XRange)

lg = legend(ax, [p0,ph]);
set(lg, 'Interpreter','latex', 'FontSize',ax.XLabel.FontSize)
lg.Location = 'EastOutside';

ax.Children = flip(ax.Children);

% get_camdata(ax)
posd = struct();
posd.figure.Units          = 'pixels';
posd.figure.Position       = [31 502 877 328];
posd.axes.Units            = 'normalized';
posd.axes.Position         = [0.068426 0.11 0.775 0.815];
posd.axcam.CameraPosition  = [7 0.5 84.41];
posd.axcam.CameraTarget    = [7 0.5 0];
posd.axcam.CameraUpVector  = [0 1 0];
posd.axcam.CameraViewAngle = 4.2376;
posd.legend.Units          = 'normalized';
posd.legend.Position       = [0.86108 0.010257 0.1343 0.98171];

set(fig, posd.figure)
set(ax, posd.axes)
set(ax.Legend, posd.legend)
movegui(fig)

% print(fig, '-dsvg', fullfile(pwd, 'Figures', [name,'.svg']))  





%% Plot Results - Prediction (Feature Image)

name = 'Forward-Inference_Prediction_Feature';

fig = figure(284348);
clf(fig)
set(fig, 'Color','white', 'NumberTitle','off', 'Name',name, 'DefaultTextInterpreter','LaTeX')
ax = axes(fig);
set(ax, 'NextPlot','add', 'DataAspectRatio',[1,.2,1], 'LabelFontSizeMultiplier',1.5)

% cols = ax.ColorOrder;
cols = ax.Colormap;

% Plot initial Dirac delta
p0 = plot(ax, [x0h,x0h], [0,1], 'DisplayName','$f^e_0(x_0)$');
set(p0, 'Color','black', 'LineWidth',3)

% Plot the following predicted Gaussian densities 
ph = matlab.graphics.function.FunctionLine.empty;
for k = 1:7
  fun = @(x1) normpdf(x1, k*dt*uh + x0h, dt*sigma*sqrt(k));
  ph(k) = fplot(ax, fun, [0,7], 'DisplayName',sprintf('$f^p_{%u}(x_{%u})$',k,k), 'Color',cols(9*k,:));
end
set(ph, 'LineWidth',3)

set(ax, 'XGrid','on', 'YGrid','on', 'ZGrid','on')
%set(ax, 'XMinorGrid','on', 'YMinorGrid','on', 'ZMinorGrid','on')
ax.XAxis.TickLabels = {};
ax.YAxis.TickLabels = {};

xlim(ax, ph(1).XRange)

ax.Children = flip(ax.Children);

% get_camdata(ax)
posd = struct();
posd.figure.Units          = 'pixels';
posd.figure.Position       = [31 629 275 201];
posd.axes.Units            = 'normalized';
posd.axes.Position         = [0.014925 0.023188 0.95821 0.95942];
posd.axcam.CameraPosition  = [3.5 0.5 44.159];
posd.axcam.CameraTarget    = [3.5 0.5 0];
posd.axcam.CameraUpVector  = [0 1 0];
posd.axcam.CameraViewAngle = 9.0635;

set(fig, posd.figure)
set(ax, posd.axes)
movegui(fig)

% print(fig, '-dsvg', fullfile(pwd, 'Figures', [name,'.svg']))  





