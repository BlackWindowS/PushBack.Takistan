BwS_fn_nouvelleTache =
{
	hint parseText "<t size='3' color='#0000ff'>Nouvelle t�che</t><br/>Pensez � regarder vos t�ches et intervenez au plus vite !";
	["TaskCreated",["","Nouvelle t�che !"]] call BIS_fnc_showNotification;
};

BwS_fn_finTache =
{
	hint parseText "<t size='3' color='#0000ff'>T�che termin�e</t><br/>La t�che en cours est termin�e.";
};

BwS_fn_ajouter_credits_usine = 
{
	// [<usine>, <nombre de credits>] call BwS_fn_ajouter_credits_usine;
	private ["_usine"];
	
	_usine = _this select 0;
	_creditsAAjouter = _this select 1;
	
	_credits = _usine getVariable "R3F_LOG_CF_credits";
	_credits = _credits + _creditsAAjouter;
	
	_usine setVariable ["R3F_LOG_CF_credits", _credits, true];
};