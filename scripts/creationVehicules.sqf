private ["_typesDeVehicules", "_objet"];

_objet = (_this select 0);

_typesDeVehicules = [
	"B_Heli_Attack_01_F",
	"B_APC_Wheeled_01_cannon_F",
	"B_MRAP_01_F",
	"B_MRAP_01_hmg_F",
	"B_MRAP_01_gmg_F",
	"B_Heli_Transport_01_F",
	"B_Plane_CAS_01_F",
	"B_Heli_Light_01_F",
	"B_Heli_Light_01_armed_F",
	"B_APC_Tracked_01_rcws_F",
	"B_Quadbike_01_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_TUSK_F",
	"B_APC_Tracked_01_AA_F"];

{
	
	_objet addAction [
		format ["Créer %1", (getText(configFile >> "CfgVehicles" >> _x >> "displayName"))],
		{
			createVehicle [((_this select 3) select 0), markerPos "respawn_vehicle_west", [], 0, "NONE"];
		},
		[_x],
		1.5
	];
	
} forEach _typesDeVehicules;