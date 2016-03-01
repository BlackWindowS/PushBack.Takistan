private ["_panneau", "_handlerInit"];

_panneau = _this select 0;

// _handlerInit = [] execVM "Inits\initCaisses.sqf";

// waitUntil {scriptDone _handlerInit};

_panneau addAction ["<t color='#FFFF00'>Stuff de base</t>", {private ["_player"]; _player = _this select 1; _player unassignItem "NVGoggles"; removeAllWeapons _player; removeAllItems _player; removeUniform _player; removeVest _player; removeBackpack _player; removeHeadgear _player; removeGoggles _player; _player addUniform "BwS_Treilli"; _player addHeadgear "BwS_beret_bws";}, [], 100];

_panneau addAction ["<t color='#876549'>Recharger les caisses</t>", {execVM "Inits\initCaisses.sqf"}]