function netSpillovers = netSpillovers(data, rollingWindow)
    % netSpillovers - Computes net volatility spillovers.
    %
    % Inputs:
    %   data          - A matrix where each column represents a commodity's time series.
    %   rollingWindow - Size of the rolling window for computing spillovers.
    %
    % Output:
    %   netSpillovers - A matrix where each column contains the net spillover for a commodity.

    % Validate inputs
    [numObs, numAssets] = size(data);
    if rollingWindow >= numObs
        error('Rolling window size must be smaller than the number of observations.');
    end

    % Initialize output
    netSpillovers = zeros(numObs - rollingWindow + 1, numAssets);

    % Loop through the time series
    for t = 1:(numObs - rollingWindow + 1)
        % Extract rolling window
        windowData = data(t:(t + rollingWindow - 1), :);

        % Compute gross spillovers
        grossTo = sum(windowData, 1); % Total spillovers to each asset (row vector)
        grossFrom = sum(windowData, 2); % Total spillovers from each asset (column vector)

        % Aggregate grossFrom for compatibility with grossTo
        grossFromAggregate = sum(grossFrom) / numAssets;

        % Compute net spillovers
        netSpillovers(t, :) = grossTo - grossFromAggregate; % Net = To - Aggregate From
    end
end
