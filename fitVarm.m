function model = fitVarm(data, lags)
    % Convert table to numeric array if needed
    if istable(data)
        data = table2array(data);
    end

    % Get dimensions
    [T, k] = size(data);
    
    % Construct lagged matrix
    Y = data(lags+1:end, :);
    X = zeros(T - lags, lags * k);
    for i = 1:lags
        X(:, (i-1)*k+1:i*k) = data(lags+1-i:end-i, :);
    end
    
    % Estimate VAR coefficients using OLS
    beta = (X' * X) \ (X' * Y);
    
    % Store results in a struct
    model.coefficients = beta;
    model.lags = lags;
    model.k = k;
end
