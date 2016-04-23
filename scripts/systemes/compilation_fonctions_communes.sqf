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
	
	(format ["%1 crédits ont été %2 à l'usine", abs _creditsAAjouter, if (_creditsAAjouter < 0) then {"retirés"} else {"ajoutés"}]) remoteExec ["systemChat"];
	
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

BwS_fn_addActionLibererOtage = 
{
	_otage = (_this select 0);
	_otage addAction ["<t color='#00ff00'>Libérer</t>", 
						{
							[[[((_this select 3) select 0)], {(_this select 0) playmovenow "Acts_AidlPsitMstpSsurWnonDnon_out";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
							((_this select 3) select 0) move position (ROADS select (random count ROADS));
							((_this select 3) select 0) enableAi "Move";
						},
						[_otage]];
};

BwS_fn_stopperAttentat = 
{
	(_this select 0) addAction ["<t color='#ff0000'>Stopper la mission</t>", 
					{
						BwS_missionEnCours_attentat = 0;
						publicVariableServer "BwS_missionEnCours_attentat";	
					}];
};

BwS_fn_initCivil = 
{
	_unit = (_this select 0);

	_wanted = if (random 100 > 95 || (isPlayer _unit)) then {true} else {false};
	_raisons = ["A commis un meurtre.", "Possède à  son domicile des images pédo-pornographiques.", "A commis un vol à l'étalage.", "A commis un vol à l'arraché.", "Vendeur à la sauvette.", "Outrage à agent.", "Non assistance à personne en danger et délit de fuite.", "Association de malfaiteur.", "Conspirateur.", "Association de malfaiteur en relation avec une entreprise terroriste.", "Vendeur de kébab avarié"];

	_unit setVariable ["BwS_age", (20 + random(30)), true];
	_unit setVariable ["BwS_wanted", _wanted, true];
	_unit setVariable ["BwS_alcool", random 1, true];

	if (_wanted) then {
		_unit setVariable ["BwS_raison", (selectRandom _raisons), true];
	};

    if (isPlayer _unit) then
    {
        _unit setVariable ["BwS_raison", "Association de malfaiteur en relation avec une entreprise terroriste.", true];
    };

	[[_unit], "BwS_fn_controle", west, true] call BIS_fnc_MP;
	[[_unit], "BwS_fn_interroger", west, true] call BIS_fnc_MP;
};

BwS_fn_controle =
{
	(_this select 0) addAction [
	"<t color='#ff0000'>Contrôler</t>",
	{
		_unit = (_this select 0);
		_splittedName = (name _unit splitString " ");
		
		_debut = "<t align='right'>"; _fin = "</t>";
		
		_nom = if (count _splittedName == 2) then {_debut + (_splittedName select 1) + _fin} else {"<t align='right'>Refuse de décliner son nom</t>"};
		_prenom = _debut + (_splittedName select 0) + _fin;
		_age = _debut + str (floor (_unit getVariable ["BwS_age", random(30)+20])) + _fin;
		_wanted = "<t align='right'>" + (if ((_unit getVariable "BwS_wanted")) then { format ["Oui<br/><t align='left'>Motif : </t>%1", (_unit getVariable "BwS_raison")] } else {"Non"}) + "</t>";
		hint parseText format ["%1%2%3%4%5%6%7%8%9",
		"<t size='1.5' color='#00ff00'>Contrôle</t><br/>",
		"<t align='left'>Nom : </t>", _nom,
		"<br/><t align='left'>Prénom : </t>", _prenom,
		"<br/><t align='left'>Age : </t>", _age,
		"<br/><t align='left'>Recherché : </t>", _wanted
		];
		
	},
	[],
	1.5,
    true,
    true,
    "",
    "((player distance _target) < 2) && (speed _target == 0)"];
};

BwS_fn_interroger =
{
	(_this select 0) addAction [
	"<t color='#ff0000'>Interroger</t>",
	{
		_unit = (_this select 0);
		_position = position _unit;
		_mine = (allMines select {_x distance _unit < 300}) select 0;
		[player, format ["Un civil a repéré un objet étrange aux coordonnées %1 !", position _mine]] remoteExec ["sideChat", 0];
		[position _mine, "hd_warning", "ColorRed", "Mine/IED"] call BwS_EBN_fn_placer_marqueur;
		
		[(_this select 0), (_this select 2)] remoteExec ["removeAction", 0, false];
	},
	[],
	1.5,
    true,
    true,
    "",
    "((player distance _target) < 2) && (speed _target == 0)"];
};