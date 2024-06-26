<?php

class Message {
    private $conn;
    private $table_name = "message";

    public $id_message;
    public $id_utilisateur;
    public $titre;
    public $type;
    public $contenu;
    public $date_envoi;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Méthode pour créer un nouveau message
    public function createMessage($id_utilisateur, $titre, $type, $contenu, $date_envoi) {
        $query = "INSERT INTO " . $this->table_name . " (id_utilisateur, titre, type, contenu, date_envoi)
                  VALUES (?, ?, ?, ?, ?)";

        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("issss", $id_utilisateur, $titre, $type, $contenu, $date_envoi);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les informations d'un message par son ID
    public function getMessageById($id_message) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_message = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_message);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $message = $result->fetch_assoc();
        
        return $message;
    }

    // Méthode pour mettre à jour les informations d'un message
    public function updateMessage($id_message, $id_utilisateur, $titre, $type, $contenu, $date_envoi) {
        $query = "UPDATE " . $this->table_name . " SET id_utilisateur = ?, titre = ?, type = ?, contenu = ?, date_envoi = ?
                  WHERE id_message = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("issssi", $id_utilisateur, $titre, $type, $contenu, $date_envoi, $id_message);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour lister tous les messages
    public function getAllMessages() {
        $query = "SELECT * FROM " . $this->table_name;
        $result = $this->conn->query($query);

        $messages = array();
        while ($row = $result->fetch_assoc()) {
            $messages[] = $row;
        }

        return $messages;
    }

    // Méthode pour supprimer un message par son ID
    public function deleteMessage($id_message) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_message = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_message);

        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }

    // Méthode pour récupérer les messages par ID utilisateur
    public function getMessagesByUtilisateurId($id_utilisateur) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_utilisateur = ?";
        
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id_utilisateur);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $messages = array();
        while ($row = $result->fetch_assoc()) {
            $messages[] = $row;
        }
        
        return $messages;
    }
}
?>
