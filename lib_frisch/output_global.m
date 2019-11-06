function stop = output_global(x,optimValues,state)
% output_global()
%
% OutputFun for optimizers (fminunc, fmincon etc), 
% saving intermediate results in global variable "output_global_data" for later access
%
% Usage 
%   options = optimoptions( ... , 'OutputFcn',@output_global ); 
%   [XOpt,fval,exitflag,output] = fminunc(@fun, X0, options); 
%   output_global_data(k).x 
%
% Last Changes
%   Daniel Frisch, ISAS, 11.2019: improved documentation 
% Created
%   Daniel Frisch, ISAS, 10.2019 
%
stop = false;
global output_global_data
switch state
  case 'init'
    output_global_data = struct();
    output_global_data.x = x;
    output_global_data.optimValues = optimValues;
    output_global_data.timerVal = tic;
  case 'iter'
    ind = length(output_global_data)+1;
    output_global_data(ind).x = x;
    output_global_data(ind).optimValues = optimValues;
    output_global_data(ind).timerVal = toc(output_global_data(1).timerVal);
  case 'done'
    %
  otherwise
    error('wrong switch')
end
end



