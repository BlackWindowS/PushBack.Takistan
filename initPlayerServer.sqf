private ["_player", "_UID"];

_player = _this select 0;

_UID = getPlayerUID _player;
	
waitUntil {!isNull _player};

if !(_UID in BwS_joueurs_BwS) then 
{
	if (_UID in (BwS_joueurs_russes + BwS_joueurs_americains)) then
	{
		if (((side _player == west) && !(_UID in BwS_joueurs_americains)) ||
			((side _player == east) && !(_UID in BwS_joueurs_russes))) then 
			{
				"ia773" serverCommand format ["#kick %1", _UID];
			};
	}
	else 
	{
		if (side _player == west) then {BwS_joueurs_americains pushBack _UID};
		if (side _player == east) then {BwS_joueurs_russes pushBack _UID};
	};
};

if (!hasInterface) then 
{
	nul = [] execVM "scripts\systemes\compilation_serveur.sqf";
	_centerMap = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	ROADS = (_centerMap nearRoads 20000) - ((getMarkerPos "PC") nearRoads 1000) - ((getMarkerPos "PC_1") nearRoads 2000);
};