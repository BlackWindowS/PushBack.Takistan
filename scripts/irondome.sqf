// Mis au point avec l'aide de ~R3F~Madbull

private ["_missile", "_dir_cible", "_cible"];

_cible = _this select 0;

_missile = "M_Titan_AA_long" createVehicle [getMarkerPos "IronDome" select 0, getMarkerPos "IronDome" select 1, (getMarkerPos "IronDome" select 2) + 500];

while {alive _missile} do
{
    _dir_cible = vectorNormalized ((getPosASL _cible) vectorDiff (getPosASL _missile) vectorAdd [0,0,0.8]);
    
	_dir_missile = vectorNormalized [
        _dir_cible select 0,
        _dir_cible select 1,
        sin (10 + asin(_dir_cible select 2))
    ];

    _vitesse = vectorMagnitude velocity _missile;
    _missile setVectorDir _dir_missile;
	_missile setVelocity (_dir_missile vectorMultiply _vitesse);
    sleep 0.01;
};