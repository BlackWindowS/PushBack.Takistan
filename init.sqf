_R3F_AI = execVM "R3F_AiComTarget\init.sqf";
_R3F_LOG = execVM "R3F_LOG\init.sqf";
_TFR = execVM "Inits\initTFR.sqf";

waituntil {scriptdone _R3F_AI && scriptdone _R3F_LOG && scriptdone _TFR};

//[] spawn {call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";};

[conteneur, arsenal1, remise1] execVM "inits\initConteneur.Sqf";
[conteneur2, arsenal2, remise2] execVM "inits\initConteneur.Sqf";
[conteneur1_1, arsenal1_1, remise1_1] execVM "inits\initConteneur.Sqf";
[conteneur2_1, arsenal2_1, remise2_1] execVM "inits\initConteneur.Sqf";

nul = [arsenal1, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [remise1, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [arsenal2, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [remise2, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";

nul = [conteneur, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [conteneur2, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [conteneur1_1, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [conteneur2_1, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";

nul = [arsenal1_1, "respawn_vehicle_east"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [remise1_1, "respawn_vehicle_east"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [arsenal2_1, "respawn_vehicle_east"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [remise2_1, "respawn_vehicle_east"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";

if (isServer) then
{
	// Suppression des cadavres des joueurs déconnectés
	addMissionEventHandler ["HandleDisconnect", {deleteVehicle (_this select 0); false}];

	execVM "Inits\initCaisses.sqf";
};