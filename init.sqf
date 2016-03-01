_R3F_AI = execVM "R3F_AiComTarget\init.sqf";
_R3F_LOG = execVM "R3F_LOG\init.sqf";
_TFR = execVM "Inits\initTFR.sqf";

waituntil {scriptdone _R3F_AI && scriptdone _R3F_LOG && scriptdone _TFR};

//[] spawn {call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";};

if (isServer) then
{
	// Suppression des cadavres des joueurs déconnectés
	addMissionEventHandler ["HandleDisconnect", {deleteVehicle (_this select 0); false}];

	execVM "Inits\initCaisses.sqf";
};