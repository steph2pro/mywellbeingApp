<?php
require_once "Database.php";
class Administrateur {
    private $conn;
    private $table_name = "administrateur";

    public $id_administrateur;
    public $id_utilisateur;
    public $autorisations;
    public $qualification;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer un nouvel administrateur
    public function createAdministrateur($id_utilisateur, $autorisations, $qualification) {
        $query = "INSERT INTO " . $this->table_name . " (id_utilisateur, autorisations, qualification)
                  VALUES (?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("iss", $id_utilisateur, $autorisations, $qualification);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un administrateur par son ID
    public function getAdministrateurById($id_administrateur) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_administrateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_administrateur);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $administrateur = $result->fetch_assoc();
        
        return $administrateur;
    }

    // Méthode pour mettre à jour les informations d'un administrateur
    public function updateAdministrateur($id_administrateur, $id_utilisateur, $autorisations, $qualification) {
        $query = "UPDATE " . $this->table_name . " SET id_utilisateur = ?, autorisations = ?, qualification = ?
                  WHERE id_administrateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("issi", $id_utilisateur, $autorisations, $qualification, $id_administrateur);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les administrateurs
    public function getAllAdministrateurs() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $administrateurs = array();
        while ($row = $result->fetch_assoc()) {
            $administrateurs[] = $row;
        }

        return $administrateurs;
    }

    // Méthode pour supprimer un administrateur par son ID
    public function deleteAdministrateur($id_administrateur) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_administrateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_administrateur);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un administrateur par son ID utilisateur
    public function getAdministrateurByUtilisateurId($id_utilisateur) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $administrateur = $result->fetch_assoc();
        
        return $administrateur;
    }

    // Méthode pour lister tous les administrateurs avec un certain niveau d'autorisations
    public function getAdministrateursByAutorisations($autorisations) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE autorisations = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $autorisations);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $administrateurs = array();
        while ($row = $result->fetch_assoc()) {
            $administrateurs[] = $row;
        }
        
        return $administrateurs;
    }

    // Méthode pour lister tous les administrateurs avec une certaine qualification
    public function getAdministrateursByQualification($qualification) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE qualification = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $qualification);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $administrateurs = array();
        while ($row = $result->fetch_assoc()) {
            $administrateurs[] = $row;
        }
        
        return $administrateurs;
    }
}
?>
