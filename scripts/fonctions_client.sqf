BwS_fn_chargement = 
{
	startLoadingScreen ["Chargement en cours"]; 
	waituntil {preloadCamera position player}; 
	endLoadingScreen;
}; 

BwS_fn_creerMarqueur =
{
	private ["_nomMarker", "_text", "_position", "_marker", "_couleur"];
	
    //[input,index,(defaultValue,dataTypes,requiredCount)] call BIS_fnc_param; 
	
	_text = _this select 0;
	_position = [_this, 1, [0, 0, 0], [[]], 3] call BIS_fnc_param;
	_couleur = [_this, 2, "Default", [""]] call BIS_fnc_param;
	
	_nomMarker = format ["%1", random 10000];
	
	_marker = createMarker [_nomMarker, _position];

	_nomMarker setMarkerColor _couleur;
	_nomMarker setMarkerShape "ICON";
	_nomMarker setMarkerType "hd_dot"; 
	_nomMarker setMarkerAlpha 1;
	_nomMarker setMarkerText format ["%1", _text];
	sleep 60;
	deleteMarker _nomMarker;
};

BwS_fn_RADAR_effacer_marqueurs = {
	{ 
		private ["_a"]; 
		_a = toArray _x; 
		_a resize 5;
		if (toString _a == "radar") then 
		{ 
			deleteMarker _x; 
		};
	} forEach allMapMarkers;
};

/*
BwS_fn_spawn_COP = {
	private ["_position", "_nombreCOP"];
	
	_position = _this select 0;
	
	// récupération du nombre de COP 
	_nombreCOP = switch (side player) do 
	{
		case west : {publicVariable "BwS_nombre_COP_americaines"; BwS_nombre_COP_americaines}; 
		case east : {publicVariable "BwS_nombre_COP_russes"; BwS_nombre_COP_russes}; 
		default {0};
	};
	
	if (_nombreCOP == 2) then {
		hint "Nombre maximal de COP atteint."} 
	else {
		private ["_FOB"];
		// creation de l'objet
		_FOB = "" createVehicle _position;
		// creation du marqueur
			// BIS_fnc_MP à destination de la faction
		// stockage de variables dans l'objet
			// faction qui la possède
			
		// add EH destruction 
			// si détruite, delete le mrkr, décrémente nombre COP faction
			
		// addAction en BIS_fnc_MP avec target FOBeur_XXX (russe/americain)
	};

};
*/