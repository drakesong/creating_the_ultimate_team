function [FIFA18_data, FIFA18_player] = cleanFIFA18(player)
%CLEANFIFA18 goes through FIFA18 and reformats them

% Load the data
load('FIFA18_player.mat')

% Replace player_fifa_api_id with player_api_id
[m,~] = size(FIFA18_player);
player_id = NaN(m,1);
for i = 1:m
    idx = find(player{:,'player_fifa_api_id'} == FIFA18_player{i,'ID'});
    if ~isempty(idx)
        player_id(i) = player{idx,'player_api_id'};
    end
end

player_id = table(player_id);

% Remove missing data
FIFA18_player = [FIFA18_player player_id];
FIFA18_data = rmmissing(FIFA18_player);

% Discard unnecessary data
FIFA18_data(:,{'Special','Composure','Name','ID'}) = [];

% Change variable names
FIFA18_data.Properties.VariableNames{'Overall'} = 'overall_rating';
FIFA18_data.Properties.VariableNames{'Potential'} = 'potential';
FIFA18_data.Properties.VariableNames{'Crossing'} = 'crossing';
FIFA18_data.Properties.VariableNames{'Acceleration'} = 'acceleration';
FIFA18_data.Properties.VariableNames{'Aggression'} = 'aggression';
FIFA18_data.Properties.VariableNames{'Agility'} = 'agility';
FIFA18_data.Properties.VariableNames{'Balance'} = 'balance';
FIFA18_data.Properties.VariableNames{'Ballcontrol'} = 'ball_control';
FIFA18_data.Properties.VariableNames{'Curve'} = 'curve';
FIFA18_data.Properties.VariableNames{'Dribbling'} = 'dribbling';
FIFA18_data.Properties.VariableNames{'Finishing'} = 'finishing';
FIFA18_data.Properties.VariableNames{'Freekickaccuracy'} = 'free_kick_accuracy';
FIFA18_data.Properties.VariableNames{'GKdiving'} = 'gk_diving';
FIFA18_data.Properties.VariableNames{'GKhandling'} = 'gk_handling';
FIFA18_data.Properties.VariableNames{'GKkicking'} = 'gk_kicking';
FIFA18_data.Properties.VariableNames{'GKpositioning'} = 'gk_positioning';
FIFA18_data.Properties.VariableNames{'GKreflexes'} = 'gk_reflexes';
FIFA18_data.Properties.VariableNames{'Headingaccuracy'} = 'heading_accuracy';
FIFA18_data.Properties.VariableNames{'Interceptions'} = 'interceptions';
FIFA18_data.Properties.VariableNames{'Jumping'} = 'jumping';
FIFA18_data.Properties.VariableNames{'Longpassing'} = 'long_passing';
FIFA18_data.Properties.VariableNames{'Longshots'} = 'long_shots';
FIFA18_data.Properties.VariableNames{'Marking'} = 'marking';
FIFA18_data.Properties.VariableNames{'Penalties'} = 'penalties';
FIFA18_data.Properties.VariableNames{'Positioning'} = 'positioning';
FIFA18_data.Properties.VariableNames{'Reactions'} = 'reactions';
FIFA18_data.Properties.VariableNames{'Shortpassing'} = 'short_passing';
FIFA18_data.Properties.VariableNames{'Shotpower'} = 'shot_power';
FIFA18_data.Properties.VariableNames{'Slidingtackle'} = 'sliding_tackle';
FIFA18_data.Properties.VariableNames{'Sprintspeed'} = 'sprint_speed';
FIFA18_data.Properties.VariableNames{'Stamina'} = 'stamina';
FIFA18_data.Properties.VariableNames{'Standingtackle'} = 'standing_tackle';
FIFA18_data.Properties.VariableNames{'Strength'} = 'strength';
FIFA18_data.Properties.VariableNames{'Vision'} = 'vision';
FIFA18_data.Properties.VariableNames{'Volleys'} = 'volleys';

end

