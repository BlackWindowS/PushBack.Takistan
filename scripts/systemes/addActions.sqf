waitUntil {!isNull player};
sleep 1;
if (joueurEOD) then 
{
	BwS_joueur_est_en_train_de_detecter = false;
	nul = [] execVM "scripts\detecteurMines.sqf";

	[	
		["Activer le détecteur de mines", 
		{BwS_joueur_est_en_train_de_detecter = true;},
		[], 
		1.5, 
		false, 
		true, 
		"", 
		"((""MineDetector"" in (items player + assignedItems player)) && !BwS_joueur_est_en_train_de_detecter)"]
	] call CBA_fnc_addPlayerAction;

	[	
		["Désactiver le détecteur de mines", 
		{BwS_joueur_est_en_train_de_detecter = false;},
		[], 
		1.5, 
		false, 
		true, 
		"", 
		"((""MineDetector"" in (items player + assignedItems player)) && BwS_joueur_est_en_train_de_detecter)"]
	] call CBA_fnc_addPlayerAction;
};