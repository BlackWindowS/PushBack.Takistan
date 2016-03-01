_u = _this select 0;
_p = ["<t color='#ffff33'>Mettre les bouchons d'oreille</t>",{
	_s = _this select 0;
	_i = _this select 2;
	if (soundVolume != 1) then {
		1 fadeSound 1;
		_s setUserActionText [_i,"<t color='#ffff33'>Mettre les bouchons d'oreille</t>"];
	} else {
		1 fadeSound 0.25;
		_s setUserActionText [_i,"<t color='#ffff33'>Enlever les bouchons d'oreille</t>"];
	}
},[],-90,false,true,"","_target == vehicle player"];
_u addAction _p;
_u addEventHandler ["Respawn",{
	1 fadeSound 1;
	(_this select 0) addAction _p;
}];