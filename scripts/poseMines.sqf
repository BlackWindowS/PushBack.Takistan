if (count allMines < 20) then
{
	private ["_mineur", "_nombreMinesMax", "_nbMines", "_minesTypes", "_type"];

	_mineur = _this select 0;

	_nombreMinesMax = (random 5) + 5;
	_nbMines = 0;

	_minesTypes = [
		"ATMine",
		"APERSMine",
		"APERSBoundingMine"
	];

	_type = _minesTypes select floor(random (count _minesTypes));
		
	while {alive _mineur && _nombreMinesMax >= _nbMines} do
	{
		if (isOnRoad _mineur) then
		{
			createMine [_type, position _mineur, [], (random 5) + 2.5];
			_nbMines = _nbMines + 1;
			sleep (random 3) / 3;
		};
		sleep 0.01;
	};
};