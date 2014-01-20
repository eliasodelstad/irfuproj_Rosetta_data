function [varargout] = import()
%RPC.LAP.import() Import all .TAB files in the current directory
%   RPC.LAP.import imports the content of all the .TAB files in the current
%   directory into struct varibales in the workspace of the caller
%   function. These struct variables are given the same name as the
%   corresponding .TAB file (without the .TAB extension).
%
%   The UTC epochs are stored as rowheaders in the structs; the
%   corresponding spacecraft times and current and voltage values are
%   stored in the 3-column data matrix of the structs.
%   
%   RPC.LAP.import() with an OUTPUT ARGUMENT stores the names and fields of
%   the structs into a single cell array, which is given as output. In this
%   case the filenames are stored as strings in the first column, the UTC
%   epochs as nx1 cell arrays of strings in the second column and the data
%   as double arrays in the third column.

%--------------------------------------------------------------------------

% Get tabfiles
tabfiles = dir('*.TAB');

% Count tabfiles
num = length(tabfiles);

% If output is required, initialize cell array for storing structs' names
% and fields
if (nargout == 1)
    out = cell(num, 3);
end

% Import data from each file and store in namesake variable in workspace,
% or cell array (if output is required)
for i = 1:num
    % Import file (into struct)
    file = importdata(tabfiles(i).name);
    % Get file name (without .TAB extension)
    filename = tabfiles(i).name(1:end-4);
    % Store name, rowheaders and data of struct in cell array (if output is
    % required)
    if (nargout == 1)
        out(i,1) = {filename};
        out(i,2) = {cell2mat(file.rowheaders)};
        out(i,3) = {file.data};
    % Assign the imported data struct to the variable 'filename' in the
    % workspace of the caller function (if output is NOT required)
    else
        assignin('caller', filename, file);
    end
end

% Give output (if required)
if (nargout == 1)
    varargout = {out};
end

end

