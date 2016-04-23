call compile preprocessFile "scripts\systemes\fonctions_serveur.sqf";

call compile preprocessFile "scripts\RADIO\fonctions.sqf";
BwS_fn_brouilleur = compile preprocessFile "scripts\RADIO\brouilleur.sqf";

BwS_fn_base = compile preprocessFile "scripts\invasions\base.sqf";
BwS_fn_camp = compile preprocessFile "scripts\invasions\camp.sqf";
BwS_fn_char = compile preprocessFile "scripts\invasions\char.sqf";
BwS_fn_raid = compile preprocessFile "scripts\invasions\raid.sqf";
BwS_fn_usines = compile preprocessFile "scripts\invasions\usine.sqf";
BwS_fn_convois = compile preprocessFile "scripts\invasions\convois.sqf";
BwS_fn_caserne = compile preprocessFile "scripts\invasions\caserne.sqf";
BwS_fn_mortier = compile preprocessFile "scripts\invasions\mortarTeam.sqf";
BwS_fn_airfield = compile preprocessFile "scripts\invasions\airfield.sqf";
BwS_fn_chasseur = compile preprocessFile "scripts\invasions\chasseur.sqf";
BwS_fn_paradrop = compile preprocessFile "scripts\invasions\paradrop.sqf";
BwS_fn_occupation = compile preprocessFile "scripts\invasions\occupation.sqf";
BwS_fn_patrolTeam = compile preprocessFile "scripts\invasions\patrolTeam.sqf";
BwS_fn_gestionArty = compile preprocessFile "scripts\invasions\artillerie.sqf";
BwS_fn_vehicleDrop = compile preprocessFile "scripts\invasions\vehicleDrop.sqf";
BwS_fn_aerialPatrol = compile preprocessFile "scripts\invasions\aerialPatrol.sqf";
BwS_fn_gestionPatrol = compile preprocessFile "scripts\invasions\gestionPatrouille.sqf";
BwS_fn_gestionPatrolSoft = compile preprocessFile "scripts\invasions\gestionPatrouilleSoft.sqf";
BwS_fn_motorizedPatrolTeam = compile preprocessFile "scripts\invasions\motorizedPatrolTeam.sqf";
BwS_fn_gestionPatrolSoftMoyen = BwS_fn_gestionPatrol;

BwS_fn_mission_camp = compile preprocessFile "scripts\missions\camp.sqf";
BwS_fn_mission_convoi = compile preprocessFile "scripts\missions\convoi.sqf";
BwS_fn_mission_otages = compile preprocessFile "scripts\missions\priseOtage.sqf";
BwS_fn_mission_attentat = compile preprocessFile "scripts\missions\attentat.sqf";
BwS_fn_mission_occupation = compile preprocessFile "scripts\missions\town.sqf";

// spawn fnct only NO CALL ^

BwS_fn_spawnGroup = compile preprocessFile "scripts\spawnGroup.sqf";

// call fnct only NO SPAWN ^