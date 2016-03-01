while {true} do
{
	if (detecter) then
	{
		{
			if (player distance _x <= 4 && ([getPos player, getDir player, 80, getPos _x] call BIS_fnc_inAngleSector)) then
			{
				[player distance _x, _x] call 
				{
					playSound3D ["A3\Sounds_f\sfx\Beep_Target.wss", player, false, getPosASL player, 100, 1, 4];
					sleep ((_this select 0) / 4);
				};
			};
		} forEach allMines;	
	};
	sleep 0.01;
};