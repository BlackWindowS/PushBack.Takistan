
BwS_missionEnCours_nomDeLaMission = 1; // cette variable permet de connaitre l'avancée dans la mission notamment dans le script de la tâche
publicVariable "BwS_missionEnCours_nomDeLaMission";

// création de la tâche
[[[_position], { // _position est l'endroit où se déroule la mission
		private ["_task"];
		_task = player createSimpleTask ["Attentat"];
		_task setSimpleTaskDestination (_this select 0); // on définit le lieu passé en paramètre
		// exemple : _task setSimpleTaskDescription ["Un attentat vient d'être commit ! Rendez vous au plus vite sur les lieux pour sécuriser la zone, évacuer les blessés et les éventuels morts.", "Attentat", "Attentat"];
		player setCurrentTask _task;
		_task setTaskState "Created";
		_task setTaskState "Assigned";
		waitUntil {BwS_missionEnCours_nomDeLaMission != 1};
		
		if (BwS_missionEnCours_nomDeLaMission == 2) then {_task setTaskState "Failed";} else {_task setTaskState "Succeeded";}; // tu vois ce que tu fais avec BwS_missionEnCours_nomDeLaMission succeeded/failed/canceled...
		
		sleep 60;
		
		player removeSimpleTask _task; 
		
	  }], 
"BIS_fnc_spawn", west, true, false] call BIS_fnc_MP;

// contenu de ta mission
// dans ta mission la variable BwS_missionEnCours_nomDeLaMission doit changer pour que la tâche évolue

BwS_missionEnCours_nomDeLaMission = 0;
publicVariable "BwS_missionEnCours_nomDeLaMission"; // cette ligne permet aux clients de connaitre l'état de la variable car le script est executé seulement sur le serveur. publicVariable doit être appelé après chaque changement de la variable visée. BIS_fnc_MP fait executer son contenu à tous les clients

