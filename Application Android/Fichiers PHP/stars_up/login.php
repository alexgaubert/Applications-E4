<?php
	include 'config.php';

	$utilisateur = new Utilisateur();

	if(isset($_POST['nomUtilisateur'], $_POST['MDP'])) { // Si le nom et le mdp récupérés ne sont pas nuls
		$nomUtilisateur = $_POST['nomUtilisateur'];
		$MDP = $_POST['MDP'];
		
		if(!empty($nomUtilisateur) && !empty($MDP)) { // Si les champs ne sont pas vides
			$utilisateur->verif_utilisateur($nomUtilisateur, $MDP);
		}
		else { // Sinon si les champs sont vides
			$json['erreur'] = 'Veuillez saisir vos identifiants';
			echo json_encode($json);
			mysqli_close($this->connexion);
		}
	}
		
	class Utilisateur {
		private $bdd;
		private $connexion;
		
		function __construct() {
			$this->bdd = new Connexion_BDD();
			$this->connexion = $this->bdd->getConnexion();
		}

		public function verif_utilisateur($nomUtilisateur, $MDP) {
			$requete = "SELECT id_inspecteur, prenom, nom FROM inspecteur WHERE nomutilisateur='$nomUtilisateur' AND motdepasse='$MDP'";
			$resultat = mysqli_query($this->connexion, $requete);
			$donnee = mysqli_fetch_assoc($resultat);

			if(mysqli_num_rows($resultat) != 0) { // Si les identifiants correspondent bien
				$json['succes'] = 'Vous vous êtes bien connectés. Bienvenue '.$donnee['prenom'].' '.$donnee['nom'];
				$json['id_inspecteur'] = $donnee['id_inspecteur'];
				echo json_encode($json);
				mysqli_close($this->connexion);
			}
			else { // Sinon si les identifiants ne correspondent pas
				$json['erreur'] = 'Les identifiants sont incorrects, veuillez réessayer';
				echo json_encode($json);
				mysqli_close($this->connexion);
			}
		}
	}
?>