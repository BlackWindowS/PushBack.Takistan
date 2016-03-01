// [] execVM "scripts\surveillerVehicules.sqf";

// private ["_typesDeVehicules", "_textures"];

// _typesDeVehicules = [
	// "B_Heli_Attack_01_F",
	// "B_APC_Wheeled_01_cannon_F",
	// "B_MRAP_01_F",
	// "B_MRAP_01_hmg_F",
	// "B_MRAP_01_gmg_F",
	// "B_Heli_Transport_01_F",
	// "B_Plane_CAS_01_F",
	// "B_Heli_Light_01_F",
	// "B_Heli_Light_01_armed_F",
	// "B_APC_Tracked_01_rcws_F",
	// "B_Quadbike_01_F",
	// "C_Quadbike_01_F",
	// "O_Quadbike_01_F",
	// "B_MBT_01_cannon_F",
	// "B_MBT_01_TUSK_F",
	// "B_APC_Tracked_01_AA_F"//,
	// "B_G_Offroad_01_F"
	// ]; // les index des vehicules correspondent aux textures
// _textures = [
	// [[0, "images\textures\tigre.jpg"]],
	// [[0, "images\textures\VBCI_Groland\VBCI.paa"], [2, "images\textures\VBCI_Groland\VBCI2.paa"]],
	// [[0, "images\textures\vbl_Groland\vbl.paa"], [1, "images\textures\vbl_Groland\vbl2.paa"]], // -------------------
	// [[0, "images\textures\hunter recto.jpg"], [1, "images\textures\hunter verso.jpg"]], // variantes du hunter
	// [[0, "images\textures\hunter recto.jpg"], [1, "images\textures\hunter verso.jpg"]], // -------------------
	// [[0, "images\textures\ghosthawk verso.jpg"], [1, "images\textures\ghosthawk recto.jpg"]],
	// [[0, "images\textures\A164 RECTO.jpg"], [1, "images\textures\A164 VERSO.jpg"]],
	// [[0, "images\textures\ah6.jpg"]],
	// [[0, "images\textures\ah6.jpg"]],
	// [[0, "images\textures\panther.jpg"]],
	// [[0, "images\textures\quad recto.jpg"], [1, "images\textures\quad verso.jpg"]],
	// [[0, "images\textures\quad recto.jpg"], [1, "images\textures\quad verso.jpg"]],
	// [[0, "images\textures\quad recto.jpg"], [1, "images\textures\quad verso.jpg"]],
	// [[0, "images\textures\slammer verso.jpg"], [1, "images\textures\slammer recto.jpg"]],
	// [[0, "images\textures\slammer verso.jpg"], [1, "images\textures\slammer recto.jpg"]],
	// [[0, "images\textures\cheetah.jpg"]]//,
	// [[0, "images\textures\pickup.jpg"]]
	// ];

// while {true} do
// {
	// private ["_vehicules"];
	// _vehicules = (markerPos "PC" nearEntities [_typesDeVehicules, 500]) - [FOBa, FOBb];
	
	// {
		// private ["_a"];
		// _a = _x;
		
		// if ((typeOf _a) in _typesDeVehicules) then // si le vehicule qu'on analyse est du type à texturer
		// {
			// for "_i" from 0 to ((count _typesDeVehicules) - 1) do // on établit la position dans le tableau de ce vehicule
			// {
				// _index = _i;

				// if ((typeOf _a) == (_typesDeVehicules select _index)) then // si on a trouvé le bon index
				// {
					// for "_j" from 0 to (count (_textures select _index) - 1) do // on parcourt les textures et on les applique
					// {
						// _a setObjectTextureGlobal ((_textures select _index) select _j);
					// };
				// };
			// };
		// };
		// waitUntil {500 preloadObject _x}; 
	// } forEach _vehicules; // on parcourt tous les véhicules sur base
	
	// {
		// _x setObjectTextureGlobal [0, "images\textures\hunter rectohq.jpg"];
		// _x setObjectTextureGlobal [1, "images\textures\hunter versohq.jpg"];
	// } forEach [FOBa, FOBb];
		
	// saveGame;
	
	// sleep 300;
// };