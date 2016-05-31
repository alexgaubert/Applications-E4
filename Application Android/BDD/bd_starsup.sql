-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 30 Mai 2016 à 22:26
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `bd_starsup`
--

-- --------------------------------------------------------

--
-- Structure de la table `inspecteur`
--

CREATE TABLE IF NOT EXISTS `inspecteur` (
  `id_inspecteur` int(5) NOT NULL AUTO_INCREMENT,
  `nom` varchar(25) COLLATE utf8_bin NOT NULL,
  `prenom` varchar(25) COLLATE utf8_bin NOT NULL,
  `adresse` varchar(50) COLLATE utf8_bin NOT NULL,
  `codePostal` int(5) NOT NULL,
  `telephone` int(10) unsigned zerofill NOT NULL,
  `nomUtilisateur` varchar(25) COLLATE utf8_bin NOT NULL,
  `motDePasse` varchar(25) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id_inspecteur`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=7 ;

--
-- Contenu de la table `inspecteur`
--

INSERT INTO `inspecteur` (`id_inspecteur`, `nom`, `prenom`, `adresse`, `codePostal`, `telephone`, `nomUtilisateur`, `motDePasse`) VALUES
(3, 'Dupont', 'Jacques', '15 rue du pont', 95600, 0684961864, 'jdupont', 'test123'),
(4, 'Bernard', 'Jean', '84 avenue de la marche', 26750, 0759348216, 'jbernard', 'test123'),
(5, 'Martel', 'Benoit', '71 boulevard des champs', 45200, 0657964823, 'bmartel', 'test123'),
(6, 'Bourdon', 'Philippe', '2 chemin du bois', 25000, 0756156485, 'pbourdon', 'test123');

-- --------------------------------------------------------

--
-- Structure de la table `restaurant`
--

CREATE TABLE IF NOT EXISTS `restaurant` (
  `id_restaurant` int(5) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8_bin NOT NULL,
  `adresse` varchar(50) COLLATE utf8_bin NOT NULL,
  `codePostal` int(5) NOT NULL,
  `ville` varchar(50) COLLATE utf8_bin NOT NULL,
  `telephone` int(10) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id_restaurant`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=11 ;

--
-- Contenu de la table `restaurant`
--

INSERT INTO `restaurant` (`id_restaurant`, `nom`, `adresse`, `codePostal`, `ville`, `telephone`) VALUES
(1, 'A la petite chaise', '8 rue Sadi Carnot', 89000, 'Auxerre', 0398609929),
(2, 'Le gourmandin', '83 Chemin Du Lavarin Sud', 94230, 'Cachan', 0118952761),
(3, 'La bouche des gouts', '69 Rue Joseph Vernet', 84000, 'Avignon', 0491585712),
(4, 'Mia cucina', '6 rue de Groussay', 26100, 'Romans-Sur-Isere', 0424168325),
(5, 'Le bouche a oreille', '58 rue des Lacs', 62110, 'Henin-Baumont', 0348491559),
(6, 'Panini gourmand', '39 rue Cazade', 93700, 'Drancy', 0162651838),
(7, 'La boulangerie', '27 rue du Clair Bocage', 85000, 'La Roche-Sur-Yon', 0201203713),
(8, 'La baraque a frites', '14 Place Napoleon', 59130, 'Lambersart', 0314421581),
(9, 'Le patio', '4 rue des Dunes', 97150, 'Saint-Martin', 0554397812),
(10, 'Flunch', '15 Quai des Belges', 13016, 'Marseille', 0462769325);

--
-- Déclencheurs `restaurant`
--
DROP TRIGGER IF EXISTS `after_delete_restaurant`;
DELIMITER //
CREATE TRIGGER `after_delete_restaurant` AFTER DELETE ON `restaurant`
 FOR EACH ROW BEGIN
DELETE FROM visite
WHERE id_restaurant=OLD.id_restaurant;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `visite`
--

CREATE TABLE IF NOT EXISTS `visite` (
  `id_visite` int(5) NOT NULL AUTO_INCREMENT,
  `note` float NOT NULL,
  `commentaire` varchar(100) COLLATE utf8_bin NOT NULL,
  `contreVisite` int(1) NOT NULL,
  `id_inspecteur` int(5) NOT NULL,
  `id_restaurant` int(5) NOT NULL,
  PRIMARY KEY (`id_visite`),
  KEY `id_inspecteur` (`id_inspecteur`),
  KEY `id_restaurant` (`id_restaurant`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=11 ;

--
-- Contenu de la table `visite`
--

INSERT INTO `visite` (`id_visite`, `note`, `commentaire`, `contreVisite`, `id_inspecteur`, `id_restaurant`) VALUES
(1, 0, '', 0, 4, 1),
(2, 0, '', 0, 3, 2),
(3, 0, '', 0, 3, 3),
(4, 0, '', 0, 6, 4),
(5, 0, '', 0, 3, 5),
(6, 0, '', 0, 3, 6),
(7, 0, '', 0, 4, 7),
(8, 0, '', 0, 4, 8),
(9, 0, '', 0, 5, 9),
(10, 0, '', 0, 6, 10);

--
-- Déclencheurs `visite`
--
DROP TRIGGER IF EXISTS `before_update_visite`;
DELIMITER //
CREATE TRIGGER `before_update_visite` BEFORE UPDATE ON `visite`
 FOR EACH ROW BEGIN
	IF NEW.note < 0 THEN
    	SET NEW.note = 0;
    ELSEIF NEW.note > 5 THEN
    	SET NEW.note = 5;
    END IF;
END
//
DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
