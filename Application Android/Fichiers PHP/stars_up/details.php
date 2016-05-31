<?php
	include 'config.php';

	$details = new Details();

	$numVisite = $_POST['numVisite'];
	$noteVisite = $_POST['noteVisite'];
	$commentaireVisite = $_POST['commentaireVisite'];
	$contreVisite = $_POST['contreVisite'];
		
	if(!empty($numVisite) && !empty($noteVisite) && !empty($commentaireVisite)) { // Si les champs ne sont pas vides
		$details->envoi_details($numVisite, $noteVisite, $commentaireVisite, $contreVisite);
	}
	else { // Sinon si les champs sont vides
		$json['erreur'] = 'Veuillez remplir tout les champs';
		echo json_encode($json);
		mysqli_close($this->connexion);
	}
		
	class Details {
		private $bdd;
		private $connexion;
		
		function __construct() {
			$this->bdd = new Connexion_BDD();
			$this->connexion = $this->bdd->getConnexion();
		}

		public function envoi_details($numVisite, $noteVisite, $commentaireVisite, $contreVisite) {
			$requete = "UPDATE visite SET note='$noteVisite', commentaire='$commentaireVisite', contreVisite='$contreVisite' WHERE id_visite='$numVisite'";

			if(mysqli_query($this->connexion, $requete)) { // Si les identifiants correspondent bien
				$json['succes'] = 'Les détails ont bien été envoyés';
				echo json_encode($json);
				mysqli_close($this->connexion);
			}
			else { // Sinon si les identifiants ne correspondent pas
				$json['erreur'] = 'Les détails n\'ont pas été envoyés';
				echo json_encode($json);
				mysqli_close($this->connexion);
			}
		}
	}
?>