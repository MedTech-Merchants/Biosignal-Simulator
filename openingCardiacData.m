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
original_order = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
desired_order = {'I', 'aVR', 'V1', 'V4', 'II', 'aVL', 'V2', 'V5', 'III', 'aVF', 'V3', 'V6'};
leads = desired_order;

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

    recording = reorderLeads(recording); % Reorder if necessary

    % Display success message
    disp([condition, ' data loaded successfully.']);

    if isfile(matfile)
        % Call the plotting function
        plotCardiacData(recording, Ts, leads);
    else
        disp(['File not found for ', condition]);
    end
end



% Helper function to reorder leads
function reordered_data = reorderLeads(recording)
    reordered_data = zeros(12, size(recording, 2)); % Initialize the reordered data matrix
    % rearrange
    reordered_data(1, :) = recording(1, :);  % Lead I
    reordered_data(5, :) = recording(2, :);  % Lead II
    reordered_data(9, :) = recording(3, :);  % Lead III
    reordered_data(2, :) = recording(4, :);  % Lead aVR
    reordered_data(6, :) = recording(5, :);  % Lead aVL
    reordered_data(10, :) = recording(6, :); % Lead aVF
    reordered_data(3, :) = recording(7, :);  % Lead V1
    reordered_data(7, :) = recording(8, :);  % Lead V2
    reordered_data(11, :) = recording(9, :); % Lead V3
    reordered_data(4, :) = recording(10, :); % Lead V4
    reordered_data(8, :) = recording(11, :); % Lead V5
    reordered_data(12, :) = recording(12, :); % Lead V6
end
