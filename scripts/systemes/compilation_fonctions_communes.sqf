BwS_fn_nouvelleTache =
{
	hint parseText "<t size='3' color='#0000ff'>Nouvelle tâche</t><br/>Pensez à regarder vos tâches et intervenez au plus vite !";
	["TaskCreated",["","Nouvelle tâche !"]] call BIS_fnc_showNotification;
};

BwS_fn_finTache =
{
	hint parseText "<t size='3' color='#0000ff'>Tâche terminée</t><br/>La tâche en cours est terminée.";
};

BwS_fn_ajouter_credits_usine = 
{
	// [<usine>, <nombre de credits>] call BwS_fn_ajouter_credits_usine;
	private ["_usine"];
	
	_usine = _this select 0;
	_creditsAAjouter = _this select 1;
	
	_credits = _usine getVariable "R3F_LOG_CF_credits";
	_credits = _credits + _creditsAAjouter;
	
	systemChat format ["%1 crédits ont été %2 à l'usine", abs _creditsAAjouter, if (_creditsAAjouter < 0) then {"retirés"} else {"ajoutés"}];
	
	_usine setVariable ["R3F_LOG_CF_credits", _credits, true];
};

BwS_fn_ajouter_caisse_reward =
{
	private  ["_position", "_caisse"];
	// spawn caisse
	_position = _this select 0;
	_caisse = "Land_Box_AmmoOld_F" createVehicle _position;
	
	// addAction sur la caisse qui donne la récompense et qui supprime la caisse
	BwS_fn_ajouter_addAction_caisse_reward = 
	{
		_caisse = _this select 0;
		_caisse addAction ["<t color='#ff0000'>Obtenir la récompense pour ma faction</t>", 
		{
			deleteVehicle (_this select 0);
			switch (side (_this select 1)) do
			{
				case east : {[usine_ru, 10000] call BwS_fn_ajouter_credits_usine;};
				case west : {[usine_us, 10000] call BwS_fn_ajouter_credits_usine;};
				default {};
			};
		}];
	};
    [_caisse] remoteExec ["BwS_fn_ajouter_addAction_caisse_reward", [east, west], true]; 
};