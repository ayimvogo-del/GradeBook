-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 20 mars 2026 à 12:03
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gradebook_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `classes`
--

CREATE TABLE `classes` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `niveau` varchar(20) NOT NULL,
  `annee_academique` varchar(20) NOT NULL,
  `professeur_titulaire_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `eleves`
--

CREATE TABLE `eleves` (
  `id` int(11) NOT NULL,
  `matricule` varchar(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `date_de_naissence` date DEFAULT NULL,
  `sexe` enum('M','F') DEFAULT NULL,
  `parent_nom` varchar(150) DEFAULT NULL,
  `parent_telephone` varchar(150) DEFAULT NULL,
  `annee_academique` varchar(20) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `classe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `matieres`
--

CREATE TABLE `matieres` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `coefficient` int(11) NOT NULL DEFAULT 1,
  `genre` enum('litteraire','scientifique','sport_&_art') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `matieres`
--

INSERT INTO `matieres` (`id`, `nom`, `coefficient`, `genre`) VALUES
(1, 'Mathematique', 4, 'scientifique'),
(2, 'Science', 2, 'scientifique'),
(3, 'TIC', 2, 'scientifique'),
(4, 'Histoire-Geo', 2, 'scientifique'),
(5, 'Francais', 4, 'litteraire'),
(6, 'Anglais', 2, 'litteraire'),
(7, 'ESF', 1, 'sport_&_art'),
(8, 'EPS', 1, 'sport_&_art');

-- --------------------------------------------------------

--
-- Structure de la table `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `valeur` decimal(5,2) NOT NULL,
  `sequence` tinyint(4) NOT NULL,
  `trimestre` tinyint(4) NOT NULL,
  `eleve_id` int(11) NOT NULL,
  `matiere_id` int(11) NOT NULL,
  `classe_id` int(11) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `periode_de_saisie`
--

CREATE TABLE `periode_de_saisie` (
  `id` int(11) NOT NULL,
  `sequence` tinyint(4) NOT NULL,
  `trimestre` tinyint(4) NOT NULL,
  `annee_academique` varchar(20) NOT NULL,
  `date_ouverture` datetime NOT NULL,
  `date_fermeture` datetime NOT NULL,
  `satut` enum('ouvert','fermer','calcul_en_cours','publie') DEFAULT 'ouvert'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `professeurs`
--

CREATE TABLE `professeurs` (
  `id` int(11) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `utilisateur_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('admin','professeur') NOT NULL,
  `actif` tinyint(1) DEFAULT 1,
  `mot_de_passe_change` tinyint(1) DEFAULT 0,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `nom`, `prenom`, `email`, `mot_de_passe`, `role`, `actif`, `mot_de_passe_change`, `create_at`) VALUES
