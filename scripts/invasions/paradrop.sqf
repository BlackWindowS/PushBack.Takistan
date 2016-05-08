scriptName "BwS_fn_paradrop";
["Un paradrop a ete spawn"] spawn BwS_fn_diag_log;

private ["_randomPos", "_eastHQ", "_group", "_veh", "_cible", "_destination", "_delay"];

_randomPos = [10000 - random(10000), (-300) - random(1000), 1000];

_veh = createVehicle ["O_Heli_Light_02_unarmed_F", _randomPos, [], 1000, "FLY"];
createVehicleCrew _veh;

// création des paras

_eastHQ = createCenter east; _group = createGroup _eastHQ;

for "_i" from 0 to 7 do
{
	"O_soldier_PG_F" createUnit [[0, 0, 10000], _group, "", 1];
	(units _group select _i) moveInCargo _veh;
	sleep 0.01;
};

_veh flyInHeight (200 + random 100);

// parachutage lorsque WP accompli
_cible = selectRandom ROADS;

_pos = position _cible;
_pos set [2, 0];
_destination = _pos;
(driver _veh) move _destination;

waitUntil {unitReady driver _veh};
group _veh move _randomPos;
sleep 5;
_delay = 1;
{
	[_x] spawn BwS_fn_gestion_radio;
	unassignVehicle _x;
	_x action ["Eject", vehicle _x];
	sleep 0.01;
	_x action ["OpenParachute", _x];
	sleep _delay;

} forEach (units _group);
[_group, position leader _group, 500] call BIS_fnc_taskPatrol;
// [_group] spawn BwS_fn_gestionPatrol;

// retour de l'helico
waitUntil { unitReady driver _veh };

{_veh deleteVehicleCrew _x; } forEach crew _veh;
deleteVehicle _veh;