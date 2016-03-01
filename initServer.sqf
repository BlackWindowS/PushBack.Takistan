diag_log "/*********************** SERVEUR DEMARRE ***********************\";
"ia773" serverCommand "#lock";
diag_log "/*************************** FERMETURE DU SERVEUR ***************************\";

BwS_joueurs_russes = []; 
BwS_joueurs_americains = [];
BwS_joueurs_BwS = ["76561198059264494", "76561198067811595", "76561198090076779", "76561198091898451", "76561198118269478", "76561198181657685", "76561198232946924"];

BwS_nombre_COP_americaines = 0;
BwS_nombre_COP_russes = 0;

publicVariable "BwS_joueurs_BwS";

BwS_Debug = true;
BwS_COS = false; // ce sont 2 systemes de peuplement : DCL et COS
BwS_DCL = !BwS_COS;

if (!isDedicated) then {BwS_nombreJoueurs = 1} else {BwS_nombreJoueurs = count playableUnits};

_compil = [] execVM "scripts\compilation_serveur.sqf";

waituntil {scriptdone _compil};

nul = [] execVM "gestions\COPs_serveur.sqf";
nul = [] execVM "Inits\initCOPs.sqf";
// nul = [] execVM "scripts\eclairage.sqf";
// nul = [] execVM "scripts\protectionBase.sqf";
// nul = [] execVM "scripts\surveillerServeur.sqf";
// nul = [markerPos "COS"] execVM "scripts\HQ\COS.sqf"; // Commandement des OP Spéciales et non le système de peuplement

_centerMap = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
ROADS = (_centerMap nearRoads 20000) - ((getMarkerPos "PC") nearRoads 1000) - ((getMarkerPos "PC_1") nearRoads 2000);

sleep 1;

// _peuplement = scriptNull;
// if (BwS_COS) then {_peuplement = [] execVM "cos\cosInit.sqf";} else {_peuplement = [] execVM "DCL\init.sqf";};
// waituntil {scriptdone _peuplement};

// nul = [] execVM "gestions\gestion_secteurs.sqf";
nul = [] execVM "invasions\loop.sqf"; 

[] spawn { while {true} do {execVM "scripts\purgeur.sqf"; sleep 5000}; };

diag_log "/*********************** FIN initServer.sqf ***********************\";