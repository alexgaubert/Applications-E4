-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mar 31 Mai 2016 à 01:49
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `bd_angerson`
--

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

CREATE TABLE IF NOT EXISTS `groupe` (
  `idGroupe` int(5) NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idGroupe`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

--
-- Contenu de la table `groupe`
--

INSERT INTO `groupe` (`idGroupe`, `nom`) VALUES
(1, 'The Offspring'),
(2, 'Dropkick Murphys'),
(3, 'Disturbed'),
(4, 'Twisted Sister');

--
-- Déclencheurs `groupe`
--
DROP TRIGGER IF EXISTS `before_delete_groupe`;
DELIMITER //
CREATE TRIGGER `before_delete_groupe` BEFORE DELETE ON `groupe`
 FOR EACH ROW BEGIN
    DELETE FROM membre
    WHERE idGroupe=OLD.idGroupe;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

CREATE TABLE IF NOT EXISTS `membre` (
  `idMembre` int(5) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(20) COLLATE utf8_bin NOT NULL,
  `nom` varchar(20) COLLATE utf8_bin NOT NULL,
  `idGroupe` int(5) DEFAULT NULL,
  PRIMARY KEY (`idMembre`),
  KEY `idGroupe` (`idGroupe`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=34 ;

--
-- Contenu de la table `membre`
--

INSERT INTO `membre` (`idMembre`, `prenom`, `nom`, `idGroupe`) VALUES
(14, 'Holland', 'Dexter', 1),
(15, 'Kevin', 'Wasserman', 1),
(16, 'Greg', 'Kriesel', 1),
(17, 'Pete', 'Parada', 1),
(18, 'Ken', 'Casey', 2),
(19, 'Al', 'Barr', 2),
(20, 'James', 'Lynch', 2),
(21, 'Tim', 'Brennan', 2),
(22, 'Scruffy', 'Wallace', 2),
(23, 'Matt', 'Kelly', 2),
(24, 'Jeff', 'DaRosa', 2),
(25, 'David', 'Draiman', 3),
(26, 'Dan', 'Donegan', 3),
(27, 'John', 'Moyer', 3),
(28, 'Mike', 'Wengren', 3),
(29, 'Dee', 'Snider', 4),
(30, 'Jay Jay', 'French', 4),
(31, 'Eddie', 'Ojeda', 4),
(32, 'Mike', 'Portnoy', 4);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
