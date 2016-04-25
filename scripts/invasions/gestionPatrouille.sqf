// _group = (_this select 0);

// [_group, (position leader _group), 500] call BIS_fnc_taskPatrol;

diag_log "Gestion patrouille RUNNING";

while {true} do
{
	call BwS_fn_tri_des_unites;
	{
		_group = _x;
		if (side _group == resistance) then
		{
			_nearestPlayer = [leader _group] call BwS_fn_nearestPlayer;
			_prochain_check = 0;
			
			{	
				if (_x in BwS_var_unites) then 
				{
					_x enableSimulationGlobal true;	
					_mechant = _x;
					{_x reveal _mechant} forEach allPlayers;
				}
				else
				{
					{	_x enableSimulationGlobal false;	} forEach units _group;
				};
				
				if ((_x in BwS_var_homed) && (_nearestPlayer distance _x < 10) && (random 1 <= 0.50)) then
				{
					_x move (position _nearestPlayer);
					_group setBehaviour "COMBAT";
				};
				
			} forEach units _group;

			if !(_group in BwS_var_groupes_a_exclure) then 
			{
				if ((_nearestPlayer distance (getMarkerPos "PC")) > 500) then // si le joueur le plus proche est à plus de 500m de la base on peut l'attaquer
				{
					if ((({(_x distance _nearestPlayer) < 20} count allPlayers) > 3) || 
						([_nearestPlayer] call BwS_fn_sont_ils_en_convoi)) then // si c'est un groupe => + de 3 unités à - de 20m de _nearestPlayer ou si c'est un convoi (3 vehicules au moins) => permet les URR 
					{
						_group move position _nearestPlayer;
						_group setFormation (selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"]);
						_group setSpeedMode "NORMAL";
					};
					else
					{
						_group move [((position leader _group) select 0)-100+random(200), ((position leader _group) select 1)-100+random(200)];
					};
				};
			};
		}; 
		
	} forEach (allGroups-BwS_var_groupes_a_exclure_simulation);
	
	if ((random 100 <= 1) && (count allplayers > 0)) then // 1 chance sur 100 toutes les 10 secondes (environ 1 raid tout les 16min)
	{
		[] spawn BwS_fn_raid;
	};
	
	sleep 10;
};