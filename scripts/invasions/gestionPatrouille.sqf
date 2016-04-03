// _group = (_this select 0);

// [_group, (position leader _group), 500] call BIS_fnc_taskPatrol;

diag_log "Gestion patrouille RUNNING";

while {true} do
{
	{
		_group = _x;
		if (side leader _group == resistance) then
		{
			_nearestPlayer = [leader _group] call BwS_fn_nearestPlayer;
			_prochain_check = 0;
			
			if (((leader _group) distance _nearestPlayer) < 3000 && (call BwS_fn_faut_il_les_simuler)) then // - de 3km
			{
				if !(simulationEnabled leader _group) then
				{
					{	
						_x enableSimulationGlobal true;	
						_mechant = _x;
						{_x reveal _mechant} forEach allPlayers;
					} forEach units _group;
					(vehicle leader _group) enableSimulationGlobal true;
					[format ["Nous venons de resimuler le groupe %1 car le joueur le plus proche etait %2 à une distance de %3", _group, name _nearestPlayer, ((leader _group) distance _nearestPlayer)]] call BwS_fn_diag_log;
				};
				
				if !(_group in BwS_var_groupes_a_exclure) then 
				{
					_group move position _nearestPlayer;
				};
			} 
			else
			{
				if (simulationEnabled (leader _group)) then 
				{
					{	_x enableSimulationGlobal false;	} forEach units _group;
					(vehicle leader _group) enableSimulationGlobal false;
					[format ["Nous venons de désimuler le groupe %1 car le joueur le plus proche etait %2 à une distance de %3", _group, name _nearestPlayer, ((leader _group) distance _nearestPlayer)]] call BwS_fn_diag_log;
				};
			};
		};
	} forEach (allGroups - BwS_var_groupes_a_exclure);
	
	sleep 10;
};