scriptName "BwS_fn_base";
// BwS_fn_gestionPatrolSoftMoyen

_positionBase = markerPos "desert";

_position = [(_positionBase select 0) + (round(random 50) -25),
			(_positionBase select 1) + (round(random 50) -25)];
				 
_group = [_position, (36 + round(random(124))), BwS_var_side_ennemie, BwS_var_side_ennemie] call BwS_fn_spawnGroup;
// [_group] spawn BwS_fn_gestionPatrolSoftMoyen;
