function varUnhedged = computeUnhedgedVariance(setData)
    % Computes the variance of the unhedged portfolio based on input data.
    % Assumes `setData` is a matrix where each column represents a time series.

    % Validate input
    if isempty(setData)
        error('Input data is empty.');
    end

    % Compute unhedged variance (sum of variances of the time series)
    varUnhedged = sum(var(setData, 0, 1)); % Variance along columns
end
