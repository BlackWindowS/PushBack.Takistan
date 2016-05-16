private ["_brouilleur", "_group", "_position", "_distance_de_brouillage"];
_position = _this select 0;

if (BwS_Debug) then { ["brouilleur", _position, "ColorBlue"] spawn BwS_fn_creerMarqueur; };
// cr�ation de l'objet
_brouilleur = "Land_JetEngineStarter_01_F" createVehicle _position;

// cr�ation de sentinelles
_group = [_position, 2, BwS_var_side_ennemie, BwS_var_side_ennemie] call BwS_fn_spawnGroup;

// rayon 3 kilom�tres ou equivalent
_distance_de_brouillage = 1500 + random 1500;

_brouilleur setVariable ["BwS_var_distance_de_brouillage", _distance_de_brouillage, true];
