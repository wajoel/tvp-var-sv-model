function netSpilloversPlots(netSpillovers, timeVec, assetNames)
    % netSpilloversPlots - Plots net volatility spillovers with grid management.
    %
    % Inputs:
    %   netSpillovers - Matrix of net spillovers (time x assets).
    %   timeVec       - Time vector corresponding to the rows of netSpillovers.
    %   assetNames    - Cell array of asset names.

    [numPoints, numAssets] = size(netSpillovers);
    if length(timeVec) ~= numPoints
        error('Time vector length must match the number of rows in netSpillovers.');
    end

    % Full-screen figure
    figure('Name', 'Net Volatility Spillovers', 'NumberTitle', 'off', ...
           'Units', 'normalized', 'OuterPosition', [0 0 1 1]);

    % Define grid settings
    maxPlotsPerGrid = 9;
    numGrids = ceil(numAssets / maxPlotsPerGrid);

    for gridIdx = 1:numGrids
        tiledlayout(3, 3, 'Padding', 'compact', 'TileSpacing', 'compact');

        % Determine assets for the current grid
        startIdx = (gridIdx - 1) * maxPlotsPerGrid + 1;
        endIdx = min(gridIdx * maxPlotsPerGrid, numAssets);

        for i = startIdx:endIdx
            nexttile;
            plot(timeVec, netSpillovers(:, i), 'k-', 'LineWidth', 1.5);
            title(assetNames{i}, 'FontSize', 10);
            xlabel('Time', 'FontSize', 8);
            ylabel('Net Spillover', 'FontSize', 8);
            grid on;
        end

        if gridIdx < numGrids
            pause; % User interaction to move to the next grid
        end
    end
end
