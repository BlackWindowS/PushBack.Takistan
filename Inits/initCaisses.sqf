// fn_clearCaisse = 
// {
	// private ["_caisse"];
	// _caisse = _this select 0;
	
	// _caisse allowDamage false;
	// clearItemCargoGlobal _caisse;
	// clearBackpackCargoGlobal _caisse;
	// clearWeaponCargoGlobal _caisse;
	// clearMagazineCargoGlobal _caisse;
// };

// private ["_armes", "_chargeurs", "_explosifs", "_gears", "_items", "_misc", "_backpacks", "_param", "_pos"];


// caisses = [caisseArmes, caisseChargeurs, caisseExplosifs, caisseItems, caisseMisc, caisseCasques, caisseVests, caisseTreillis, caisseBackpacks, poubelle];

// _armes = [
	// "R3F_Famas_F1",
	// "R3F_Famas_F1_DES",
	// "R3F_Famas_F1_HG",
	// "R3F_Famas_F1_HG_DES",
	// "R3F_Famas_F1_M203",
	// "R3F_Famas_F1_M203_DES",
	// "R3F_Famas_G2",
	// "R3F_Famas_G2_DES",
	// "R3F_Famas_G2_HG",
	// "R3F_Famas_G2_HG_DES",
	// "R3F_Famas_G2_M203",
	// "R3F_Famas_G2_M203_DES",
	// "R3F_Famas_surb_HG",
	// "R3F_Famas_surb_HG_DES",
	// "R3F_Famas_surb",
	// "R3F_Famas_surb_DES",
	// "R3F_Famas_surb_M203",
	// "R3F_Famas_surb_M203_DES",
	// "R3F_Famas_felin",
	// "R3F_Famas_felin_DES",
	// "R3F_TAC50",
	// "R3F_FRF2",
	// "R3F_FRF2_DES",
	// "R3F_PGM_Hecate_II",
	// "R3F_PGM_Hecate_II_DES",
	// "R3F_PGM_Hecate_II_POLY",
	// "R3F_M107",
	// "R3F_M107_DES",
	// "R3F_Minimi",
	// "R3F_Minimi_HG",
	// "R3F_Minimi_762",
	// "R3F_Minimi_762_HG",
	// "R3F_HK417L",
	// "R3F_HK417L_DES",
	// "R3F_HK417M",
	// "R3F_HK417M_DES",
	// "R3F_HK417M_HG",
	// "R3F_HK417M_HG_DES",
	// "R3F_HK417S_HG",
	// "R3F_HK417S_HG_DES",
	// "R3F_HK416M",
	// "R3F_HK416M_M203",
	// "R3F_HK416M_M203_DES",
	// "R3F_HK416M_DES",
	// "R3F_HK416M_HG",
	// "R3F_HK416M_HG_DES",
	// "R3F_MP5SD",
	// "R3F_MP5A5",
	// "R3F_M4S90",
	// "R3F_PAMAS",
	// "R3F_AT4CS",
	// "R3F_ERYX",
	// "R3F_STINGER"];
	
// _chargeurs = [   
	// "R3F_25Rnd_556x45_FAMAS",
	// "R3F_25Rnd_556x45_TRACER_FAMAS",
	// "R3F_30Rnd_556x45_FAMAS",
	// "R3F_30Rnd_556x45_TRACER_FAMAS",
	// "R3F_10Rnd_762x51_FRF2",
	// "R3F_7Rnd_127x99_PGM",
	// "R3F_7Rnd_127x99_PEI_PGM",
	// "R3F_10Rnd_127x99_M107",
	// "R3F_10Rnd_127x99_PEI_M107",
	// "R3F_200Rnd_556x45_MINIMI",
	// "R3F_100Rnd_762x51_MINIMI",
	// "R3F_20Rnd_762x51_HK417",
	// "R3F_20Rnd_762x51_TRACER_HK417",
	// "R3F_30Rnd_556x45_HK416",
	// "R3F_30Rnd_556x45_TRACER_HK416",
	// "R3F_30Rnd_9x19_MP5",
	// "R3F_7Rnd_M4S90",
	// "R3F_15Rnd_9x19_PAMAS",
	// "R3F_5Rnd_127x99_TAC50",
	// "R3F_AT4CS_Mag",
	// "R3F_ERYX_Mag",
	// "R3F_STINGER_Mag"];
	
