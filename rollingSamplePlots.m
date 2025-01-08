function rollingSamplePlots(commoditySets)
    % rollingSamplePlots - Generates rolling-sample volatility spillover plots.
    %
    % Inputs:
    %   commoditySets - Cell array of commodity sets (each set is a cell array of strings).
    %   windowSize    - Rolling window size (e.g., 72 months).

    % Determine grid size based on number of sets
    numSets = length(commoditySets);
    numRows = ceil(numSets / 3); % Adjust rows dynamically for a maximum of 3 columns

    % Create a full-screen figure
    figure('Name', 'Rolling-Sample Volatility Spillovers', 'NumberTitle', 'off', ...
           'Units', 'normalized', 'OuterPosition', [0 0 1 1]);

    % Create tiled layout
    tiledlayout(numRows, 3, 'Padding', 'compact', 'TileSpacing', 'compact');

    for i = 1:numSets
        % Simulate rolling spillover values
        numSamples = 500; % Example number of rolling samples
        time = linspace(1, numSamples, numSamples);
        spilloverValues = rand(numSamples, 1) * 30; % Simulated values

        % Plot for the current commodity set
        nexttile;
        plot(time, spilloverValues, 'k-', 'LineWidth', 1.5);
        title(sprintf('Set %d', i), 'FontSize', 10);
        xlabel('Time', 'FontSize', 8);
        ylabel('Spillover (%)', 'FontSize', 8);
        grid on;
    end

    % Add a super title for the entire figure
    sgtitle('Rolling-Sample Volatility Spillovers Across Commodity Sets', ...
            'FontSize', 14, 'FontWeight', 'bold');
end
