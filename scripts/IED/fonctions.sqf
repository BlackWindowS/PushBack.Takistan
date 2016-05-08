BwS_IED_fn_init =
{
	scriptName "BwS_IED_fn_init";

	for "_i" from 0 to BwS_IED_cfg_nombre_d_IED do
	{
		_randomRoad = selectRandom ROADS;
		_randomType = selectRandom BwS_IED_cfg_types;
		
		_IED = (_randomType select 0) createVehicle ([_randomRoad] call EPD_FIND_LOCATION_BY_ROAD);

		if (_IED != objNull) then {			
			_IED setVariable ["BwS_IED_est_un_IED", true, true];
			_IED setVariable ["BwS_IED_force", (_randomType select 1), true];
			if (random 1 < BwS_IED_cfg_probabilite_RC) then
			{
				_IED setVariable ["BwS_IED_RC", true, true];
				_GRP_controleur = [(position _IED), 1, civilian, resistance] call BwS_fn_spawnGroup;
				BwS_var_groupes_a_exclure pushBack _GRP_controleur; 
				sleep 0.01;
				_controleur = (units _GRP_controleur) select 0;
				_controleur setPos [(position _controleur select 0)-10+random(20), (position _controleur select 1)-10+random(20)];
				_controleur setBehaviour "STEALTH";
				_controleur disableAI "MOVE";
				_IED setVariable ["BwS_IED_controleur", _controleur, true];
				_controleur addMagazine "rhs_30Rnd_545x39_AK";
				_controleur addWeapon "rhs_weap_ak74m";
				_controleur addMagazine "rhs_30Rnd_545x39_AK";
				_controleur addMagazine "rhs_30Rnd_545x39_AK";
			}
			else
			{
				_IED setVariable ["BwS_IED_RC", false, true];
				_IED setVariable ["BwS_IED_controleur", objNull, true];
			};
		};		
		[format ["IED %1", (_ied getVariable "BwS_IED_RC")], position _IED] spawn BwS_fn_creerMarqueur;
	};
};

EPD_CREATE_FRAGMENTS = { // fonction de [EPD] Brian du script random IED
	_pos = _this select 0;
	_numberOfFragments = _this select 1;
	for "_i" from 0 to _numberOfFragments - 1 do{
		_pos set[2,.1 + random 2]; 
		_bullet = "B_408_Ball" createVehicle _pos;
		_angle = random 360;
		_speed = 450 + random 100;
		_bullet setVelocity [_speed*cos(_angle), _speed*sin(_angle), -1*(random 4)];
	};
};

EPD_FIND_LOCATION_BY_ROAD = { // fonction de [EPD] Brian du script random IED
	_road = _this select 0;
	_orthogonalDist = 5;
	_dir = 0;
	if(count (roadsConnectedTo _road) > 0) then {
		_dir  = [_road, (roadsConnectedTo _road) select 0] call BIS_fnc_DirTo;
	};
	_position = getpos _road;
	_opositionX = _position select 0;
	_opositionY = _position select 1;

	_offSetDirection = 1;
	if((random 100) > 50) then { _offSetDirection = -1;};

	_positionX = _opositionX + (random 5) * _offSetDirection * sin(_dir);
	_positionY = _opositionY + (random 5) * _offSetDirection * cos(_dir);

	if((random 100) > 50) then { _offSetDirection = -1 * _offSetDirection;};		

	_tx = _positionX;
	_ty = _positionY;

	while{isOnRoad [_tx,_ty,0]} do{
		_orthogonalDist = _orthogonalDist + _offSetDirection;
		_tx = (_positionX + (_orthogonalDist * cos(_dir)));
		_ty = (_positionY + (_orthogonalDist * sin(_dir)));
	};	

	_extraOffSet = 1 + random 5;
	//move it off the road a random amount
	_tx = (_positionX + ((_orthogonalDist + _extraOffSet *_offSetDirection) * cos(_dir)));
	_ty = (_positionY + ((_orthogonalDist + _extraOffSet *_offSetDirection) * sin(_dir)));

	//ensure we didn't put it on another road, this happens a lot at Y type intersections
	while{isOnRoad [_tx,_ty,0]} do
	{
		_extraOffSet = _extraOffSet - 0.5;
		_tx = (_positionX + ((_orthogonalDist + _extraOffSet *_offSetDirection) * cos(_dir)));
		_ty = (_positionY + ((_orthogonalDist + _extraOffSet *_offSetDirection) * sin(_dir)));
	};
			
	[_tx,_ty,0];
};

	
BwS_IED_fn_Explose_IED = 
{
	_ied = (_this select 0);
	_ied setVariable ["BwS_IED_est_un_IED", false, true];
	
	_pos = position _ied;
	_type = (_ied getVariable ["BwS_IED_force", "Bo_GBU12_LGB"]);
	
	deleteVehicle _ied;

	[_pos, 100] call EPD_CREATE_FRAGMENTS;
	[[_pos], "IED_SCREEN_EFFECTS", true, false] spawn BIS_fnc_MP;
	[[_pos], "IED_SMOKE_LARGE", true, false] spawn BIS_fnc_MP;
	[[_pos], "SHOCK_WAVE", true, false] spawn BIS_fnc_MP;
	
	_pos set [2, 0];
	_type createVehicle _pos;
};

BwS_IED_fn_addAction =
{
	_ied = (_this select 0);
	
	_desarmer = ("<t color=""#27EE1F"">") + ("Désarmer l'IED") + "</t>";
	
	_ied addAction [
		_desarmer,
		{
			_ied = (_this select 3) select 0;
			
			[[[player], {(_this select 0) playmovenow "AinvPknlMstpSnonWrflDr_medic4";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
			disableUserInput true;
			sleep 4.545;			
			
			if ((joueurEOD && (random 100 > 98)) or (random 100 < 10)) then {_ied setVariable ["BwS_IED_est_un_IED", false, true];}
			else {[_ied] spawn BwS_IED_fn_Explose_IED};
			
			[[[player], {(_this select 0) playmove "AinvPknlMstpSnonWrflDr_medic3";}], "BIS_fnc_call", nil, false, false] call BIS_fnc_MP;
			sleep 6.545;
			disableUserInput false;

			_ied removeAction (_this select 2);
		},
		[_ied],
		11,
		false,
		true,
		"",
		BwS_IED_cfg_condition_desarmement
	];
};	