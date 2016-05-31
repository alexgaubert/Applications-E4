<?php
	include 'config.php';

	$liste = new Liste();
	$liste->liste_visites();

	class Liste {
		private $bdd;
		private $connexion;
		
		function __construct() {
			$this->bdd = new Connexion_BDD();
			$this->connexion = $this->bdd->getConnexion();
		}

		public function liste_visites() {
		    $requete = "SELECT v.id_visite AS id_visite, v.id_inspecteur AS id_inspecteur, r.nom AS nom FROM visite AS v
		    			INNER JOIN restaurant AS r ON r.id_restaurant=v.id_restaurant";
			$resultat = mysqli_query($this->connexion, $requete);
		    $json = array();

		    while($row = mysqli_fetch_assoc($resultat))
		    {
		        $json[] = $row;
		    }

		    echo json_encode($json);
			mysqli_close($this->connexion);
		}
	}
?>