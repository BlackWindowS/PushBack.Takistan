call compile preprocessFile "scripts\fonctions_serveur.sqf";

call compile preprocessFile "scripts\RADIO\fonctions.sqf";
BwS_fn_brouilleur = compile preprocessFile "scripts\RADIO\brouilleur.sqf";

BwS_fn_base = compile preprocessFile "invasions\base.sqf";
BwS_fn_camp = compile preprocessFile "invasions\camp.sqf";
BwS_fn_char = compile preprocessFile "invasions\char.sqf";
BwS_fn_convois = compile preprocessFile "invasions\convois.sqf";
BwS_fn_mortier = compile preprocessFile "invasions\mortarTeam.sqf";
BwS_fn_airfield = compile preprocessFile "invasions\airfield.sqf";
BwS_fn_chasseur = compile preprocessFile "invasions\chasseur.sqf";
BwS_fn_paradrop = compile preprocessFile "invasions\paradrop.sqf";
BwS_fn_occupation = compile preprocessFile "invasions\occupation.sqf";
BwS_fn_patrolTeam = compile preprocessFile "invasions\patrolTeam.sqf";
BwS_fn_gestionArty = compile preprocessFile "invasions\artillerie.sqf";
BwS_fn_vehicleDrop = compile preprocessFile "invasions\vehicleDrop.sqf";
BwS_fn_aerialPatrol = compile preprocessFile "invasions\aerialPatrol.sqf";
BwS_fn_gestionPatrol = compile preprocessFile "invasions\gestionPatrouille.sqf";
BwS_fn_gestionPatrolSoft = compile preprocessFile "invasions\gestionPatrouilleSoft.sqf";
BwS_fn_motorizedPatrolTeam = compile preprocessFile "invasions\motorizedPatrolTeam.sqf";
BwS_fn_gestionPatrolSoftMoyen = compile preprocessFile "invasions\gestionPatrouilleSoftMoyen.sqf";

// spawn fnct only NO CALL ^

BwS_fn_spawnGroup = compile preprocessFile "scripts\spawnGroup.sqf";

// call fnct only NO SPAWN ^