/*
* Type d'objet et force de l'explosion
* Type of object and strength of the explosion
*/
BwS_IED_cfg_types = [
		["Land_CanisterOil_F", "R_80mm_HE"],
		["Land_FMradio_F", "R_80mm_HE"],
		["Land_Canteen_F", "R_80mm_HE"],
		["Land_CerealsBox_F", "R_80mm_HE"],
		["Land_BottlePlastic_V1_F", "R_80mm_HE"],
		["Land_PowderedMilk_F", "R_80mm_HE"],
		["Land_RiceBox_F", "R_80mm_HE"],
		["Land_TacticalBacon_F", "R_80mm_HE"],
		["Land_VitaminBottle_F", "R_80mm_HE"],
		["Land_BottlePlastic_V2_F", "R_80mm_HE"],
		["RoadCone_F", "R_80mm_HE"],
		["Land_Pallets_F", "M_Mo_82mm_AT_LG"],
		["Land_WheelCart_F", "R_80mm_HE"],
		["Land_Tyre_F", "R_80mm_HE"],
		["Land_ButaneCanister_F", "M_Mo_82mm_AT_LG"],
		["Land_Bucket_F", "M_Mo_82mm_AT_LG"],
		["Land_GasCanister_F", "M_Mo_82mm_AT_LG"],
		["Land_Pillow_F", "M_Mo_82mm_AT_LG"],
		["Land_Portable_generator_F", "HelicopterExploSmall"],
		["Land_WoodenBox_F", "HelicopterExploSmall"],
		["Land_MetalBarrel_F", "M_Mo_82mm_AT_LG"],
		["Land_BarrelTrash_grey_F", "HelicopterExploSmall"],
		["Land_Sacks_heap_F", "HelicopterExploSmall"],
		["Land_WoodenLog_F", "HelicopterExploSmall"],
		["Land_WoodPile_F", "HelicopterExploSmall"],
		["Land_Sack_F", "HelicopterExploSmall"], 
		["Land_Suitcase_F", "M_Mo_82mm_AT_LG"], 
		["Land_BarrelTrash_F", "Bo_GBU12_LGB"], 
		["Land_GarbageBags_F", "Bo_GBU12_LGB"], 
		["Land_GarbageWashingMachine_F", "Bo_GBU12_LGB"], 
		["Bomb", "Bo_GBU12_LGB_MI10"]];
		// selectRandom ["M_Mo_82mm_AT_LG", ""], "Bo_Mk82", ""], "HelicopterExploBig", ""], "HelicopterExploSmall", ""], "R_80mm_HE", ""], "Bo_GBU12_LGB"]

/*------ stops a tank
Bo_GBU12_LGB_MI10
Bo_GBU12_LGB
Bo_Mk82
------ stops a marshall
HelicopterExploSmall

------stops a hunter
M_Mo_82mm_AT_LG
HelicopterExploBig
M_Air_AA_MI02 

------ low damage
M_Titan_AA_long
M_Zephyr
M_Air_AT
M_Titan_AA
M_Titan_AT
R_80mm_HE
M_PG_AT

------ white smoke glows bright at night
R_230mm_HE*/		

/*
* Condition de désarmement pour l'addAction
* Defusal condition to get the addAction
*/
BwS_IED_cfg_condition_desarmement = """ACE_DefusalKit"" in (items player) && ""MineDetector"" in (items player) && (_target distance _this) <= 3";

/*
* Nombre d'IED à placer sur la carte entière
* Number of IED to place on the entire map
*/		
BwS_IED_cfg_nombre_d_IED = 50 + random 10;

/*
* Probabilité que l'IED soit contrôlé par une IA à distance => implique que l'observateur soit vivant pour déclencher 
* Probability that the IED is remote controlled by an AI => need the AI to be alive to trigger the explosion
*/
BwS_IED_cfg_probabilite_RC = 0.3;

/*
* Toutes les routes de la carte, pour un script portable
* Every roads of the map, for a portable script
*/
// _centerMap = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
// ROADS = (_centerMap nearRoads 20000) - ((getMarkerPos "PC") nearRoads 1000);