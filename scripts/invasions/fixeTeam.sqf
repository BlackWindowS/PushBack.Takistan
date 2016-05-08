scriptName "BwS_fn_fixeTeam";
// @param 1 : vehicule où sont créées les unités

// Création d'un binôme : chacun un sac.

private ["_vehicule"];

_vehicule = _this select 0;

_eastHQ = createCenter east;
_group = createGroup _eastHQ;

"rhs_g_Soldier_F" createUnit [[0, 0, 1000], _group, "porteur1 = this", 1];
"rhs_g_Soldier_F" createUnit [[0, 0, 1000], _group, "porteur2 = this", 1];

_porteur1 = porteur1;
_porteur2 = porteur2;

_porteur1 moveInCargo _vehicule; 
_porteur2 moveInCargo _vehicule; 

// On attend qu'ils aillent jusqu'à leur destination
private ["_initWP"];
_initWP = currentWaypoint group _vehicule;
waitUntil { (_initWP < (currentWaypoint group _vehicule)) };

// Débarquement
_group leaveVehicle _vehicule;
_positionGroup = position leader _group;
_positionDeposeMortier = [(_positionGroup select 0) - 50 + random 100, (_positionGroup select 1) -50 + random 100, 0];

_group move _positionDeposeMortier;

_porteur1 addBackpack "O_HMG_01_support_high_F";
_porteur2 addBackpack "O_HMG_01_high_weapon_F";

waitUntil { unitReady _porteur1 && unitReady _porteur2 };
sleep 5;

if (alive _porteur1 && alive _porteur2) then 
{
	// Dépose du fixe, montage
	_porteur1 action ["DropBag", _porteur2, typeOf unitBackpack _porteur1];
	sleep 3;
	_porteur2 action ["Assemble", (nearestObject [_porteur2, "O_HMG_01_support_high_F"])];

	sleep 10;
	// L'un monte dans le fixe.

	_fixe = (nearestObject [_porteur2, "O_HMG_01_high_F"]);
	_porteur2 moveInGunner _fixe;

}
else
{
	[_group, position leader _group, 50] call BIS_fnc_taskPatrol;
};

{	[_x] spawn BwS_fn_gestion_radio;	} forEach units _group;