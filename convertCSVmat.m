function matfile=convertCSVmat(filepath)
% a function to convert data in csv format to .mat
matfile = ''; %initialize empty file
% Load the file
            if isfile(filepath)
                % Read the CSV file directly into a matrix
                data = readmatrix(filepath); % Use readmatrix to handle CSV reading

                % Check if the data loaded correctly
                if size(data, 1) == 5000 && size(data, 2) == 12
                    % Transpose the data to get a 12x5000 matrix
                    recording = data'; % Transpose to get 12 rows and 5000 columns
                    % Reorder the data matrix to match the desired lead layout

                    % Save reordered data to .mat file
                    matfile = strrep(filepath, '.csv', '.mat');
                    save(matfile, 'recording');
                    disp(['File converted and saved as ', matfile]);
                else
                    disp('Error: Data dimensions do not match expected 5000x12.');
                end
            else
                disp('File not found.');
 end