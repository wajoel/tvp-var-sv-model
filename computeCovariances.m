function [covMat, volOil, volFood, covOilFood] = computeCovariances(setData)
    % Computes the covariance matrix and associated metrics
    %
    % Inputs:
    %   setData - A matrix where each column represents a time series for
    %             a commodity (Oil, Food, etc.)
    %
    % Outputs:
    %   covMat - Covariance matrix of the data
    %   volOil - Conditional volatility of crude oil (standard deviation)
    %   volFood - Conditional volatility of food (standard deviation)
    %   covOilFood - Conditional covariance between crude oil and food

    % Ensure input data is a matrix
    if ~ismatrix(setData)
        error('Input setData must be a matrix where each column is a time series.');
    end

    % Compute the covariance matrix
    covMat = cov(setData);

    % Extract individual components
    volOil = sqrt(covMat(1, 1)); % Variance of crude oil
    volFood = sqrt(covMat(2, 2)); % Variance of food commodity
    covOilFood = covMat(1, 2); % Covariance between crude oil and food
end
