scriptName "BwS_fn_motorizedPatrolTeam";
// Création d'un pick up armé et de son équipage
private ["_group", "_positionOnRoad", "_positionGroup"];

_positionOnRoad = position (selectRandom ROADS);

sleep 0.01;
_tab = ["rhs_btr70_chdkz", "rhs_btr60_chdkz", "rhs_t72bb_chdkz", "RHS_UAZ_chdkz", "rhs_uaz_dshkm_chdkz", "rhs_uaz_ags_chdkz"];

_veh = (selectRandom _tab) createVehicle _positionOnRoad;

createVehicleCrew _veh;
_group = group driver _veh;

_groupePassager = [[0,0,0], (_veh emptyPositions "cargo"), BwS_var_side_ennemie, BwS_var_side_ennemie] call BwS_fn_spawnGroup;
{[_x] join _group; _x moveInCargo _veh;} forEach units _groupePassager;

BwS_var_unites_d_usine pushBack _group;

_positionGroup = position driver _veh;

if (BwS_Debug) then { ["pick up", _positionGroup] spawn BwS_fn_creerMarqueur; };

// [_group] spawn BwS_fn_gestionPatrolSoftMoyen; 

{	[_x] spawn BwS_fn_gestion_radio;	} forEach crew _veh;

while {alive driver _veh} do {
	driver _veh move position (selectRandom ROADS);
	waituntil {unitReady driver _veh};
	_veh setFuel 1;
	sleep 1;
};

