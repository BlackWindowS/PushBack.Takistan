
private ["_config"];
_config = [] execVM "scripts\invasions\config.sqf";
waitUntil {scriptDone _config}; 

// peuplement du serveur
if (BwS_var_casernes) then {for "_i" from 0 to 10+random(3) do {	[] spawn BwS_fn_caserne; sleep 0.01;};};

if (BwS_var_usines) then {for "_i" from 0 to 10+random(3) do {	[] spawn BwS_fn_usines; sleep 0.01;};};

// for "_i" from 0 to (10 + (random 5)) do {	[] spawn BwS_fn_motorizedPatrolTeam; };

// for "_i" from 0 to (15 + (random 10)) do {	[] spawn BwS_fn_patrolTeam;		};

for "_i" from 0 to (5 + (random 0)) do {	[] spawn BwS_fn_mortier;	};

// for "_i" from 0 to (4 + (random 2)) do {	[] spawn BwS_fn_aerialPatrol;	};

_positionCamps = [];
for "_i" from 0 to (3 + (random 2)) do 
{	
	_position = position (selectRandom ROADS);
	_position set [0, (_position select 0)-300+random(600)];
	_position set [1, (_position select 1)-300+random(600)];
	
	// _positionCamps pushBack _position;
	[(selectRandom ["petit", "moyen", "grand"]), _position] spawn BwS_fn_camp;
};

BwS_fn_loop = {
	scriptName "BwS_fn_loop";
	waitUntil {sleep 1800; (({side _x == BwS_var_side_ennemie} count allUnits) < 50) && (count allPlayers == 0)};
	execVM "scripts\invasions\loop.sqf";
};

[] spawn BwS_fn_loop;

// sleep 60;	

// while {true} do
// {	
	// waituntil { ({side _x == east} count allGroups) <= 40};
		
	// BwS_nombreJoueurs = count allPlayers;
	// if (BwS_nombreJoueurs != 0) then 
	// {
		// private ["_alea"];
		
		// _alea = 5 + random 5;
		// BwS_nombreEnnemis = {side _x == East} count allUnits;
		// if (BwS_nombreEnnemis < 50) then {_alea = 10 + random 6};
		
		// _nbPara = ceil (0.4 * _alea);
		// _nbAmphibie = ceil (0.2 * _alea);
		// _nbChar = ceil (0.2 * _alea);
		// _nbChass = ceil (0.2 * _alea);
		
		// for "_i" from 0 to _nbPara do {
			// [] spawn BwS_fn_paradrop;
			// sleep 0.01;
		// };
		
		// for "_i" from 0 to _nbAmphibie do {
			// [] spawn BwS_fn_char;
			// sleep 0.01;
		// };
		
		// for "_i" from 0 to _nbChar do {
			// [] spawn BwS_fn_vehicleDrop;
			// sleep 0.01;
		// };
		
		// for "_i" from 0 to _nbChass do {
			// [] spawn BwS_fn_chasseur;
			// sleep 0.01;
		// };	
		
		// sleep 60;
	// };
	
	// sleep 1;
// };