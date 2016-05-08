scriptName "BwS_fn_vehicleDrop";
_veh = createVehicle ["O_Heli_Transport_04_F", [0, 0, 0], [], 1000, "FLY"];
createVehicleCrew _veh;

// création de l'ifrit
_eastHQ = createCenter east;
_group = createGroup _eastHQ;

_ifrit = createVehicle ["rhs_uaz_dshkm_chdkz", [0, 0, 0], [], 1000, "NONE"];
_veh setSlingLoad _ifrit;

_pos = position (selectRandom ROADS);
_pos set [2, 0];
_destination = _pos;

_veh commandMove _destination;

_veh flyInHeight 200;
waitUntil {((driver _veh) distance (_destination)) <= 200};

_veh setSlingLoad objNull;

_veh move [0, 0, 0];
sleep 3;
createVehicleCrew _ifrit;
_ifrit setDamage 0;
_group = [[0, 0, 0], 4, resistance, resistance] call BwS_fn_spawnGroup;

{_x moveInCargo _ifrit} forEach units _group;

[driver _ifrit] join _group;

sleep 15;
// _gestion = [_group] spawn BwS_fn_gestionPatrolSoftMoyen;

{	[_x] spawn BwS_fn_gestion_radio;	} forEach crew _ifrit;

while {alive driver _ifrit} do {
	driver _ifrit move position (selectRandom ROADS);
	waituntil {unitReady driver _ifrit};
	_ifrit setFuel 1;
	sleep 1;
};