
BwS_fn_TP_COP_USA = {
	(_this select 0) addAction ["<t color='#555555'>COP #1</t>", {player moveInCargo COP_USA_1; [] spawn BwS_fn_chargement}];
	(_this select 0) addAction ["<t color='#555555'>COP #2</t>", {player moveInCargo COP_USA_2; [] spawn BwS_fn_chargement}];
	(_this select 0) addAction ["<t color='#00FF00'>BASE</t>", {(_this select 1) setPos (getMarkerPos "respawn_west");}];
};

{
	[_x] call BwS_fn_TP_COP_USA;
} forEach [FOBa, FOBb];
