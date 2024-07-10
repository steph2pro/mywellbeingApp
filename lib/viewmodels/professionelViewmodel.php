<?php

require_once '../models/Database.php'; // Assurez-vous que le chemin est correct
require_once '../models/Professionel.php';
require_once '../models/crypto/crypto.php';

// Instancier la classe Database
$database = new Database();
$connection = $database->getConnection();
$profBD = new ProfessionnelDeSante($connection);
$succes=0;
// Récupération des données
$action = ($_POST['action']);

// Effectuer les opérations CRUD en fonction de l'action
switch ($action) {
    case 'create':
        $id_utilisateur = $_POST['id_utilisateur'];
        $specialite = $_POST['specialite'];
        $description = $_POST['description'];
        $horaire = $_POST['horaire'];
        $dispo = $_POST['disponibilite'];
        if (!empty($_FILES['photo']['name'])) {
            $photo = $_FILES['photo']['tmp_name'];
            $ext = pathinfo($_FILES['photo']['name'], PATHINFO_EXTENSION);
            $newName = 'profile_' . rand() . '.' . $ext;
            $target = 'profils/' . $newName;
            move_uploaded_file($photo, $target);
            
                    
                        // Créer un nouvel utilisateur
                        $create = $profBD->createProfessionnelDeSante($id_utilisateur, $description, $specialite,$horaire, $dispo,$newName);
                        if ($create) {
                            // $query = "SELECT * FROM professionnel_de_sante WHERE id_utilisateur = :id_utilisateur";
        $query = "SELECT * FROM utilisateur u INNER JOIN professionnel_de_sante p ON(u.id_utilisateur=p.id_utilisateur) WHERE u.role='professionel' AND p.id_professionnel_de_sante=$id_utilisateur";
                            $stmt = $connection->prepare($query);
                            // $stmt->bindValue(':id_utilisateur', $id_utilisateur);
                            $stmt->execute();
                            $professionel = $stmt->fetch(PDO::FETCH_ASSOC);
                            if ($stmt->rowCount() > 0) {
                                // profil trouvé, récupérer les informations et les renvoyer sous forme de tableau associatif
                                
                                $succes = 1;
                                $msg = "Profile enregistrer avec success!";
                            } else {
                                // profil non trouvé, retourner null
                                $succes = 0;
                                $msg = "impossible d'enregister le profil.";
                            }
                      
                    }
        } else {
            $succes = 0;
            $msg = "aucune photo n'as ete charger.";
        }
       

        echo json_encode(
            [
                "data" => [
                    "message" => $msg,
                    "success" => $succes,
                    "professionel" => $professionel
                ]
            ]
        );
        break;
    }