// _explosifs = [
	// "1Rnd_HE_Grenade_shell",
	// "UGL_FlareWhite_F",
	// "UGL_FlareGreen_F",
	// "UGL_FlareRed_F",
	// "UGL_FlareYellow_F",
	// "UGL_FlareCIR_F",
	// "1Rnd_Smoke_Grenade_shell",
	// "1Rnd_SmokeRed_Grenade_shell",
	// "1Rnd_SmokeGreen_Grenade_shell",
	// "1Rnd_SmokeYellow_Grenade_shell",
	// "1Rnd_SmokePurple_Grenade_shell",
	// "1Rnd_SmokeBlue_Grenade_shell",
	// "1Rnd_SmokeOrange_Grenade_shell",
	// "3Rnd_HE_Grenade_shell",
	// "3Rnd_UGL_FlareWhite_F",
	// "3Rnd_UGL_FlareGreen_F",
	// "3Rnd_UGL_FlareRed_F",
	// "3Rnd_UGL_FlareYellow_F",
	// "3Rnd_UGL_FlareCIR_F",
	// "3Rnd_Smoke_Grenade_shell",
	// "3Rnd_SmokeRed_Grenade_shell",
	// "3Rnd_SmokeGreen_Grenade_shell",
	// "3Rnd_SmokeYellow_Grenade_shell",
	// "3Rnd_SmokePurple_Grenade_shell",
	// "3Rnd_SmokeBlue_Grenade_shell",
	// "3Rnd_SmokeOrange_Grenade_shell",
	// "MiniGrenade",
	// "HandGrenade",
	// "DemoCharge_Remote_Mag",
	// "SatchelCharge_Remote_Mag",
	// "ATMine_Range_Mag",
	// "ClaymoreDirectionalMine_Remote_Mag",
	// "APERSMine_Range_Mag",
	// "APERSBoundingMine_Range_Mag",
	// "SLAMDirectionalMine_Wire_Mag",
	// "APERSTripMine_Wire_Mag",
	// "SmokeShell",
	// "SmokeShellYellow",
	// "SmokeShellGreen",
	// "SmokeShellRed",
	// "SmokeShellPurple",
	// "SmokeShellOrange",
	// "SmokeShellBlue",
	// "Chemlight_green",
	// "Chemlight_red",
	// "Chemlight_yellow",
	// "Chemlight_blue",
	// "B_IR_Grenade"];

// _casques = [
	// "BwS_Beret_bws", 
	// "BwS_Casque",
	// "BwS_Casque_fs",
	// "BwS_Beret_SSA",
	// "BwS_Beret_Genie",
	// "BwS_Beret_ALAT",
	// "BwS_Beret_inf",
	// "BwS_Beret_arti",
	// "H_CrewHelmetHeli_B",
	// "H_PilotHelmetHeli_B",
	// "H_PilotHelmetFighter_B",
	// "H_HelmetCrew_B"];
	
// _vests = [
	// "V_RebreatherB",
	// "BwS_Gilet",
	// "BwS_Gilet_fs"];
	
// _treillis = [
	// "BwS_Treilli",
	// "BwS_Treilli_fs",
	// "U_B_Wetsuit",
	// "U_B_HeliPilotCoveralls",
	// "U_B_GhillieSuit",
	// "U_B_PilotCoveralls"];
	
// _backpacks = [
	// "BwS_Fast",
	// "BwS_Small",
	// "B_AssaultPack_blk",
	// "B_Kitbag_blk",
	// "B_TacticalPack_rgr",
	// "B_TacticalPack_mcamo",
	// "B_TacticalPack_blk",
	// "B_Carryall_mcamo",
	// "B_Carryall_khk",
	// "B_Carryall_cbr",
	// "B_Parachute",
	// "B_UAV_01_backpack_F"];	

