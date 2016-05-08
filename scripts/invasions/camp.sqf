scriptName "BwS_fn_camp";
private ["_position", "_positionBase", "_objects", "_qttPax"];

_position = (_this select 1);
_positionBase = [];
_objects = [];
_qttPax = 0;

if ("petit" in _this) then {
	_qttPax = (3 + floor(random 6));
	_positionBase = [1871.51,691.775,0.00143909];
	_objects = [["rhs_DSHKM_ins",[1875.48,689.081,-0.0673723],206.782],
		["Land_BagFence_Round_F",[1874.35,697.123,-0.00130129],139.838],
		["Land_BagFence_Round_F",[1874.91,687.379,-0.00130129],20.3673],
		["Land_BagFence_Round_F",[1881.58,696.952,-0.00130129],224.633],
		["Land_BagFence_Round_F",[1880.96,688.332,-0.00130129],312.826],
		["rhs_weapon_crate",[1880.23,689.038,0.000919342],140.542],
		["Land_Sleeping_bag_F",[1876.4,694.622,0],177.168],
		["Land_Sleeping_bag_F",[1878.67,694.786,0],177.168],
		["FirePlace_burning_F",[1877.71,691.977,-9.53674e-007],0],
		["rhs_gear_crate",[1879.62,689.619,-0.000130177],131.919],
		["Land_MetalBarrel_F",[1880.63,696.57,5.48363e-005],359.995],
		["Land_BarrelWater_F",[1881.3,695.692,5.57899e-005],0.000500177],
		["Land_Map_altis_F",[1876.54,693.59,-4.76837e-007],269.685],
		["Land_Sleeping_bag_F",[1877.52,694.743,0],177.168],
		["rhs_g_Soldier_SL_F",[1871.51,691.775,0.00143909],93.2095],
		["Camera",[1872.02,691.644,1.44804],0],
		["GroundWeaponHolder",[1871.81,691.767,0],93.2095]];
};

if ("moyen" in _this) then 
{
	_qttPax = (6 + (random 9));
	_positionBase = [3591.01,4298.51,0.00143862];
	_objects = [["Land_BagFence_Long_F",[3583.08,4300.09,-0.0483766],282.557],
	["B_G_Offroad_01_F",[3586,4298.99,-0.0587568],28.759],
	["Land_TentA_F",[3594.85,4292.84,-0.170759],152.292],
	["Land_TentA_F",[3589.1,4294.85,-0.184682],252.25],
	["Land_BagFence_Round_F",[3596.66,4303.62,-0.104334],196.331],
	["Land_Campfire_F",[3593.22,4296.47,0.0603871],189.111],
	["Land_BagFence_Long_F",[3597.72,4298.97,-0.0790963],272.402],
	["Land_BagFence_Long_F",[3592.67,4303.78,-0.0685282],180.406],
	["Land_BagFence_Long_F",[3596.74,4292.83,-0.0826511],296.856],
	["Land_BagFence_Long_F",[3587.1,4303.42,-0.0360675],162.883],
	["IG_supplyCrate_F",[3587.94,4298.04,1.43051e-006],296.693],
	["Land_Sleeping_bag_F",[3594.75,4297.79,0.0178695],226.845],
	["Land_Sleeping_bag_F",[3592.64,4298.64,-0.00994062],175.995],
	["Land_GasTank_01_khaki_F",[3589.06,4298.08,2.67029e-005],238.774]];
};

