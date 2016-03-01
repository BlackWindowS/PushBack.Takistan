_panneau = _this select 0;
_faction = _this select 1;

_panneau allowDamage false;

if (_faction == west) then
{
	_panneau addAction ["<t color='#FF0000'>FOB Alpha</t>", {(_this select 1) moveincargo FOBa;}, [], 1.5, true, true, "", '((speed FOBa == 0) && (_target distance FOBa > 100) && isNull (FOBa getVariable ["R3F_LOG_est_transporte_par", objNull])) && (isNull (FOBa getVariable ["R3F_LOG_est_deplace_par", objNull])) && (BwS_MUTEX_peut_rejoindre_champ_de_bataille) && (alive FOBa)'];
	_panneau addAction ["<t color='#FF0000'>FOB Bravo</t>", {(_this select 1) moveincargo FOBb;}, [], 1.5, true, true, "", '((speed FOBb == 0) && (_target distance FOBb > 100) && isNull (FOBb getVariable ["R3F_LOG_est_transporte_par", objNull])) && (isNull (FOBb getVariable ["R3F_LOG_est_deplace_par", objNull])) && (BwS_MUTEX_peut_rejoindre_champ_de_bataille) && (alive FOBb)'];
};

if (_faction == east) then
{
	_panneau addAction ["<t color='#FF0000'>FOB Alpha</t>", {(_this select 1) moveincargo FOBA_R;}, [], 1.5, true, true, "", '((speed FOBA_R == 0) && (_target distance FOBA_R > 100) && isNull (FOBA_R getVariable ["R3F_LOG_est_transporte_par", objNull])) && (isNull (FOBA_R getVariable ["R3F_LOG_est_deplace_par", objNull])) && (BwS_MUTEX_peut_rejoindre_champ_de_bataille) && (alive FOBA_R)'];
	_panneau addAction ["<t color='#FF0000'>FOB Bravo</t>", {(_this select 1) moveincargo FOBB_R;}, [], 1.5, true, true, "", '((speed FOBB_R == 0) && (_target distance FOBB_R > 100) && isNull (FOBB_R getVariable ["R3F_LOG_est_transporte_par", objNull])) && (isNull (FOBB_R getVariable ["R3F_LOG_est_deplace_par", objNull])) && (BwS_MUTEX_peut_rejoindre_champ_de_bataille) && (alive FOBB_R)'];
};