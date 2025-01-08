function plotHedgeRatios(time, hedgeRatios, titleText)
    % Plot time-varying hedge ratios
    numPlots = size(hedgeRatios, 2);
    plotsPerFigure = 4; % Number of plots per figure
    
    for i = 1:numPlots
        if mod(i - 1, plotsPerFigure) == 0
            figure('Name', titleText, 'WindowState', 'maximized');
        end
        subplot(2, 2, mod(i - 1, plotsPerFigure) + 1);
        plot(time, hedgeRatios(:, i), 'k', 'LineWidth', 1.5);
        title(['Hedge Ratio ' num2str(i)]);
        xlabel('Time');
        ylabel('Hedge Ratio');
    end
end
