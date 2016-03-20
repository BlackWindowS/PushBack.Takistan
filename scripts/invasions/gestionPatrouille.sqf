_group = (_this select 0);

// [_group, (position leader _group), 500] call BIS_fnc_taskPatrol;

while {count units _group != 0} do
{
	_nearestPlayer = [leader _group] call BwS_fn_nearestPlayer;
	_prochain_check = 0;
	
	if (((leader _group) distance _nearestPlayer) < 3000 && (call BwS_fn_faut_il_les_simuler)) then // - de 3km
	{
		{	
			_x enableSimulationGlobal true;	
			_mechant = _x;
			{_x reveal _mechant} forEach allPlayers;
		} forEach units _group;
		(vehicle leader _group) enableSimulationGlobal true;
		[format ["Nous venons de resimuler le groupe %1 car le joueur le plus proche etait %2", _group, _nearestPlayer]] call BwS_fn_diag_log;
		_group move position _nearestPlayer;
		_prochain_check = time + 300; // prochain check dans 5 min
	} 
	else
	{
		if (simulationEnabled (leader _group)) then 
		{
			{	_x enableSimulationGlobal false;	} forEach units _group;
			(vehicle leader _group) enableSimulationGlobal false;
			_prochain_check = time + 30;
			[format ["Nous venons de désimuler le groupe %1 car le joueur le plus proche etait %2", _group, _nearestPlayer]] call BwS_fn_diag_log;
		};
	};

	waitUntil {sleep 0.1; time >= _prochain_check};
	sleep 1;
};


{	
	_x enableSimulation true;	
	deleteVehicle _x;
} forEach units _group;