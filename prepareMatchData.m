function [X_match, Y_match] = prepareMatchData(raw_match, raw_team_attrib)
%PREPAREDATA prepares the data for PREDICTMATCH.M

% Use CLEAN functions
[data_match, Y_match] = cleanMatch(raw_match);
team_attrib = cleanTeamAttrib(raw_team_attrib);

% Find home team attributes for each match
vars = {'buildUpPlaySpeed','buildUpPlayPassing', ...
    'chanceCreationPassing','chanceCreationCrossing', ...
    'chanceCreationShooting','defencePressure','defenceAggression', ...
    'defenceTeamWidth','buildUpPlayPositioning', ...
    'chanceCreationPositioning','defenceDefenderLineClass'};
[m,~] = size(data_match);
home_attrib = NaN([m 11]);
for i = 1:m
    idx = find(team_attrib{:,'team_api_id'} == data_match{i,'home_team_api_id'});
    matched = find(team_attrib{idx,'season'} == data_match{i,'season'});
    if ~isempty(matched)
        stats = team_attrib{idx(matched),vars};
        for k = 1:11
            home_attrib(i,k) = stats(1,k);
        end
    end
end

% Find away team attributes for each match
away_attrib = NaN([m 11]);
for i = 1:m
    idx = find(team_attrib{:,'team_api_id'} == data_match{i,'away_team_api_id'});
    matched = find(team_attrib{idx,'season'} == data_match{i,'season'});
    if ~isempty(matched)
        stats = team_attrib{idx(matched),vars};
        for k = 1:11
            away_attrib(i,k) = stats(1,k);
        end
    end
end

% Add home team attributes and away team attributes to the predictors
vars_home = {'homeBuildUpPlaySpeed','homeBuildUpPlayPassing', ...
    'homeChanceCreationPassing','homeChanceCreationCrossing', ...
    'homeChanceCreationShooting','homeDefencePressure', ...
    'homeDefenceAggression','homeDefenceTeamWidth', ...
    'homeBuildUpPlayPositioning','homeChanceCreationPositioning', ...
    'homeDefenceDefenderLineClass'};
vars_away = {'awayBuildUpPlaySpeed','awayBuildUpPlayPassing', ...
    'awayChanceCreationPassing','awayChanceCreationCrossing', ...
    'awayChanceCreationShooting','awayDefencePressure', ...
    'awayDefenceAggression','awayDefenceTeamWidth', ...
    'awayBuildUpPlayPositioning','awayChanceCreationPositioning', ...
    'awayDefenceDefenderLineClass'};

home_attrib = array2table(home_attrib, 'VariableNames', vars_home);
away_attrib = array2table(away_attrib, 'VariableNames', vars_away);

X_match = data_match(:, 4:end);
X_match = [X_match home_attrib away_attrib];

% Remove rows with missing data
temp = [X_match Y_match];
temp = rmmissing(temp);

% Set X_match and Y_match
Y_match = temp(:, 'results');
X_match = temp;
X_match(:, 'results') = [];

end

