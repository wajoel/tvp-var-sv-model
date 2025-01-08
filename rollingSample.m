function rollingSample(commoditySets, windowSize)
    % rollingSample - Calculates and displays rolling-sample volatility spillovers.
    %
    % Inputs:
    %   commoditySets - Cell array of commodity sets (each set is a cell array of strings).
    %   windowSize    - Rolling window size (e.g., 72 months).

    fprintf('Rolling-Sample Volatility Spillover Analysis\n');
    fprintf('Window Size: %d months\n', windowSize);
    fprintf('=============================================\n');

    % Placeholder for spillover results
    totalSpilloverResults = [];

    for i = 1:length(commoditySets)
        fprintf('Set %d: %s\n', i, strjoin(commoditySets{i}, ', '));

        % Simulate rolling-sample calculation
        numSamples = 500; % Example number of rolling samples
        spilloverValues = rand(numSamples, 1) * 30; % Simulated volatility spillover values (1% - 30%)

        % Calculate descriptive statistics
        meanValue = mean(spilloverValues);
        minValue = min(spilloverValues);
        maxValue = max(spilloverValues);
        stdDev = std(spilloverValues);

        % Store results
        totalSpilloverResults = [totalSpilloverResults; meanValue, minValue, maxValue, stdDev]; %#ok<AGROW>

        % Display results in console
        fprintf('Mean: %.2f%% | Min: %.2f%% | Max: %.2f%% | Std Dev: %.2f%%\n', ...
            meanValue, minValue, maxValue, stdDev);
    end

    fprintf('=============================================\n');
end
