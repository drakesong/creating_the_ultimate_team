function [data, results] = cleanMatch(raw_data)
%CLEANMATCH is a function that discards unnecessary features from MATCH
%data

% Collect the necessary data
[m,~] = size(raw_data);
vars = {'season','home_team_api_id','away_team_api_id','B365H','B365D', ...
    'B365A'};
data = raw_data(:, vars);

% 1 = home team won; 2 = away team won; 3 = tie
results = zeros(m,1);
for i = 1:m
    if raw_data{i, 'home_team_goal'} > raw_data{i, 'away_team_goal'}
        results(i) = 1;
    elseif raw_data{i, 'home_team_goal'} < raw_data{i, 'away_team_goal'}
        results(i) = 2;
    else
        results(i) = 3;
    end
end

% Remove tied matches
results = table(results);
temp = [data results];
idx = [];
for i = 1:m
    if temp{i,'results'} == 3
        idx = [idx i];
    end
end
temp(idx,:) = [];

% Removing data with missing values
temp = rmmissing(temp);

% Separate predictors and results
[~,n] = size(temp);
data = temp(:, 1:n-1);
results = temp(:, n);

end

