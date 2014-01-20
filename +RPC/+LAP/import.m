function [] = import()
%RPC.LAP.import() Import all .TAB files in the current directory into workspace
%   RPC.LAP.import imports the content of all the .TAB files in the current
%   directory into struct varibales in the workspace of the caller
%   function. These struct variables are given the same name as the
%   corresponding .TAB file (without the .TAB extension).
%
%   The UTC epochs are stored as rowheaders in the structs; the
%   corresponding spacecraft times and current and voltage values are
%   stored in the 3-column data matrix of the structs.

%--------------------------------------------------------------------------

% Get tabfiles
tabfiles = dir('*.TAB');

% Count tabfiles
num = length(tabfiles);

% Import data from each file and store in namesake variable in workspace
for i = 1:num
    % Import file (into struct)
    file = importdata(tabfiles(i).name);
    % Get file name (without .TAB extension)
    filename = tabfiles(i).name(1:end-4);
    % Assign the imported data struct to the variable 'filename' in the
    % workspace of the caller function
    assignin('caller', filename, file);
end

end

