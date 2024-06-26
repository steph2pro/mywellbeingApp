<?php

class Profil {
    private $conn;
    private $table_name = "profil";

    public $id_profil;
    public $id_utilisateur;
    public $age;
    public $taille;
    public $poids;
    public $ville_residence;
    public $objectifs;
    public $photo;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer un nouveau profil
    public function createProfil($id_utilisateur, $age, $taille, $poids, $ville_residence, $objectifs, $photo) {
        $query = "INSERT INTO " . $this->table_name . " (id_utilisateur, age, taille, poids, ville_residence, objectifs, photo)
                  VALUES (?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("issssss", $id_utilisateur, $age, $taille, $poids, $ville_residence, $objectifs, $photo);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un profil par son ID
    public function getProfilById($id_profil) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_profil = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_profil);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $profil = $result->fetch_assoc();
        
        return $profil;
    }

    // Méthode pour mettre à jour les informations d'un profil
    public function updateProfil($id_profil, $id_utilisateur, $age, $taille, $poids, $ville_residence, $objectifs, $photo) {
        $query = "UPDATE " . $this->table_name . " SET id_utilisateur = ?, age = ?, taille = ?, poids = ?, ville_residence = ?, objectifs = ?, photo = ?
                  WHERE id_profil = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("issssssi", $id_utilisateur, $age, $taille, $poids, $ville_residence, $objectifs, $photo, $id_profil);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les profils
    public function getAllProfils() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $profils = array();
        while ($row = $result->fetch_assoc()) {
            $profils[] = $row;
        }

        return $profils;
    }

    // Méthode pour supprimer un profil par son ID
    public function deleteProfil($id_profil) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_profil = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_profil);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un profil par son ID utilisateur
    public function getProfilByUtilisateurId($id_utilisateur) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $profil = $result->fetch_assoc();
        
        return $profil;
    }

    // Méthode pour lister tous les profils par ville de résidence
    public function getProfilsByVilleResidence($ville_residence) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE ville_residence = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $ville_residence);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $profils = array();
        while ($row = $result->fetch_assoc()) {
            $profils[] = $row;
        }
        
        return $profils;
    }

    // Méthode pour lister tous les profils par objectifs
    public function getProfilsByObjectifs($objectifs) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE objectifs = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $objectifs);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $profils = array();
        while ($row = $result->fetch_assoc()) {
            $profils[] = $row;
        }
        
        return $profils;
    }

    // Méthode pour lister tous les profils ayant le même ID utilisateur
    public function getProfilsByUtilisateurId($id_utilisateur) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $profils = array();
        while ($row = $result->fetch_assoc()) {
            $profils[] = $row;
        }
        
        return $profils;
    }
}
?>
