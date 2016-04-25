_compil = [] execVM "scripts\EBN\compilation.sqf";

waitUntil {scriptDone _compil};

[] execVM "scripts\EBN\menus.sqf";

if (isServer) then
{
	nul = [] execVM "scripts\EBN\markers.sqf"; 
};

if (hasInterface) then 
{
	[
		["<t color='#CC2222'>Espace de Bataille Numérique (EBN)</t>", 
		{showCommandingMenu "#USER:BwS_MENU_EBN"}, 
		[], 
		1, 
		false, 
		true, 
		"User1",
		"(""item_R3F_SIT_COMDE"" in (items player + assignedItems player)) || ((typeof vehicle player == ""BwS_Fennek"") && (commander vehicle player == player))"]
	] call CBA_fnc_addPlayerAction;


	// ["BwS_EBN_onEachFrame", "onEachFrame", 
		// {
			// construction du sous menu de gestion des marqueurs
			// call BwS_fn_construction_menus_marqueurs;
		// }	
	// ] call BIS_fnc_addStackedEventHandler;

	sleep 3;

	while {true} do
	{
		 call BwS_fn_construction_menus_marqueurs;
		 sleep 2; // pas besoin à chaque frame
	};
};