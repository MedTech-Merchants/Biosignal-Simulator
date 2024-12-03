function MenuGUI
% predefine flags to know which parameters the user decided to change
persistent gainValue noiseValue fcutoff_low fcutoff_high filter_order;
persistent isGainSet isNoiseSet isBandwidthSet;

% Initialize flags to false
isGainSet = false;
isNoiseSet = false;
isBandwidthSet = false;

    fig = figure('Name', 'Main-Menu GUI', 'Position', [300, 300, 1000, 400]); % Initialize the GUI window
    selectedCondition = ''; %empty variable to hold delected condition

    % Main menu buttons
    btn1_main_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'ECG', ...
        'Position', [100, 275, 800, 100],'FontSize', 30, 'FontWeight', 'bold', 'Callback', @(src, event) switchToECGMenu());
    btn2_main_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'EMG', ...
        'Position', [100, 150, 800, 100],'FontSize', 30, 'FontWeight', 'bold', 'Callback', @(src, event) switchToEMGMenu());
    btn3_main_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'EEG', ...
        'Position', [100, 25, 800, 100],'FontSize', 30, 'FontWeight', 'bold', 'Callback', @(src, event) switchToEEGMenu());
    
    % ECG menu button settings (initially hidden)
    buttonWidth = 200;
    buttonHeight = 40;
    horizontalSpacing = 50;  % Space between columns
    verticalSpacing = 10;     % Space between rows

    CardiacConditions = { ...
        'Healthy','Atrial Fibrillation', 'Ventricular Fibrillation', 'Bradycardia', ...
        'Premature Ventricular Contractions', 'Long QT syndrome', ...
        'Torsades de pointes', 'Atrial Flutter', 'Ventricular tachycardia', ...
        'AV nodal reentrant tachycardia', 'Premature contraction', ...
        'Fetal arrhythmia', 'Sick sinus syndrome', 'Supraventricular Tachycardia', ...
        'Heart Block: First Degree', 'Heart Block: Second Degree', ...
        'Heart Block: Third Degree'};

    MotorConditions = {'put our conditions here'};
    NeuralConditions = {'put here'};

    Conditions = [CardiacConditions, MotorConditions, NeuralConditions];

    % Preallocate storage for ECG menu buttons
    buttons_ECG_menu = gobjects(length(CardiacConditions), 1); 
    for i = 1:length(CardiacConditions)
        col = ceil(i / 6); % Determine the column (3 total)
        row = mod(i-1, 6) + 1; % Determine the row (1 to 6)
        
        % Calculate x and y positions based on row and column
        x = 100 + (col - 1) * (buttonWidth + horizontalSpacing);
        y = 350 - (row * (buttonHeight + verticalSpacing));
        
        % Create the button for each cardiac condition
        buttons_ECG_menu(i) = uicontrol(fig, 'Style', 'pushbutton', ...
            'String', CardiacConditions{i}, ...
            'Position', [x, y, buttonWidth, buttonHeight], ...
            'Visible', 'off', ...
            'Callback', @(src, event) switchToFeatureMenu(CardiacConditions{i}));
    end

    % Create the back button
    col_back = ceil(18 / 6); % Determine the column (3 total)
    row_back = mod(18-1, 6) + 1; % Determine the row (1 to 6)
    % Calculate x and y positions based on row and column
    x_back = 100 + (col_back - 1) * (buttonWidth + horizontalSpacing);
    y_back = 350 - (row_back * (buttonHeight + verticalSpacing));
    back_btn_ECG_menu = uicontrol(fig, 'Style', 'pushbutton', ...
        'String', '<< back', ...
        'Position', [x_back, y_back, buttonWidth, buttonHeight], ...
        'Visible', 'off', ...
        'Callback', @(src, event) switchToMainMenu());

    % Feature menu buttons (initially hidden)
    btn1_feat_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'Noise',  ...
    'Position', [100, 325, 800, 75],'FontSize', 30, 'FontWeight', 'bold', 'Visible', 'off','Callback', @(src, event) getNoise());
    btn2_feat_menu = uicontrol(fig, 'Style','pushbutton', 'String', 'Gain', ...
        'Position', [100, 225, 800, 75], 'FontSize', 30, 'FontWeight', 'bold','Visible', 'off','Callback', @(src, event) getGain());
    btn3_feat_menu = uicontrol(fig, 'Style','pushbutton', 'String', 'Bandwidth', ...
        'Position', [100, 125, 800, 75],'FontSize', 30, 'FontWeight', 'bold','Visible', 'off','Callback', @(src, event) getBandwidth());
    btn4_feat_menu = uicontrol(fig, 'Style','pushbutton', 'String', 'Play', ...
        'Position', [100, 25, 800, 75],'FontSize', 30, 'FontWeight', 'bold','Visible', 'off','Callback', @(src, event) displayGraphs());

     % Function to switch to main menu from ECG menu
    function switchToMainMenu
        % Hide ECG menu buttons
        set(buttons_ECG_menu, 'Visible', 'off');
        set(back_btn_ECG_menu, 'Visible', 'off');
        
        % Show ECG menu buttons
        set([btn1_main_menu, btn2_main_menu, btn3_main_menu], 'Visible', 'on');
    end

    % Function to switch from main menu to ECG menu
    function switchToECGMenu
        % Hide main menu buttons
        set([btn1_main_menu, btn2_main_menu, btn3_main_menu], 'Visible', 'off');
        
        % Show ECG menu buttons
        set(buttons_ECG_menu, 'Visible', 'on');
        set(back_btn_ECG_menu, 'Visible', 'on');
    end

    % Function to switch from ECG menu to feature menu
    function switchToFeatureMenu(condition)
        % Hide ECG menu buttons
        set(buttons_ECG_menu, 'Visible', 'off');
        set(back_btn_ECG_menu, 'Visible', 'off');
        
        % Show feature menu buttons
        set([btn1_feat_menu, btn2_feat_menu, btn3_feat_menu, btn4_feat_menu], 'Visible', 'on');
        
        % Store the selected condition for use in displayGraphs
        selectedCondition = condition;

        % Display the selected condition (for debugging or display purposes)
        disp(['Selected condition: ', selectedCondition]);

    end

    % Placeholder functions for EMG and EEG menu buttons
    function switchToEMGMenu
        disp('EMG menu selected');
    end

    function switchToEEGMenu
        disp('EEG menu selected');
    end


    function getNoise()
        % Holder function
        isNoiseSet = true;
        noiseValue = true; % Or any specific noise level if needed
        disp('Noise enabled.');
    end

    function getGain()
        try
            % Prompt user for gain input
            prompt = 'Enter gain value:';
            dlgTitle = 'Set Gain';
            dims = [1 35]; % Specify dialog box dimensions
            defaultInput = {'1'}; % Provide a default value
            answer = inputdlg(prompt, dlgTitle, dims, defaultInput);
            
            % Validate the user input
            if isempty(answer)
                disp('Gain input canceled.');
                return;
            end
            
            gainValue = str2double(answer{1}); % Convert input to numeric
            
            if isnan(gainValue)
                error('Invalid gain value. Please enter a numeric value.');
            else
                % Set gain and update flag
                isGainSet = true;
                disp(['Gain set to: ', num2str(gainValue)]);
            end
        catch ME
            disp(['Error in getGain: ', ME.message]);
        end
    end

    function getBandwidth()
        try
            % Prompt user for bandwidth input via dialog box
            prompt = {'Enter low cut-off frequency:', 'Enter high cut-off frequency:', 'Enter filter order:'};
            dlgTitle = 'Set filter parameters';
            dims = [1 35];
            defaultInput = {'0.5', '40', '1'}; % Default low and high cut-off values
            answer = inputdlg(prompt, dlgTitle, dims, defaultInput);
            
            % Validate the user input
            if isempty(answer)
                disp('Bandwidth input canceled.');
                return;
            end
            
            fcutoff_low = str2double(answer{1});
            fcutoff_high = str2double(answer{2});
            filter_order = str2double(answer{3});
            
            if isnan(fcutoff_low) || isnan(fcutoff_high)
                error('Invalid bandwidth values. Please enter numeric values.');
            else
                % Set bandwidth and update flag
                isBandwidthSet = true;
                disp(['Bandwidth set: Low = ', num2str(fcutoff_low), ', High = ', num2str(fcutoff_high), ', Filter order = ', num2str(filter_order)]);
            end
        catch ME
            disp(['Error in getBandwidth: ', ME.message]);
        end
    end

    
    function [signal, Fs] = processSignal()
        % Load the base signal
        [signal, Fs] = openingCardiacData(selectedCondition);
    
        % Apply gain if set
        if isGainSet
            signal = applyGain(signal, gainValue);
        end
    
        % Apply noise if set
        if isNoiseSet
            signal = addNoise(signal, noiseValue);
        end
    
        % Apply bandwidth filter if set
        if isBandwidthSet
            signal = ECG_digital_filter(signal,Fs, fcutoff_low, fcutoff_high, filter_order);
        end
    end  

    function displayGraphs()
        % Hides the feature menu buttons
        set([btn1_feat_menu, btn2_feat_menu, btn3_feat_menu, btn4_feat_menu], 'Visible', 'off');
    
        % Process the signal
        [signal, Fs] = processSignal();
    
        % Plot the signal
        plotCardiacData(signal, 1/Fs, selectedCondition);
    
    end


end
