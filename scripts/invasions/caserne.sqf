/*
Ce script gère la production d'unités dans des casernes

Les casernes peuvent être totalement détruites ou bien reconstruites au bout d'un temps définit par BwS_var_cooldown_de_reconstruction_casernes

[] spawn BwS_fn_caserne;

*/

private ["_caserne", "_continuer"];

// creation d'une caserne position aléatoire
_positionCaserne = position (selectRandom ROADS);

_positionCaserne set [0, (_positionCaserne select 0) - 200 + random 400];
_positionCaserne set [1, (_positionCaserne select 1) - 200 + random 400];

_caserne = "Land_i_Barracks_V1_F" createVehicle _positionCaserne;
_caserne setDir (random 360);

_caserne setVectorUp surfaceNormal position _caserne;
_caserne setPosATL [position _caserne select 0, position _caserne select 1, 0.5];

BwS_casernes pushBack _caserne;
publicVariable "BwS_casernes";

// marqueur pour debug
if (BwS_Debug) then { ["caserne", _positionCaserne, "ColorBlue"] spawn BwS_fn_creerMarqueur; };

// boucle tant random 1 > BwS_var_probabilite_caserne_detruite_pour_toujours
_continuer = true;
while {_continuer} do
{
	// si damage caserne < 1 && presence de joueurs
	if ((damage _caserne < 1) && ([_caserne] call BwS_fn_faut_il_produire_des_pedestres)) then
	{
		// creation de groupe(s) de combat
		_groupe = ([(_caserne buildingPos floor(random(count([_caserne] call BIS_fnc_buildingPositions)))), 3 + floor(random 6) , resistance, resistance] call BwS_fn_spawnGroup);
		{
			if (typeOf _x == "B_G_soldier_exp_F" || typeOf _x == "O_soldier_exp_F" || typeof _x == "rhs_g_Soldier_exp_F") then {[_x] execVM "scripts\poseMines.sqf";};
		} forEach units _groupe;
		
		BwS_var_unites_de_caserne pushBack _groupe;
		// cool down de BwS_var_cooldown_production_unites_pedestres
		sleep BwS_var_cooldown_production_unites_pedestres;
	};
	
	// si caserne détruite et qu'on est dans la proba de reconstruire
	if (damage _caserne >= 1) then
	{
		if (random 1 > BwS_var_probabilite_caserne_detruite_pour_toujours) then 
		{
			// cool down de BwS_var_cooldown_de_reconstruction_casernes
			sleep BwS_var_cooldown_de_reconstruction_casernes;
			
			// caserne setDamage 0
			_caserne setDamage 0;
		}
		else 
		{
			_continuer = false;
		};
	};
	
	// temporisation
	sleep 30;
};