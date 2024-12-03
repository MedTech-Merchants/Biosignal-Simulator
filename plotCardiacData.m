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
    for i = 1:min(12, size(recording, 1)) % Adjust for available leads or channels
        subplot(3, 4, i)
        plot(timeAxis, recording(i, :), 'k');
        xlabel('Time (ms)');
        ylabel('Signal');
        title(leads{i});
    end
    hold off;

    % Plot Frequency-Domain Signals (Fourier Transform)
    figure(2);
    hold on;
    for i = 1:min(12, size(recording, 1))
        subplot(4, 3, i)
        plot(freqAxis, abs(fftshift(fft(recording(i, :)))), 'r');
        xlabel('Frequency'); 
        ylabel('Signal FT');
        title(leads{i});
    end
    hold off;
end