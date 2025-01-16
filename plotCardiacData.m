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
    figure(1);
    hold on;
    numLeads = size(recording, 1); % Total number of leads
    numCols = 4; % Number of columns in each row
    timeLength = length(timeAxis); % Length of the time axis for one lead

    % Iterate through the subplots for rows 1-3
    for i = 1:min(12, ceil(numLeads / numCols)) % Adjust for available leads or channels
        subplot(4, 1, i);
        
        % Plot up to 4 leads on the same subplot, concatenating their time axes
        for j = 0:3
            leadIndex = 4*(i-1)+j+1; % Calculate the actual lead index
            if leadIndex <= numLeads % Ensure we don't exceed available leads
                % Shift the time axis for the j-th plot
                shiftedTime = timeAxis + j * max(timeAxis); % Avoid overlap by shifting by the full time range
                plot(shiftedTime, recording(leadIndex, :), 'k'); 
                hold on; % Keep adding to the same subplot
            end
        end

        
        xlabel('Time (ms)');
        ylabel('Signal');
        title(['Leads: ' num2str(4*(i-1)+1) '-' num2str(min(4*i, numLeads))]); % Title with lead indices
    end

    % Row 4: Create a wide subplot spanning all 4 columns
    subplot(4, 1, 4); % Combine positions 13, 14, 15, 16
    plot(timeAxis, recording(5, :), 'k')
    xlabel('Time (ms)');
    ylabel('Signal');
    title(leads{5});

    hold off;

    % % Plot Frequency-Domain Signals (Fourier Transform)
    % figure(2);
    % hold on;
    % for i = 1:min(12, size(recording, 1))
    %     subplot(4, 3, i)
    %     plot(freqAxis, abs(fftshift(fft(recording(i, :)))), 'r');
    %     xlabel('Frequency'); 
    %     ylabel('Signal FT');
    %     title(leads{i});
    % end
    % hold off;
end