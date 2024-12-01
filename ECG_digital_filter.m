function filtered_ecg = ECG_digital_filter(signal, sampling_frequency, fcutoff_low, fcutoff_high, filter_order)
% this function spits out an output filtered_ecg when the filter_ecg_signal
% is called

    % defining filter parameters
    w_n = [fcutoff_low fcutoff_high] / (sampling_frequency / 2); %normalised cutoff frequencies, using Nyquist frequency

    % designing the Hamming window FIR filter - like from the signals lecture!!
    % Digital filter design includes choosing the a and b coefficients
    b = fir1(filter_order, w_n, 'bandpass', hamming(filter_order + 1)); % called b as the a of the H(z) is 1 for an FIR filter as there is no feedback required
    
    % applying to ECG signal
    filtered_ecg = filter(b, 1, signal); %assuming that the ecg data is stored as ecg_signal, and filtfilt applies the filter foward and backwards, minimising phase distortion which is ideal for biomedical signals that want to be preserved
    
    % % visualising the ECG signal
    % t = (0 : length(filtered_ecg) - 1) / sampling_frequency; %initialising the time vector to plot the filtered signal
    % figure;
    % for i = 1 : 12 %for the 12 ECG channels
    %     subplot(12, 1, i);
    %     plot(t, filtered_ecg(i, :)); %$plotting each channel of the ecg
    %     title(['Filtered ECG signal - Channel ', num2str(i)]);
    %     xlabel('Time/ s');
    %     ylabel('Voltage/ V');
    % end
end