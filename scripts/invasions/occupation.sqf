// [thisTrigger] spawn BwS_fn_spawnOccupation
BwS_fn_spawnOccupation = {
	private ["_maisons", "_nombreMaisons", "_trigger"];
	
	_trigger = (_this select 0);
	
	// maisons rayon - 500m
	_maisons = (position _trigger) nearObjects ["House", 350];
	_maisons = _maisons call BIS_fnc_arrayShuffle;
	_nombreMaisons = count _maisons;
	
	// une patrouille pour 50 maisons
	private ["_group"];
	for "_i" from 0 to (_nombreMaisons/50) do 
	{
		_group = [(position _trigger), 3 + round(random(5)), resistance, resistance] call BwS_fn_spawnGroup;
		[_group, (position leader _group), 200] call BIS_fnc_taskPatrol;
	};	
	
	// on prend 10% des maisons
	_maisons resize floor(0.1*_nombreMaisons);
	_nombreMaisons = (count _maisons);

	// spawner des homed en proportion
	if (_nombreMaisons > 0) then 
	{
		{
			if (count ([_x] call BIS_fnc_buildingPositions) > 0) then 
			{
				_pos = (selectRandom ([_x] call BIS_fnc_buildingPositions));
				if ((_pos select 0) != 0) then {
					_groupHomed = createGroup resistance;
					BwS_var_groupes_a_exclure pushBackUnique _groupHomed;
					"rhs_g_Soldier_F" createUnit [_pos, _groupHomed]; 
					_groupHomed setBehaviour "STEALTH";
					_unit = (units _groupHomed) select 0;
					[_unit] spawn BwS_fn_gestion_radio;
					_unit setpos [(position _unit select 0),
								  (position _unit select 1),
								  (((position _unit) select 2) + 1.2)];
				};
			};
		} forEach _maisons;
	};
	deleteVehicle _trigger;
};

// recuperation des villes
private ["_villes", "_centerMap", "_locations"];

_villes = [];
_centerMap = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_locations = nearestLocations [_centerMap, ["NameCityCapital", "NameCity", "NameVillage"], 30000];
{_villes pushBack [(locationPosition _x) select 0, (locationPosition _x) select 1]} forEach _locations;

// pour chaque villes
{
	_positionVille = _x;
	
	_trg = createTrigger ["EmptyDetector", _positionVille, false];
	_trg setTriggerArea [500, 500, 0, false];
	_trg setTriggerActivation ["WEST", "PRESENT", false];
	_trg setTriggerStatements ["(({side _x == resistance} count allUnits) < 300) && {vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 25} count allunits > 0", "[thisTrigger] spawn BwS_fn_spawnOccupation; hint 'occupation d une ville';", ""];
	systemChat "trigger place sur une ville";
	sleep 1;
} forEach _villes;