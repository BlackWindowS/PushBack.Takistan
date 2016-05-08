scriptName "BwS_fn_patrolTeam";
// Création d'une équipe d'infanterie puis qui patrouille

private ["_group", "_position"];

_position = position (selectRandom ROADS);

_group = [_position, (3 + floor(random 6)), resistance, resistance] call BwS_fn_spawnGroup;

// Mines
{
	if (typeOf _x == "B_G_soldier_exp_F" || typeOf _x == "O_soldier_exp_F" || typeof _x == "rhs_g_Soldier_exp_F") then {[_x] execVM "scripts\poseMines.sqf";};
} forEach units _group;

// Patrouille 
if (BwS_Debug) then { ["patrouille", _position, "ColorGreen"] spawn BwS_fn_creerMarqueur; };

// [_group] spawn BwS_fn_gestionPatrol;