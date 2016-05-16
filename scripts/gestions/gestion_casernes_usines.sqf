diag_log "Gestion des casernes et des usines RUNNING";

while {true} do
{
	{
		_caserne = _x;
		if ((damage _caserne < 1) && ([_caserne] call BwS_fn_faut_il_produire_des_pedestres) && time > (_caserne getVariable ["BwS_var_quand_produire", 0])) then
		{
			// creation de groupe(s) de combat
			_groupe = ([(_caserne buildingPos floor(random(count([_caserne] call BIS_fnc_buildingPositions)))), 3 + floor(random 6) , BwS_var_side_ennemie, BwS_var_side_ennemie] call BwS_fn_spawnGroup);
			{
				if (typeOf _x == "B_G_soldier_exp_F" || typeOf _x == "O_soldier_exp_F" || typeof _x == "rhs_g_Soldier_exp_F") then {[_x] execVM "scripts\poseMines.sqf";};
			} forEach units _groupe;
			
			BwS_var_unites_de_caserne pushBack _groupe;
			// cool down de BwS_var_cooldown_production_unites_pedestres
			_caserne setVariable ["BwS_var_quand_produire", time+BwS_var_cooldown_production_unites_pedestres];
		};
		
		// si caserne détruite et qu'on est dans la proba de reconstruire et qu'elle n'est pas déjà en reconstruction
		if (damage _caserne >= 1) then
		{
			if ((_caserne getVariable ["BwS_var_en_reconstruction", false]) && (time > _caserne getVariable ["BwS_var_fin_de_reconstruction", 0])) then
			{
				_caserne setDamage 0;
				_caserne setVariable ["BwS_var_en_reconstruction", false];
			};
			
			if (!(_caserne getVariable ["BwS_var_en_reconstruction", false])) then // si on doit la reconstruire et qu'elle n'est pas déjà en reconstruction
			{
				if (random 1 > BwS_var_probabilite_caserne_detruite_pour_toujours) then
				{
					// cool down de BwS_var_cooldown_de_reconstruction_casernes
					_caserne setVariable ["BwS_var_en_reconstruction", true];
					_caserne setVariable ["BwS_var_fin_de_reconstruction", time+BwS_var_cooldown_de_reconstruction_casernes];
				}
				else 
				{
					BwS_casernes = BwS_casernes - [_caserne];
				};
			};
		};
	} forEach BwS_casernes;	
	
	{
		_usine = _x;
		if ((damage _usine < 1) && ([_usine] call BwS_fn_faut_il_produire_des_vehicules) && time > (_usine getVariable ["BwS_var_quand_produire", 0])) then // a changer
		{
			// creation d'un vehicule
			_types = [["rhs_t72bb_chdkz", 1],
					["rhs_bmd1_chdkz", 2],
					["rhs_btr70_chdkz", 3],
					["rhs_uaz_ags_chdkz", 3],
					["rhs_ural_chdkz", 4]];
			
			_safePos = [(position _usine), 1, 100, 3, 0, -1, 0] call BIS_fnc_findSafePos;
			_vehicule = createVehicle [([_types] call BwS_fn_pick_random), _safePos, [], 25, "NONE"];

			createVehicleCrew _vehicule;
			_groupe = group driver _vehicule;
		
			_groupePassager = [[0,0,0], (_vehicule emptyPositions "cargo"), BwS_var_side_ennemie, BwS_var_side_ennemie] call BwS_fn_spawnGroup;
			{[_x] join _groupe; _x moveInCargo _vehicule;} forEach units _groupePassager;
		
			BwS_var_unites_d_usine pushBack _groupe;
		
			// cool down de BwS_var_cooldown_production_unites_motorisees
			_usine setVariable ["BwS_var_quand_produire", time+BwS_var_cooldown_production_unites_motorisees];
		};
		
		// si usine détruite et qu'on est dans la proba de reconstruire
		if (damage _usine >= 1) then
		{
			if ((_usine getVariable ["BwS_var_en_reconstruction", false]) && (time > _usine getVariable ["BwS_var_fin_de_reconstruction", 0])) then
			{
				_usine setDamage 0;
				_usine setVariable ["BwS_var_en_reconstruction", false];
			};
			
			if (!(_usine getVariable ["BwS_var_en_reconstruction", false])) then // si elle n'est pas déjà en reconstruction
			{
				if (random 1 > BwS_var_probabilite_caserne_detruite_pour_toujours) then // s'il faut la reconstruire
				{
					// cool down de BwS_var_cooldown_de_reconstruction_casernes
					_usine setVariable ["BwS_var_en_reconstruction", true];
					_usine setVariable ["BwS_var_fin_de_reconstruction", time+BwS_var_cooldown_de_reconstruction_usines];
				}
				else // sinon elle est retirée des usines
				{
					BwS_usines = BwS_usines - [_usine];
				};
			};
		};
	} forEach BwS_usines;
	
	sleep 30;
};