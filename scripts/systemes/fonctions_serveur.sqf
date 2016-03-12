BwS_fn_chargement = 
{
	startLoadingScreen ["Chargement en cours"]; 
	waituntil {preloadCamera position player}; 
	endLoadingScreen;
}; 

BwS_fn_localiser_joueurs = 
{
	/************
	inspiré de la fonction R3F_OPEX_FNCT_locate_players de la team ~R3F~ (team-R3F.org)
	return = [] call BwS_fn_localiser_joueurs;
	return = [x,y,z] ou false si pas de position
	*************/
	
	private ["_position"];
	
	if ((count allPlayers) != 0) then {
		if (isDedicated) then {
			private ["_list_of_entities","_nb_playble_units_in_radius","_cible"];
			
			_cible = objNull;
			
			{ 
				_list_of_entities = ( position _x ) nearEntities ["CAManBase", 100]; // les joueurs dans un rayon de 100m
				sleep 0.2;
				
				_nb_playble_units_in_radius = {_x in playableUnits} count _list_of_entities;
				
				if ( _nb_playble_units_in_radius > 3 ) exitWith {_cible = _x;};
			} forEach playableUnits; 

			if ( isNull _cible ) then 
			{
				_position = position (playableUnits select 0);
			} 
			else {
				_position = getPos _cible;
			};
		}
		else {
			_position = position player;
		};
	}
	else {
		_position = [random 10000, random 10000, 0];
	};
	
	_position
};
	
BwS_fn_nearestPlayer = 
{
	private ["_nearest"];
	if ((count allPlayers) != 0) then {
		if (isDedicated) then {
			private ["_unit", "_distance_de_l_objet_actuel", "_distance_du_plus_proche"];
			_unit = (_this select 0);
			
			_nearest = objNull;
			_distance_de_l_objet_actuel = 0;
			_distance_du_plus_proche = 1000000000000000;
		
			{
				_distance_de_l_objet_actuel = _unit distance _x;
				if (_distance_de_l_objet_actuel < _distance_du_plus_proche) then {_nearest = _x; _distance_du_plus_proche = _distance_de_l_objet_actuel;};
			} forEach playableUnits;
		}
		else {
			_nearest = player;
		};
	} 
	else {
		_nearest = objNull
	};
	_nearest
};
	
BwS_fn_nearestEnnemy = 
{		
	private ["_unit", "_distance", "_distancePrecedente", "_nearest"];
	
	BwS_nombreEnnemis = {side _x == East} count allUnits;
	if (BwS_nombreEnnemis != 0) then {
		_unit = (_this select 0);
		_nearest = objNull;
		_distance = 0;
		_distancePrecedente = 1000000000000000;
		
		{
			if (side _x == east) then {
				_distance = _unit distance _x;
				if (_distance < _distancePrecedente) then {_nearest = _x;};
				_distancePrecedente = _distance;
			};
		} forEach allUnits;
	}
	else {
		_nearest = objNull;
	};
	_nearest
};

BwS_fn_creerMarqueur =
{
	private ["_nomMarker", "_text", "_position", "_marker", "_couleur"];
	
    //[input,index,(defaultValue,dataTypes,requiredCount)] call BIS_fnc_param; 
	
	_text = _this select 0;
	_position = [_this, 1, [0, 0, 0], [[]], 3] call BIS_fnc_param;
	_couleur = [_this, 2, "Default", [""]] call BIS_fnc_param;
	
	_nomMarker = format ["%1", random 10000];
	
	_marker = createMarker [_nomMarker, _position];

	_nomMarker setMarkerColor _couleur;
	_nomMarker setMarkerShape "ICON";
	_nomMarker setMarkerType "hd_dot"; 
	_nomMarker setMarkerAlpha 1;
	_nomMarker setMarkerText format ["%1", _text];
	sleep 60;
	deleteMarker _nomMarker;
};

BwS_fn_addArray = {
	private ["_tabA", "_tabB", "_tabC"];
	_tabA = (_this select 0);
	_tabB = (_this select 1);
	_tabC = [];
	
	if (count _tabA == count _tabB) then
	{
		{
			_tabC pushBack (_x + (_tabB select ([_tabA, _x] call BwS_fn_getIndex)));
		} forEach _tabA;
	};
	
	_tabC
};

