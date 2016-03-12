
// Création d'un binôme : chacun un sac.

private ["_vehicule"];

// _vehicule = _this select 0;

// _eastHQ = createCenter east; _group = createGroup _eastHQ;

_position = position (selectRandom ROADS);
_position set [0, (_position select 0)-300+random(600)];
_position set [1, (_position select 1)-300+random(600)];

_vehicle = "rhs_2b14_82mm_ins" createVehicle _position;
createVehicleCrew _vehicle;

_group = group gunner _vehicle;

"O_G_Soldier_lite_F" createUnit [_position, _group, "", 1];
// "O_G_Soldier_lite_F" createUnit [_position, _group, "", 1];

// sleep 0.1;

// _porteur1 = units _group select 0; 
// _porteur2 = units _group select 1;

// _porteur1 addBackpack "O_Mortar_01_support_F";
// _porteur2 addBackpack "O_Mortar_01_weapon_F";

// _positionDeposeMortier = [(position leader _group select 0) - 50 + random 100, (position leader _group select 1) -50 + random 100, 0];

// _group move _positionDeposeMortier;

// waitUntil { unitReady _porteur1 && unitReady _porteur2 };
// sleep 5;

// if (alive _porteur1 && alive _porteur2) then 
// {
	// Dépose du mortier, montage
	// _porteur1 action ["DropBag", _porteur2, typeOf unitBackpack _porteur1];
	// sleep 3;
	// _porteur2 action ["Assemble", (nearestObject [_porteur2, "O_Mortar_01_support_F"])];

	// sleep 10;
	// L'un monte dans le mortier.

	// _mortier = (nearestObject [_porteur2, "O_Mortar_01_F"]);
	// _porteur2 moveInGunner _mortier;
// }
// else
// {
	// [_group, position leader _group, 500] call BIS_fnc_taskPatrol;
// };

if (BwS_Debug) then { ["mortier", position leader _group, "ColorRed"] spawn BwS_fn_creerMarqueur; };

{	[_x] spawn BwS_fn_gestion_radio;	} forEach units _group;

[_vehicle] spawn BwS_fn_gestionArty;