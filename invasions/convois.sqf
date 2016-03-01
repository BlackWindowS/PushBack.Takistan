/*
	Script de gestion de convois entre camps par SoP pour la team B.w.S
	
	on récupère les positions des camps (paramètre 0)
	on séléctionne un nombre de camps aléatoire
	on créé dans ces camps un pickup rempli de méchants
	on fait rouler ces pickups jusqu'à un autre camp
	puis à un autre camp... etc.
*/

private ["_positionCamp", "_nombreDeCamps", "_campsSelectionnes"];

_positionCamp = (_this select 0);

_nombreDeCamps = count _positionCamp;

_campsSelectionnes = [];

{ if ((random 100) < 20) then {_campsSelectionnes pushBack _x}; } forEach _positionCamp;

if (count _campsSelectionnes == 0) then {_campsSelectionnes = [_positionCamp select (random count _positionCamp), _positionCamp select (random count _positionCamp)];}; // petite securité qd mm.. au cas où y'a aucun random => on prend 2 camps random, faut pas déconner non plus..

{
	[_x, _positionCamp] spawn { 
		private ["_positionSafe", "_veh"];
		_positionSafe = [(_this select 0), 1, 30, 3, 0, 20, 0] call BIS_fnc_findSafePos;
		
		_veh = "O_G_Van_01_transport_F" createVehicle _positionSafe; 
		createVehicleCrew _veh;
		
		if (BwS_Debug) then {["Camion", position _veh, "ColorPink"] spawn BwS_fn_creerMarqueur};

		_group = [_positionSafe, 12, resistance, resistance] call BwS_fn_spawnGroup;
		
		{_x moveInCargo _veh; _x assignascargo _veh} forEach units _group;
		
		while {alive driver _veh} do
		{
			driver _veh move ((_this select 1) select (random (count (_this select 1)))); // on bouge jusqu'à un camp random
			waituntil {_veh setFuel 1; sleep 1; unitReady driver _veh };
			_veh setDamage 0;
		};
	};
} forEach _campsSelectionnes;