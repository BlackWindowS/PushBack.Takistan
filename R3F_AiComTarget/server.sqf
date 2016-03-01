/**************************************
server.sqf
Functions server side

Author : ~R3F~ Mapoule
team-r3f.org
***************************************/

R3F_AIC_FNCT_ai_suppress_fire = { 
	private ["_unit","_cible","_random_result"];
	
	_unit = _this select 0;
	_cible = _this select 1;
	
	_random_result = floor ( random 100 );	
	if (( _random_result <= R3F_AIC_CFG_suppress_fire_probability ) && ( _unit distance _cible <= ( R3F_AIC_CFG_distance_min_suppress_fire + random ( R3F_AIC_CFG_distance_max_suppress_fire - R3F_AIC_CFG_distance_min_suppress_fire )))) then 
	{
		_unit suppressFor ( R3F_AIC_CFG_time_min_suppress_fire + random (R3F_AIC_CFG_time_max_suppress_fire - R3F_AIC_CFG_time_min_suppress_fire) );
	};
};

R3F_AIC_FNCT_ai_flares = {
	if (( sunOrMoon < 1 ) && ( time > R3F_AIC_time_flare + (( random 120 ) + 120 )) && ( floor ( random 100 ) <= 15 )) then
	{
		private ["_unit", "_cible", "_flare"];
		
		_unit = _this select 0;
		_cible = _this select 1;
		
		if ( _unit distance _cible < floor ( random 50 ) + 150 ) then
		{	
			R3F_AIC_time_flare = time;
			sleep ( random 15 ) + 10;
			_flare =  createvehicle ["F_20mm_Red", [ getPos _cible select 0, getPos _cible select 1, (getPos _cible select 2) + 190 ], [], 100, "NONE"]; 
			_flare setVelocity [0, 0, -10];
			waitUntil {sleep 1; ! alive _flare};
			deleteVehicle _flare;
		};
	};
};

BwS_fn_GetInNearest = {
	private ["_unit", "_nearests"];
	
	_unit = _this select 0;

	_unit commandWatch objNull; // arrête d'être fixé sur moiiiii !
	_unit doWatch objNull; // non mais oh...
	
	_nearests = (position _unit) nearEntities [["StaticWeapon", "Tank", "Car", "Air"], 20]; // on récupère les statics les plus proches (- de 20m)

	if (count(_nearests) != 0) then 
	{
		{
			private ["_nearest", "_occupe"];
			_nearest = _x; // on prend le premier venu (pas forcément le plus proche, à améliorer)	
			// private ["_distance_de_l_objet_actuel", "_distance_du_plus_proche"];
			// _nearest = objNull;
			// _distance_de_l_objet_actuel = 0;
			// _distance_du_plus_proche = 1000000000000000;
			
			// {
				// _distance_de_l_objet_actuel = _unit distance _x;
				// if (_distance_de_l_objet_actuel < _distance_du_plus_proche) then {_nearest = _x; _distance_du_plus_proche = _distance_de_l_objet_actuel;};
			// } forEach _nearests;
			
			_occupe = (_nearest getVariable ["BwS_var_occupe", false]);
			_assigne = ((leader group _unit) getVariable ["BwS_var_assigne", false]);
			
			if (!_occupe && !_assigne) exitWith
			{
				group _unit addVehicle _nearest;
				{
					[_x] orderGetIn true;
				} forEach units group _unit;
				_nearest setVariable ["BwS_var_occupe", true];
				(leader group _unit) setVariable ["BwS_var_assigne", true];
				
			};
		} forEach _nearests;
		// [_unit] orderGetIn true;
		
		// if (_nearest isKindOf "StaticWeapon") then // si c'est un poste fixe
		// {
			// if ((gunner _nearest) isEqualTo objNull) then // si y'a personne dedans en tireur
			// { 
				// _unit assignAsGunner _nearest; // monte dedans bonhomme !
			// };
		// };
		// if ((_nearest isKindOf "Tank") OR (_nearest isKindOf "Car")) then // condition en cascade pour remplir par ordre : tireur, conducteur, chef de bord, passager
		// {
			// if (gunner _nearest isEqualTo objNull) then 
			// {
				// _unit assignAsGunner _nearest;
			// } 
			// else 
			// {
				// if (driver _nearest isEqualTo objNull) then 
				// {
					// _unit assignAsDriver _nearest;
				// } 
				// else 
				// {
					// if (commander _nearest isEqualTo objNull) then 
					// {
						// _unit assignAsCommander _nearest;
					// }
					// else 
					// {
						// _unit assignAsCargo _nearest;
					// };
				// };
			// };
		// };
	};	
};

R3F_AIC_FNCT_sever = {
	private ["_player_array_eni","_player","_array_eni_detected","_distance","_min_max_reveal"];

	_player_array_eni = _this select 1;
	_player = _player_array_eni  select 0;
	_array_eni_detected = _player_array_eni select 1;

	switch ( sunOrMoon ) do
	{
		case 1:
		{
			_min_max_reveal = R3F_AIC_CFG_spotting_day_min_max;
		};
		case 0:
		{
			_min_max_reveal = R3F_AIC_CFG_spotting_night_min_max;
		};		
		default 
		{
			_min_max_reveal = R3F_AIC_CFG_spotting_transition_d_n_min_max;
		};
	};
	
	{
		if ( _x knowsAbout _player < R3F_AIC_CFG_knowsAbout_set_mini ) then 
		 {
			_distance_de_l_objet_actuel= _x distance _player;
			if ( _x isKindOf "LandVehicle" ) then
			{
				_x reveal [ _player, 3.3 ];
				_x setCombatMode "RED";
				_x setBehaviour "COMBAT";
				_x allowFleeing 0;
				_x doTarget _player;
			} else {
				if ( _distance_de_l_objet_actuel> 250 ) then
				{
					_x reveal [ _player, _min_max_reveal select 0 ];
				} else {
					_x reveal [ _player, _min_max_reveal select 1 ];
				};
			};
		 }; 

		[ _x, _player ] call R3F_AIC_FNCT_ai_suppress_fire; 
		[ _x, _player ] spawn R3F_AIC_FNCT_ai_flares; 
		[ _x ] spawn BwS_fn_GetInNearest;
	} forEach _array_eni_detected;
};