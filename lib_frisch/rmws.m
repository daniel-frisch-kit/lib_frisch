function rmws( varargin )
%RMWS Remove White Space Border around Figures
% Input: axes (optional, otherwise gca is used)
% Execute after window resize! 
% Then, save figure with: print(fig, '-dpdf', 'test.pdf')
% Alternatively: use export_fig() which automatically removes whitespace. 
%

args = varargin;

if nargin==0
    ax = gca;
else
    ax = args{1};
    assert(isa(ax,'matlab.graphics.axis.Axes'))
end
    
par = ax.Parent;

% Find parent figure
fig = par;
while ~isempty(fig) && ~strcmp('figure', get(fig,'type'))
    fig = get(fig,'parent');
end 

old_figunits = fig.Units;
old_paperunits = fig.PaperUnits;
old_parunits = par.Units;
old_axunits = ax.Units;

units = 'centimeters';
fig.Units = units;
fig.PaperUnits = units;
par.Units = units;
ax.Units = units;

space = 0.05;
width = par.Position(3);
height = par.Position(4);
yPos = space;

insets = ax.TightInset;
pos = [space, yPos, width-2*space, height-2*space];
pos = pos + [insets(1), insets(2), -insets(1)-insets(3), -insets(2)-insets(4)];
pos = max(0,pos);
ax.Position = pos;

% ax = axes; plot(1:10); rmws(ax);

% Also ensure borderless PDF page saving
if ~isempty(fig) && isa(fig,'matlab.ui.Figure')
    extent = fig.Position(3:4);
    fig.PaperPosition = [0,0,extent];
    fig.PaperSize = extent;
else
    warning('Could not find parent figure. No borderless PDF printing.')
end

% print(fig, '-dpdf', 'test.pdf')

fig.Units = old_figunits;
fig.PaperUnits = old_paperunits;
par.Units = old_parunits;
ax.Units = old_axunits;

end

