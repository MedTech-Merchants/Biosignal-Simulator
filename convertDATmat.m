function matfile=convertDATmat(filepath)
% a function to convert data in .dat format to .mat
matfile = ''; %initialize empty file
% Load the file
            if isfile(filepath)
                % Read the dat file directly into a matrix
                data = readtable(filepath); % Use readmatrix to handle dat reading
                % data = readtable('filename.dat');

                % Generate output .mat filename
                [path, name, ~] = fileparts(filepath); % Extract filename without extension
                matfile = fullfile(path, [name, '.mat']); % Construct .mat filename
        
                % Save data to .mat file
                save(matfile, 'recording');
                disp(['File converted and saved as ', matfile]);
            else
                disp('File not found.');
            end
 end