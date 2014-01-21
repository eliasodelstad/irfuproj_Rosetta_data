function [] = all_plot()
%ALL_PLOT Plots data from all .TAB files in the current directory
%   all_plot() plots all current-bias mode data in current directory vs S/C
%   time for each probe. The files are organized entirely based on
%   information present in the file names.

%--------------------------------------------------------------------------

% Import all .TAB files (in the form of a cell array, see RPC.LAP.import.m)
in = RPC.LAP.import();

% Extract the file names from the cell array
names = cell2mat(in(:,1));

% Gather all data obtained in current bias mode ('N')
files = in(names(:,24) == 'N', :);

% Separate out the data from the two different probes ('1' and '2')
files1P = files(names(:,22) == '1', :);
files2P = files(names(:,22) == '2', :);

% Extract the data sets from each probe
data1P = cell2mat(files1P(:,3));
data2P = cell2mat(files2P(:,3));

% Plot data from each probe separately, vs S/C time
plot(data1P(:,1), data1P(:,3), 'b', data2P(:,1), data2P(:,3), 'r')

% Insert legend for clarity
legend('Probe 1', 'Probe 2')



end

