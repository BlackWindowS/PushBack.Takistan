// Création d'un pick up armé et de son équipage
private ["_group", "_positionOnRoad", "_positionGroup"];

_positionOnRoad = position (selectRandom ROADS);

sleep 0.01;
_tab = ["rhs_btr70_chdkz", "rhs_btr60_chdkz", "rhs_t72bb_chdkz", "RHS_UAZ_chdkz", "rhs_uaz_dshkm_chdkz", "rhs_uaz_ags_chdkz"];

_veh = (selectRandom _tab) createVehicle _positionOnRoad;

createVehicleCrew _veh;
_group = group driver _veh;

_positionGroup = position driver _veh;

if (BwS_Debug) then { ["pick up", _positionGroup] spawn BwS_fn_creerMarqueur; };

[_group] spawn BwS_fn_gestionPatrolSoftMoyen; 

{	[_x] spawn BwS_fn_gestion_radio;	} forEach crew _veh;

while {alive driver _veh} do {
	driver _veh move position (selectRandom ROADS);
	waituntil {unitReady driver _veh};
	_veh setFuel 1;
	sleep 1;
};

