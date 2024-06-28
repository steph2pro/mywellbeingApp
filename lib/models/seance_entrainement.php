<?php

class SeanceEntrainement {
    private $conn;
    private $table_name = "seance_entrainement";

    public $id_seance_entrainement;
    public $titre;
    public $description;
    public $contenu;
    public $duree;
    public $niveau_difficulte;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer une nouvelle séance d'entraînement
    public function createSeanceEntrainement($titre, $description, $contenu, $duree, $niveau_difficulte) {
        $query = "INSERT INTO " . $this->table_name . " (titre, description, contenu, duree, niveau_difficulte)
                  VALUES (?, ?, ?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssss", $titre, $description, $contenu, $duree, $niveau_difficulte);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'une séance d'entraînement par son ID
    public function getSeanceEntrainementById($id_seance_entrainement) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_seance_entrainement = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_seance_entrainement);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $seance_entrainement = $result->fetch_assoc();
        
        return $seance_entrainement;
    }

    // Méthode pour mettre à jour les informations d'une séance d'entraînement
    public function updateSeanceEntrainement($id_seance_entrainement, $titre, $description, $contenu, $duree, $niveau_difficulte) {
        $query = "UPDATE " . $this->table_name . " SET titre = ?, description = ?, contenu = ?, duree = ?, niveau_difficulte = ?
                  WHERE id_seance_entrainement = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssssi", $titre, $description, $contenu, $duree, $niveau_difficulte, $id_seance_entrainement);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister toutes les séances d'entraînement
    public function getAllSeancesEntrainement() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $seances_entrainement = array();
        while ($row = $result->fetch_assoc()) {
            $seances_entrainement[] = $row;
        }

        return $seances_entrainement;
    }

    // Méthode pour supprimer une séance d'entraînement par son ID
    public function deleteSeanceEntrainement($id_seance_entrainement) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_seance_entrainement = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_seance_entrainement);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }
}
?>
