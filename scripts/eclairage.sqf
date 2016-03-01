
_positionBaseX = position lamp select 0;
_positionBaseY = position lamp select 1;

_espacement = 30;

for "_j" from 1 to 3 do 
{
	for "_i" from 1 to 50 do
	{
		 createVehicle ["Land_Camping_Light_F", [_positionBaseX + _i*(sin(45)*_espacement), _positionBaseY + _i*(cos(45)*_espacement)], [], 0, "CAN_COLLIDE"];
	};
	_positionBaseX = _positionBaseX + _j*cos(135)*_espacement;
	_positionBaseY = _positionBaseY + _j*sin(135)*_espacement;
};