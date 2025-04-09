function [recording, Fs] = openingMotorData(condition)
% a function to load files associated with corresponding cardiac conditions
% calls the function that plots the data 

isCSV = false;
isDAT = false;


    % Define file paths and other parameters for specific conditions
    switch condition
        case 'Healthy'
            data = readmatrix('emg_healthy.txt');
            Fs = 50000; % sampling rate in Hz

            timeAxis = data(:,1) * 50000;   % Convert to milliseconds
            recording = data(:,2);
        
        case 'ALS'
            filepath = ''; % Insert the actual file path
            isDAT = true;
            Fs = 500; % insert sampling frequency for the recording

        case 'Myasthenia Gravis'
            filepath = ''; % Insert the actual file path
            isDAT = true;
            Fs = 720; % insert sampling frequency for the recording

        otherwise
            disp('Condition not recognized.');
       
    end

    % Convert CSV to .mat if needed using convertCSVmat function
    if isCSV
        matfile = convertCSVmat(filepath);
        if isempty(matfile)
            disp('Error converting CSV to .mat');
            return;
        end
        load(matfile, 'recording');
    end

    % Convert .dat to .mat if needed using convertDATmat function
    if isDAT
        matfile = convertDATmat(filepath);
        if isempty(matfile)
            disp('Error converting CSV to .mat');
            return;
        end
        load(matfile, 'recording');
    end

    disp(['Size of recording: ', num2str(size(recording))]);
    disp(['Sampling frequency (Fs): ', num2str(Fs)]);
end