<?php

class Recette {
    private $conn;
    private $table_name = "recette";

    public $id_recette;
    public $nom;
    public $propriete;
    public $description;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer une nouvelle recette
    public function createRecette($nom, $propriete, $description) {
        $query = "INSERT INTO " . $this->table_name . " (nom, propriete, description)
                  VALUES (?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sss", $nom, $propriete, $description);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'une recette par son ID
    public function getRecetteById($id_recette) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_recette = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_recette);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $recette = $result->fetch_assoc();
        
        return $recette;
    }

    // Méthode pour mettre à jour les informations d'une recette
    public function updateRecette($id_recette, $nom, $propriete, $description) {
        $query = "UPDATE " . $this->table_name . " SET nom = ?, propriete = ?, description = ?
                  WHERE id_recette = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssi", $nom, $propriete, $description, $id_recette);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister toutes les recettes
    public function getAllRecettes() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $recettes = array();
        while ($row = $result->fetch_assoc()) {
            $recettes[] = $row;
        }

        return $recettes;
    }

    // Méthode pour supprimer une recette par son ID
    public function deleteRecette($id_recette) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_recette = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_recette);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }
}
?>
