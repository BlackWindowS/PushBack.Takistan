scriptName "BwS_fn_airfield";
private ["_position" ,"_radius"];

_positionBase = _this select 0;
_radius = 300;

// spawn d'unités AC et AA CSAT

for "_i" from 0 to (3 + round(random(4))) do
{
	_position = [(_positionBase select 0) + (round(random 100) -50),
				 (_positionBase select 1) + (round(random 100) -50)];
				 
	_group = [_position, (6 + round(random(10))), resistance, resistance] call BwS_fn_spawnGroup;
	// [_group] spawn BwS_fn_gestionPatrolSoftMoyen;
};

// spawn de Tigris