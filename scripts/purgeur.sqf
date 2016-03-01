{
	if (count units _x == 0) then
	{
		deleteGroup _x;
	};
	sleep 0.01;
} forEach allGroups;

// {
	// deleteVehicle _x; 
// } forEach allDead;