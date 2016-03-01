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