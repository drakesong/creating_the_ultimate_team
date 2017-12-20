function [match_B365H, match_B365A, match_homeBuildUpPlayPositioning, ...
    ultimateTeam_playerAttrib] = prepareRegressionData(match, team_attrib)
%PREPAREREGRESSIONDATA extracts and cleans the necessary data for the
%regression models

% Extract needed data from match data
match_B365H = match(:,{'season','home_player_1','home_player_2',...
    'home_player_3','home_player_4','home_player_5','home_player_6',...
    'home_player_7','home_player_8','home_player_9','home_player_10',...
    'home_player_11','away_player_1','away_player_2','away_player_3',...
    'away_player_4','away_player_5','away_player_6','away_player_7',...
    'away_player_8','away_player_9','away_player_10','away_player_11',...
    'B365H','home_team_api_id','away_team_api_id'});
match_B365A = match(:,{'season','home_player_1','home_player_2',...
    'home_player_3','home_player_4','home_player_5','home_player_6',...
    'home_player_7','home_player_8','home_player_9','home_player_10',...
    'home_player_11','away_player_1','away_player_2','away_player_3',...
    'away_player_4','away_player_5','away_player_6','away_player_7',...
    'away_player_8','away_player_9','away_player_10','away_player_11',...
    'B365A'});

% Remove missing data
match_B365H = rmmissing(match_B365H);
match_B365A = rmmissing(match_B365A);

% Create the third data set needed
match_homeBuildUpPlayPositioning = match_B365H;
match_homeBuildUpPlayPositioning(:,'B365H') = [];

% Find the homeBuildUpPlayPositioning feature for each match
cleaned_teamAttrib = cleanTeamAttrib(team_attrib);
[m,~] = size(match_homeBuildUpPlayPositioning);
home_attrib = NaN([m 1]);
for i = 1:m
    idx = find(cleaned_teamAttrib{:,'team_api_id'} == ...
        match_homeBuildUpPlayPositioning{i,'home_team_api_id'});
    matched = find(cleaned_teamAttrib{idx,'season'} == ...
        match_homeBuildUpPlayPositioning{i,'season'});
    if ~isempty(matched)
        home_attrib(i,1) = cleaned_teamAttrib{idx(matched),...
            'buildUpPlayPositioning'};
    end
end

away_attrib = NaN([m 2]);
for i = 1:m
    idx = find(cleaned_teamAttrib{:,'team_api_id'} == ...
        match_homeBuildUpPlayPositioning{i,'away_team_api_id'});
    matched = find(cleaned_teamAttrib{idx,'season'} == ...
        match_homeBuildUpPlayPositioning{i,'season'});
    if ~isempty(matched)
        away_attrib(i,:) = cleaned_teamAttrib{idx(matched),...
            {'defencePressure','defenceTeamWidth'}};
    end
end

away_attrib = array2table(away_attrib, 'VariableNames', ...
    {'awayDefencePressure','awayDefenceTeamWidth'});

match_homeBuildUpPlayPositioning = [match_homeBuildUpPlayPositioning ...
    table(home_attrib) away_attrib];

% Remove unnecessary features
match_B365H(:,{'home_team_api_id','away_team_api_id'}) = [];
match_homeBuildUpPlayPositioning(:,...
    {'home_team_api_id','away_team_api_id'}) = [];


% ===================== match_player_attrib.mat ==========================
% % This part adds unncessary running time to the program
% 
% % Clean player attributes data
% cleaned_playerAttrib = cleanPlayerAttrib(player_attrib);
% 
% % Variables needed for player attribue features
% vars = {'overall_rating','potential','crossing','finishing',...
%     'heading_accuracy','short_passing','volleys','dribbling',...
%     'curve','free_kick_accuracy','long_passing','ball_control',...
%     'acceleration','sprint_speed','agility','reactions','balance',...
%     'shot_power','jumping','stamina','strength','long_shots',...
%     'aggression','interceptions','positioning','vision','penalties',...
%     'marking','standing_tackle','sliding_tackle','gk_diving',...
%     'gk_handling','gk_kicking','gk_positioning','gk_reflexes'};
% 
% % Variables needed from match data
% vars_player = {'home_player_1','home_player_2','home_player_3',...
%     'home_player_4','home_player_5','home_player_6','home_player_7',...
%     'home_player_8','home_player_9','home_player_10','home_player_11',...
%     'away_player_1','away_player_2','away_player_3','away_player_4',...
%     'away_player_5','away_player_6','away_player_7','away_player_8',...
%     'away_player_9','away_player_10','away_player_11'};
% vars_playerAttrib = {};
% 
% % Variables that combines the two above (35 features for 22 players)
% for i = 1:22
%     for j = 1:35
%         vars_playerAttrib = [vars_playerAttrib ...
%             strcat(vars_player{i},'_',vars{j})];
%     end
% end
% 
% % Find 35 player_attrib features for all 22 players in a match for all 200k
% % matches
% [m,~] = size(match_B365H);
% attrib = NaN([m 770]);
% attrib_match = [];
% for i = 1:m
%     for j = 1:22
%         idx = find(match_B365H{i,vars_player{j}} == ...
%             cleaned_playerAttrib{:,'player_api_id'});
%         matched = find(cleaned_playerAttrib{idx,'season'} == ...
%             match_B365H{i,'season'});
%         if ~isempty(matched)
%             stats = cleaned_playerAttrib{idx(matched(1)),vars};
%             for k = 1:35
%                 attrib(i,k+(35*(j-1))) = stats(1,k);
%             end
%         end
%     end
%     fprintf('%g\n',i)
% end
% match_player_attrib = array2table(attrib, ...
%     'VariableNames', vars_playerAttrib);
% 
% ========================================================================
load('match_player_attrib.mat')

% Add player_attrib of 22 players into the match data
match_B365H = [match_B365H match_player_attrib];
match_B365A = [match_B365A match_player_attrib];
match_homeBuildUpPlayPositioning = [match_homeBuildUpPlayPositioning ...
    match_player_attrib];

% Remove missing data
match_B365H = rmmissing(match_B365H);
match_B365A = rmmissing(match_B365A);
match_homeBuildUpPlayPositioning = rmmissing(match_homeBuildUpPlayPositioning);


% Load player attribute data from FIFA18
load('FIFA18_data.mat')

% Create lists of the Ultimate Team and the players' id
ultimateTeam = ["Cristiano Ronaldo";'Lionel Messi';'Manuel Neuer';...
    'David De Gea';'Sergio Ramos';'Gianluigi Buffon';'Antoine Griezmann';...
    'David Alaba';'Neymar';'Toni Kroos';'Leonardo Bonucci'];
ultimateTeam_player_id = [30893;30981;27299;182917;30962;30717;...
    184138;121633;19533;95078;24235];

% Find the player attributes for the Ultimate Team
[m,~] = size(ultimateTeam);
ultimateTeam_playerAttrib = table();
for i = 1:m
    idx = find(ultimateTeam_player_id(i) == data_FIFA18{:,'player_id'});
    ultimateTeam_playerAttrib = [ultimateTeam_playerAttrib; ...
        data_FIFA18(idx,:)];
end

end

