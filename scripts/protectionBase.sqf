while {true} do
{
	if (count (getMarkerPos "IronDome" nearObjects ["O_Heli_Attack_02_F", 4000]) > 0) then 
	{
		// {[_x] execVM "scripts\irondome.sqf";} forEach (getMarkerPos "IronDome" nearObjects ["O_Heli_Attack_02_F", 4000]);
		// {[_x] execVM "scripts\irondome.sqf";} forEach (getMarkerPos "IronDome" nearObjects ["O_Heli_Attack_02_F", 4000]);
		// {[_x] execVM "scripts\irondome.sqf";} forEach (getMarkerPos "IronDome" nearObjects ["O_Heli_Attack_02_F", 4000]);
		// {[_x] execVM "scripts\irondome.sqf";} forEach (getMarkerPos "IronDome" nearObjects ["O_Heli_Attack_02_F", 4000]);
		// {[_x] execVM "scripts\irondome.sqf";} forEach (getMarkerPos "IronDome" nearObjects ["O_Heli_Attack_02_F", 4000]);
		{deleteVehicle _x} forEach (getMarkerPos "IronDome" nearObjects ["O_Heli_Attack_02_F", 4000]);
	};
	sleep 5;
};