//[player] execVM "scripts\simpleEP.sqf";
[player] execVM "scripts\systemes\surveillerJoueur.sqf";

//[player, 0] execVM "scripts\effetIED.sqf";

// fn_clr = {private ["_player"]; _player = _this select 0; _player unassignItem "NVGoggles"; removeAllWeapons _player; removeAllItems _player; removeUniform _player; removeVest _player; removeBackpack _player; removeHeadgear _player; removeGoggles _player; _player addUniform "U_B_CombatUniform_mcam"; _player addHeadgear "H_Beret_02";};

// [player] call fn_clr;

[player] join grpNull;
BwS_MUTEX_peut_rejoindre_champ_de_bataille = false;