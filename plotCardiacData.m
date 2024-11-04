function plotCardiacData(recording, Ts, leads)
    % Calculate Time and Frequency Axes
    timeAxis = (1:size(recording, 2)) * Ts * 1000; % Time axis in ms
    nFFT = size(recording, 2); % Number of points in FFT
    freqAxis = linspace(0, 1/Ts, nFFT); % Frequency axis from 0 to Fs
    %freqAxis = fftshift((-nFFT/2:nFFT/2-1) / nFFT / Ts); % Discrete frequency axis
    %freqAxis = fftshift(-0.5:1/length(recording):0.5-1/length(recording)); % Discrete frequency axis

    % Plot Time-Domain Signals
    figure(1);
    hold on;
    for i = 1:min(12, size(recording, 1)) % Adjust for available leads or channels
        subplot(4, 3, i)
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