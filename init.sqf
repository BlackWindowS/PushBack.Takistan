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

// ----------------------- 2 HC ----------------------
BwS_HC_0_present = if (isNil "headless_client_0") then {false} else {true};
BwS_HC_1_present = if (isNil "headless_client_1") then {false} else {true};

if (BwS_HC_0_present && isMultiplayer) then 
{
	if (!isServer && !hasInterface) then 
	{
		// on est chez le HC 0
		nul = [] execVM "scripts\invasions\loop.sqf"; 
	};
};

if (BwS_HC_1_present && isMultiplayer) then 
{
	if (!isServer && !hasInterface) then 
	{
		// on est chez le HC 1
		// homed, patrouilles, etc
		_occupation = [] spawn BwS_fn_occupation;
		waituntil {scriptDone _occupation};
		diag_log "Occupation Terminée";
	};
};
	