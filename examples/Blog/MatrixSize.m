%% Trace and Determinant of Matrix
%  Trace is invariant against rotations

% TODO add marginal plots, Blog article! 

addpath('../../../mtimesx')
addpath('../../../export_fig')
addpath('../../lib_frisch')


name = 'MatrixSize';

fig = figure(85345345);
clf(fig);
set(fig, 'NumberTitle','off', 'Name',name, 'Color','white')
ax = axes(fig);
set(ax, 'NextPlot','add')
set(ax, 'XGrid','on', 'YGrid','on', 'XMinorGrid','on', 'YMinorGrid','on')
ax.DataAspectRatio = [1 1 1];
set([ax.XLabel,ax.YLabel], 'Interpreter','LaTeX', 'FontSize',16)
ax.TickLabelInterpreter = 'LaTeX';
ax.FontSize = 13;

fig.Position = [1925         102         732         416];
ax.Position  = [0.0764    0.1185    0.5043    0.8065];

% mat2str(ax.ColorOrder)
cord = [0 0.447 0.741;0.85 0.325 0.098;0.929 0.694 0.125;0.494 0.184 0.556;0.466 0.674 0.188;0.301 0.745 0.933;0.635 0.078 0.184];


% Define matrix
%Cov = eye(2);

std1 = 1;
std2 = 2;
od = 0;
Cov0 = [std1^2 od; od std2^2];

%theta_deg = 30; % to rotate counterclockwise
theta_deg = 90; % to rotate counterclockwise

% Coordinate Transformation Functions 
R = @(theta) [cos(theta) -sin(theta); sin(theta) cos(theta)];
%Cov = R(theta)' * Cov * R(theta);
CovCreate = @(Cov0,theta) R(theta)' * Cov0 * R(theta);

% Actual Coordinate Transformation
Cov = CovCreate(Cov0,theta_deg/180*pi);

% Check
assert(all(all(isfinite(inv(Cov)))))

iCov = inv(Cov);
% Density height line of stddev: x^T * inv(Cov) * x = 1
%fun = @(x,y) [x, y] * Cov * [x; y] - 1; % not vectorized
fun0 = @(x,y,iCov) reshape( mtimesx(mtimesx( permute([x(:),y(:)],[3,2,1]), iCov), permute([x(:),y(:)],[2,3,1])), size(x)) - 1;
fun = @(x,y) fun0(x,y,iCov);

%hp = fimplicit(fun, [-30,30]);
hp = fimplicit(fun, 'Color',cord(1,:), 'LineWidth',3);

% Print values
%str = sprintf('Covariance matrix: tr=%g, det=%g', trace(Cov), det(Cov));
str = sprintf('Covariance Ellipse at $\\sigma$');
hp.DisplayName = str;

% Plot eigenvectors
[V,D] = eig(Cov); % A*V = V*D
evecs = sqrt(D)*V;
%str = sprintf('Eigenvectors: $\\sqrt{%g^2 + %g^2}=\\sqrt{%g}$',sqrt(D(1,1)),sqrt(D(2,2)),trace(D));
str = sprintf('Eigenvalues: $%g + %g=%g$',D(1,1),D(2,2),trace(D));
hEig1 = plotConnect(zeros(4,2), [evecs;-evecs], 'Color',cord(3,:), 'LineWidth',3, 'DisplayName',str); 
hEig2 = plotConnect(evecs(1,:).*[1;-1;1;-1], evecs(2,:).*[1;1;-1;-1], 'Color',cord(3,:), 'LineWidth',2, 'LineStyle',':'); 

% Plot Marginals
dCov = diag(diag(Cov));
diags = sqrt(dCov)*eye(2);
%str = sprintf('Marginals: $\\sqrt{%g^2 + %g^2}=\\sqrt{%g}$',sqrt(dCov(1,1)),sqrt(dCov(2,2)),trace(dCov));
str = sprintf('Marginals: $%.3f + %.3f=%.3g$',dCov(1,1),dCov(2,2),trace(dCov));
hDg1 = plotConnect(zeros(2,2), diags, 'Color',cord(4,:), 'LineWidth',3, 'DisplayName',str);
hDg2 = plotConnect(diags(1,:), diags(2,:), 'Color',cord(4,:), 'LineWidth',2, 'LineStyle',':'); 

lg = legend(ax, [hp,hEig1,hDg1], 'Position',[0.58    0.73    0.4    0.16]);
%lg.Location = 'NorthEastOutside';
%lg.Position = [0.58    0.77    0.33    0.16];
lg.Interpreter = 'LaTeX';
lg.FontSize = 13;

ax.XLim = [-2,2]*1.05;
ax.YLim = [-2,2]*1.05;

ax.XLabel.String = 'x';
ax.YLabel.String = 'y';

