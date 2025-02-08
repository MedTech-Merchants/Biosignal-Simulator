function plotCardiacData(recording, Ts, selectedCondition)
    % Calculate Time and Frequency Axes
    timeAxis = (1:size(recording, 2)) * Ts * 1000; % Time axis in ms
    nFFT = size(recording, 2); % Number of points in FFT
    freqAxis = linspace(0, 1/Ts, nFFT); % Frequency axis from 0 to Fs

    % Leads available in the recording (replace if different)
    original_order = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
    desired_order = {'I', 'aVR', 'V1', 'V4', 'II', 'aVL', 'V2', 'V5', 'III', 'aVF', 'V3', 'V6'};
    leads = desired_order;

    recording = reorderLeads(recording); % Reorder if necessary

    % Display success message
    disp([selectedCondition, ' data loaded successfully.']);

    % Plot Time-Domain Signals
    f = figure;
    f.Position = [100, 100, 600, 360]; % Set figure size to 800x480 pixels
    hold on;
    
    numLeads = size(recording, 1); % Total number of leads
    numCols = 4; % Number of columns in each row
    timeLength = length(timeAxis); % Length of the time axis for one lead
    yOffset = 2500; % Vertical offset for stacking signals
    spacing = 2500;
    labelYOffset = 1500;
    

    % Iterate through the subplots for rows 1-3
    for i = 1:3 % Adjust for available leads or channels
        for j = 0:3
            leadIndex = 4*(i-1)+j+1; % Calculate the actual lead index
            if leadIndex <= numLeads % Ensure we don't exceed available leads
                % Shift the time axis for the j-th plot
                shiftedTime = timeAxis + j * max(timeAxis); % Avoid overlap by shifting by the full time range
                plot(shiftedTime, recording(leadIndex, :) + yOffset, 'k');
                text(shiftedTime(1), yOffset + labelYOffset, desired_order{leadIndex}, 'FontSize', 10, 'Color', 'r'); % Lead label
                hold on; % Keep adding to the same subplot
            end
        end

        yOffset = yOffset - spacing;
        xlabel('Time (ms)');
        ylabel('Signal');
        title(['Leads: ' num2str(4*(i-1)+1) '-' num2str(min(4*i, numLeads))]); % Title with lead indices

    end

    % Row 4: Create a wide subplot spanning all 4 columns
    plot(timeAxis*4, recording(5, :) - 4000, 'k')
    xlabel('Time (ms)');
    ylabel('Signal');
    title('ECG recording');
    text(timeAxis(1), -5000 + labelYOffset, 'Lead II', 'FontSize', 12, 'Color', 'r');

    hold off;
    exportgraphics(f, 'plot.jpg', 'Resolution', 100);

end