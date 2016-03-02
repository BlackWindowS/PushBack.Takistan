/*
Add Script to individual units spawned by COS.
_unit = unit. Refer to Unit as _unit.
*/

_unit = (_this select 0);

if ((random 100) < 20) then {
	_unit allowFleeing 0;
	_unit setSkill 1;
	
	// le mec est un taleb
	// suicide bomber ou attaque à la kalash
	BwS_nombreJoueurs = count allPlayers;
	if ((random 100) < 10) then {
		// suicide bomber ! on lui ajoute une ceinture
		_unit addVest "V_BandollierB_khk";
		waituntil { if (BwS_nombreJoueurs != 0) then { _unit move (position ([_unit] call BwS_fn_nearestPlayableUnit)); sleep 1; (_unit distance ([_unit] call BwS_fn_nearestPlayableUnit)) < 10} else {false}; };
		// EXPLOSIONNNNN
		if (alive _unit) then {
			_explo = "Grenade" createVehicle (position _unit); 
			_explo attachTo [_unit];
		};
	} 
	else {
		// attaque à la kalash		
		// faire pop une kalash dans ses mains
		_unit addMagazine "rhs_30Rnd_545x39_AK";
		_unit addWeapon "rhs_weap_ak74m";
		_unit addMagazine "rhs_30Rnd_545x39_AK";
		_unit addMagazine "rhs_30Rnd_545x39_AK";
		// attaquer les pax
		_unit doFire ([_unit] call BwS_fn_nearestPlayableUnit);
		while {alive _unit} do { if (BwS_nombreJoueurs != 0) then { _unit move (position ([_unit] call BwS_fn_nearestPlayableUnit)); sleep 1;} else {false};};
	};
	
}
else
{
	_unit addEventHandler ["Killed", 
	{
		if (count ((_this select 0) getVariable ["ace_medical_openwounds", []]) != 0) then
		{
			systemChat "Un civil à été tué. Les 2 factions ont une pénalité.";
			[usine_us, -2000] call BwS_fn_ajouter_credits_usine;
			[usine_ru, -2000] call BwS_fn_ajouter_credits_usine;
		};
	}]; 
};