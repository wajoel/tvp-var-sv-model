function posteriorEstimates(horizons, responses, credibleIntervals)
    % Parameters:
    % - horizons: Vector of time horizons (e.g., 1, 3, 6 months)
    % - responses: Matrix of posterior means (rows: horizons, cols: variables)
    % - credibleIntervals: 3D array of credible intervals 
    %   (dim1: lower bound, posterior mean, upper bound; dim2: horizons; dim3: variables)

    numVariables = size(responses, 2);
    numRows = ceil(sqrt(numVariables));
    numCols = ceil(numVariables / numRows);

    figure('Units', 'normalized', 'OuterPosition', [0, 0, 1, 1]);

    for i = 1:numVariables
        subplot(numRows, numCols, i);
        hold on;

        % Plot credible intervals as shaded area
        fill([horizons; flipud(horizons)], ...
             [credibleIntervals(1, :, i)'; flipud(credibleIntervals(3, :, i)')], ...
             [0.9 0.9 0.9], 'EdgeColor', 'none');

        % Plot posterior mean
        plot(horizons, responses(:, i), 'k', 'LineWidth', 1.2);

        % Axis labels and formatting
        ylabel(['Response ' num2str(i)], 'FontSize', 10, 'Interpreter', 'none');
        xlabel('Horizon (months)', 'FontSize', 10);
        set(gca, 'FontSize', 8, 'Box', 'on');

        hold off;
    end
    
    sgtitle('Impulse Response Posterior Estimates', 'FontSize', 14, 'FontWeight', 'bold');
end