% Annotation
if exist('anno_t','var'), delete(anno_t); end
anno_t = annotation(fig, 'textbox');
anno_t.Position = [0.57 0.15 0.4 0.15];
set(anno_t, 'LineStyle','none', 'VerticalAlignment','bottom', 'FontName','Courier', 'FontWeight','bold', 'FontSize',12)
%anno_t.String = sprintf('%.3f  %.3f \n%.3f  %.3f', Cov(1,1),Cov(1,2),Cov(2,1),Cov(2,2));
%anno_t.String = sprintf('$\\mathbf{C}=\\left[\\begin{array}{rr}%.3f & %.3f \\\\ %.3f & %.3f \\end{array}\\right]$', Cov(1,1),Cov(1,2),Cov(2,1),Cov(2,2));
matstr = sprintf('\\mathbf{C} \\!\\!\\!\\!&=&\\!\\!\\!\\! \\left[\\begin{array}{rr}%.3f & %.3f \\\\ %.3f & %.3f \\end{array}\\right]', Cov(1,1),Cov(1,2),Cov(2,1),Cov(2,2));
anno_t.String = sprintf('$\\begin{array}{rcl} %s \\\\ \\\\  \\mathrm{tr}(\\mathbf{C}) \\!\\!\\!\\!&=&\\!\\!\\!\\! %.3g \\\\ \\\\ \\mathrm{det}(\\mathbf{C}) \\!\\!\\!\\!&=&\\!\\!\\!\\! %.3g \\\\ \\\\ \\rho \\!\\!\\!\\!&=&\\!\\!\\!\\! % 7.3f \\end{array}$', matstr, trace(Cov), det(Cov), Cov(1,2)/sqrt(prod(diag(Cov))));
anno_t.Interpreter = 'LaTeX';
anno_t.FontSize = 16;


% set([hDg1,hDg2], 'Visible',false) % hide Marginals (if wanted)

fname = sprintf('%s_theta=%g_Cov0=%s',name,theta_deg,strjoin(cellfun(@num2str, num2cell(Cov0(:)), 'UniformOutput',false), '-'));
%expfig(fname, fig)
% saveas(fig, ['Figures/',fname], 'svg')

return
%% Video

thetas_deg = (0:0.5:360) + 90;

for iTheta = 1:length(thetas_deg)
    theta_deg = thetas_deg(iTheta);
    
    fprintf('% 5u / %u : %g \n', iTheta, length(thetas_deg), theta)
    
    % New matrix
    Cov = CovCreate(Cov0, theta_deg/180*pi);
    
    % Ellipse
    iCov = inv(Cov);
    fun = @(x,y) fun0(x,y,iCov);
    hp.Function = fun;
    
    % Eigenvectors
    [V,D] = eig(Cov); % A*V = V*D
    evecs = sqrt(D)*V;
    str = sprintf('Eigenvalues: $%g + %g=%g$',D(1,1),D(2,2),trace(D));
    hEig1.DisplayName = str;
    %plotConnect_update(hEig1, zeros(2,2), evecs)
    %plotConnect_update(hEig2, evecs(1,:), evecs(2,:))
    plotConnect_update(hEig1, zeros(4,2), [evecs;-evecs])
    plotConnect_update(hEig2, evecs(1,:).*[1;-1;1;-1], evecs(2,:).*[1;1;-1;-1])

    % Diagonals
    dCov = diag(diag(Cov));
    diags = sqrt(dCov)*eye(2);
    str = sprintf('Marginals: $%.3f + %.3f=%g$',dCov(1,1),dCov(2,2),trace(dCov));
    hDg1.DisplayName = str;
    plotConnect_update(hDg1, zeros(2,2), diags)
    plotConnect_update(hDg2, diags(1,:), diags(2,:))
    %plotConnect_update(hDg1, zeros(4,2), [diags;-diags])
    %plotConnect_update(hDg2, diags(1,:).*[1;-1;1;-1], diags(2,:).*[1;1;-1;-1])
    
    % Annotation
    matstr = sprintf('\\mathbf{C} \\!\\!\\!\\!&=&\\!\\!\\!\\! \\left[\\begin{array}{rr}%.3f & %.3f \\\\ %.3f & %.3f \\end{array}\\right]', Cov(1,1),Cov(1,2),Cov(2,1),Cov(2,2));
    anno_t.String = sprintf('$\\begin{array}{rcl} %s \\\\ \\\\  \\mathrm{tr}(\\mathbf{C}) \\!\\!\\!\\!&=&\\!\\!\\!\\! %.3g \\\\ \\\\ \\mathrm{det}(\\mathbf{C}) \\!\\!\\!\\!&=&\\!\\!\\!\\! %.3g \\\\ \\\\ \\rho \\!\\!\\!\\!&=&\\!\\!\\!\\! % 06.3f \\end{array}$', matstr, trace(Cov), det(Cov), Cov(1,2)/sqrt(prod(diag(Cov))));

    drawnow
    export_fig(sprintf('VideoTemp/%04u.png',iTheta), fig, '-m2', '-nocrop')
end


% Commandline, cd ./VideoTemp
% ffmpeg -y -f image2 -framerate 24 -i %*.png -vcodec libx264 -pix_fmt yuv420p -crf 18 -tune animation -preset slow vid.mp4





