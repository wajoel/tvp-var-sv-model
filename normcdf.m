function p = normcdf(x, mu, sigma)
    % NORMCDF computes the cumulative distribution function (CDF) of the normal distribution.
    %
    % p = normcdf(x, mu, sigma) returns the CDF of the normal distribution with mean mu and
    % standard deviation sigma, evaluated at x.
    %
    % If mu and sigma are not provided, the function defaults to the standard normal (mu = 0, sigma = 1).

    % Set default values if necessary
    if nargin < 2
        mu = 0;
    end
    if nargin < 3
        sigma = 1;
    end
    
    % Validate inputs
    if sigma <= 0
        error('Standard deviation sigma must be positive.');
    end

    % Calculate the cumulative probability
    z = (x - mu) / sigma;
    p = 0.5 * (1 + erf(z / sqrt(2)));
end
