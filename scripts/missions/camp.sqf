
BwS_missionEnCours_camp = 1; // cette variable permet de connaitre l'avancée dans la mission notamment dans le script de la tâche
publicVariable "BwS_missionEnCours_camp";

_position = position (ROADS select (floor(random(count ROADS))));
_position set [0, (_position select 0)-300+random(600)];
_position set [1, (_position select 1)-300+random(600)];

// création de la tâche
[[[_position], { // _position est l'endroit où se déroule la mission
		private ["_task"];
		_task = player createSimpleTask ["Camp d'entrainement"];
		_task setSimpleTaskDestination (_this select 0); // on définit le lieu passé en paramètre
		_task setSimpleTaskDescription ["Un camp d'entrainement vient d'etre decouvert. Allez-y ! Vous avez une heure !", "Camp", "Camp"];
		player setCurrentTask _task;
		_task setTaskState "Created";
		_task setTaskState "Assigned";
		waitUntil {BwS_missionEnCours_camp != 1};
		
		if (BwS_missionEnCours_camp == 2) then {_task setTaskState "Failed";} else {_task setTaskState "Succeeded";}; // tu vois ce que tu fais avec BwS_missionEnCours_camp succeeded/failed/canceled...
		
		sleep 60;
		
		player removeSimpleTask _task; 
		
	  }], 
"BIS_fnc_spawn", west, true, false] call BIS_fnc_MP;

// contenu de ta mission
["grand", _position] spawn BwS_fn_camp;

_futur = time + 3600;
waitUntil {time <= _futur};

BwS_missionEnCours_camp = 0;
publicVariable "BwS_missionEnCours_camp"; // cette ligne permet aux clients de connaitre l'état de la variable car le script est executé seulement sur le serveur. publicVariable doit être appelé après chaque changement de la variable visée. BIS_fnc_MP fait executer son contenu à tous les clients

