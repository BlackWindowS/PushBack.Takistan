scriptName "BwS_fn_vilain";
_unit = (_this select 0);

if ((random 100) < 15) then {
	_unit allowFleeing 0;
	_unit setSkill 1;
	
	// le mec est un taleb
	// suicide bomber ou attaque à la kalash
	
	if ((random 100) < 10) then {
		// suicide bomber ! on lui ajoute une ceinture
		_unit addVest "V_BandollierB_khk";
		waituntil { if (BwS_nombreJoueurs != 0) then { _unit move (position ([_unit] call BwS_fn_nearestPlayer)); sleep 1; (_unit distance ([_unit] call BwS_fn_nearestPlayer)) < 10} else {false}; };
		// EXPLOSIONNNNN
		if (alive _unit) then {
			"Bo_Mk82" createVehicle (position _unit); 
		};
	} 
	else {
		// attaque à la kalash		
		// lorsque les mecs sont proche de lui (- de 100m)
		waituntil { if (BwS_nombreJoueurs != 0) then { _unit move (position ([_unit] call BwS_fn_nearestPlayer)); sleep 1; (_unit distance ([_unit] call BwS_fn_nearestPlayer)) < 100} else {false}; };
		
		// aller dans la maison la plus proche
		_unit move (position nearestBuilding (position _unit));
		waituntil {unitReady _unit};
		// faire pop une kalash dans ses mains
		_unit addMagazine "30Rnd_65x39_caseless_green";
		_unit addWeapon "arifle_Katiba_F";
		_unit addMagazine "30Rnd_65x39_caseless_green";
		_unit addMagazine "30Rnd_65x39_caseless_green";
		// attaquer les pax
		_unit doFire ([_unit] call BwS_fn_nearestPlayer);
		while {alive _unit} do { if (BwS_nombreJoueurs != 0) then { _unit move (position ([_unit] call BwS_fn_nearestPlayer)); sleep 1;} else {false};};
	};
	
};