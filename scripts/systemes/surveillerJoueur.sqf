JOUEUR_EST_DANS_PC = {((player distance (nearestObject [player, "Land_Cargo_Tower_V1_F"])) < 10) && ((getPosATL player select 2) > 12) && (playerInHQ isEqualTo false) && ((((getMarkerPos "PC") distance (position player)) < 20) || (((getMarkerPos "PC_1") distance (position player)) < 20))};

#define CONDITION_DRONISTE ((("B_UavTerminal" in (items player + assignedItems player)) || ("O_UavTerminal" in (items player + assignedItems player))) && !joueurDroniste)

#define CONDITION_INTERDICTION_UAV (backpack player == "B_UAV_01_backpack_F") || (backpack player == "O_UAV_01_backpack_F") || (backpack player == "I_UAV_01_backpack_F") || (backpack player == "B_rhsusf_B_BACKPACK")

#define CONDITION_TWS ("Weapon_optic_tws" in (primaryWeaponItems player)) || ("Weapon_optic_tws_mg" in (primaryWeaponItems player)) 

#define CONDITION_JUMELLES ("ACE_MX2A" in [(binocular player)])

#define CONDITION_PILOTE ((vehicle player) isKindOf "Air" && !(joueurPilote) && (driver vehicle player == player) && !(typeOf vehicle player isEqualTo "Steerable_Parachute_F"))

startLoadingScreen ["Chargement en cours"];

waitUntil {scriptDone BwS_compilation_client};

/*---------- Initialisation des variables ------------*/
playerInHQ = false;

joueurDroniste = false;
joueurEOD = false;
joueurPilote = false;

if ((player getVariable "pilote") isEqualTo true) then {joueurPilote = true;};
if ((player getVariable "AGM_isEOD") isEqualTo true) then {joueurEOD = true;};
if ((player getVariable "droniste") isEqualTo true) then {joueurDroniste = true;};

_UIDs = ["_SP_PLAYER_", "76561198118269478", "76561198067811595"];

if (getplayeruid player in _UIDs) then {player addAction ["MENU ADMIN", {showCommandingMenu "#USER:BwS_MENU_ADMIN"}, [], 1, false, true, ""];};

onMapSingleClick "_shift";

[] spawn {
	while {alive player} do {
		if ((vehicle player == FOBa) ||
			(vehicle player == FOBb)) then 
		{	
			if !(player getVariable ["tf_unable_to_use_radio", false]) then 
			{
				BwS_script_vehiculeRadar = [] execVM "scripts\vehiculeRadar.sqf";
				waitUntil {scriptDone BwS_script_vehiculeRadar};	
				BwS_marqueur_brouillage setMarkerAlphaLocal 0;
			}
			else
			{
				BwS_marqueur_brouillage setMarkerAlphaLocal 1;
				BwS_marqueur_brouillage setMarkerPos (position vehicle player);
			};
		};
		sleep 0.01;
	};
};

[] spawn {
	BwS_MUTEX_peut_rejoindre_champ_de_bataille = false;
	// _futur = time + 120;
	// waitUntil {hintSilent format ["%1:%2 avant TP possible", floor ((_futur-time)/60), floor ((_futur-time)%60)]; sleep 1; time >= _futur}; 
	BwS_MUTEX_peut_rejoindre_champ_de_bataille = true;
	hint "TP possible";
};

waituntil {preloadCamera position player};
endLoadingScreen;

player disableTIEquipment true;

while {alive player} do
{
	[player, "OperationPushBack"] call BIS_fnc_setUnitInsignia;
	
	if (call JOUEUR_EST_DANS_PC) then
	{
		[player] execVM "scripts\HQ\HQ.sqf";
		playerInHQ = true;
		
		// player addItemToBackpack "item_R3F_SIT_COMDE";
		
		waitUntil {((player distance (nearestObject [player, "Land_Cargo_Tower_V1_F"])) > 10) || ((getPosATL player select 2) < 12)};
		
		playerInHQ = false;
		// player removeItemFromBackpack "item_R3F_SIT_COMDE";
		// removeBackpack player;
	};
	
	if (CONDITION_DRONISTE) then // Pour le slot droniste
	{
		hintC "Vous devez être droniste pour contrôler un drone !";
		player unassignItem "B_UavTerminal";
		player unassignItem "O_UavTerminal";
		player removeItem "B_UavTerminal";
		player removeItem "O_UavTerminal";
	};
	
	if (CONDITION_INTERDICTION_UAV) then
	{
		removeBackpack player;
		hintC "Les UAV sont interdits via l'arsenal.";
	};
	
	if (CONDITION_TWS) then
	{
		player removePrimaryWeaponItem "Weapon_optic_tws";
		player removePrimaryWeaponItem "Weapon_optic_tws_mg";
		hintC "TWS interdites.";
	};
	
	if (CONDITION_JUMELLES) then
	{
		player removeWeapon (binocular player);
	};
	
	if (CONDITION_PILOTE) then {moveOut player; hintC "Vous devez être pilote !"; }; // on jarte du véhicule s'il n'est pas pilote
		
	showChat true;
		
	// ouverture automatique de barrière
	
	if ((player distance (nearestObject [player, "Land_BarGate_F"])) < 8) then
	{
		[] spawn { (nearestObject [player, "Land_BarGate_F"]) animate ["Door_1_rot", 1]; sleep 5; (nearestObject [player, "Land_BarGate_F"]) animate ["Door_1_rot", 0]; };
	};
	
	call BwS_fn_brouillage_local;
	
	sleep 0.1;
};