/*

	Script d'IEDs créé par [B.w.S] SoP pour la mission Operation PushBack

	Réalisé en prenant les meilleurs morceaux du script de [EPD] Brian

	http://www.armaholic.com/page.php?id=23995

	WIP

*/

sleep 5;
	
call compile preprocessFile "scripts\IED\fonctions.sqf";
call compile preprocessFile "scripts\IED\ExplosionEffects.sqf";

sleep 2;	

if (isServer) then
{
	private ["_nomMarker", "_types"];

	_nombreDIED = 50 + random 10;

	_types = ["Land_CanisterOil_F",
		"Land_FMradio_F",
		"Land_Canteen_F",
		"Land_CerealsBox_F",
		"Land_BottlePlastic_V1_F",
		"Land_PowderedMilk_F",
		"Land_RiceBox_F",
		"Land_TacticalBacon_F",
		"Land_VitaminBottle_F",
		"Land_BottlePlastic_V2_F",
		"RoadCone_F",
		"Land_Pallets_F",
		"Land_WheelCart_F",
		"Land_Tyre_F",
		"Land_ButaneCanister_F",
		"Land_Bucket_F",
		"Land_GasCanister_F",
		"Land_Pillow_F",
		"Land_Portable_generator_F",
		"Land_WoodenBox_F",
		"Land_MetalBarrel_F",
		"Land_BarrelTrash_grey_F",
		"Land_Sacks_heap_F",
		"Land_WoodenLog_F",
		"Land_WoodPile_F",
		"Land_Sack_F", 
		"Land_BottlePlastic_V1_F", 
		"Land_Suitcase_F", 
		"Land_BarrelTrash_F", 
		"Land_GasCanister_F", 
		"Land_GarbageBags_F", 
		"Land_GarbageWashingMachine_F", 
		"Land_MetalBarrel_F", 
		"Bomb"];

	for "_i" from 0 to _nombreDIED do
	{
		_randomRoad = selectRandom ROADS;
		_randomType = selectRandom _types;
		
		_IED = _randomType createVehicle ([_randomRoad] call EPD_FIND_LOCATION_BY_ROAD);

		["IED", position _IED] spawn BwS_fn_creerMarqueur;
		if (_IED != objNull) then {			
			_IED setVariable ["BwS_IED_est_un_IED", true, true];
			_IED setVariable ["BwS_IED_force", selectRandom ["M_Mo_82mm_AT_LG", "Bo_Mk82", "HelicopterExploBig", "HelicopterExploSmall", "R_80mm_HE", "Bo_GBU12_LGB"], true];
		};
	};
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
			if (!joueurEOD || (abs(speed player) >= 6)) then // si le joueur n'est pas EOD ou s'il va trop vite
			{
				_ied = ((nearestObjects [player, [], _distance]) select {_x getVariable ["BwS_IED_est_un_IED", false]}) select 0;
				[_ied] call BwS_IED_fn_Explose_IED; // boom
			};
		};
		sleep 1;
	};
};