function toty = determineID(player)
% DETERMINEID finds the player_id for each of the toty players

% Load data
load('toty.mat')

% Initialize values
[m,~] = size(toty);

% Find the player id for each player using name
player_id = NaN([m 1]);
for i = 1:m
    idx = find(player{:,'player_name'} == toty{i,'Player'});
    if ~isempty(idx)
        player_id(i) = player{idx,'player_api_id'};
    end
end

toty = [toty table(player_id)];

end

