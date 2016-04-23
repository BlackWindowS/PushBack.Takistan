/*
Add Script to individual units spawned by COS.
_unit = unit. Refer to Unit as _unit.
*/

_unit = (_this select 0);

[_unit] call BwS_fn_initCivil;

{civilian revealMine _x} forEach allMines;

if ((random 100) < 15) then {

	[_unit] join grpNull;

	_unit allowFleeing 0;
	_unit setSkill 1;
	_unit setVariable ["BwS_wanted", true, true];
	_unit setVariable ["BwS_raison", "Terrorisme", true];
	
	// le mec est un taleb
	// suicide bomber ou attaque à la kalash
	BwS_nombreJoueurs = count allPlayers;
	if ((random 100) < 10) then {
		// suicide bomber ! on lui ajoute une ceinture
		// _unit addVest "V_BandollierB_khk";
		waituntil { if (BwS_nombreJoueurs != 0) then { _unit move (position ([_unit] call BwS_fn_nearestPlayer)); sleep 5; (_unit distance ([_unit] call BwS_fn_nearestPlayer)) < 10} else {false}; };
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
		_unit doFire ([_unit] call BwS_fn_nearestPlayer);		
		
		// for "_i" from 0 to 5 do 
		// {
			// _unit forceWeaponFire [currentWeapon _unit, "FullAuto"];
			// sleep random 1;
		// };

		while {alive _unit} do { if (BwS_nombreJoueurs != 0) then { _unit move (position ([_unit] call BwS_fn_nearestPlayer)); _unit doFire ([_unit] call BwS_fn_nearestPlayer); sleep 5;} else {false};};
	};
}
else
{
	_unit addEventHandler ["Killed", 
	{
		"Un civil à été tué. Pénalité financière !" remoteExec ["systemChat"];
		[usine_us, -2000] call BwS_fn_ajouter_credits_usine;
	}]; 
	
	_unit addeventhandler ['FiredNear', {
				(_this select 0) playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';
				(_this select 0) stop true;
			}];
};