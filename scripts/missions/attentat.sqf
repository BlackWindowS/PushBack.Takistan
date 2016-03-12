BwS_missionEnCours_attentat = 1;
publicVariable "BwS_missionEnCours_attentat";

// choix du lieu
private ["_posAttentat", "_markersAttentat"];
_markersAttentat = ["otage", "otage_1", "otage_2", "otage_3", "otage_4", "otage_5", "otage_6", "otage_7", "otage_8"];

_posAttentat = markerPos (_markersAttentat select (random ((count _markersAttentat)-1)));
// création de la tâche
[[[_posAttentat], {
		private ["_task"];
		_task = player createSimpleTask ["Attentat"];
		_task setSimpleTaskDestination (_this select 0);
		_task setSimpleTaskDescription ["Un attentat vient d'être commit ! Rendez vous au plus vite sur les lieux pour sécuriser la zone, évacuer les blessés et les éventuels morts.", "Attentat", "Attentat"];
		player setCurrentTask _task;
		_task setTaskState "Created";
		_task setTaskState "Assigned";
		waitUntil {BwS_missionEnCours_attentat != 1};
		
		if (BwS_missionEnCours_attentat == 2) then {_task setTaskState "Failed";} else {_task setTaskState "Succeeded";};
		
		sleep 60;
		
		player removeSimpleTask _task; 
		
	  }], 
"BIS_fnc_spawn", true, true, false] call BIS_fnc_MP;

// création de la foule (rayon 50m)
private ["_civils"];
_civils = [];
for "_i" from 0 to (20 + (random 20)) do 
{
	_x = (_posAttentat select 0) - 20 + random 40;
	_y = (_posAttentat select 1) - 20 + random 40;
	_z = (_posAttentat select 2) + 10;
	
	_group = [[_x, _y, _z], 1, Civilian] call BwS_fn_spawnGroup;
	
	(units _group select 0) disableAi "Move";
	_civils pushBack (units _group select 0);
};

sleep 60;

// création de l'explosion

"Grenade" createVehicle position (selectRandom _civils);
"Grenade" createVehicle position (selectRandom _civils);
"Grenade" createVehicle position (selectRandom _civils);
"Grenade" createVehicle position (selectRandom _civils);
"Grenade" createVehicle position (selectRandom _civils);

sleep 10;

// création d'un panneau pour stopper la mission

private ["_panneau"];
_panneau = "Land_InfoStand_V1_F" createVehicle _posAttentat;

[[_panneau], "BwS_fn_stopperAttentat", west, false] call BIS_fnc_MP;
[_posAttentat] call BwS_fn_ajouter_caisse_reward;

waitUntil {BwS_missionEnCours_attentat == 0;};
publicVariable "BwS_missionEnCours_attentat";

{ deleteVehicle _x} forEach _civils;
deleteVehicle _panneau;

