// Création du marqueur
private ["_array"];
_array = [];
_drapeauFOB = "";

if (side player == west) then 
{
	_array = [	[FOBa, "FOB Alpha"], 
				[FOBb, "FOB Bravo"]];
	_drapeauFOB = "flag_france";
};

if (side player == east) then 
{
	_array = [	[FOBA_R, "FOB Alpha"], 
				[FOBB_R, "FOB Bravo"]];
	_drapeauFOB = "rhs_flag_vdv";
};

{
	createMarkerLocal [(_x select 1), position (_x select 0)];
	(_x select 1) setMarkerTextLocal (_x select 1);
	(_x select 1) setMarkerTypeLocal _drapeauFOB;
	
} forEach _array;

// Déplacement du marqueur
while {true} do
{
	{
		(_x select 1) setMarkerPosLocal position (_x select 0);
	} forEach _array;
	sleep 10;
};