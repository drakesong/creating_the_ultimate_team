% Start final project
fprintf('\nStarting FINAL PROJECT\n by AUSTIN LEE and DRAKE SONG\n\n')

% Load data
fprintf('Loading data...')
load('data.mat')
fprintf('DONE\n\n')

% Create mdl for predicting outcome of a match
fprintf('Running predictMatch...')
[B, stats] = predictMatch(match, team_attrib);

% Create the Ultimate Team
fprintf('\nRunning predictUltimate...')
[ultimateTeam, utlimateTeam_player_id] = ...
    predictUltimate(player, player_attrib);
fprintf('  Here is the Ultimate Team produced by the model:\n')
fprintf('    %s\n',ultimateTeam)

% Actual Ultimate Team
ultimateTeam = ["Cristiano Ronaldo";'Lionel Messi';'Manuel Neuer';...
    'David De Gea';'Sergio Ramos';'Gianluigi Buffon';'Antoine Griezmann';...
    'David Alaba';'Neymar';'Toni Kroos';'Leonardo Bonucci'];
fprintf('\nAfter 100 runs of predictUltimate, the following 11 players will be considered as the Ultimate Team:\n')
fprintf('  %s\n',ultimateTeam)

% Calculate the needed features in predictMatch for the Ultimate Team
fprintf('\nRunning predictFeatures...')
X_ultimate = predictFeatures(match, team_attrib);

% Test out the Ultimate Team
fprintf('\nRunning testUltimate...')
testUltimate(B, stats, X_ultimate);

% Stop project
fprintf('\nEnd of project\n')


