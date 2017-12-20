function [ teamAttribs ] = cleanTeamAttrib( teamAttribData )
%CLEANTEAMATTRIB discards unncessary info from team_attrib and changes
%certain string vars to numbers, also adds categorical column "season"
%showing which season the stats came from

buildUpPlayPositioning = contains(string(teamAttribData.buildUpPlayPositioningClass),...
    'Organised')+1; %2 = organised, 1 = free form
chanceCreationPositioning = contains(string(teamAttribData.chanceCreationPositioningClass),...
    'Organised')+1; %2 = organised, 1 = free form
defenceDefenderLineClass = contains(string(teamAttribData.defenceDefenderLineClass),...
    'Cover')+1; %2 = cover, 1 = offside trap

vars = {'team_api_id','buildUpPlaySpeed','buildUpPlayDribbling'...
   'buildUpPlayPassing','chanceCreationPassing','chanceCreationCrossing',...
   'chanceCreationShooting','defencePressure','defenceAggression',...
   'defenceTeamWidth'};

% teamAttribs =  [teamAttribData(:, vars) array2table(buildUpPlayPositioning)...
%     array2table(chanceCreationPositioning) array2table(defenceDefenderLineClass)];

season = cell([max(size(teamAttribData)) 1]);
season(contains(string(teamAttribData.date),'2010'),1) = cellstr('2009/2010');
season(contains(string(teamAttribData.date),'2011'),1) = cellstr('2010/2011');
season(contains(string(teamAttribData.date),'2012'),1) = cellstr('2011/2012');
season(contains(string(teamAttribData.date),'2013'),1) = cellstr('2012/2013');
season(contains(string(teamAttribData.date),'2014'),1) = cellstr('2013/2014');
season(contains(string(teamAttribData.date),'2015'),1) = cellstr('2015/2016');

seasonTable = table(season, 'VariableNames', {'season'});

teamAttribs =  [seasonTable teamAttribData(:, vars) array2table(buildUpPlayPositioning)...
    array2table(chanceCreationPositioning) array2table(defenceDefenderLineClass)];
teamAttribs.season = categorical(teamAttribs.season);

end

