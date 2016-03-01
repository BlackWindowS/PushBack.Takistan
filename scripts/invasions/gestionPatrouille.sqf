_group = (_this select 0);

_conditionDone = false;

while {count units _group != 0} do
{
	_nearestPlayer = [leader _group] call BwS_fn_nearestPlayableUnit;
	
	if ((((leader _group) distance _nearestPlayer) < 4000) && !(simulationEnabled (leader _group))) then
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
	
	if ((((leader _group) distance _nearestPlayer) <= 500) && !_conditionDone) then
	{
		_positionGroup = position leader _group;
		[_group, _positionGroup, 50] call BIS_fnc_taskPatrol;
		_conditionDone = true;
	};
	
	if ((((leader _group) distance _nearestPlayer) < 2500) && (((leader _group) distance _nearestPlayer) > 500)) then
	{
		_group move (position _nearestPlayer);
		sleep 10;
	};
	sleep 1;
};

// _positionGroup = position leader _group;
// [_group, _positionGroup, 300] call BIS_fnc_taskPatrol;

// {	
	// _x enableSimulation false;	
// } forEach units _group;