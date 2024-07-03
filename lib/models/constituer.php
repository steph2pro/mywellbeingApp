<?php

class Constituer {
    private $conn;
    private $table_name = "constituer";

    public $id_seance_entrainement;
    public $id_exercice;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour associer un exercice à une séance d'entraînement
    public function associerExercice($id_seance_entrainement, $id_exercice) {
        $query = "INSERT INTO " . $this->table_name . " (id_seance_entrainement, id_exercice)
                  VALUES (?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ii", $id_seance_entrainement, $id_exercice);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer tous les exercices associés à une séance d'entraînement
    public function getExercicesBySeanceEntrainement($id_seance_entrainement) {
        $query = "SELECT e.* FROM exercice e
                  INNER JOIN " . $this->table_name . " c ON e.id_exercice = c.id_exercice
                  WHERE c.id_seance_entrainement = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_seance_entrainement);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $exercices = array();
        while ($row = $result->fetch_assoc()) {
            $exercices[] = $row;
        }
        
        return $exercices;
    }

    // Méthode pour dissocier un exercice d'une séance d'entraînement
    public function dissocierExercice($id_seance_entrainement, $id_exercice) {
        $query = "DELETE FROM " . $this->table_name . "
                  WHERE id_seance_entrainement = ? AND id_exercice = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ii", $id_seance_entrainement, $id_exercice);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }
}
?>
