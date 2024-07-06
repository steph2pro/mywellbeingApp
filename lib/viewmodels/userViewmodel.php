<?php

require_once '../models/Database.php'; // Assurez-vous que le chemin est correct
require_once '../models/Utilisateur.php';
require_once '../models/crypto/crypto.php';

// Instancier la classe Database
$database = new Database();
$connection = $database->getConnection();
$userBD = new Utilisateur($connection);

// Récupération des données
$action = ($_POST['action']);

// Effectuer les opérations CRUD en fonction de l'action
switch ($action) {
    case 'create':
        $nom = $_POST['nom'];
        $prenom = $_POST['prenom'];
        // Cryptage du mot de passe 
        $pass = sha1($_POST['pass']);
        $email = $_POST['email'];
        $sexe = $_POST['sexe'];
        $role = "simple_utilisateur";
        if (!empty($_FILES['photo']['name'])) {
            $photo = $_FILES['photo']['tmp_name'];
            $ext = pathinfo($_FILES['photo']['name'], PATHINFO_EXTENSION);
            $newName = 'profile_' . rand() . '.' . $ext;
            $target = 'profils/' . $newName;
            move_uploaded_file($photo, $target);
            
            // $sql = 'INSERT INTO profil (id_utilisateur,age, taille, poids, ville_residence, objectifs, photo) VALUES (?, ?, ?, ?, ?, ?)';
            // $stmt = $pdo->prepare($sql);
            // $stmt->execute([$id,$age, $taille, $poids, $ville_residence, $objectif, $newName]);
            // Vérifier si l'email existe déjà
                    if ($userBD->emailExists($email)) {
                        $succes = 0;
                        $msg = "L'email existe deja. Veuillez utiliser un autre email.";
                    } else {
                        // Créer un nouvel utilisateur
                        $create = $userBD->createUtilisateur($nom, $prenom, $pass, $email, $sexe, $role,$newName);
                        if ($create) {
                            $succes = 1;
                            $msg = "Compte cree avec succes !";
                        } else {
                            $succes = 0;
                            $msg = "Erreur d'enregistrement.";
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
                    "success" => $succes
                ]
            ]
        );
        break;
        case 'login':
                    // Récupérer les données de connexion
                $nom =decrypt( $_POST['nom']);
                $mot_de_passe = sha1(decrypt($_POST['pass'])); // Cryptage du mot de passe avec 
                $query = "SELECT * FROM utilisateur WHERE nom = :nom AND mot_de_passe = :mot_de_passe";
        
                $stmt = $connection->prepare($query);
                $stmt->bindValue(':nom', $nom);
                $stmt->bindValue(':mot_de_passe', $mot_de_passe);
                $stmt->execute();
                $utilisateur = $stmt->fetch(PDO::FETCH_ASSOC);
                if ($stmt->rowCount() > 0) {
                    // Utilisateur trouvé, récupérer les informations et les renvoyer sous forme de tableau associatif
                    
                    $success = 1;
                    $msg = "Connexion réussie !";
                } else {
                    // Utilisateur non trouvé, retourner null
                    // Authentification échouée
                    $success = 0;
                    $msg = "nom ou mot de passe incorrect.";
                }
                    echo json_encode(
                        [
                            "data" => [
                                "message" => encrypt($msg),
                                "success" => $success,
                                "user" => $utilisateur
                            ]
                        ]
                    );
           
            break;
    
    case 'update':
        // Code pour la mise à jour
        break;

    // Ajouter d'autres cas selon les besoins
}
?>
