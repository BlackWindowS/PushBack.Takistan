player removeAction (_this select 2);

_nomMarker = format ["detresse_%1", name player];

_marqueurtranspondeur = createMarker [_nomMarker, position player];

_nomMarker setMarkerText "Signal de détresse";
_nomMarker setMarkerColor "ColorBlue";
_nomMarker setMarkerType "mil_flag"; 

_temps = time + 600;

waitUntil {time >= _temps};

deleteMarker _nomMarker;
