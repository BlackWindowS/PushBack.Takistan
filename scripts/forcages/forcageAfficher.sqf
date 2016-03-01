private ["_markers"];

_markers = [];

{
	_nomMarker = format ["unite_%1", random 1000];
	
	_markers = _markers + [_nomMarker];
	
	_marker = createMarkerLocal [_nomMarker, position _x];

	_nomMarker setMarkerShapeLocal "ICON";
	_nomMarker setMarkerTypeLocal "hd_dot"; 
	_nomMarker setMarkerAlphaLocal 1;
	_nomMarker setMarkerTextLocal format ["%1", getText (configFile >> "CfgVehicles" >> typeof _x >> "DisplayName")];
	_nomMarker setMarkerColorLocal "ColorEast";
} forEach allUnits;

sleep 60;

{ deleteMarker _x; } forEach _markers;