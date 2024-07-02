<?php
require_once "Database.php";
class GroupesDiscussion {
    private $conn;
    private $table_name = "groupes_discussion";

    public $id_groupes_discussion;
    public $nom;
    public $objectif;
    public $photo;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer un nouveau groupe de discussion
    public function createGroupeDiscussion($nom, $objectif, $photo) {
        $query = "INSERT INTO " . $this->table_name . " (nom, objectif, photo) VALUES (?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sss", $nom, $objectif, $photo);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un groupe de discussion par son ID
    public function getGroupeDiscussionById($id_groupes_discussion) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_groupes_discussion = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_groupes_discussion);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $groupe = $result->fetch_assoc();
        
        return $groupe;
    }

    // Méthode pour mettre à jour les informations d'un groupe de discussion
    public function updateGroupeDiscussion($id_groupes_discussion, $nom, $objectif, $photo) {
        $query = "UPDATE " . $this->table_name . " SET nom = ?, objectif = ?, photo = ? WHERE id_groupes_discussion = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssi", $nom, $objectif, $photo, $id_groupes_discussion);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les groupes de discussion
    public function getAllGroupesDiscussion() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $groupes = array();
        while ($row = $result->fetch_assoc()) {
            $groupes[] = $row;
        }

        return $groupes;
    }

    // Méthode pour supprimer un groupe de discussion par son ID
    public function deleteGroupeDiscussion($id_groupes_discussion) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_groupes_discussion = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_groupes_discussion);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour ajouter un utilisateur à un groupe de discussion
    public function addUserToGroupe($id_utilisateur, $id_groupes_discussion) {
        $query = "INSERT INTO appartenir (id_utilisateur, id_groupes_discussion) VALUES (?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ii", $id_utilisateur, $id_groupes_discussion);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour retirer un utilisateur d'un groupe de discussion
    public function removeUserFromGroupe($id_utilisateur, $id_groupes_discussion) {
        $query = "DELETE FROM appartenir WHERE id_utilisateur = ? AND id_groupes_discussion = ?";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ii", $id_utilisateur, $id_groupes_discussion);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour obtenir tous les utilisateurs appartenant à un groupe de discussion
    public function getUsersByGroupeId($id_groupes_discussion) {
        $query = "SELECT utilisateur.* FROM utilisateur 
                  INNER JOIN appartenir ON utilisateur.id_utilisateur = appartenir.id_utilisateur 
                  WHERE appartenir.id_groupes_discussion = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_groupes_discussion);
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
