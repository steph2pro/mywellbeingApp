<?php

class Exercice {
    private $conn;
    private $table_name = "exercice";

    public $id_exercice;
    public $nom;
    public $type;
    public $niveau_difficulte;
    public $contenu;
    public $duree;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer un nouvel exercice
    public function createExercice($nom, $type, $niveau_difficulte, $contenu, $duree) {
        $query = "INSERT INTO " . $this->table_name . " (nom, type, niveau_difficulte, contenu, duree)
                  VALUES (?, ?, ?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssss", $nom, $type, $niveau_difficulte, $contenu, $duree);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un exercice par son ID
    public function getExerciceById($id_exercice) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_exercice = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_exercice);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $exercice = $result->fetch_assoc();
        
        return $exercice;
    }

    // Méthode pour mettre à jour les informations d'un exercice
    public function updateExercice($id_exercice, $nom, $type, $niveau_difficulte, $contenu, $duree) {
        $query = "UPDATE " . $this->table_name . " SET nom = ?, type = ?, niveau_difficulte = ?, contenu = ?, duree = ?
                  WHERE id_exercice = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssssi", $nom, $type, $niveau_difficulte, $contenu, $duree, $id_exercice);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les exercices
    public function getAllExercices() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $exercices = array();
        while ($row = $result->fetch_assoc()) {
            $exercices[] = $row;
        }

        return $exercices;
    }

    // Méthode pour supprimer un exercice par son ID
    public function deleteExercice($id_exercice) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_exercice = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_exercice);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }
}
?>
