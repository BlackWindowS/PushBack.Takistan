/*

	Script d'IEDs créé par [B.w.S] SoP pour la mission Operation PushBack

	Réalisé en prenant les meilleurs morceaux du script de [EPD] Brian

	http://www.armaholic.com/page.php?id=23995

	WIP

*/

sleep 5;

call compile preprocessFile "scripts\IED\config.sqf";
sleep 0.01;
call compile preprocessFile "scripts\IED\fonctions.sqf";
call compile preprocessFile "scripts\IED\ExplosionEffects.sqf";

sleep 2;	

if (isServer) then
{
	0 spawn BwS_IED_fn_init;
};

if (hasInterface) then // cote client
{
	BwS_IEDs = (([0,0] nearObjects 30000) select {_x getVariable ["BwS_IED_est_un_IED", false]});
	sleep 3;
	{
		[_x] spawn BwS_IED_fn_addAction;
	} forEach BwS_IEDs;
	
	while {true} do
	{
		_distance = 10;
		_IEDs = ((player nearObjects _distance) select {_x getVariable ["BwS_IED_est_un_IED", false]});
		
		if (count _IEDs > 0) then // s'il y a des IED à - de _distance m
		{
			_ied = ((nearestObjects [player, [], _distance]) select {_x getVariable ["BwS_IED_est_un_IED", false]}) select 0;
			
			if (_ied getVariable ["BwS_IED_RC", false]) then // si l'IED est contrôlé à distance
			{
				if (alive (_ied getVariable ["BwS_IED_controleur", objNull])) then // si le déclencheur est vivant, peu importe EOD ou pas, boum
				{
					[_ied] call BwS_IED_fn_Explose_IED;
				}
				else // l'observateur n'est plus vivant, l'objet n'est plus un IED
				{
					_ied setVariable ["BwS_IED_est_un_IED", false, true];
				};
			}
			else
			{
				if (!joueurEOD || (abs(speed player) >= 6)) then // si le joueur n'est pas EOD ou s'il va trop vite
				{
					[_ied] call BwS_IED_fn_Explose_IED; // boom
				};
			};
			
			
		};
		sleep 1;
	};
};
