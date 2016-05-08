scriptName "BwS_fn_char";
["Un char a ete spawn"] spawn BwS_fn_diag_log;

private ["_randomPos", "_group", "_char", "_cible", "_wp", "_gestion", "_types"];

// création du char ET de l'escouade jonction des groupes (en dehors de map)
_randomPos = [random(10000), 500, 0];

_types = ["rhs_btr70_chdkz", "rhs_btr60_chdkz"];
// _char = createVehicle [(_types select 0), _randomPos, [], 0, "NONE"];
_char = createVehicle [(selectRandom _types), _randomPos, [], 0, "NONE"];
createVehicleCrew _char;

_group = [_randomPos, 8, resistance, resistance] call BwS_fn_spawnGroup;

units _group join (group driver _char); 
sleep 0.01;
_group = group driver _char;

if (BwS_Debug) then { ["char", position leader _group, "ColorRed"] spawn BwS_fn_creerMarqueur; };

// déplacement jusque point random
// _gestion = [_group] spawn BwS_fn_gestionPatrolSoft; 

_pos = position (selectRandom ROADS);
_pos set [2, 0];
driver _char move _pos;
waituntil {sleep 0.1; unitReady driver _char};
sleep 3600;
terminate _gestion;

// _gestion = [_group] spawn BwS_fn_gestionPatrolSoftMoyen;

while {alive driver _char} do {
	_pos = position (selectRandom ROADS);
	_pos set [2, 0];
	driver _char move _pos;
	waituntil {sleep 0.1; unitReady driver _char};
	_char setFuel 1;
	sleep 1;
};