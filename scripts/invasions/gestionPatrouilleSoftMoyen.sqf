_group = (_this select 0);

_prochain_check = 0;

while {count units _group != 0} do
{
	_nearestPlayer = [leader _group] call BwS_fn_nearestPlayer;
	
	if ((((leader _group) distance _nearestPlayer) < 2000) && !(simulationEnabled (leader _group))) then
	{
		{	
			_x enableSimulationGlobal true;	
			_mechant = _x;
			{_x reveal _mechant} forEach allPlayers;
		} forEach units _group;
		(vehicle leader _group) enableSimulationGlobal true;
		
		[format ["Nous venons de resimuler le groupe %1 car le joueur le plus proche etait %2", _group, _nearestPlayer]] call BwS_fn_diag_log;
	};
	
	if ((((leader _group) distance _nearestPlayer) > 2000) && (simulationEnabled (leader _group))) then
	{
		{	_x enableSimulationGlobal false;	} forEach units _group;
		(vehicle leader _group) enableSimulationGlobal false;
		[format ["Nous venons de désimuler le groupe %1 car le joueur le plus proche etait %2", _group, _nearestPlayer]] call BwS_fn_diag_log;
	};
	
	waitUntil {time >= _prochain_check};
	sleep 1;
};

{	
	_x enableSimulation false;	
	deleteVehicle _x;
} forEach units _group;