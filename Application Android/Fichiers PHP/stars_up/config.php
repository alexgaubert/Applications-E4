<?php
	define('adresse', 'eu-cdbr-west-01.cleardb.com');
	define('utilisateur', 'b8d6aadca68b20');
	define('mdp', 'a65b186a');
	define('nom_bdd', 'heroku_d024a4013e65b6c');

	class Connexion_BDD {
		private $connexion;

		function __construct() {
			$this->connexion = mysqli_connect(adresse, utilisateur, mdp, nom_bdd) or die("Impossible de se connecter à la base de données");
		}

		public function getConnexion() {
			return $this->connexion;
		}
	}
?>