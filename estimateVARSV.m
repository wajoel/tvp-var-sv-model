function [GFEVD, totalSpilloverIndex] = estimateVARSV(dataMatrix, p, h)
% estimateVARSV Estimates Generalized Forecast Error Variance Decompositions (GFEVD).

    % Estimate the VAR model using least squares
    [coeffs, residuals] = estimateVAR(dataMatrix, p);

    % Compute GFEVD
    try
        GFEVD = computeGFEVD(coeffs, residuals, h);
    catch ME
        error('Error computing GFEVD: %s', ME.message);
    end

    % Compute Total Spillover Index
    totalSpilloverIndex = sum(GFEVD(:)) - trace(GFEVD);
    totalSpilloverIndex = totalSpilloverIndex / sum(GFEVD(:));
end
function laggedData = lagmatrix(data, p)
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

function [coeffs, residuals] = estimateVAR(dataMatrix, p)
% estimateVAR Estimates coefficients and residuals for a VAR model.

    N = size(dataMatrix, 2);
    laggedData = lagmatrix(dataMatrix, 1:p);
    laggedData = laggedData(p+1:end, :);
    targetData = dataMatrix(p+1:end, :);

    coeffs = (laggedData' * laggedData) \ (laggedData' * targetData);
    residuals = targetData - laggedData * coeffs;
end

function GFEVD = computeGFEVD(coeffs, residuals, h)
% computeGFEVD Computes Generalized Forecast Error Variance Decomposition.

    N = size(coeffs, 2);
    GFEVD = zeros(N, N);

    % Example implementation (replace with precise method as per tpv-VAR-SV model)
    for i = 1:N
        GFEVD(i, :) = var(residuals(:, i)) / sum(var(residuals));
    end
end