(1, 'Admin', 'GradeBook', 'admin@gradebook.cm', 'Admin@gradebook2026', 'admin', 1, 1, '2026-03-20 10:43:00');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vue_eleves`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `vue_eleves` (
`eleve_id` int(11)
,`matricule` varchar(20)
,`eleve_nom` varchar(100)
,`eleve_prenom` varchar(100)
,`sexe` enum('M','F')
,`date_de_naissence` date
,`parent_nom` varchar(150)
,`parent_telephone` varchar(150)
,`annee_academique` varchar(20)
,`classe` varchar(50)
,`niveau` varchar(20)
,`titulaire` varchar(200)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vue_notes`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `vue_notes` (
`note_id` int(11)
,`valeur` decimal(5,2)
,`sequence` tinyint(4)
,`trimestre` tinyint(4)
,`eleve_nom` varchar(100)
,`eleve_prenom` varchar(100)
,`matricule` varchar(20)
,`classe` varchar(50)
,`matiere` varchar(100)
,`coefficient` int(11)
,`genre` enum('litteraire','scientifique','sport_&_art')
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vue_professeurs`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `vue_professeurs` (
`professeurs_id` int(11)
,`nom` varchar(100)
,`prenom` varchar(100)
,`email` varchar(150)
,`actif` tinyint(1)
,`telephone` varchar(20)
,`classe` varchar(50)
,`niveau` varchar(20)
,`annee_academique` varchar(20)
);

-- --------------------------------------------------------

--
-- Structure de la vue `vue_eleves`
--
DROP TABLE IF EXISTS `vue_eleves`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vue_eleves`  AS SELECT `e`.`id` AS `eleve_id`, `e`.`matricule` AS `matricule`, `e`.`nom` AS `eleve_nom`, `e`.`prenom` AS `eleve_prenom`, `e`.`sexe` AS `sexe`, `e`.`date_de_naissence` AS `date_de_naissence`, `e`.`parent_nom` AS `parent_nom`, `e`.`parent_telephone` AS `parent_telephone`, `e`.`annee_academique` AS `annee_academique`, `c`.`nom` AS `classe`, `c`.`niveau` AS `niveau`, concat(`u`.`nom`,'',`u`.`prenom`) AS `titulaire` FROM (((`eleves` `e` join `classes` `c` on(`e`.`classe_id` = `c`.`id`)) left join `professeurs` `p` on(`c`.`professeur_titulaire_id` = `p`.`id`)) left join `utilisateurs` `u` on(`p`.`utilisateur_id` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `vue_notes`
--
DROP TABLE IF EXISTS `vue_notes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vue_notes`  AS SELECT `n`.`id` AS `note_id`, `n`.`valeur` AS `valeur`, `n`.`sequence` AS `sequence`, `n`.`trimestre` AS `trimestre`, `e`.`nom` AS `eleve_nom`, `e`.`prenom` AS `eleve_prenom`, `e`.`matricule` AS `matricule`, `c`.`nom` AS `classe`, `m`.`nom` AS `matiere`, `m`.`coefficient` AS `coefficient`, `m`.`genre` AS `genre` FROM (((`notes` `n` join `eleves` `e` on(`n`.`eleve_id` = `e`.`id`)) join `classes` `c` on(`n`.`classe_id` = `c`.`id`)) join `matieres` `m` on(`n`.`matiere_id` = `m`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `vue_professeurs`
--
DROP TABLE IF EXISTS `vue_professeurs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vue_professeurs`  AS SELECT `p`.`id` AS `professeurs_id`, `u`.`nom` AS `nom`, `u`.`prenom` AS `prenom`, `u`.`email` AS `email`, `u`.`actif` AS `actif`, `p`.`telephone` AS `telephone`, `c`.`nom` AS `classe`, `c`.`niveau` AS `niveau`, `c`.`annee_academique` AS `annee_academique` FROM ((`professeurs` `p` join `utilisateurs` `u` on(`p`.`utilisateur_id` = `u`.`id`)) left join `classes` `c` on(`c`.`professeur_titulaire_id` = `p`.`id`)) ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `professeur_titulaire_id` (`professeur_titulaire_id`);

--
-- Index pour la table `eleves`
--
ALTER TABLE `eleves`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricule` (`matricule`),
  ADD KEY `classe_id` (`classe_id`);

--
-- Index pour la table `matieres`
--
ALTER TABLE `matieres`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_note` (`eleve_id`,`matiere_id`,`sequence`),
  ADD KEY `matiere_id` (`matiere_id`),
  ADD KEY `classe_id` (`classe_id`);

--
-- Index pour la table `periode_de_saisie`
--
ALTER TABLE `periode_de_saisie`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_periode` (`sequence`,`annee_academique`);

--
-- Index pour la table `professeurs`
--
ALTER TABLE `professeurs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `utilisateur_id` (`utilisateur_id`);

--
-- Index pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `eleves`
--
ALTER TABLE `eleves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `matieres`
--
ALTER TABLE `matieres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `periode_de_saisie`
--
ALTER TABLE `periode_de_saisie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `professeurs`
--
ALTER TABLE `professeurs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`professeur_titulaire_id`) REFERENCES `professeurs` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `eleves`
--
ALTER TABLE `eleves`
  ADD CONSTRAINT `eleves_ibfk_1` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`);

--
-- Contraintes pour la table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`eleve_id`) REFERENCES `eleves` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notes_ibfk_2` FOREIGN KEY (`matiere_id`) REFERENCES `matieres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notes_ibfk_3` FOREIGN KEY (`classe_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `professeurs`
--
ALTER TABLE `professeurs`
  ADD CONSTRAINT `professeurs_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
