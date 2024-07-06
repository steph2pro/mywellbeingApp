<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require_once "Database.php";
class Utilisateur {
    private $conn;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer un nouvel utilisateur
    public function createUtilisateur($nom, $prenom, $mot_de_passe, $email, $sexe, $role,$photo) {
        $query = "INSERT INTO utilisateur (nom, prenom, mot_de_passe, email, sexe, role,photo)
                  VALUES (:nom, :prenom, :mot_de_passe, :email, :sexe, :role,:photo)";

        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':nom', $nom);
        $stmt->bindValue(':prenom', $prenom);
        $stmt->bindValue(':mot_de_passe', $mot_de_passe);
        $stmt->bindValue(':email', $email);
        $stmt->bindValue(':sexe', $sexe);
        $stmt->bindValue(':role', $role);
        $stmt->bindValue(':photo', $photo);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }
    
    // Méthode pour récupérer les informations d'un utilisateur par son ID
    public function getUtilisateurById($id_utilisateur) {
        $query = "SELECT * FROM utilisateur WHERE id_utilisateur = :id_utilisateur";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':id_utilisateur', $id_utilisateur, PDO::PARAM_INT);
        $stmt->execute();
        $utilisateur = $stmt->fetch(PDO::FETCH_ASSOC);
        
        return $utilisateur;
    }

    // Méthode pour mettre à jour les informations d'un utilisateur
    public function updateUtilisateur($id_utilisateur, $nom, $prenom, $mot_de_passe, $email, $sexe, $role) {
        $query = "UPDATE utilisateur SET nom = :nom, prenom = :prenom, mot_de_passe = :mot_de_passe, email = :email, sexe = :sexe, role = :role
                  WHERE id_utilisateur = :id_utilisateur";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':nom', $nom);
        $stmt->bindValue(':prenom', $prenom);
        $stmt->bindValue(':mot_de_passe', $mot_de_passe);
        $stmt->bindValue(':email', $email);
        $stmt->bindValue(':sexe', $sexe);
        $stmt->bindValue(':role', $role);
        $stmt->bindValue(':id_utilisateur', $id_utilisateur, PDO::PARAM_INT);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les utilisateurs
    public function getAllUtilisateurs() {
        $query = "SELECT * FROM utilisateur";
        $stmt = $this->conn->query($query);

        $utilisateurs = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $utilisateurs[] = $row;
        }

        return $utilisateurs;
    }

    // Méthode pour compter le nombre total d'utilisateurs
    public function countUtilisateurs() {
        $query = "SELECT COUNT(*) as total FROM utilisateur";
        $stmt = $this->conn->query($query);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        return $row['total'];
    }

    // Méthode pour supprimer un utilisateur par son ID
    public function deleteUtilisateur($id_utilisateur) {
        $query = "DELETE FROM utilisateur WHERE id_utilisateur = :id_utilisateur";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':id_utilisateur', $id_utilisateur, PDO::PARAM_INT);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

     // Méthode pour authentifier un utilisateur
     public function authenticate($nom, $mot_de_passe) {
        // Vérifier si l'utilisateur existe dans la base de données
        $query = "SELECT * FROM utilisateur WHERE nom = :nom AND mot_de_passe = :mot_de_passe";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':nom', $nom);
        $stmt->bindValue(':mot_de_passe', $mot_de_passe);
        $stmt->execute();
        
        if ($stmt->rowCount() > 0) {
            // Utilisateur trouvé, récupérer les informations et les renvoyer sous forme de tableau associatif
            $data = $stmt->fetch(PDO::FETCH_ASSOC);
            return $data;
        } else {
            // Utilisateur non trouvé, retourner null
            return null;
        }
    }

    // Méthode pour vérifier l'existence d'un email
    public function emailExists($email) {
        $query = "SELECT * FROM utilisateur WHERE email = :email";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':email', $email);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        return $result !== false;
    }

    // Méthode pour rechercher des utilisateurs par rôle
    public function getUtilisateursByRole($role) {
        $query = "SELECT * FROM utilisateur WHERE role = :role";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':role', $role);
        $stmt->execute();
        
        $utilisateurs = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $utilisateurs[] = $row;
        }
        
        return $utilisateurs;
    }

    // Méthode pour rechercher des utilisateurs par sexe
    public function getUtilisateursBySexe($sexe) {
        $query = "SELECT * FROM utilisateur WHERE sexe = :sexe";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':sexe', $sexe);
        $stmt->execute();
        
        $utilisateurs = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $utilisateurs[] = $row;
        }
        
        return $utilisateurs;
    }
}
