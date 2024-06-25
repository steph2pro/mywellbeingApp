-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour PostgreSQL
-- -----------------------------------------------------------------------------
--       CREATION DE LA BASE 
-- -----------------------------------------------------------------------------

DROP DATABASE IF EXISTS mywellbein_bd;
CREATE DATABASE mywellbein_bd;

-- Sélection de la base de données
\c mywellbein_bd

-- -----------------------------------------------------------------------------
--       TABLE : utilisateur
-- -----------------------------------------------------------------------------

CREATE TABLE utilisateur (
    id_utilisateur INTEGER AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NULL,
    prenom VARCHAR(255) NULL,
    mot_de_passe VARCHAR(255) NULL,
    email VARCHAR(255) NULL,
    sexe VARCHAR(255) NULL,
    role VARCHAR(255) NULL
);

-- -----------------------------------------------------------------------------
--       TABLE : profil
-- -----------------------------------------------------------------------------

CREATE TABLE profil (
    id_profil INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INTEGER NOT NULL,
    age VARCHAR(255) NULL,
    taille VARCHAR(255) NULL,
    poids VARCHAR(255) NULL,
    ville_residence VARCHAR(255) NULL,
    objectifs VARCHAR(255) NULL,
    photo VARCHAR(255) NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

-- -----------------------------------------------------------------------------
--       TABLE : professionnel_de_sante
-- -----------------------------------------------------------------------------

CREATE TABLE professionnel_de_sante (
    id_professionnel_de_sante INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INTEGER NOT NULL,
    cv VARCHAR(255) NULL,
    specialite VARCHAR(255) NULL,
    horaire_travail VARCHAR(255) NULL,
    disponibilite VARCHAR(255) NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

-- -----------------------------------------------------------------------------
--       TABLE : administrateur
-- -----------------------------------------------------------------------------

CREATE TABLE administrateur (
    id_administrateur INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INTEGER NOT NULL,
    autorisations VARCHAR(255) NULL,
    qualification VARCHAR(255) NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

-- -----------------------------------------------------------------------------
--       TABLE : groupes_discussion
-- -----------------------------------------------------------------------------

CREATE TABLE groupes_discussion (
    id_groupes_discussion INTEGER AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NULL,
    objectif VARCHAR(255) NULL,
    photo VARCHAR(255) NULL
);

-- -----------------------------------------------------------------------------
--       TABLE : message
-- -----------------------------------------------------------------------------

CREATE TABLE message (
    id_message INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INTEGER NOT NULL,
    titre VARCHAR(255) NULL,
    type VARCHAR(255) NULL,
    contenu VARCHAR(255) NULL,
    date_envoi VARCHAR(255) NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

-- -----------------------------------------------------------------------------
--       TABLE : recette
-- -----------------------------------------------------------------------------

CREATE TABLE recette (
    id_recette INTEGER AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NULL,
    propriete VARCHAR(255) NULL,
    description VARCHAR(255) NULL
);

-- -----------------------------------------------------------------------------
--       TABLE : seance_entrainement
-- -----------------------------------------------------------------------------

CREATE TABLE seance_entrainement (
    id_seance_entrainement INTEGER AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NULL,
    description VARCHAR(255) NULL,
    contenu VARCHAR(255) NULL,
    duree VARCHAR(255) NULL,
    niveau_difficulte VARCHAR(255) NULL
);

-- -----------------------------------------------------------------------------
--       TABLE : exercice
-- -----------------------------------------------------------------------------

CREATE TABLE exercice (
    id_exercice INTEGER AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NULL,
    type VARCHAR(255) NULL,
    niveau_difficulte VARCHAR(255) NULL,
    contenu VARCHAR(255) NULL,
    duree VARCHAR(255) NULL
);

-- -----------------------------------------------------------------------------
--       TABLE : ration_alimentaire
-- -----------------------------------------------------------------------------

CREATE TABLE ration_alimentaire (
    id_ration_alimentaire INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_recette INTEGER NOT NULL,
    titre VARCHAR(255) NULL,
    description VARCHAR(255) NULL,
    contenu VARCHAR(255) NULL,
    hydratation VARCHAR(255) NULL,
    FOREIGN KEY (id_recette) REFERENCES recette(id_recette)
);

-- -----------------------------------------------------------------------------
--       TABLE : programme
-- -----------------------------------------------------------------------------

CREATE TABLE programme (
    id_programme INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_ration_alimentaire INTEGER NOT NULL,
    id_seance_entrainement INTEGER NOT NULL,
    titre VARCHAR(255) NULL,
    description VARCHAR(255) NULL,
    type VARCHAR(255) NULL,
    FOREIGN KEY (id_ration_alimentaire) REFERENCES ration_alimentaire(id_ration_alimentaire),
    FOREIGN KEY (id_seance_entrainement) REFERENCES seance_entrainement(id_seance_entrainement)
);

-- -----------------------------------------------------------------------------
--       TABLE : suivre
-- -----------------------------------------------------------------------------

CREATE TABLE suivre (
    id_programme INTEGER NOT NULL,
    id_utilisateur INTEGER NOT NULL,
    PRIMARY KEY (id_programme, id_utilisateur),
    FOREIGN KEY (id_programme) REFERENCES programme(id_programme),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
);

-- -----------------------------------------------------------------------------
--       TABLE : constituer
-- -----------------------------------------------------------------------------

CREATE TABLE constituer (
    id_seance_entrainement INTEGER NOT NULL,
    id_exercice INTEGER NOT NULL,
    PRIMARY KEY (id_seance_entrainement, id_exercice),
    FOREIGN KEY (id_seance_entrainement) REFERENCES seance_entrainement(id_seance_entrainement),
    FOREIGN KEY (id_exercice) REFERENCES exercice(id_exercice)
);

-- -----------------------------------------------------------------------------
--       TABLE : appartenir
-- -----------------------------------------------------------------------------

CREATE TABLE appartenir (
    id_utilisateur INTEGER NOT NULL,
    id_groupes_discussion INTEGER NOT NULL,
    PRIMARY KEY (id_utilisateur, id_groupes_discussion),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (id_groupes_discussion) REFERENCES groupes_discussion(id_groupes_discussion)
);