<?php

class Utilisateur {
    private $conn;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer un nouvel utilisateur
    public function createUtilisateur($nom, $prenom, $mot_de_passe, $email, $sexe, $role) {
        $query = "INSERT INTO utilisateur (nom, prenom, mot_de_passe, email, sexe, role)
                  VALUES (?, ?, ?, ?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssssss", $nom, $prenom, $mot_de_passe, $email, $sexe, $role);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un utilisateur par son ID
    public function getUtilisateurById($id_utilisateur) {
        $query = "SELECT * FROM utilisateur WHERE id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $utilisateur = $result->fetch_assoc();
        
        return $utilisateur;
    }

    // Méthode pour mettre à jour les informations d'un utilisateur
    public function updateUtilisateur($id_utilisateur, $nom, $prenom, $mot_de_passe, $email, $sexe, $role) {
        $query = "UPDATE utilisateur SET nom = ?, prenom = ?, mot_de_passe = ?, email = ?, sexe = ?, role = ?
                  WHERE id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssssssi", $nom, $prenom, $mot_de_passe, $email, $sexe, $role, $id_utilisateur);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les utilisateurs
    public function getAllUtilisateurs() {
        $query = "SELECT * FROM utilisateur";
        $result = $this->conn->query($query);

        $utilisateurs = array();
        while ($row = $result->fetch_assoc()) {
            $utilisateurs[] = $row;
        }

        return $utilisateurs;
    }

    // Méthode pour compter le nombre total d'utilisateurs
    public function countUtilisateurs() {
        $query = "SELECT COUNT(*) as total FROM utilisateur";
        $result = $this->conn->query($query);
        $row = $result->fetch_assoc();

        return $row['total'];
    }

    // Méthode pour supprimer un utilisateur par son ID
    public function deleteUtilisateur($id_utilisateur) {
        $query = "DELETE FROM utilisateur WHERE id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour authentifier un utilisateur
    public function authenticate($email, $mot_de_passe) {
        $query = "SELECT * FROM utilisateur WHERE email = ? AND mot_de_passe = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ss", $email, $mot_de_passe);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $utilisateur = $result->fetch_assoc();
        
        return $utilisateur;
    }

    // Méthode pour vérifier l'existence d'un email
    public function emailExists($email) {
        $query = "SELECT * FROM utilisateur WHERE email = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->num_rows > 0;
    }

    // Méthode pour rechercher des utilisateurs par rôle
    public function getUtilisateursByRole($role) {
        $query = "SELECT * FROM utilisateur WHERE role = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $role);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $utilisateurs = array();
        while ($row = $result->fetch_assoc()) {
            $utilisateurs[] = $row;
        }
        
        return $utilisateurs;
    }

    // Méthode pour rechercher des utilisateurs par sexe
    public function getUtilisateursBySexe($sexe) {
        $query = "SELECT * FROM utilisateur WHERE sexe = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $sexe);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $utilisateurs = array();
        while ($row = $result->fetch_assoc()) {
            $utilisateurs[] = $row;
        }
        
        return $utilisateurs;
    }
}
?>