if ("grand" in _this) then 
{
	_qttPax = (9 + (random 10));
	_positionBase = [2080.22,60.7977,0.00143909];
	_objects = [["Land_HBarrierTower_F",[2079.07,54.6097,0],90.0067],
		["Land_HBarrier_5_F",[2079.76,50.5923,0],179.405],
		["rhs_DSHKM_ins",[2077.5,55.0315,-0.0923691],270.279],
		["Land_HBarrier_3_F",[2075.42,64.5416,0],89.0099],
		["Land_Poster_06_F",[2074.59,57.5479,1.4092],102.315],
		["GroundWeaponHolder",[2080.49,60.7864,0],93.2095],
		["Land_HBarrier_5_F",[2079.69,70.4284,0],179.405],
		["Land_HBarrier_5_F",[2075.48,69.0469,0],90.1011],
		["rhs_ural_chdkz",[2077.83,66.1992,0.0701132],179.386],
		["CamoNet_BLUFOR_open_F",[2087.2,60.4123,0],267.02],
		["Land_HBarrier_5_F",[2090.95,50.6383,0],179.405],
		["Land_HBarrier_5_F",[2093.84,62.5662,0],90.1011],
		["Land_HBarrier_5_F",[2085.36,50.6423,0],179.405],
		["Land_HBarrier_5_F",[2093.89,56.8845,0],90.1011],
		["Land_TentA_F",[2091.94,62.6007,0],88.8642],
		["Land_TentA_F",[2091.96,60.9831,0],88.8642],
		["rhs_DSHKM_ins",[2091.82,51.853,-0.0673752],143.21],
		["Land_BagFence_Round_F",[2092.92,50.6715,-0.00130129],322.029],
		["Land_Sink_F",[2083.52,51.9222,-9.53674e-007],360],
		["Land_CampingChair_V2_F",[2087.79,59.2252,2.09808e-005],28.2875],
		["Land_PortableLight_single_F",[2084.11,55.4706,0],217.752],
		["Land_CampingTable_F",[2087.39,58.5609,2.86102e-006],202.694],
		["MapBoard_altis_F",[2086.02,57.1487,-0.00221109],235.399],
		["MapBoard_stratis_F",[2087.81,56.4223,-0.00218868],182.774],
		["rhs_g_Soldier_SL_F",[2080.22,60.7977,0.00143909],93.2095],
		["Camera",[2080.79,60.6509,1.39863],0],
		["RHS_UAZ_chdkz",[2080.46,67.2324,0.0177908],181.921],
		["Land_HBarrier_5_F",[2093.86,68.2064,3.33786e-006],90.1011],
		["Land_HBarrier_5_F",[2090.88,70.4743,0],179.405],
		["Land_HBarrier_5_F",[2085.3,70.4783,0],179.405],
		["Land_TentA_F",[2088.23,68.5901,0],354.261],
		["Land_TentA_F",[2086.77,68.5052,0],354.261],
		["Land_TentA_F",[2089.85,68.683,0],354.261],
		["Land_TentA_F",[2091.92,64.2037,0],88.8642],
		["rhs_DSHKM_ins",[2092.08,68.1179,-0.0673747],35.3695],
		["Land_BagFence_Round_F",[2092.84,69.5003,-0.00130129],218.728],
		["Campfire_burning_F",[2088.83,65.4865,0.0299988],0],
		["rhs_weapon_crate",[2083.06,68.2031,9.53674e-007],270.446],
		["rhs_weapon_crate",[2082.21,68.1182,9.53674e-007],270.446],
		["Land_Portable_generator_F",[2085.43,68.266,-0.000821114],267.014],
		["rhs_mags_crate",[2084.2,68.0797,-8.39233e-005],185.08],
		["rhs_mags_crate",[2084.32,68.9923,-0.000139236],185.066],
		["rhs_mags_crate",[2084.25,68.5319,-0.000144482],185.085],
		["Land_CarBattery_01_F",[2085.31,69.377,2.0504e-005],271.286],
		["Land_CarBattery_01_F",[2085.11,69.3729,-4.76837e-007],271.18],
		["Land_CarBattery_01_F",[2085.5,69.3573,-0.0114055],271.305],
		["Land_Ammobox_rounds_F",[2083.88,67.8662,-0.000164032],360],
		["Land_Ammobox_rounds_F",[2084.46,67.6112,-0.000165462],0.000643641],
		["Land_Ammobox_rounds_F",[2084.46,67.7758,-0.000163555],2.86988e-005],
		["Land_Ammobox_rounds_F",[2083.89,67.6989,-0.000164509],2.62129e-006],
		["Land_Camping_Light_F",[2088.24,66.8421,-0.00114346],0.00368104],
		["Land_PortableLight_single_F",[2082.77,64.6501,2.86102e-006],298.9]]
};
// placement : 

{ 
	_temp = createVehicle [(_x select 0), ([_position, [_positionBase, _x select 1] call BwS_fn_substractArray] call BwS_fn_addArray), [], 0, "CAN_COLLIDE"];
	_temp setDir (_x select 2);
	_temp setVectorUp surfaceNormal position _temp;
	_temp setPosATL [position _temp select 0, position _temp select 1, 0];
} forEach _objects;

if (BwS_Debug) then { ["camp", _position, "ColorYellow"] spawn BwS_fn_creerMarqueur; };

private ["_eastHQ", "_group", "_soldats"];

_group = [_position, _qttPax, resistance, resistance] call BwS_fn_spawnGroup;
sleep 1;
[_group, _position, 50] call BIS_fnc_taskPatrol;
BwS_var_groupes_a_exclure pushBackUnique _group;
// [_group] spawn BwS_fn_gestionPatrolSoftMoyen;

// Brouilleur radio
_posX = (_position select 0)-30+random(60);
_posY = (_position select 1)-30+random(60);

[[_posX, _posY, 0]] call BwS_fn_brouilleur;

/*
Code pour récupérer le camp

dans la console : tab = []; { tab pushback [typeof _x, position _x, direction _x]} forEach (position player nearObjects 300); copyToClipboard format ["%1 %2", position player, tab];
récupérer la variable tab ainsi que la position du joueur lors de la récup de tab et me l'envoyer

*/