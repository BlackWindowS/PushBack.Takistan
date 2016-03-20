#define HEURES 3600
#define MINUTES 60

BwS_var_casernes = true;

if (BwS_var_casernes) then
{
	// temps entre la productions d'unit�s par caserne
	BwS_var_cooldown_production_unites_pedestres = 1*HEURES; // une heure entre chaque production

	// probabilit� qu'une caserne soit d�truite � tout jamais 0 � 1
	BwS_var_probabilite_caserne_detruite_pour_toujours = 0.5;

	// temps entre les reconstructions si caserne detruite et qu'elle n'est pas perdue pour toujours
	BwS_var_cooldown_de_reconstruction_casernes = 5*HEURES; // 5 heures avant de faire reconstruire
};

BwS_var_usines = true;

if (BwS_var_usines) then
{
	// temps entre la productions d'unit�s par caserne
	BwS_var_cooldown_production_unites_motorisees = 1*HEURES; // une heure entre chaque production

	// probabilit� qu'une caserne soit d�truite � tout jamais 0 � 1
	BwS_var_probabilite_usine_detruite_pour_toujours = 0.5;

	// temps entre les reconstructions si caserne detruite et qu'elle n'est pas perdue pour toujours
	BwS_var_cooldown_de_reconstruction_usines = 5*HEURES; // 5 heures avant de faire reconstruire
};