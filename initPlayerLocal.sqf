fn_clr = {private ["_player"]; _player = _this select 0; _player unassignItem "NVGoggles"; removeAllWeapons _player; removeAllItems _player; removeVest _player; removeBackpack _player;};

[player] call fn_clr;

BwS_compilation_client = [] execVM "scripts\compilation_client.sqf";

waitUntil {scriptDone BwS_compilation_client};
nul = [] execVM "scripts\FOB.sqf";
nul = [] execVM "gestions\COPs_client.sqf";
nul = [] execVM "Inits\initFOBs.sqf";

BwS_MUTEX_action_en_cours = false;
BwS_MUTEX_peut_rejoindre_champ_de_bataille = true;

["MyID", "OnTangent", {
	_unit = _this select 0;
	_est_en_train_de_parler = _this select 4;
	_unit setVariable ["BwS_var_est_en_train_de_transmettre", _est_en_train_de_parler, true];
}, player] call TFAR_fnc_addEventHandler;

player addEventHandler ["FiredNear", {[] spawn {BwS_thirdPerson_allowed = false; sleep 120; BwS_thirdPerson_allowed = true;}}];

["EH_gestion_3rd_personne", "onEachFrame", 
{	
	if (!BwS_thirdPerson_allowed) then 
	{
		if (cameraView == "EXTERNAL") then 
		{	
			player switchCamera "INTERNAL";
		};
	};
}, []] call BIS_fnc_addStackedEventHandler; 

// ["EH_gestion_simulation_IA", "onEachFrame", 
// {	
	// {
		// if (side _x == resistance) then
		// {
			// if ((_x distance player) < 2000) then
			// {
				// _x enableSimulation true;
			// }
			// else
			// {
				// _x enableSimulation false;
			// };
		// };
	// } forEach ((position player) nearEntities ["Man", 3000]);
// }, []] call BIS_fnc_addStackedEventHandler; 