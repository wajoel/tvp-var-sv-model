function irf = fitVarModel(data, lags, horizons)
    % fitVarModel - Fits a VAR model and computes impulse response functions (IRFs).
    %
    % Inputs:
    %   data - The log returns data to fit the VAR model.
    %   lags - The number of lags for the VAR model.
    %   horizons - The number of periods ahead for the IRFs.
    %
    % Outputs:
    %   irf - The impulse response function results.

    try
        % Fit the VAR model with the specified number of lags
        model = var(data, lags);  % VAR model fitting

        % Calculate the IRFs for the specified number of periods ahead
        irf = irf(model, 'NumPeriods', horizons);  % Calculate the IRFs
    catch ME
        % Handle error in fitting VAR model
        error('Error fitting VAR model: %s', ME.message);
    end
end
