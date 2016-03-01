
BwS_fn_TP_COP_USA = {
	(_this select 0) addAction ["<t color='#555555'>COP #1</t>", {player moveInCargo COP_USA_1; [] spawn BwS_fn_chargement}];
	(_this select 0) addAction ["<t color='#555555'>COP #2</t>", {player moveInCargo COP_USA_2; [] spawn BwS_fn_chargement}];
};

BwS_fn_TP_COP_RU = {
	(_this select 0) addAction ["<t color='#555555'>COP #1</t>", {player moveInCargo COP_RU_1; [] spawn BwS_fn_chargement}];
	(_this select 0) addAction ["<t color='#555555'>COP #2</t>", {player moveInCargo COP_RU_2; [] spawn BwS_fn_chargement}];
};

{
	[_x] call BwS_fn_TP_COP_USA;
} forEach [FOBa, FOBb];

{
	[_x] call BwS_fn_TP_COP_RU;
} forEach [FOBA_R, FOBB_R];