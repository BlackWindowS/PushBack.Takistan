diag_log "/*********************** SERVEUR DEMARRE ***********************\";
"ia773" serverCommand "#lock";
diag_log "/*************************** FERMETURE DU SERVEUR ***************************\";

BwS_joueurs_BwS = ["76561198059264494", "76561198067811595", "76561198090076779", "76561198091898451", "76561198118269478", "76561198181657685", "76561198232946924"];

publicVariable "BwS_joueurs_BwS";

BwS_Debug = true;
BwS_COS = false; // ce sont 2 systemes de peuplement : DCL et COS
BwS_DCL = !BwS_COS;

BwS_casernes = [];
BwS_usines = [];

BwS_var_groupes_a_exclure = [];
BwS_var_groupes_a_exclure_simulation = [];
BwS_var_unites_de_caserne = [];
BwS_var_unites_d_usine = [];

BwS_IEDs = [];

if (!isDedicated) then {BwS_nombreJoueurs = 1} else {BwS_nombreJoueurs = count playableUnits};

_compil = [] execVM "scripts\systemes\compilation_serveur.sqf";

waituntil {scriptdone _compil};

nul = [] execVM "scripts\gestions\COPs_serveur.sqf";
nul = [] execVM "Inits\FOBs_serveur.sqf";
nul = [] execVM "Inits\initCOPs.sqf";
// nul = [] execVM "scripts\missions\loop.sqf";
// nul = [] execVM "scripts\eclairage.sqf";
// nul = [] execVM "scripts\protectionBase.sqf";
nul = [] execVM "scripts\systemes\surveillerServeur.sqf";
// nul = [markerPos "COS"] execVM "scripts\HQ\COS.sqf"; // Commandement des OP Spéciales et non le système de peuplement

_centerMap = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
ROADS = (_centerMap nearRoads 20000) - ((getMarkerPos "PC") nearRoads 1000) - ((getMarkerPos "PC_1") nearRoads 2000);

sleep 1;

[] spawn { while {true} do {execVM "scripts\purgeur.sqf"; sleep 5000}; };

[conteneur, arsenal1, remise1] execVM "inits\initConteneur.Sqf";
[conteneur2, arsenal2, remise2] execVM "inits\initConteneur.Sqf";

nul = [arsenal1, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [remise1, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [arsenal2, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [remise2, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";

nul = [conteneur, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";
nul = [conteneur2, "respawn_vehicle_west"] execVM "R3F_LOG\USER_FUNCT\do_not_lose_it.sqf";

_peuplement = scriptNull;
if (BwS_COS) then {_peuplement = [] execVM "cos\cosInit.sqf";} else {_peuplement = [] execVM "DCL\init.sqf";};
waituntil {scriptdone _peuplement};

nul = [] execVM "scripts\invasions\loop.sqf"; 

// homed, patrouilles, etc
_occupation = [] spawn BwS_fn_occupation;
systemChat "Occupation en cours";
waituntil {scriptDone _occupation};
diag_log "Occupation Terminée";

diag_log "/*********************** FIN initServer.sqf ***********************\";
"ia773" serverCommand "#unlock";
diag_log "/*************************** RE-OUVERTURE DU SERVEUR ***************************\";