
BwS_compilation_client = [] execVM "scripts\systemes\compilation_client.sqf";

waitUntil {scriptDone BwS_compilation_client};

if (hasInterface) then 
{
	fn_clr = {private ["_player"]; _player = _this select 0; _player unassignItem "NVGoggles"; removeAllWeapons _player; removeAllItems _player; removeVest _player; removeBackpack _player;};

	[player] call fn_clr;

	nul = [] execVM "scripts\FOB.sqf";
	nul = [] execVM "scripts\gestions\COPs_client.sqf";
	nul = [] execVM "Inits\initFOBs.sqf";

	BwS_MUTEX_action_en_cours = false;
	BwS_MUTEX_peut_rejoindre_champ_de_bataille = true;

	["TFAR_EH_communique", "OnTangent", {
		_unit = _this select 0;
		_est_en_train_de_parler = _this select 4;
		_unit setVariable ["BwS_var_est_en_train_de_transmettre", _est_en_train_de_parler, true];
	}, player] call TFAR_fnc_addEventHandler;

	player addEventHandler ["FiredNear", {[] spawn {BwS_thirdPerson_allowed = false; sleep 120; BwS_thirdPerson_allowed = true;}}];

	["BwS_EH_gestion_3rd_personne", "onEachFrame", 
	{	
		if (!BwS_thirdPerson_allowed) then 
		{
			if (cameraView == "EXTERNAL") then 
			{	
				player switchCamera "INTERNAL";
			};
		};
	}, []] call BIS_fnc_addStackedEventHandler; 
	
	joueurDroniste = false;
	joueurEOD = false;
	joueurPilote = false;
	
	if ((player getVariable "pilote") isEqualTo true) then {joueurPilote = true;};
	if ((player getVariable "AGM_isEOD") isEqualTo true) then {joueurEOD = true;};
	if ((player getVariable "droniste") isEqualTo true) then {joueurDroniste = true;};
	
	nul = [] execVM "scripts\systemes\addActions.sqf";
};