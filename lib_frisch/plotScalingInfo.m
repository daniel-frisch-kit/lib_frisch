function hnd = plotScalingInfo( varargin )
% -------------------------------------------------------
%
%    plotScalingInfo - Adds a scaling information to a plot
%
%    Ver. 1.0.0
%
%    Created:         Daniel Frisch        (30.07.2014)
%    Last modified:   Daniel Frisch        (30.07.2014)
%
%    Institute of Biomedical Engineering
%    Universitaet Karlsruhe (TH)
%
%    http://www.ibt.uni-karlsruhe.de
%
%    Copyright 2000-2014 - All rights reserved.
%
% ------------------------------------------------------
%
% This function adds a scaling information to a plot.
% The arguments are property-value pairs. 
% All of them are optional; default values will be used then. 
%
% Properties {default values}:
%   'Axes'            Axes handle {gca}
%   'Size'            Size of the scaling info {1}  
%   'Position'        (1 x 2) matrix with the position relative to axes: [x,y] {[0.97,0.12]} 
%   'HeadSize'        (1 x 2) matrix with the rectangular head size: [width,length] {[15,1]} 
%   'LineWidth'       Line width {2}
%   'String'          Information string {''}
%   'FontSize'        Font size {20}

% Usage example:    
% plotScalingInfo('Size',5, 'String','5mV', 'Position',[0.9,0.2])
%
% Attention: The scaling information does not update if you zoom the axes! 
% The position of the scaling information is fixed in normalized units
% relative to the figure. 
%
% TODO support horizontal scaling info
%



%% Dependencies
% matlab.codetools.requiredFilesAndProducts('plotScalingInfo.m')'

% (no dependencies)



%% Parse & Check Input Arguments

ax = [];
infoSize = 1;
position = [0.97,0.12];
headSize = [15,1];
lineWidth = 2;
color = 'black';
string = '';
fontSize = 20;

assert(mod(length(varargin),2)==0,'Input arguments are key-value pairs, so even number of arguments required')
for arg = 1:2:length(varargin)
    name = varargin{arg};
    value = varargin{arg+1};
    assert(isa(name,'char'),'Input argument %u should be a string',arg)
    switch name
        % TODO inputParser
        case 'Axes'
            assert(ishandle(value) && strcmp(get(value,'type'),'axes'),'Axes must be an axes handle')
            ax = value;
        case 'Size'
            ensureStd(value);
            assert(isscalar(value),'Size must be scalar');
            infoSize = value;
        case 'String'
            assert(isa(value,'char'),'String must be a string')
            string = value;
        case 'Position'
            ensureStdZeroToOne(value);
            assert(isequal(size(value),[1,2]),'Position size must be 1x2')
            position = value;
        case 'HeadSize'
            ensureStd(value);
            assert(isequal(size(value),[1,2]),'Position size must be 1x2')
            headSize = value;
        case 'LineWidth'
            lineWidth = value;
        case 'Color'
            color = value;
        case 'FontSize'
            ensureStdInt(value);
            assert(isscalar(value),'FontSize must be scalar');
            fontSize = value;
        otherwise
            error('Unknown key argument: %s',name)
    end
end

if isempty(ax)
    ax = gca;
end
fig = get(ax,'Parent');
units = get(ax,'Units');
set(ax,'Units','normalized')

% Axes-relative position to figure-relative position
axPos = get(ax,'Position'); % [left bottom width height], axes position in figure
x  = axPos(1) + position(1)*axPos(3);
y0 = axPos(2) + position(2)*axPos(4);



%% Plot Scaling Info

yrange_val = diff(get(ax,'YLim')); 
pos_rel = get(ax,'Position');
assert(infoSize<=yrange_val,'Scaling information: size=%f is bigger than axis limits %f',infoSize,yrange_val)
yrange_rel = pos_rel(4);
dy = infoSize / yrange_val * yrange_rel;
headWidth = headSize(1);
headLength = headSize(2);
hnd(1) = annotation(fig, 'doublearrow', [x,x],[y0,y0+dy], 'Head1Length',headLength, 'Head2Length',headLength, 'Head1Width',headWidth, 'Head2Width',headWidth, 'Head1Style','rectangle', 'Head2Style','rectangle', 'LineWidth',lineWidth, 'Color',color);
hnd(2) = annotation(fig, 'textarrow',   [x,x],[y0+dy/2,y0+dy/2], 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'String',string, 'LineStyle','none', 'HeadStyle','none', 'TextRotation',90, 'Units','normalized', 'FontSize',fontSize, 'Color',color);

set(ax,'Units',units)

end



%% Internal Functions

function ensureStd(x)
% Reason for everything being a double:
% uint64(10)*sqrt(2) = 14
if ~isa(x,'double') || ~isreal(x) || any(x(:)<0)
    error('Input must be non-negative real and of type double. Reason: uint64(10)*sqrt(2) = 14')
end
end

function ensureStdZeroToOne(x)
if ~isa(x,'double') || ~isreal(x) || any(x(:)<0) || any(x(:)>1)
    error('Input must be real between zero and one and of type double. Reason: uint64(10)*sqrt(2) = 14')
end
end

function ensureStdInt(x)
% Reason for everything being a double:
% uint64(10)*sqrt(2) = 14
if ~isa(x,'double') || ~isreal(x) || any(x(:)<0) || ~isempty(find(mod(x,1),1))
    error('Input must be non-negative real integer and of type double. Reason: uint64(10)*sqrt(2) = 14')
end
end