// _items = [    
	// "ItemMap",
	// "ItemGPS",
	// "ItemCompass",
	// "ItemWatch",
	// "ItemRadio",
	// "B_UavTerminal",
	// "NVGoggles",
	// "FirstAidKit", 
	// "MediKit",
	// "ToolKit",
	// "MineDetector",
	// "Binocular",
	// "Laserbatteries",
	// "G_B_Diving",
	// "Item_R3F_SIT_COMDE",
	// "R3F_JIM_LR",
	// "R3F_JIM_LR_DES"];

// _misc = [
	// "R3F_AIMPOINT",
	// "R3F_AIMPOINT_DES",
	// "R3F_EOTECH",
	// "R3F_EOTECH_DES",
	// "R3F_J4",
	// "R3F_J4_DES",
	// "R3F_FELIN",
	// "R3F_FELIN_DES",
	// "R3F_FELIN_FRF2",
	// "R3F_J8",
	// "R3F_J8_DES",
	// "R3F_J8_MILDOT",
	// "R3F_J8_MILDOT_DES",
	// "R3F_J10",
	// "R3F_J10_DES",
	// "R3F_J10_MILDOT",
	// "R3F_J10_MILDOT_DES",
	// "R3F_NF",
	// "R3F_NF_DES",
	// "R3F_NF42",
	// "R3F_NF42_DES",
	// "R3F_ZEISS",
	// "R3F_ZEISS_DES",
	// "R3F_OB50",
	// "R3F_LAMPE_SURB",
	// "R3F_LAMPE_SURB_DES",
	// "R3F_POINTEUR_SURB",
	// "R3F_POINTEUR_SURB_DES",
	// "R3F_PIRAT",
	// "R3F_PIRAT_DES",
	// "R3F_SILENCIEUX_FAMAS",
	// "R3F_SILENCIEUX_FAMAS_DES",
	// "R3F_SILENCIEUX_HK416",
	// "R3F_SILENCIEUX_HK416_DES",
	// "R3F_SILENCIEUX_FRF2",
	// "R3F_SILENCIEUX_FRF2_DES",
	// "R3F_SILENCIEUX_HK417",
	// "R3F_SILENCIEUX_HK417_DES",
	// "R3F_SILENCIEUX_MINIMI",
	// "R3F_SILENCIEUX_MINIMI_DES",
	// "R3F_BIPIED_HK417",
	// "R3F_BIPIED_HK417_DES",
	// "muzzle_snds_L"];
	
// {	
	// [_x] call fn_clearCaisse;
// } forEach caisses;

// {
	// caisseArmes addWeaponCargoGlobal [_x, 50];
// } forEach _armes;

// {
	// caisseChargeurs addMagazineCargoGlobal [_x, 300];
// } forEach _chargeurs;

// caisseChargeurs addItemCargoGlobal ["R3F_APAV40", 300];
// caisseChargeurs addItemCargoGlobal ["R3F_AC58", 300];
// caisseChargeurs addItemCargoGlobal ["R3F_ECL40", 300];
// caisseChargeurs addItemCargoGlobal ["R3F_FUM40", 300];

// {
	// caisseExplosifs addMagazineCargoGlobal [_x, 50];
// } forEach _explosifs;

// {
	// caisseCasques addItemCargoGlobal [_x, 10];
// } forEach _casques;

// {
	// caisseTreillis addItemCargoGlobal [_x, 10];
// } forEach _treillis;

// {
	// caisseVests addItemCargoGlobal [_x, 10];
// } forEach _vests;

// {
	// caisseBackpacks addBackpackCargoGlobal [_x, 10];
// } forEach _backpacks;

// {
	// caisseItems addItemCargoGlobal  [_x, 10];
// } forEach _items; 

// {
	// caisseMisc addItemCargoGlobal [_x, 50];
// } forEach _misc; 

// _AGMMed = AGMMed;
// _AGMMisc = AGMMisc;

// _pos = position _AGMMed;
// deleteVehicle _AGMMed;
// _AGMMed = createVehicle ["AGM_Box_Medical", _pos, [], 0, "CAN_COLLIDE"];
// _AGMMed setDir -60;

// _pos = position _AGMMisc;
// deleteVehicle _AGMMisc;
// _AGMMisc = createVehicle ["AGM_Box_Misc", _pos, [], 0, "CAN_COLLIDE"];
// _AGMMisc setDir -60;


