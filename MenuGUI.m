function MenuGUI
    fig = figure('Name', 'Main-Menu GUI', 'Position', [300, 300, 1000, 400]); % Initialize the GUI window
    selectedCondition = ''; %empty variable to hold delected condition

    % Main menu buttons
    btn1_main_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'ECG', ...
        'Position', [100, 275, 800, 100], 'Callback', @(src, event) switchToECGMenu());
    btn2_main_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'EMG', ...
        'Position', [100, 150, 800, 100], 'Callback', @(src, event) switchToEMGMenu());
    btn3_main_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'EEG', ...
        'Position', [100, 25, 800, 100], 'Callback', @(src, event) switchToEEGMenu());
    
    % ECG menu button settings (initially hidden)
    buttonWidth = 200;
    buttonHeight = 40;
    horizontalSpacing = 50;  % Space between columns
    verticalSpacing = 10;     % Space between rows

    CardiacConditions = { ...
        'Helathy','Atrial Fibrillation', 'Ventricular Fibrillation', 'Bradycardia', ...
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
        %if CardiacConditions{i} == '<< back'
            %back_btn_ECG_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'Noise',  ...
            %'Position', [100, 275, 800, 100], 'Visible', 'off','Callback', @(src, event) switchToMainMenu());
    % end
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
        'Position', [100, 275, 800, 100], 'Visible', 'off','Callback', @(src, event) displayGraphs());
    btn2_feat_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'Amplitude', ...
        'Position', [100, 150, 800, 100], 'Visible', 'off','Callback', @(src, event) displayGraphs());
    btn3_feat_menu = uicontrol(fig, 'Style', 'pushbutton', 'String', 'Bandwidth', ...
        'Position', [100, 25, 800, 100],'Visible', 'off','Callback', @(src, event) displayGraphs());

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
        set([btn1_feat_menu, btn2_feat_menu, btn3_feat_menu], 'Visible', 'on');
        
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

    function displayGraphs()
        % Hide feature menu buttons
        set([btn1_feat_menu, btn2_feat_menu, btn3_feat_menu], 'Visible', 'off');

        % Load the data for the selected condition by calling the external function
        openingCardiacData(selectedCondition);
    end

end
