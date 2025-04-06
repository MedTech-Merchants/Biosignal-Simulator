function plotEEGData(recording, Ts, selectedCondition)
    % Calculate Time and Frequency Axes
    timeAxis = (1:length(recording)) * Ts * 1000; % Time axis in ms
    nFFT = size(recording, 2); % Number of points in FFT
    freqAxis = linspace(0, 1/Ts, nFFT); % Frequency axis from 0 to Fs

    % COMMENTING THIS ALL OUT FOR NOW AS EACH .MAT FILE IS JUST ONE CHANNEL
    % Working with 10-20 leads for a typical clinical EEG setup
    % eeg_channels = {'Fp1', 'Fp2', 'F3', 'F4', 'C3', 'C4', 'P3', 'P4', 'O1', 'O2', 'F7', 'F8', 'T3', 'T4', 'T5', 'T6', 'Pz', 'Oz'}; % The channels are named after the location of each electrode relative to the skull (Left/Right Frontal Pole, Frontal Lobe, Central Lobe, Occipital Lobe, Temporal Lobe, z = midline)
    % numChannels = length(eeg_channels); % Number of EEG channels (we are trying to use datasets that are around 10-20 channels)

    % Display success message
    disp([selectedCondition, ' data loaded successfully.']);

    % Plot Time-Domain Signals
    recording = recording';
    f = figure;
    f.Position = [100, 100, 600, 360]; % Set figure size to 800x480 pixels
    hold on;
    plot(timeAxis, recording, 'k'); % Plot the EEG signal
    xlabel('Time (ms)');
    ylabel('Signal Amplitude');
    title(['EEG Recording - ', selectedCondition]);
    hold off;
    
    %{
    numCols = 1; % Number of columns in each row
    numRows = 1; % Determine the number of rows needed
    timeLength = length(timeAxis); % Length of the time axis for one lead
    yOffset = 2500; % Vertical offset for stacking signals
    spacing = 2500;
    labelYOffset = 1500;
    %}


    %{ 
    % Iterate through the subplots for rows 1-3
    for i = 1:numRows % Adjust for available leads or channels
        for j = 0:numCols
            channelIndex = numCols * (i - 1) + j; % Calculate the actual channel index
            if channelIndex <= numChannels % Ensure we don't exceed available channels
                % Shift the time axis for the j-th plot
                shiftedTime = timeAxis + j * max(timeAxis); % Avoid overlap by shifting by the full time range
                plot(shiftedTime, recording(channelIndex, :) + yOffset, 'k');
                text(shiftedTime(1), yOffset + labelYOffset, eeg_channels{channelIndex}, 'FontSize', 10, 'Color', 'r'); % Channel label
                hold on; % Keep adding to the same subplot
            end
        end 

        yOffset = yOffset - spacing;
        xlabel('Time (ms)');
        ylabel('Signal');
        title(['Channels: ' num2str(numCols*(i-1)+1) '-' num2str(min(numCols*i, numChannels))]); % Title with channel indices
    end
    %}

    %{
    % If there are any remaining channels that don’t fit in the rows
    if mod(numChannels, numCols) ~= 0
        extraIndex = numCols * numRows + 1;
        plot(timeAxis, recording(extraIndex, :) - 4000, 'k')
        xlabel('Time (ms)');
        ylabel('Signal');
        title(['EEG recording - Channel: ', eeg_channels{extraIndex}]);
        text(timeAxis(1), -5000 + labelYOffset, eeg_channels{extraIndex}, 'FontSize', 12, 'Color', 'r');
    end
    %}

    hold off;
    exportgraphics(f, 'plotEEG.jpg', 'Resolution', 100);

end