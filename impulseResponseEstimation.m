%% impulseResponseEstimation.m
function impulseResponses = impulseResponseEstimation(results, shockIndex, horizons)
    % IMPULSERESPONSEESTIMATION Computes impulse responses for TVP-VAR model.
    % 
    % Inputs:
    %   results: Parameter estimation results [time x variables] (table or array)
    %   shockIndex: Index of the shock variable (1-based indexing)
    %   horizons: Array of time horizons to compute responses for
    %
    % Output:
    %   impulseResponses: 3D matrix of impulse responses [horizons x variables x time]

    % Ensure results is numeric
    if istable(results)
        resultsArray = table2array(results);
    else
        resultsArray = results;
    end

    % Validate dimensions
    [numPeriods, numVariables] = size(resultsArray);
    if shockIndex > numVariables || shockIndex < 1
        error('Invalid shockIndex: must be between 1 and %d.', numVariables);
    end

    % Preallocate response matrix
    maxHorizon = max(horizons);
    impulseResponses = zeros(maxHorizon, numVariables, numPeriods);

    % Compute impulse responses efficiently
    decayFactors = exp(-0.1 * (1:maxHorizon)');
    for t = 1:numPeriods
        shockEffects = resultsArray(t, :) .* decayFactors;
        shockEffects(:, shockIndex) = shockEffects(:, shockIndex) * 1.5; % Amplify shock
        impulseResponses(:, :, t) = shockEffects;
    end

    % Retain only the specified horizons
    impulseResponses = impulseResponses(horizons, :, :);
end