["Un vhicule aerien a ete spawn"] spawn BwS_fn_diag_log;

private ["_randomPos", "_veh", "_types"];
// spawn d'un vehicule aerien
_randomPos = position (selectRandom ROADS);
_randomPos set [2, 1000];

_types = ["RHS_Mi8amt_chdkz"];
_veh = createVehicle [(selectRandom _types), _randomPos, [], 0, "FLY"];
createVehicleCrew _veh;

if (BwS_Debug) then { ["aeronef", _randomPos, "ColorRed"] spawn BwS_fn_creerMarqueur; };

// gestionPatrolSoftMoyen
// [group driver _veh] spawn BwS_fn_gestionPatrolSoftMoyen;

// BIS_fnc_taskPatrol 10 km
[group driver _veh, _randomPos, 10000] call BIS_fnc_taskPatrol;

{	[_x] spawn BwS_fn_gestion_radio;	} forEach crew _veh;