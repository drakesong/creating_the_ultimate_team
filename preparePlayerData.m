function [X_player, Y_player] = preparePlayerData(player_attrib,player)
%PREPAREPLAYERDATA determines if a player has been in TOTY

% Clean the data
player_attrib = cleanPlayerAttrib(player_attrib);
toty_data = determineID(player);

% Initialize values
[m,~] = size(player_attrib);
toty = zeros(m,1);

% Determine if the player was in TOTY
for i = 1:m
    idx = find(toty_data{:,'player_id'} == ...
        player_attrib{i,'player_api_id'});
    matched = find(toty_data{idx,'Season'} == ...
        player_attrib{i,'season'});
    if ~isempty(matched)
        toty(i) = 1;
    end
end

toty = table(toty);

X_player = player_attrib;
X_player(:,{'season','player_api_id'}) = [];
Y_player = toty;

end

