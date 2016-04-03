/*
Ce script gère la production d'unités dans des usines

Les usines peuvent être totalement détruites ou bien reconstruites au bout d'un temps définit par BwS_var_cooldown_de_reconstruction_usines

[] spawn BwS_fn_usine;

*/

private ["_usine", "_continuer", "_dir", "_types"];

// _types = ["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_MBT_02_cannon_F", "O_MRAP_02_hmg_F"];
_types = ["rhs_t72bb_chdkz", "rhs_bmd1_chdkz", "rhs_btr70_chdkz", "rhs_uaz_ags_chdkz"];

// creation d'une usine position aléatoire
_positionusine = position (selectRandom ROADS);

_positionusine set [0, (_positionusine select 0) - 200 + random 400];
_positionusine set [1, (_positionusine select 1) - 200 + random 400];

_usine = "Land_i_Garage_V1_F" createVehicle _positionusine;
_dir =(random 360);
_usine setDir _dir;

_usine setVectorUp surfaceNormal position _usine;
_usine setPosATL [position _usine select 0, position _usine select 1, 1];

BwS_usines pushBack _usine;
publicVariable "BwS_usines";

// marqueur pour debug
if (BwS_Debug) then { ["usine", _positionusine, "ColorBlue"] spawn BwS_fn_creerMarqueur; };

// boucle tant random 1 > BwS_var_probabilite_usine_detruite_pour_toujours
_continuer = true;
while {_continuer} do
{
	// si damage usine < 1 && presence de joueurs - de 3000m
	if ((damage _usine < 1) && ([_usine] call BwS_fn_faut_il_produire_des_vehicules)) then // a changer
	{
		// creation d'un vehicule
		_vehicule = createVehicle [(selectRandom _types), _positionusine, [], 25, "NONE"];
		_vehicule setDir (_dir-90);
		createVehicleCrew _vehicule;
		_groupe = group driver _vehicule;
	
		// cool down de BwS_var_cooldown_production_unites_motorisees
		sleep BwS_var_cooldown_production_unites_motorisees;
	};
	
	// si usine détruite et qu'on est dans la proba de reconstruire
	if (damage _usine >= 1) then
	{
		if (random 1 > BwS_var_probabilite_usine_detruite_pour_toujours) then 
		{
			// cool down de BwS_var_cooldown_de_reconstruction_usines
			sleep BwS_var_cooldown_de_reconstruction_usines;
			
			// usine setDamage 0
			_usine setDamage 0;
		}
		else 
		{
			_continuer = false;
		};
	};
	
	// temporisation
	sleep 30;
};