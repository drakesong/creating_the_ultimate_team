function [B, stats] = predictMatch(match, raw_team_attrib)
%PREDICTMATCH is a function that predicts the outcome of a match

% Prepare data
[X_match, Y_match] = prepareMatchData(match, raw_team_attrib);

% Initialize value
[m,~] = size(X_match);

% % Test for correlation
% figure
% plotmatrix(X_match{:,:})

% Remove linearly correlated feature
X_match(:,'B365D') = [];

% =================== TESTING 'DIFFERENCE' FEATURES ======================
% diffBuildUpPlaySpeed = X_match{:,'homeBuildUpPlaySpeed'} - ...
%     X_match{:,'awayBuildUpPlaySpeed'};
% diffBuildUpPlayPassing = X_match{:,'homeBuildUpPlayPassing'} - ...
%     X_match{:,'awayBuildUpPlayPassing'};
% diffChanceCreationPassing = X_match{:,'homeChanceCreationPassing'} - ...
%     X_match{:,'awayChanceCreationPassing'};
% diffChanceCreationCrossing = X_match{:,'homeChanceCreationCrossing'} - ...
%     X_match{:,'awayChanceCreationCrossing'};
% diffChanceCreationShooting = X_match{:,'homeChanceCreationShooting'} - ...
%     X_match{:,'awayChanceCreationShooting'};
% diffDefencePressure = X_match{:,'homeDefencePressure'} - ...
%     X_match{:,'awayDefencePressure'};
% diffDefenceAggression = X_match{:,'homeDefenceAggression'} - ...
%     X_match{:,'awayDefenceAggression'};
% diffDefenceTeamWidth = X_match{:,'homeDefenceTeamWidth'} - ...
%     X_match{:,'awayDefenceTeamWidth'};
% diffBuildUpPlayPositioning = X_match{:,'homeBuildUpPlayPositioning'} - ...
%     X_match{:,'awayBuildUpPlayPositioning'};
% diffChanceCreationPositioning = X_match{:,'homeChanceCreationPositioning'} - ...
%     X_match{:,'awayChanceCreationPositioning'};
% diffDefenceDefenderLineClass = X_match{:,'homeDefenceDefenderLineClass'} - ...
%     X_match{:,'awayDefenceDefenderLineClass'};
% 
% diff = table(diffBuildUpPlaySpeed,diffBuildUpPlayPassing, ...
%     diffChanceCreationPassing,diffChanceCreationCrossing, ...
%     diffChanceCreationShooting,diffDefencePressure, ...
%     diffDefenceAggression,diffDefenceTeamWidth,diffBuildUpPlayPositioning, ...
%     diffChanceCreationPositioning,diffDefenceDefenderLineClass);
%     
% 
% X_match = X_match(:, {'B365H','B365A'});
% X_match = [X_match diff];
% ========================================================================

% Remove features with p-values > 0.05
X_match(:,{'awayDefenceDefenderLineClass',...
    'awayChanceCreationPositioning','awayDefenceAggression',...
    'awayBuildUpPlayPositioning','awayChanceCreationPassing',...
    'homeDefencePressure','homeChanceCreationPositioning',...
    'homeBuildUpPlaySpeed','homeBuildUpPlayPassing',...
    'homeChanceCreationShooting','awayBuildUpPlaySpeed',...
    'homeChanceCreationCrossing','homeDefenceTeamWidth',...
    'awayBuildUpPlayPassing','homeDefenceDefenderLineClass',...
    'homeDefenceAggression','awayChanceCreationShooting',...
    'homeChanceCreationPassing','awayChanceCreationCrossing'}) = []; 

% Separate TEST data
X_full = X_match;
Y_full = Y_match;

num_test = round(m*0.1);
test_index = sort(randperm(m, num_test));
X_test = X_match(test_index, :);
Y_test = Y_match(test_index, :);
X_match(test_index, :) = [];
Y_match(test_index, :) = [];

% Logistic Regression
[B, ~, stats] = mnrfit(X_match{:,:}, Y_match{:,:});
pihat = mnrval(B, X_test{:,:}, stats);

% Determine Yhat
Yhat = zeros(num_test, 1);
for i = 1:num_test
    [~, Yhat(i)] = max(pihat(i,:));
end

% Calculate error
err = 0;
for i = 1:num_test
    if Yhat(i) ~= Y_test{i, 'results'}
        err = err + 1;
    end
end

c = confusionmat(Y_test{:,:},Yhat);


% Retrain on full dataset
[B, ~, stats] = mnrfit(X_full{:,:}, Y_full{:,:});

% Print error percentage
fprintf('DONE\n')
error_perc = err/num_test*100;
fprintf('  Error produced by model: %g%%\n', error_perc)
fprintf('  Confusion matrix:')
c

end

