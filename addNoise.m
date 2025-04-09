function noisySignal = addNoise(signal, noiseType, stdDev, meanVal)
    % adds noise to the signal, white' or 'gaussian'
    %
    % stdDev: standard deviation of the noise
    % meanVal: mean of Gaussian noise (only used for 'gaussian')

    if nargin < 4
        meanVal = 0; % default
    end
    if nargin < 3
        stdDev = 1; % default
    end

    switch lower(noiseType)
        case 'white'
            % White noise: zero mean, unit variance → scaled by stdDev
            noise = stdDev * randn(size(signal)); 

        case 'gaussian'
            % Gaussian noise with specified mean and std
            noise = stdDev * randn(size(signal)) + meanVal;

        otherwise
            error('Unknown noise type. Use ''white'' or ''gaussian''.');
    end

    % Add noise to signal
    noisySignal = signal + noise;
end
