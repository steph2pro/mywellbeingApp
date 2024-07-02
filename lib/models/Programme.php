<?php
require_once "Database.php";
class Programme {
    private $conn;
    private $table_name = "programme";

    public $id_programme;
    public $id_ration_alimentaire;
    public $id_seance_entrainement;
    public $titre;
    public $description;
    public $type;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer un nouveau programme
    public function createProgramme($id_ration_alimentaire, $id_seance_entrainement, $titre, $description, $type) {
        $query = "INSERT INTO " . $this->table_name . " (id_ration_alimentaire, id_seance_entrainement, titre, description, type)
                  VALUES (?, ?, ?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("iisss", $id_ration_alimentaire, $id_seance_entrainement, $titre, $description, $type);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un programme par son ID
    public function getProgrammeById($id_programme) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_programme = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_programme);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $programme = $result->fetch_assoc();
        
        return $programme;
    }

    // Méthode pour mettre à jour les informations d'un programme
    public function updateProgramme($id_programme, $id_ration_alimentaire, $id_seance_entrainement, $titre, $description, $type) {
        $query = "UPDATE " . $this->table_name . " SET id_ration_alimentaire = ?, id_seance_entrainement = ?, titre = ?, description = ?, type = ?
                  WHERE id_programme = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("iisssi", $id_ration_alimentaire, $id_seance_entrainement, $titre, $description, $type, $id_programme);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les programmes
    public function getAllProgrammes() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $programmes = array();
        while ($row = $result->fetch_assoc()) {
            $programmes[] = $row;
        }

        return $programmes;
    }

    // Méthode pour supprimer un programme par son ID
    public function deleteProgramme($id_programme) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_programme = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_programme);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les programmes par type
    public function getProgrammesByType($type) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE type = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("s", $type);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $programmes = array();
        while ($row = $result->fetch_assoc()) {
            $programmes[] = $row;
        }
        
        return $programmes;
    }

    // Méthode pour lister les programmes suivis par un utilisateur
    public function getProgrammesByUtilisateur($id_utilisateur) {
        $query = "SELECT p.* FROM " . $this->table_name . " p
                  JOIN suivre s ON p.id_programme = s.id_programme
                  WHERE s.id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $programmes = array();
        while ($row = $result->fetch_assoc()) {
            $programmes[] = $row;
        }
        
        return $programmes;
    }

    // Méthode pour compter les programmes suivis par un utilisateur
    public function countProgrammesByUtilisateur($id_utilisateur) {
        $query = "SELECT COUNT(*) as total FROM suivre WHERE id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        
        return $row['total'];
    }

    // Méthode pour lister les types de programmes suivis par un utilisateur
    public function getTypesByUtilisateur($id_utilisateur) {
        $query = "SELECT DISTINCT p.type FROM " . $this->table_name . " p
                  JOIN suivre s ON p.id_programme = s.id_programme
                  WHERE s.id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $types = array();
        while ($row = $result->fetch_assoc()) {
            $types[] = $row['type'];
        }
        
        return $types;
    }

    // Méthode pour lister les programmes suivis par un utilisateur par type
    public function getProgrammesByUtilisateurAndType($id_utilisateur, $type) {
        $query = "SELECT p.* FROM " . $this->table_name . " p
                  JOIN suivre s ON p.id_programme = s.id_programme
                  WHERE s.id_utilisateur = ? AND p.type = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("is", $id_utilisateur, $type);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $programmes = array();
        while ($row = $result->fetch_assoc()) {
            $programmes[] = $row;
        }
        
        return $programmes;
    }

    // Méthode pour compter les programmes suivis par un utilisateur par type
    public function countProgrammesByUtilisateurAndType($id_utilisateur, $type) {
        $query = "SELECT COUNT(*) as total FROM " . $this->table_name . " p
                  JOIN suivre s ON p.id_programme = s.id_programme
                  WHERE s.id_utilisateur = ? AND p.type = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("is", $id_utilisateur, $type);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        
        return $row['total'];
    }
}
?>
