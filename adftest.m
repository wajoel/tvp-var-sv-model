% Perform Augmented Dickey-Fuller GLS Test
function adfResults = adftest(data, detrendMethod, numLags, testType, localToUnity)
    % Inputs:
    %   data - Table of time series data
    %   detrendMethod - 1 (none), 2 (intercept), 3 (intercept + trend)
    %   numLags - Number of lags for the ADF regression
    %   testType - 1 (GLS detrend), 2 (OLS detrend), 3 (standard ADF)
    %   localToUnity - Negative constant for GLS detrending

    columns = data.Properties.VariableNames;
    adfResults = struct(); % Initialize results structure

    % Loop through each column
    for i = 1:numel(columns)
        series = data.(columns{i}); % Extract the column as a series
       % series = series(~isnan(series)); % Remove NaNs

        % Perform the Augmented Dickey-Fuller GLS Test
        adfStat = adfgls(series, detrendMethod, numLags, testType, localToUnity);

        % Store results
        adfResults(i).Column = columns{i};
        adfResults(i).ADFStatistic = adfStat;

        % Display results
        fprintf('ADF GLS Test Result for %s:\n', columns{i});
        fprintf('ADF GLS Statistic: %.4f\n\n', adfStat);
    end
end

% Function: ADF GLS Test Implementation
function adfgls = adfgls(y, d, k, m, c)
    y = y(:);
    T = size(y, 1);
    x = [];
    switch m
        case 1
            switch d
                case 2
                    z = ones(T, 1);
                    zgls = [1; (ones(T-1, 1) - 1 - (c / T))];
                case 3
                    z = [ones(T, 1) (1:T)'];
                    zgls = [1 1; (z(2:end, 1) - (1 + c / T) * z(1:end-1, 1)) ...
                        (z(2:end, 2) - (1 + c / T) * z(1:end-1, 2))];
                otherwise
                    error('Unexpected option');
            end
            ygls = [y(1); y(2:end) - (1 + c / T) * y(1:end-1)];
            psi = (zgls' * zgls) \ (zgls' * ygls);
            yadf = y - sum(psi' .* z, 2);
            index = 1;
        case 2
            switch d
                case 2
                    z = ones(T, 1);
                case 3
                    z = [ones(T, 1) (1:T)'];
                otherwise
                    error('Unexpected option');
            end
            psi = (z' * z) \ (z' * y);
            yadf = y - sum(psi' .* z, 2);
            index = 1;
        case 3
            yadf = y;
            switch d
                case 1
                case 2
                    x = ones(T-k, 1);
                case 3
                    x = [ones(T-k, 1) (1:T-k)'];
                otherwise
                    error('Unexpected option');
            end
            index = d;
        otherwise
            error('Unexpected option');
    end
    x = [x yadf(k:end-1)];
    switch k
        case 1
        otherwise
            for i = 1:k-1
                x = [x (yadf(k+1-i:end-i) - yadf(k-i:end-1-i))];
            end
    end
    phi = (x' * x) \ (x' * yadf(k+1:end));
    e = yadf(k+1:end) - x * phi;
    s2 = (e' * e) / (size(x, 1) - size(x, 2));
    V = s2 * (x' * x)^-1;
    adfgls = (phi(index) - 1) / sqrt(V(index, index));
end
