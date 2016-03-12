diag_log "debut prise otage";

BwS_missionEnCours_otages = 1;
publicVariable "BwS_missionEnCours_otages";

private ["_difficulte"];
_difficulte = (_this select 0);

// selection du lieu d'attaque et du lieu de spawn des méchants
private ["_spawnTerro", "_posAttaque", "_markersAttaque"];

_markersAttaque = ["otage", "otage_1", "otage_2", "otage_3", "otage_4", "otage_5", "otage_6", "otage_7", "otage_8"];

_posAttaque = markerPos (_markersAttaque select (random ((count _markersAttaque)-1)));
_spawnTerro = position (ROADS select (random count ROADS));

while {((_spawnTerro distance _posAttaque) > 5000) || ((_spawnTerro distance _posAttaque) < 2000)} do { // détermination d'une position entre 2km et 5km de la cible
	_spawnTerro = position (ROADS select (random count ROADS));
};

// création de la tâche "des informateurs nous ont prévenu que blablabla"
[[[_posAttaque], {
		private ["_task"];
		_task = player createSimpleTask ["Prise d'otage"];
		_task setSimpleTaskDestination (_this select 0);
		_task setSimpleTaskDescription ["Selon nos sources infiltrées, une prise d'otage se préparerait. Intervenez au plus vite pour sécuriser les otages. Si toutefois les terroristes n'étaient pas là, engagez les recherches sur le territoire d'Altis afin de les retrouver. Ils circuleraient en pickup de couleur et serait une demi-douzaine. Bonne chance !", "Prise d'otage", "Otages"];
		_task setTaskState "Created";
		_task setTaskState "Assigned";
		player setCurrentTask _task;
		waitUntil {BwS_missionEnCours_otages == 0};
		_task setTaskState "Succeeded";
		sleep 60;
		player removeSimpleTask _task;	
	  }], 
"BIS_fnc_spawn", true, true, false] call BIS_fnc_MP;


// création du commando point random direction le lieu de la prise d'otage
private ["_group", "_vehicle", "_nombreTerro", "_typeVehicule"];

_nombreTerro = 6;
_typeVehicule = "C_Offroad_01_F";

if (_difficulte == 1) then
{
	_nombreTerro = 12;
	_typeVehicule = "C_Van_01_transport_F";
};
_group = [_spawnTerro, _nombreTerro] call BwS_fn_spawnGroup;

_vehicle = createVehicle [_typeVehicule, _spawnTerro, [], 50, "NONE"];

_vehicle allowDamage false;
(units _group select 0) moveInDriver _vehicle;
{_x moveInCargo _vehicle} forEach (units _group - [units _group select 0]);

(units _group select 0) move _posAttaque;

// creation des otages
private ["_groupOtages"];
_groupOtages = [_posAttaque, 2 + (random 3), Civilian] call BwS_fn_spawnGroup;

{ _x disableAi "Move"} forEach units _groupOtages;

// lorsque terro a proximité des otages, ligature des otages + addAction libération
waitUntil {(((units _group select 0) distance (units _groupOtages select 0)) < 5000) || ({((!alive _x) || (_x getVariable ["ace_captives_ishandcuffed", false]))} count units _group) == (count units _group)};
_vehicle allowDamage true;

waitUntil {((units _group select 0) distance (_posAttaque)) < 30 || (({((!alive _x) || (_x getVariable ["ace_captives_ishandcuffed", false]))} count units _group) == (count units _group))};

{moveOut _x; unassignVehicle _x} forEach units _group;

_group move _posAttaque;

{
	[[[_x], {(_this select 0) playmovenow "Acts_AidlPsitMstpSsurWnonDnon_loop";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
	[[_x], "BwS_fn_addActionLibererOtage", west, false] call BIS_fnc_MP;
} forEach units _groupOtages;

// si tous les terro sont ligotés OU tués réussite de la mission
waitUntil { ({((!alive _x) || (_x getVariable ["ace_captives_ishandcuffed", false]))} count units _group) == (count units _group)};

BwS_missionEnCours_otages = 0;
publicVariable "BwS_missionEnCours_otages";

sleep 60;

{ deleteVehicle _x } forEach units _group + units _groupOtages;




// unit getVariable ["ace_captives_ishandcuffed", false];
// playmove "Acts_AidlPsitMstpSsurWnonDnon_loop" // otage attaché
// "Acts_AidlPsitMstpSsurWnonDnon_out" // libération