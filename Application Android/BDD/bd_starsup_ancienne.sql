-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 30 Mai 2016 à 22:25
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `bd_ppe4_gaubertetco`
--

-- --------------------------------------------------------

--
-- Structure de la table `annee`
--

CREATE TABLE IF NOT EXISTS `annee` (
  `NUM_ANNEE` bigint(20) NOT NULL,
  PRIMARY KEY (`NUM_ANNEE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `annee`
--

INSERT INTO `annee` (`NUM_ANNEE`) VALUES
(2016),
(2017),
(2018),
(2019);

-- --------------------------------------------------------

--
-- Structure de la table `camping`
--

CREATE TABLE IF NOT EXISTS `camping` (
  `ID_HEBERGEMENT` int(11) NOT NULL,
  PRIMARY KEY (`ID_HEBERGEMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `chambrehotes`
--

CREATE TABLE IF NOT EXISTS `chambrehotes` (
  `ID_HEBERGEMENT` int(11) NOT NULL,
  `NB_CHAMBRES` int(11) DEFAULT NULL,
  `CUISINECOMMUNE` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_HEBERGEMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `connexion`
--

CREATE TABLE IF NOT EXISTS `connexion` (
  `id_connexion` int(11) NOT NULL,
  `motdepasse` varchar(15) NOT NULL,
  PRIMARY KEY (`id_connexion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `departement`
--

CREATE TABLE IF NOT EXISTS `departement` (
  `NUM_DEPARTEMENT` int(11) NOT NULL,
  `NOM_DEPARTEMENT` char(32) DEFAULT NULL,
  PRIMARY KEY (`NUM_DEPARTEMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `equipement`
--

CREATE TABLE IF NOT EXISTS `equipement` (
  `ID_HEBERGEMENT` int(11) NOT NULL,
  `ID_EQUIPEMENT` int(11) NOT NULL,
  `LIBELLE_EQUIPEMENT` char(32) DEFAULT NULL,
  PRIMARY KEY (`ID_HEBERGEMENT`,`ID_EQUIPEMENT`),
  KEY `I_FK_EQUIPEMENT_CAMPING` (`ID_HEBERGEMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `gerant`
--

CREATE TABLE IF NOT EXISTS `gerant` (
  `ID_GERANT` int(11) NOT NULL,
  `NOM_GERANT` char(32) DEFAULT NULL,
  `TELEPHONE` int(11) DEFAULT NULL,
  `MAIL` char(32) DEFAULT NULL,
  `ADRESSE_GERANT` char(32) DEFAULT NULL,
  `CODEPOSTAL_GERANT` bigint(20) DEFAULT NULL,
  `VILLE_GERANT` char(32) DEFAULT NULL,
  `MOTDEPASSE` text,
  PRIMARY KEY (`ID_GERANT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `gerant`
--

INSERT INTO `gerant` (`ID_GERANT`, `NOM_GERANT`, `TELEPHONE`, `MAIL`, `ADRESSE_GERANT`, `CODEPOSTAL_GERANT`, `VILLE_GERANT`, `MOTDEPASSE`) VALUES
(1, 'x', 708090405, 'xx@hotmail.com', '10 rue bressigny', 49000, 'Angers', 'xx');

-- --------------------------------------------------------

--
-- Structure de la table `gerer`
--

CREATE TABLE IF NOT EXISTS `gerer` (
  `ID_GERANT` int(11) NOT NULL,
  `ID_HEBERGEMENT` int(11) NOT NULL,
  PRIMARY KEY (`ID_GERANT`,`ID_HEBERGEMENT`),
  KEY `I_FK_GERER_GERANT` (`ID_GERANT`),
  KEY `I_FK_GERER_HEBERGEMENT` (`ID_HEBERGEMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `gerer`
--

INSERT INTO `gerer` (`ID_GERANT`, `ID_HEBERGEMENT`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `hebergement`
--

CREATE TABLE IF NOT EXISTS `hebergement` (
  `ID_HEBERGEMENT` int(11) NOT NULL,
  `ID_SPECIALITE` int(11) NOT NULL,
  `ADRESSE` char(32) DEFAULT NULL,
  `CODE_POSTAL` bigint(20) DEFAULT NULL,
  `VILLE` char(32) DEFAULT NULL,
  `TEL` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID_HEBERGEMENT`),
  KEY `I_FK_HEBERGEMENT_SPECIALITE` (`ID_SPECIALITE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `hebergement`
--

INSERT INTO `hebergement` (`ID_HEBERGEMENT`, `ID_SPECIALITE`, `ADRESSE`, `CODE_POSTAL`, `VILLE`, `TEL`) VALUES
(1, 1, '1 rue louis pasteur', 49000, 'Angers', 241565758),
(2, 1, '45 rue de hollande', 75000, 'Paris', 407080936),
(3, 1, '8 rue de fribourg', 13000, 'Marseille', 698415836),
(4, 1, '125 rue de montmatre', 35000, 'Rennes', 102030405);

-- --------------------------------------------------------

--
-- Structure de la table `historiqueetoiles`
--

CREATE TABLE IF NOT EXISTS `historiqueetoiles` (
  `ID_HEBERGEMENT` int(11) NOT NULL,
  `NUM_ANNEE` bigint(20) NOT NULL,
  `NBETOILES` char(32) DEFAULT NULL,
  PRIMARY KEY (`ID_HEBERGEMENT`,`NUM_ANNEE`),
  KEY `I_FK_HISTORIQUEETOILES_HEBERGEMENT` (`ID_HEBERGEMENT`),
  KEY `I_FK_HISTORIQUEETOILES_ANNEE` (`NUM_ANNEE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `historiqueetoiles`
--

INSERT INTO `historiqueetoiles` (`ID_HEBERGEMENT`, `NUM_ANNEE`, `NBETOILES`) VALUES
(1, 2016, '3');

-- --------------------------------------------------------

--
-- Structure de la table `hotel`
--

CREATE TABLE IF NOT EXISTS `hotel` (
  `ID_HEBERGEMENT` int(11) NOT NULL,
  PRIMARY KEY (`ID_HEBERGEMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `inspecteur`
--

CREATE TABLE IF NOT EXISTS `inspecteur` (
  `ID_INSPECTEUR` int(11) NOT NULL,
  `ID_SPECIALITE` int(11) NOT NULL,
  `NOM` char(32) DEFAULT NULL,
  `PRENOM` char(32) DEFAULT NULL,
  `ADRESSE` char(32) DEFAULT NULL,
  `CODE_POSTAL` bigint(20) DEFAULT NULL,
  `TEL` bigint(20) DEFAULT NULL,
  `NOMUTILISATEUR` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `MOTDEPASSE` varchar(32) NOT NULL,
  PRIMARY KEY (`ID_INSPECTEUR`),
  KEY `I_FK_INSPECTEUR_SPECIALITE` (`ID_SPECIALITE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `inspecteur`
--

INSERT INTO `inspecteur` (`ID_INSPECTEUR`, `ID_SPECIALITE`, `NOM`, `PRENOM`, `ADRESSE`, `CODE_POSTAL`, `TEL`, `NOMUTILISATEUR`, `MOTDEPASSE`) VALUES
(1, 1, 'François', 'Hollande', 'elyse', 75000, NULL, '', 'FH'),
(2, 1, 'GAUBERT', 'Alex', NULL, NULL, NULL, 'agaubert', 'test');

-- --------------------------------------------------------

--
-- Structure de la table `restaurant`
--

CREATE TABLE IF NOT EXISTS `restaurant` (
  `ID_HEBERGEMENT` int(11) NOT NULL,
  `ID_CHEF` int(11) NOT NULL,
  `ID_CUISINE` int(11) NOT NULL,
  `NOM_CHEF` char(32) DEFAULT NULL,
  PRIMARY KEY (`ID_HEBERGEMENT`,`ID_CHEF`),
  KEY `I_FK_RESTAURANT_HOTEL` (`ID_HEBERGEMENT`),
  KEY `I_FK_RESTAURANT_TYPECUISINE` (`ID_CUISINE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `semaine`
--

CREATE TABLE IF NOT EXISTS `semaine` (
  `NUM_ANNEE` bigint(20) NOT NULL,
  `NUM_SEMAINE` int(11) NOT NULL,
  `DATE_DEBUT` date DEFAULT NULL,
  `DATE_FIN` date DEFAULT NULL,
  PRIMARY KEY (`NUM_ANNEE`,`NUM_SEMAINE`),
  KEY `I_FK_SEMAINE_ANNEE` (`NUM_ANNEE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `se_trouver`
--

CREATE TABLE IF NOT EXISTS `se_trouver` (
  `ID_HEBERGEMENT` int(11) NOT NULL,
  `NUM_DEPARTEMENT` int(11) NOT NULL,
  PRIMARY KEY (`ID_HEBERGEMENT`,`NUM_DEPARTEMENT`),
  KEY `I_FK_SE_TROUVER_HEBERGEMENT` (`ID_HEBERGEMENT`),
  KEY `I_FK_SE_TROUVER_DEPARTEMENT` (`NUM_DEPARTEMENT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `se_voit_attribuer`
--

CREATE TABLE IF NOT EXISTS `se_voit_attribuer` (
  `NUM_ANNEE` bigint(20) NOT NULL,
  `NUM_SEMAINE` int(11) NOT NULL,
  `ID_INSPECTEUR` int(11) NOT NULL,
  `NUM_DEPARTEMENT` int(11) NOT NULL,
  PRIMARY KEY (`NUM_ANNEE`,`NUM_SEMAINE`,`ID_INSPECTEUR`),
  KEY `I_FK_SE_VOIT_ATTRIBUER_DEPARTEMENT` (`NUM_DEPARTEMENT`),
  KEY `I_FK_SE_VOIT_ATTRIBUER_SEMAINE` (`NUM_ANNEE`,`NUM_SEMAINE`),
  KEY `I_FK_SE_VOIT_ATTRIBUER_INSPECTEUR` (`ID_INSPECTEUR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `specialite`
--

CREATE TABLE IF NOT EXISTS `specialite` (
  `ID_SPECIALITE` int(11) NOT NULL,
  `LIBELLE_SPECIALITE` char(32) DEFAULT NULL,
  PRIMARY KEY (`ID_SPECIALITE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `specialite`
--

INSERT INTO `specialite` (`ID_SPECIALITE`, `LIBELLE_SPECIALITE`) VALUES
(1, 'Hotel');

-- --------------------------------------------------------

--
-- Structure de la table `typecuisine`
--

CREATE TABLE IF NOT EXISTS `typecuisine` (
  `ID_CUISINE` int(11) NOT NULL,
  `LIBELLE_CUISINE` char(32) DEFAULT NULL,
  PRIMARY KEY (`ID_CUISINE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `visite`
--

CREATE TABLE IF NOT EXISTS `visite` (
  `id_visite` int(20) NOT NULL AUTO_INCREMENT,
  `id_inspecteur` varchar(20) DEFAULT NULL,
  `id_hebergement` varchar(20) DEFAULT NULL,
  `date_visite` varchar(20) DEFAULT NULL,
  `heure` varchar(20) DEFAULT NULL,
  `nbetoileplus` varchar(20) DEFAULT NULL,
  `commentaire` varchar(20) DEFAULT NULL,
  `test1` varchar(20) DEFAULT NULL,
  `test2` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_visite`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

--
-- Contenu de la table `visite`
--

INSERT INTO `visite` (`id_visite`, `id_inspecteur`, `id_hebergement`, `date_visite`, `heure`, `nbetoileplus`, `commentaire`, `test1`, `test2`) VALUES
(13, '2', NULL, NULL, NULL, '4.0', 'ceci est un commenta', 'A la petite chaise', NULL),
(14, '2', NULL, NULL, NULL, NULL, NULL, 'Le gourmandin', NULL),
(15, '2', NULL, NULL, NULL, '3.0', 'ceci est un commenta', 'La bouche des gouts', NULL),
(16, '2', NULL, NULL, NULL, NULL, NULL, 'Mia cucina', NULL),
(17, '2', NULL, NULL, NULL, NULL, NULL, 'Le bouche a oreille', NULL),
(18, '2', NULL, NULL, NULL, NULL, NULL, 'Panini Gourmand', NULL),
(19, '2', NULL, NULL, NULL, NULL, NULL, 'La boulangerie', NULL),
(20, '2', NULL, NULL, NULL, NULL, NULL, 'La baraque a frites', NULL),
(21, '2', NULL, NULL, NULL, NULL, NULL, 'Le patio', NULL),
(22, '2', NULL, NULL, NULL, NULL, NULL, 'Flunch', NULL),
(23, '2', NULL, NULL, NULL, NULL, NULL, 'McDonalds', NULL),
(24, '2', NULL, NULL, NULL, NULL, NULL, 'La Cambuse', NULL),
(25, '2', NULL, NULL, NULL, NULL, NULL, 'Le cucaracha', NULL),
(26, '2', NULL, NULL, NULL, NULL, NULL, 'La chassagnette', NULL);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `camping`
--
ALTER TABLE `camping`
  ADD CONSTRAINT `camping_ibfk_1` FOREIGN KEY (`ID_HEBERGEMENT`) REFERENCES `hebergement` (`ID_HEBERGEMENT`);

--
-- Contraintes pour la table `chambrehotes`
--
ALTER TABLE `chambrehotes`
  ADD CONSTRAINT `chambrehotes_ibfk_1` FOREIGN KEY (`ID_HEBERGEMENT`) REFERENCES `hebergement` (`ID_HEBERGEMENT`);

--
-- Contraintes pour la table `equipement`
--
ALTER TABLE `equipement`
  ADD CONSTRAINT `equipement_ibfk_1` FOREIGN KEY (`ID_HEBERGEMENT`) REFERENCES `camping` (`ID_HEBERGEMENT`);

--
-- Contraintes pour la table `gerer`
--
ALTER TABLE `gerer`
  ADD CONSTRAINT `gerer_ibfk_1` FOREIGN KEY (`ID_GERANT`) REFERENCES `gerant` (`ID_GERANT`),
  ADD CONSTRAINT `gerer_ibfk_2` FOREIGN KEY (`ID_HEBERGEMENT`) REFERENCES `hebergement` (`ID_HEBERGEMENT`);

--
-- Contraintes pour la table `hebergement`
--
ALTER TABLE `hebergement`
  ADD CONSTRAINT `hebergement_ibfk_1` FOREIGN KEY (`ID_SPECIALITE`) REFERENCES `specialite` (`ID_SPECIALITE`);

--
-- Contraintes pour la table `historiqueetoiles`
--
ALTER TABLE `historiqueetoiles`
  ADD CONSTRAINT `historiqueetoiles_ibfk_1` FOREIGN KEY (`ID_HEBERGEMENT`) REFERENCES `hebergement` (`ID_HEBERGEMENT`),
  ADD CONSTRAINT `historiqueetoiles_ibfk_2` FOREIGN KEY (`NUM_ANNEE`) REFERENCES `annee` (`NUM_ANNEE`);

--
-- Contraintes pour la table `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `hotel_ibfk_1` FOREIGN KEY (`ID_HEBERGEMENT`) REFERENCES `hebergement` (`ID_HEBERGEMENT`);

--
-- Contraintes pour la table `inspecteur`
--
ALTER TABLE `inspecteur`
  ADD CONSTRAINT `inspecteur_ibfk_1` FOREIGN KEY (`ID_SPECIALITE`) REFERENCES `specialite` (`ID_SPECIALITE`);

--
-- Contraintes pour la table `restaurant`
--
ALTER TABLE `restaurant`
  ADD CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`ID_HEBERGEMENT`) REFERENCES `hotel` (`ID_HEBERGEMENT`),
  ADD CONSTRAINT `restaurant_ibfk_2` FOREIGN KEY (`ID_CUISINE`) REFERENCES `typecuisine` (`ID_CUISINE`);

--
-- Contraintes pour la table `semaine`
--
ALTER TABLE `semaine`
  ADD CONSTRAINT `semaine_ibfk_1` FOREIGN KEY (`NUM_ANNEE`) REFERENCES `annee` (`NUM_ANNEE`);

--
-- Contraintes pour la table `se_trouver`
--
ALTER TABLE `se_trouver`
  ADD CONSTRAINT `se_trouver_ibfk_1` FOREIGN KEY (`ID_HEBERGEMENT`) REFERENCES `hebergement` (`ID_HEBERGEMENT`),
  ADD CONSTRAINT `se_trouver_ibfk_2` FOREIGN KEY (`NUM_DEPARTEMENT`) REFERENCES `departement` (`NUM_DEPARTEMENT`);

--
-- Contraintes pour la table `se_voit_attribuer`
--
ALTER TABLE `se_voit_attribuer`
  ADD CONSTRAINT `se_voit_attribuer_ibfk_1` FOREIGN KEY (`NUM_DEPARTEMENT`) REFERENCES `departement` (`NUM_DEPARTEMENT`),
  ADD CONSTRAINT `se_voit_attribuer_ibfk_2` FOREIGN KEY (`NUM_ANNEE`, `NUM_SEMAINE`) REFERENCES `semaine` (`NUM_ANNEE`, `NUM_SEMAINE`),
  ADD CONSTRAINT `se_voit_attribuer_ibfk_3` FOREIGN KEY (`ID_INSPECTEUR`) REFERENCES `inspecteur` (`ID_INSPECTEUR`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
