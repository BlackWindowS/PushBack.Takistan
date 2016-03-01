_group = (_this select 0);

while {count units _group != 0} do
{
	BwS_nombreJoueurs = count allPlayers;
	
	if ((BwS_nombreJoueurs != 0) && !(simulationEnabled (leader _group))) then
	{
		{	
			_x enableSimulationGlobal true;	
			_mechant = _x;
			{_x reveal _mechant} forEach allPlayers;
		} forEach units _group;
		(vehicle leader _group) enableSimulationGlobal true;
		[format ["Nous venons de resimuler le groupe %1 car il y a des joueurs", _group]] call BwS_fn_diag_log;
	};
	
	if ((BwS_nombreJoueurs == 0) && (simulationEnabled (leader _group))) then
	{
		{	_x enableSimulationGlobal false;	} forEach units _group;
		(vehicle leader _group) enableSimulationGlobal false;
		[format ["Nous venons de désimuler le groupe %1 car il n'y a personne", _group]] call BwS_fn_diag_log;
	};

	sleep 1;
};

// {	
	// _x enableSimulation false;	
// } forEach units _group;