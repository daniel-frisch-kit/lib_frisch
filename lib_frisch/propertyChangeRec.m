function propertyChangeRec(src,evnt)
% propertyChangeRec
% Records a variable's property changes into a global variable to be processed later 
%
% Usage: 
%   global propertyChangeRec;     % define global variable that will contain the changes later 
%   propertyChangeRec_data = [];  % delete previously recorded data  
%   % Example: (doc addlistener for more details) 
%   addlistener(ax, 'CameraPosition', 'PostSet', @propertyChangeRec); 
%
% Last Changes
%   Daniel Frisch, ISAS, 11.2019: improved documentation 
% Created
%   Daniel Frisch, ISAS, 11.2019 
%

global propertyChangeRec_data
global propertyChangeRec_index

% keyboard

if isempty(propertyChangeRec_data)
    propertyChangeRec_data = struct();
    propertyChangeRec_index = 0;
end

validateattributes(propertyChangeRec_data , {'struct'}, {'scalar'}                                        , 'camera_path.m', 'global variable propertyChangeRec_data')
validateattributes(propertyChangeRec_index, {'double'}, {'scalar','nonnegative','real','finite','integer'}, 'camera_path.m', 'global variable propertyChangeRec_index')

name = src.Name;
val = evnt.AffectedObject.(name);

propertyChangeRec_index = propertyChangeRec_index + 1;

% % Print? (slow)  
% fprintf('[propertyChangeRec.m]  %05u  %s = %s \n', propertyChangeRec_index, src.Name, mat2str(val))

if ~isfield(propertyChangeRec_data,name)
  propertyChangeRec_data.(name) = struct();
  propertyChangeRec_data.(name).data  = zeros(0,numel(val));
  propertyChangeRec_data.(name).index = zeros(0,0);
end

% TODO maybe better with pre-allocation? 
propertyChangeRec_data.(name).data(end+1,:) = val(:);
propertyChangeRec_data.(name).index(end+1,1) = propertyChangeRec_index;

end

