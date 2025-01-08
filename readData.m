function [data,logReturnsTable] = readData()
    % Load the food_oil data
    data = readtable('foodOilMSCI.xlsx');
    % Convert 'Date' to datetime and adjust the format as needed
    data.Date = datetime(data.Date, 'InputFormat', 'yyyy/MM/dd');
    % Drop rows with missing values
    data = rmmissing(data);
    
    % Calculate log returns
    logReturnsTable = calculateLogReturns(data, 'Date');
    logReturnsTable = rmmissing(logReturnsTable);
    % Display log returns
    % disp('Log-Returns Table (First 5 rows):');
    % disp(logReturnsTable(1:5, :));
end