BwS_fn_substractArray = {
	private ["_tabA", "_tabB", "_tabC"];
	_tabA = (_this select 0);
	_tabB = (_this select 1);
	_tabC = [];
	
	if (count _tabA == count _tabB) then
	{
		{
			_tabC pushBack (_x - (_tabB select ([_tabA, _x] call BwS_fn_getIndex)));
		} forEach _tabA;
	};
	
	_tabC
};

BwS_fn_getIndex = {
	private ["_tab", "_elmt"];
	_tab = _this select 0;
	_elmt = _this select 1;
	
	for "_i" from 0 to count _tab do
	{
		if (_elmt == _tab select _i) exitWith {_i};
	};
};

BwS_fn_diag_log = {
	
	if (BwS_debug) then {
		diag_log format ["%1", (_this select 0)];
	};
};

BwS_fn_spawn_camp = 
{
	// [[<items>, ...], <position>, <position de ref>] call BwS_fn_spawn_camp;
	
	_items = (_this select 0);
	_position = _this select 1,
	_positionBase = _this select 2;
	
	{ 
		_temp = createVehicle [(_x select 0), ([_position, [_positionBase, _x select 1] call BwS_fn_substractArray] call BwS_fn_addArray), [], 0, "CAN_COLLIDE"];
		_temp setDir (_x select 2);
		_temp setVectorUp surfaceNormal position _temp;
		_temp setPosATL [position _temp select 0, position _temp select 1, 0];
	} forEach _objects;
};

//[<location>] spawn BwS_fn_occuper_une_location;
BwS_fn_occuper_une_location =
{
	private ["_maisons", "_nombreMaisons", "_location", "_group", "_groupHomed"];
	
	_location = _this select 0;

	// maisons rayon - 500m
	_maisons = (locationPosition _location) nearObjects ["House", 350];
	_maisons = _maisons call BIS_fnc_arrayShuffle;
	_nombreMaisons = count _maisons;
	
	// une patrouille pour 50 maisons
	private ["_group"];
	for "_i" from 0 to (_nombreMaisons/50) do 
	{
		_group = [(locationPosition _location), 3 + round(random(5)), resistance, resistance] call BwS_fn_spawnGroup;
		[_group, (position leader _group), 200] call BIS_fnc_taskPatrol;
	};	
	
	// on prend 5% des maisons
	_maisons resize floor(0.1*_nombreMaisons);
	_nombreMaisons = (count _maisons);

	// spawner des homed en proportion
	if (_nombreMaisons > 0) then 
	{
		{
			_pos = (_x buildingPos floor(random(count([_x] call BIS_fnc_buildingPositions))));
			if ((_pos select 0) != 0 && (_pos select 1) != 0) then {
				_groupHomed = createGroup resistance;
				"rhs_g_Soldier_F" createUnit [_pos, _groupHomed]; 
				_groupHomed setBehaviour "STEALTH";
				[(units _groupHomed) select 0] call BwS_fn_gestion_radio;
			};
		} forEach _maisons;
	};
	
	waitUntil {(({alive _x}count (units _group)) == 0) && (({alive _x}count (units _groupHomed)) == 0)};
};

BwS_fn_buildings_inAngleSector =
{
	//[<array buildings>, <unit>, <angle>, <to unit>] call BwS_fn_buildings_inAngleSector;
	private ["_array_buildings", "_unit", "_angle", "_toUnit", "_buildings_inAngleSector"];
	_array_buildings = _this select 0;
	_unit = _this select 1;
	_angle = _this select 2;
	_toUnit = _this select 3;
	
	_buildings_inAngleSector = [];
	{
		if ([getPos _unit, _unit getDir _toUnit, _angle, getPos _x] call BIS_fnc_inAngleSector) then
		{
			_buildings_inAngleSector pushBack _x;
		};
	} forEach _array_buildings;
	_buildings_inAngleSector
};


