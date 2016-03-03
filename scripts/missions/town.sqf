
BwS_missionEnCours_town = 1; // cette variable permet de connaitre l'avancée dans la mission notamment dans le script de la tâche
publicVariable "BwS_missionEnCours_town";
private ["_locations", "_villeEnCours", "_ville"];
_locations = (nearestLocations [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["NameCityCapital", "NameCity"], 20000]);
_ville = selectRandom _locations;

// création de la tâche
[[[locationPosition _ville], { // _position est l'endroit où se déroule la mission
		private ["_task"];
		_task = player createSimpleTask ["Invasion"];
		_task setSimpleTaskDestination (_this select 0); // on définit le lieu passé en paramètre
		_task setSimpleTaskDescription ["Une ville est envahie par un ennemi bien armé ! Libérez-la !", "Occupation", "Occupation"];
		player setCurrentTask _task;
		_task setTaskState "Created";
		_task setTaskState "Assigned";
		waitUntil {BwS_missionEnCours_town != 1};
		
		if (BwS_missionEnCours_town == 2) then {_task setTaskState "Failed";} else {_task setTaskState "Succeeded";}; // tu vois ce que tu fais avec BwS_missionEnCours_town succeeded/failed/canceled...
		
		sleep 60;
		
		player removeSimpleTask _task; 
		
	  }], 
"BIS_fnc_spawn", west, true, false] call BIS_fnc_MP;

// contenu de ta mission
_villeEnCours = [_ville] spawn BwS_fn_occuper_une_location;
waitUntil {scriptDone _villeEnCours};
// dans ta mission la variable BwS_missionEnCours_town doit changer pour que la tâche évolue

BwS_missionEnCours_town = 0;
publicVariable "BwS_missionEnCours_town"; // cette ligne permet aux clients de connaitre l'état de la variable car le script est executé seulement sur le serveur. publicVariable doit être appelé après chaque changement de la variable visée. BIS_fnc_MP fait executer son contenu à tous les clients

