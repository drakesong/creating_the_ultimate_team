function [ultimateTeam,ultimateTeam_player_id] = ...
    predictUltimate(player,player_attrib)
%PREDICTULTIMATE determines the Ultimate Team

% ====================== preparePlayerData.mat ===========================
% % This part adds unncessary running time to the program
% 
% % Clean up player data
% [X_player,Y_player] = preparePlayerData(player_attrib,player);
% 
% ========================================================================
load('preparePlayerData.mat')

% Clean up the FIFA18 data
[data_FIFA18, raw_data_FIFA18] = cleanFIFA18(player);

% Initialize variable names
vars = {'overall_rating','potential','acceleration','aggression',...
    'agility','balance','ball_control','crossing','curve','dribbling',...
    'finishing','free_kick_accuracy','gk_diving','gk_handling',...
    'gk_kicking','gk_positioning','gk_reflexes','heading_accuracy',...
    'interceptions','jumping','long_passing','long_shots','marking',...
    'penalties','positioning','reactions','short_passing','shot_power',...
    'sliding_tackle','sprint_speed','stamina','standing_tackle',...
    'strength','vision','volleys'};

% Set the indices for test data
[m,~] = size(X_player);
X_full = X_player;
Y_full = Y_player;
num_test = round(m*0.1);
test_index = sort(randperm(m, num_test));
X_test = X_player(test_index, :);
Y_test = Y_player(test_index, :);
X_player(test_index, :) = [];
Y_player(test_index, :) = [];

% Create SVM model
mdl = fitcsvm(X_player(:,vars),Y_player(:,:), ...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 2, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true, ...
    'ClassNames', [0; 1]);
yhat = predict(mdl, X_test(:,vars));
error = sum(abs(yhat - Y_test{:,:}));

% Create SVM model using full data
mdl = fitcsvm(X_full(:,vars),Y_full(:,:), ...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 2, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true, ...
    'ClassNames', [0; 1]);
yhat = predict(mdl, data_FIFA18(:,vars));

% Find the Ultimate Team selected by the model
idx = find(yhat == 1);
ultimateTeam_player_id = data_FIFA18(idx,'player_id');

% Create a list for names and another for player_id
[m,~] = size(ultimateTeam_player_id);
ultimateTeam = [];
for i = 1:m
    idx = find(ultimateTeam_player_id{i,'player_id'} == ...
        player{:,'player_api_id'});
    ultimateTeam = [ultimateTeam player{idx,'player_name'}];
end

fprintf('DONE\n')
error_perc = error/num_test*100;
fprintf('  Error produced by model: %g%%\n', error_perc)
end

