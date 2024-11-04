% defining filter parameters
sampling_frequency = 500;
fcutoff_low = 0.5;
fcutoff_high = 40;
filter_order = 100;
w_n = [fcutoff_low fcutoff_high] / (sampling_frequency);

% designing the Hamming window FIR filter - like from the signals lecture!!
% Digital filter design includes choosing the a and b coefficients
b = fir1(filter_order, w_n, 'bandpass', hamming(filter_order + 1)); % called b as the a of the H(z) is 1 for an FIR filter as there is no feedback required

% applying to ECG signal
filtered_ecg = filtfilt(b, 1, ecg_signal); %assuming that the ecg data is stored as ecg_signal, and filtfilt applies the filter foward and backwards, minimising phase distortion which is ideal for biomedical signals that want to be preserved

% visualising the ECG signal
t = (0 : length(ecg_signal) - 1) / sampling_frequency; %initialising the time vector to plot the filtered signal
figure;
subplot(2, 1, 1);
plot(t, ecg_signal);
title('Filtered ECG signal');
xlabel('Time/ s');
ylabel('Voltage/ V');
