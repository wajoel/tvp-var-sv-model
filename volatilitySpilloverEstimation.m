function [spilloverTable, totalSpilloverIndex] = volatilitySpilloverEstimation(data, p, h)
    % Function to estimate volatility spillovers based on Diebold and Yilmaz (2012)
    % INPUTS:
    %   data: Matrix of time series (T x N), where T is time and N is the number of series
    %   p: Lag order for the VAR model
    %   h: Forecast horizon
    % OUTPUTS:
    %   spilloverTable: Spillover table (N x N) with directional spillovers
    %   totalSpilloverIndex: Total spillover index as a percentage

    % Validate inputs
    [T, N] = size(data);
    if T <= N
        error('Data matrix must have more rows (time points) than columns (variables).');
    end
    
    if nargin < 2 || isempty(p)
        p = 5; % Default lag order if not provided
    end
    if nargin < 3 || isempty(h)
        h = 10; % Default forecast horizon if not provided
    end
    
    % Ensure data is numeric
    if istable(data)
        data = table2array(data); % Convert table to numeric array if needed
    elseif ~isnumeric(data)
        error('Data must be a numeric matrix or table.');
    end

    % Estimate VAR model coefficients
    laggedData = lagMatrix(data, p);
    Y = data(p + 1:end, :); % Dependent variables (adjusted for lags)
    X = laggedData;

    % Solve for coefficients using OLS
    modelCoefficients = (X' * X) \ (X' * Y); % Efficient matrix computation

    % Compute forecast error variance decomposition
    FEVD = computeFEVD(modelCoefficients, h, N, p);

    % Calculate spillover table
    spilloverTable = 100 * FEVD ./ sum(FEVD, 2); % Normalize by row sums
    
    % Compute total spillover index
    offDiagonalSpillovers = sum(spilloverTable(:)) - trace(spilloverTable);
    totalSpilloverIndex = offDiagonalSpillovers / N;
end

function laggedData = lagMatrix(data, p)
    % Helper function to create a lag matrix for VAR model
    % INPUTS:
    %   data: Matrix of time series (T x N)
    %   p: Number of lags
    % OUTPUT:
    %   laggedData: Matrix of lagged data for VAR model (T-p x N*p)

    [T, N] = size(data);
    laggedData = zeros(T - p, N * p);

    for i = 1:p
        laggedData(:, (i - 1) * N + (1:N)) = data(p - i + 1:end - i, :);
    end
end

function FEVD = computeFEVD(modelCoefficients, h, N, p)
    % Helper function to compute forecast error variance decomposition (FEVD)
    % INPUTS:
    %   modelCoefficients: Coefficients of the VAR model (N*p x N)
    %   h: Forecast horizon
    %   N: Number of variables
    %   p: Lag order of the VAR model
    % OUTPUT:
    %   FEVD: Forecast error variance decomposition matrix (N x N)

    % Initialize FEVD
    FEVD = zeros(N, N);

    % Impulse response computations
    for i = 1:N
        for j = 1:N
            impulseResponse = computeImpulseResponse(modelCoefficients, h, N, p, i, j);
            FEVD(i, j) = sum(impulseResponse.^2);
        end
    end
end

function impulseResponse = computeImpulseResponse(coefficients, h, N, p, i, j)
    % Computes impulse response functions for VAR model
    % INPUTS:
    %   coefficients: Coefficients of the VAR model (N*p x N)
    %   h: Forecast horizon
    %   N: Number of variables
    %   p: Lag order of the VAR model
    %   i, j: Indices of the variables
    % OUTPUT:
    %   impulseResponse: Impulse response values for variable i to shock in variable j

    impulseResponse = zeros(h, 1);
    responseMatrix = eye(N); % Identity matrix for initial shock

    for t = 1:h
        if t <= p
            coefficientBlock = coefficients((t - 1) * N + 1:t * N, :);
            impulseResponse(t) = responseMatrix(i, :) * coefficientBlock(:, j);
        else
            impulseResponse(t) = 0; % Beyond lag order, contributions diminish
        end
    end
end
