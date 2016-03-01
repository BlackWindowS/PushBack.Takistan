// BwS_fn_gestionPatrolSoftMoyen

_positionBase = markerPos "desert";

_position = [(_positionBase select 0) + (round(random 50) -25),
			(_positionBase select 1) + (round(random 50) -25)];
				 
_group = [_position, (36 + round(random(124))), resistance, resistance] call BwS_fn_spawnGroup;
[_group] spawn BwS_fn_gestionPatrolSoftMoyen;
