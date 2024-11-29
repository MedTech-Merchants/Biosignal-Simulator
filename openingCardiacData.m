function openingCardiacData(condition)
% a function to load files associated with corresponding cardiac conditions
% calls the function that plots the data

% Define parameters common for all conditions (can be overwritten for a
% specific condition if need be)
n_step = 100; 
stepSize = 0.2; 
Ts = 500; % Recording sampling interval (in ms or seconds as needed)
Fs = 1/Ts; % Sampling frequency
                
% Leads available in the recording (replace if different)
leads = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1','V2','V3','V4','V5','V6'};

    % Define file paths and other parameters for specific conditions
    switch condition
        case 'Helathy'
            filepath = 'JS00001.mat'; % Insert the actual file path
            data = load(filepath);
            recording = data.val; % Replace 'val' with the actual variable name in the .mat file
        
        case 'Atrial Fibrillation'
            filepath = 'MUSE_20180111_155154_74000.csv'; % Insert the actual file path
            data_bef = readtable(filepath); %chance to readtable f data is in .csv, filepath if data is in .mat
            data = reshape(data_bef, 12, 5000);
            recording = data.val;

            %{
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

    if isfile(filepath)
        disp([condition, ' data loaded successfully.']);
        
        % Call the common plotting function
        plotCardiacData(recording, Ts, leads);
    else
        disp(['File not found for ', condition]);
    end
end