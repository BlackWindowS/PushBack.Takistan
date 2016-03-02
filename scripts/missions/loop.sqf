private ["_missionEnCours", "_missions", "_nombreDeJoueurs"];

_missions = [BwS_fn_mission_convoi] call BIS_fnc_arrayShuffle;

_i = 0;

while {true} do
{
	_missionEnCours = scriptNull;
	_nombreDeJoueurs = count allPlayers;
	
	if (_nombreDeJoueurs > 0) then 
	{
		// sleep 300; // attente 5 min pour voir combien de joueurs sont arrivés
		
		if (_nombreDeJoueurs > 0) then 
		{
			[[], "BwS_fn_nouvelleTache", west] call BIS_fnc_MP;
			
			_missionEnCours = [] spawn (_missions select (_i % (count _missions)));
			
			waitUntil {scriptDone _missionEnCours};
			
			[[], "BwS_fn_finTache", west] call BIS_fnc_MP;
			_i = _i+1;
		};
	};
	
	sleep 5;
};