[_this select 0, _this select 1] spawn { 

	private ["_damageTaken", "_player", "_initSound", "_volume"];
	
	_damageTaken = _this select 1;
	_player = _this select 0;
	
	_player forceWalk true;
    _player switchMove "Acts_CrouchingCoveringRifle01"; 	
	
	sleep 0.3;
	
	_initSound = soundVolume;
	
	1 fadeMusic 0;
	0.5 fadeSound 0.2;
	
	_volume = linearConversion [0,60,_damageTaken*10000, 0.1, 1, true];
	playSound3d["A3\Missions_F_EPA\data\sounds\combat_deafness.wss", _player, false, getpos _player, _volume];
	
	addCamShake [2, 5, 20];
	
	private ["_blur"];
	_blur = ppEffectCreate ["DynamicBlur", 474];
	_blur ppEffectEnable true;
	_blur ppEffectAdjust [0];
	_blur ppEffectCommit 0;
	
	waitUntil {ppEffectCommitted _blur};
	
	_blur ppEffectAdjust [10];
	_blur ppEffectCommit 0;
	
	titleCut ["", "WHITE IN", 5];
	[_player] spawn {_futur = time + 5; waitUntil {time > _futur}; (_this select 0) switchMove "";};
	_blur ppEffectAdjust [0];
	_blur ppEffectCommit 100*_damageTaken;
	
	waitUntil {ppEffectCommitted _blur};
	
	_blur ppEffectEnable false;
	ppEffectDestroy _blur;
	
	_player forceWalk false;
	_player switchMove "";
	
	0.5 fadeSound _initSound;
};  