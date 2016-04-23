// choix des groupes proches des joueurs
_groups = allGroups select {((position leader _x) distance ([leader _x] call BwS_fn_nearestPlayer) < 3000) && (side _x == resistance) && !(_x in BwS_var_groupes_a_exclure) && (_x in (BwS_var_unites_de_caserne+BwS_var_unites_d_usine))};

if (count _groups > 0) then
{
	// exclusions de ces groupes
	BwS_var_groupes_a_exclure = BwS_var_groupes_a_exclure + _groups;
	BwS_var_groupes_a_exclure_simulation = BwS_var_groupes_a_exclure_simulation + _groups;

	// regroupement de ces goupes
	// _tx = 0;
	// _ty = 0;
	
	{
		// _tx = _tx + ((position leader _x) select 0);
		// _ty = _ty + ((position leader _x) select 1);
		[position leader _x, "hd_warning", "ColorRed", "groupe", 120] spawn BwS_EBN_fn_placer_marqueur;
	} forEach _groups;
	
	// _ty = _ty/(count _groups);
	// _tx = _tx/(count _groups);
	
	// fusion de ces groupes
	_mainGroup = (_groups select 0);
	
	{	
		_grp = _x;
		{deleteWaypoint [_grp, _forEachIndex]} forEach waypoints _grp;
		(units _grp) join _mainGroup;
	} forEach _groups;
		
	// [[_tx, _ty], "hd_dot", "ColorRed", "point de rgrp", 120] spawn BwS_EBN_fn_placer_marqueur;
	// _mainGroup move [_tx, _ty];
	_mainGroup setSpeedMode "FULL";

	{_x enableSimulationGlobal true} forEach units _mainGroup;
	
	// mouvement sur une colline
	// waitUntil {({(_x distance [_tx, _ty] < 100)} count units _mainGroup) == (count units _mainGroup)};
	
	_mainGroup setFormation "WEDGE";
	_mainGroup setSpeedMode "NORMAL";
	
	_nearestPlayer = [leader _mainGroup] call BwS_fn_nearestPlayer;
	
	_pointLePlusHaut = position _nearestPlayer;
	
	for "_ixe" from (position _nearestPlayer select 0)-1500 to (position _nearestPlayer select 0)+1500 do
	{
		for "_igrec" from (position _nearestPlayer select 1)-1500 to (position _nearestPlayer select 1)+1500 do
		{
			if (getTerrainHeightASL [_ixe, _igrec] >= getTerrainHeightASL _pointLePlusHaut) then
			{
				_pointLePlusHaut = [_ixe, _igrec];
			};
		};
	};
	
	_mainGroup move _pointLePlusHaut;
	[_pointLePlusHaut, "hd_dot", "ColorRed", "point de destination", 120] spawn BwS_EBN_fn_placer_marqueur;
};