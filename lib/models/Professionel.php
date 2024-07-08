<?php
require_once "Database.php";
class ProfessionnelDeSante {
    private $conn;
    private $table_name = "professionnel_de_sante";

    public $id_professionnel_de_sante;
    public $id_utilisateur;
    public $description;
    public $specialite;
    public $horaire_travail;
    public $disponibilite;
    public $photo;
    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer un nouveau professionnel de santé
    public function createProfessionnelDeSante($id_utilisateur, $description, $specialite, $horaire_travail, $disponibilite,$photo) {
        $query = "INSERT INTO " . $this->table_name . " (id_utilisateur, description, specialite, horaire_travail, disponibilite,photo)
                   VALUES (:id_utilisateur, :description, :specialite, :horaire_travail, :disponibilite, :photo)";
                  
        $stmt = $this->conn->prepare($query);
        $stmt->bindValue(':id_utilisateur', $id_utilisateur);
        $stmt->bindValue(':description', $description);
        $stmt->bindValue(':specialite', $specialite);
        $stmt->bindValue(':horaire_travail', $horaire_travail);
        $stmt->bindValue(':disponibilite', $disponibilite);
        $stmt->bindValue(':photo', $photo);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un professionnel de santé par son ID
    public function getProfessionnelDeSanteById($id_professionnel_de_sante) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_professionnel_de_sante = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_professionnel_de_sante);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $professionnel_de_sante = $result->fetch_assoc();
        
        return $professionnel_de_sante;
    }

    // Méthode pour mettre à jour les informations d'un professionnel de santé
    public function updateProfessionnelDeSante($id_professionnel_de_sante, $id_utilisateur, $description, $specialite, $horaire_travail, $disponibilite) {
        $query = "UPDATE " . $this->table_name . " SET id_utilisateur = ?, description = ?, specialite = ?, horaire_travail = ?, disponibilite = ?
                  WHERE id_professionnel_de_sante = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("issssi", $id_utilisateur, $description, $specialite, $horaire_travail, $disponibilite, $id_professionnel_de_sante);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les professionnels de santé
    public function getAllProfessionnelsDeSante() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $professionnels_de_sante = array();
        while ($row = $result->fetch_assoc()) {
            $professionnels_de_sante[] = $row;
        }

        return $professionnels_de_sante;
    }

    // Méthode pour supprimer un professionnel de santé par son ID
    public function deleteProfessionnelDeSante($id_professionnel_de_sante) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_professionnel_de_sante = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_professionnel_de_sante);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un professionnel de santé par son ID utilisateur
    public function getProfessionnelDeSanteByUtilisateurId($id_utilisateur) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $professionnel_de_sante = $result->fetch_assoc();
        
        return $professionnel_de_sante;
    }

    // Méthode pour lister tous les professionnels de santé par spécialité
    public function getProfessionnelsDeSanteBySpecialite($specialite) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE specialite = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $specialite);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $professionnels_de_sante = array();
        while ($row = $result->fetch_assoc()) {
            $professionnels_de_sante[] = $row;
        }
        
        return $professionnels_de_sante;
    }

    // Méthode pour lister tous les professionnels de santé par disponibilité
    public function getProfessionnelsDeSanteByDisponibilite($disponibilite) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE disponibilite = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $disponibilite);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $professionnels_de_sante = array();
        while ($row = $result->fetch_assoc()) {
            $professionnels_de_sante[] = $row;
        }
        
        return $professionnels_de_sante;
    }
}
?>
