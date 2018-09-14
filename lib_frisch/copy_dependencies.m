function copy_dependencies( start_mfile, destination )
%copy_dependencies Copies all files necessary to run into a subfolder
%   For example to run in a screen, to give code away, or for backup

%[flist,plist] = matlab.codetools.requiredFilesAndProducts('copy_dependencies.m'); [flist'; {plist.Name}']

% Find dependent files
fprintf('Looking for dependent files...   ')
flist = matlab.codetools.requiredFilesAndProducts(start_mfile); 
nFiles = length(flist);
fprintf('Found %u files.   Copying...   ', nFiles)

% Create target dir if not exists
if exist(destination,'dir')~=7
    mkdir(destination)
end

for iFile = 1:nFiles
    % source file
    file = flist{iFile}; 
    % destination filename
    [~,name,ext] = fileparts(file);
    filename = [name,ext];
    destfile = fullfile(destination,filename);
    % copy
    copyfile(file,destfile);
end

fprintf('Done. \n')



end

