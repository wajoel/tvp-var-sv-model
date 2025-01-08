function parameterPlots(results)
    % Ensure results table contains required fields
    requiredFields = {'Mean', 'CI_Lower', 'CI_Upper', 'Parameter'};
    if ~all(ismember(requiredFields, results.Properties.VariableNames))
        error('Results table must contain "Mean", "CI_Lower", "CI_Upper", and "Parameter" columns.');
    end

    % Extract data
    means = results.Mean;
    ciLower = results.CI_Lower;
    ciUpper = results.CI_Upper;
    parameters = results.Parameter;

    % Create the figure
    figure;
    hold on;

    % Plot each parameter
    for i = 1:height(results)
        % Plot posterior mean as a point
        plot(parameters(i), means(i), 'bo', 'MarkerSize', 8, 'LineWidth', 1.5);
        
        % Plot credible interval as a vertical line
        line([parameters(i), parameters(i)], [ciLower(i), ciUpper(i)], ...
             'Color', 'b', 'LineWidth', 1.5);
    end

    % Add labels and grid
    xlabel('Parameter Index');
    ylabel('Estimated Value');
    title('Posterior Estimates of Stochastic Volatility');
    grid on;
    hold off;
end
