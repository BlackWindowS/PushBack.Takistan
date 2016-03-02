
BwS_missionEnCours_convoi = 1; // cette variable permet de connaitre l'avancée dans la mission notamment dans le script de la tâche
publicVariable "BwS_missionEnCours_convoi";

//entrée des marquers itinéraires
_itineraires = [
	[getMarkerPos "convoi_debut_1", getMarkerPos "convoi_fin_1"],
	[getMarkerPos  "convoi_debut_2", getMarkerPos "convoi_fin_2"],
	[getMarkerPos "convoi_debut_3", getMarkerPos "convoi_fin_3"],
	[getMarkerPos "convoi_debut_4", getMarkerPos "convoi_fin_4"]
];
_itinerairechoisi = selectRandom _itineraires;
_convoi_debut = _itinerairechoisi select 0;
_convoi_fin = _itinerairechoisi select 1;

// création de la tâche
[[[_convoi_fin], { // _position est l'endroit où se déroule la mission
		private ["_task"];
		_task = player createSimpleTask ["Convoi"];
		_task setSimpleTaskDestination (_this select 0); // on définit le lieu passé en paramètre
		_task setSimpleTaskDescription ["Un convoi logistique insurgé aurait pour destination la position marquée sur votre carte, allez l'intercepter !", "Convoi", "Convoi"];
		player setCurrentTask _task;
		_task setTaskState "Created";
		_task setTaskState "Assigned";
		waitUntil {BwS_missionEnCours_convoi != 1};
		
		if (BwS_missionEnCours_convoi == 2) then {_task setTaskState "Failed";} else {_task setTaskState "Succeeded";}; // tu vois ce que tu fais avec BwS_missionEnCours_nomDeLaMission succeeded/failed/canceled...
		
		sleep 60;
		
		player removeSimpleTask _task; 
		
	  }], 
"BIS_fnc_spawn", true, true, false] call BIS_fnc_MP;

// contenu de ta mission
// dans ta mission la variable BwS_missionEnCours_nomDeLaMission doit changer pour que la tâche évolue
_camion1 = createVehicle ["rhs_ural_chdkz", _convoi_debut, [], 20, "NONE"];
_camion2 = createVehicle ["rhs_ural_chdkz", _convoi_debut, [], 20, "NONE"];
_jeep1 = createVehicle ["rhs_uaz_dshkm_chdkz", _convoi_debut, [], 20, "NONE"];
_jeep2 = createVehicle ["rhs_uaz_sp9_chdkz", _convoi_debut, [], 20, "NONE"];
createVehicleCrew _camion1;
createVehicleCrew _camion2;
createVehicleCrew _jeep1;
createVehicleCrew _jeep2;

//on crée le groupe et lance vers la destination du convoi
_group = group driver _jeep1;
(units group driver _camion1) join _group;
(units group driver _camion2) join _group;
(units group driver _jeep2) join _group;
_group addWaypoint [_convoi_fin, 0];

_continuer = true;
while {_continuer} do
{
	//si le convoi est mort
	if ({alive _x}count units _group == 0) then { BwS_missionEnCours_convoi = 42; _continuer = false;};
	//si le convoi est arrivé, la mission est ratée
	if ((position (driver _jeep1) distance _convoi_fin) < 30) then {BwS_missionEnCours_convoi = 2; _continuer = false;};
};

BwS_missionEnCours_nomDeLaMission = 0;
publicVariable "BwS_missionEnCours_nomDeLaMission"; // cette ligne permet aux clients de connaitre l'état de la variable car le script est executé seulement sur le serveur. publicVariable doit être appelé après chaque changement de la variable visée. BIS_fnc_MP fait executer son contenu à tous les clients

