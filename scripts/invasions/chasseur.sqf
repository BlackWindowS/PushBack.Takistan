scriptName "BwS_fn_chasseur";
["Un chasseur a ete spawn"] spawn BwS_fn_diag_log;

private ["_chasseur", "_cible", "_vehicles", "_type"];

// spawn un chasseur

_vehicles = ["RHS_Mi8amt_chdkz"];

_type = _vehicles select (floor (random count _vehicles));

_chasseur = createVehicle [_type, [0, 0, 1000], [], 1000, "FLY"];
createVehicleCrew _chasseur;

// le fait aller sur n'imp quel joueur et l'engage

_cible = selectRandom allPlayers;

(driver _chasseur) reveal [_cible, 4];

(driver _chasseur) move position _cible;

(driver _chasseur) doFire _cible;

_wp = (group driver _chasseur) addWaypoint [_cible, 0];
_wp setWaypointType "DESTROY"; 

{	[_x] spawn BwS_fn_gestion_radio;	} forEach crew _chasseur;