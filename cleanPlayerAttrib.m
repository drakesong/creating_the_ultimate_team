function player_attrib = cleanPlayerAttrib(player_attrib)
%CLEANPLAYERATTRIB changes data to a useable form

% Remove missing data
player_attrib = rmmissing(player_attrib);

% Reformat data so that they're usable
[m,~] = size(player_attrib);
preferred_foot = zeros(m,1);
season = cell([m 1]);
for i = 1:m
    % 0 if preferred_foot of player is 'left'; 1 if 'right'
    if player_attrib{i,'preferred_foot'} == 'left'
        preferred_foot(i) = 0;
    else
        preferred_foot(i) = 1;
    end
    
    % Change date to categorial seasons
    if isbetween(player_attrib{i,'date'},datetime(2006,06,01),datetime(2007,05,31))
        season(i,1) = cellstr('2006/2007');
    elseif isbetween(player_attrib{i,'date'},datetime(2007,06,01),datetime(2008,05,31))
        season(i,1) = cellstr('2007/2008');
    elseif isbetween(player_attrib{i,'date'},datetime(2008,06,01),datetime(2009,05,31))
        season(i,1) = cellstr('2008/2009');
    elseif isbetween(player_attrib{i,'date'},datetime(2009,06,01),datetime(2010,05,31))
        season(i,1) = cellstr('2009/2010');
    elseif isbetween(player_attrib{i,'date'},datetime(2010,06,01),datetime(2011,05,31))
        season(i,1) = cellstr('2010/2011');
    elseif isbetween(player_attrib{i,'date'},datetime(2011,06,01),datetime(2012,05,31))
        season(i,1) = cellstr('2011/2012');
    elseif isbetween(player_attrib{i,'date'},datetime(2012,06,01),datetime(2013,05,31))
        season(i,1) = cellstr('2012/2013');
    elseif isbetween(player_attrib{i,'date'},datetime(2013,06,01),datetime(2014,05,31))
        season(i,1) = cellstr('2013/2014');
    elseif isbetween(player_attrib{i,'date'},datetime(2014,06,01),datetime(2015,05,31))
        season(i,1) = cellstr('2014/2015');
    elseif isbetween(player_attrib{i,'date'},datetime(2015,06,01),datetime(2016,05,31))
        season(i,1) = cellstr('2015/2016');
    elseif isbetween(player_attrib{i,'date'},datetime(2016,06,01),datetime(2017,05,31))
        season(i,1) = cellstr('2016/2017');
    end
end

preferred_foot = table(preferred_foot);
player_attrib(:,'preferred_foot') = [];

seasonTable = table(season, 'VariableNames', {'season'});

% Remove unncessary features
player_attrib(:,{'id','player_fifa_api_id','date'}) = [];

% Add the reformatted features
player_attrib = [seasonTable player_attrib preferred_foot];

end

