function recording = openingCardiacData(condition)
% a function to load files associated with corresponding cardiac conditions
% calls the function that plots the data

% Define parameters common for all conditions (can be overwritten for a
% specific condition if need be)
n_step = 100; 
stepSize = 0.2; 
Ts = 500; % Recording sampling interval (in ms or seconds as needed)
Fs = 1/Ts; % Sampling frequency
                

isCSV = false;


    % Define file paths and other parameters for specific conditions
    switch condition
        case 'Healthy'
            matfile = 'JS00001.mat'; % Actual .mat file path
            varName = 'val';  % Name of the variable in the .mat file
            load(matfile, varName);  % Load the 'val' variable from the .mat file
            recording = val;  % Assign the loaded 'val' to 'recording'
        
        case 'Atrial Fibrillation'
            filepath = 'MUSE_20180111_155154_74000.csv'; % Insert the actual file path
            isCSV = true;

            %{ 
        we can input those later so it is easier to debug now
        case 'Ventricular Fibrillation'
        case 'Bradycardia'
        case'Premature Ventricular Contractions'
        case'Long QT syndrome'
        case 'Torsades de pointes'
        case 'Atrial] Flutter'
        case 'Ventricular] tachycardia'
        case 'AV nodal reentrant tachycardia'
        case 'Premature contraction'
        case 'Fetal arrhythmia'
        case 'Sick sinus syndrome'
        case 'Supraventricular Tachycardia'
        case 'Heart Block: First Degree'
        case 'Heart Block: Second Degree'
        case 'Heart Block: Third Degree'
            %}
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

    disp(['Size of recording: ', num2str(size(recording))]);
end