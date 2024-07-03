<?php

class RationAlimentaire {
    private $conn;
    private $table_name = "ration_alimentaire";

    public $id_ration_alimentaire;
    public $id_recette;
    public $titre;
    public $description;
    public $contenu;
    public $hydratation;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer une nouvelle ration alimentaire
    public function createRationAlimentaire($id_recette, $titre, $description, $contenu, $hydratation) {
        $query = "INSERT INTO " . $this->table_name . " (id_recette, titre, description, contenu, hydratation)
                  VALUES (?, ?, ?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("issss", $id_recette, $titre, $description, $contenu, $hydratation);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'une ration alimentaire par son ID
    public function getRationAlimentaireById($id_ration_alimentaire) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_ration_alimentaire = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_ration_alimentaire);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $ration_alimentaire = $result->fetch_assoc();
        
        return $ration_alimentaire;
    }

    // Méthode pour mettre à jour les informations d'une ration alimentaire
    public function updateRationAlimentaire($id_ration_alimentaire, $id_recette, $titre, $description, $contenu, $hydratation) {
        $query = "UPDATE " . $this->table_name . " SET id_recette = ?, titre = ?, description = ?, contenu = ?, hydratation = ?
                  WHERE id_ration_alimentaire = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("issssi", $id_recette, $titre, $description, $contenu, $hydratation, $id_ration_alimentaire);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister toutes les rations alimentaires
    public function getAllRationsAlimentaires() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $rations_alimentaires = array();
        while ($row = $result->fetch_assoc()) {
            $rations_alimentaires[] = $row;
        }

        return $rations_alimentaires;
    }

    // Méthode pour supprimer une ration alimentaire par son ID
    public function deleteRationAlimentaire($id_ration_alimentaire) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_ration_alimentaire = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_ration_alimentaire);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }
}
?>
