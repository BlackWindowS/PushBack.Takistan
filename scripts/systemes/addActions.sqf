JOUEUR_EST_DANS_PC = {((player distance (nearestObject [player, "Land_Cargo_Tower_V1_F"])) < 10) && ((getPosATL player select 2) > 12) && (playerInHQ isEqualTo false) && ((((getMarkerPos "PC") distance (position player)) < 20) || (((getMarkerPos "PC_1") distance (position player)) < 20))};

waitUntil {!isNull player};
sleep 1;
if (joueurEOD) then 
{
	BwS_joueur_est_en_train_de_detecter = false;
	nul = [] execVM "scripts\detecteurMines.sqf";

	[	
		["Activer le détecteur de mines", 
		{BwS_joueur_est_en_train_de_detecter = true; player forceWalk true;},
		[], 
		1.5, 
		false, 
		true, 
		"", 
		"((""MineDetector"" in (items player + assignedItems player)) && !BwS_joueur_est_en_train_de_detecter)"]
	] call CBA_fnc_addPlayerAction;

	[	
		["Désactiver le détecteur de mines", 
		{BwS_joueur_est_en_train_de_detecter = false; player forceWalk false;},
		[], 
		1.5, 
		false, 
		true, 
		"", 
		"((""MineDetector"" in (items player + assignedItems player)) && BwS_joueur_est_en_train_de_detecter)"]
	] call CBA_fnc_addPlayerAction;
};