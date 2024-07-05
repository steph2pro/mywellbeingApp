<?php

// Vérifiez si les données POST sont envoyées
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    // Récupérer les données POST
    $nom = $_POST['nom'] ?? '';
    $description = $_POST['description'] ?? '';
    $propriete = $_POST['propriete'] ?? '';
    $ingredients = $_POST['ingredients'] ?? '';
    $image = $_POST['image'] ?? '';

    // Vérifiez si toutes les données nécessaires sont présentes
    if (!empty($nom) && !empty($description) && !empty($propriete) && !empty($ingredients) && !empty($image)) {

        include "connection.php"; // Inclure la connexion à la base de données

        try {
            // Préparez et exécutez la requête SQL d'insertion
            $req = $db->prepare("INSERT INTO recette(nom, propriete, description, ingredients, image)
                                VALUES (?, ?, ?, ?, ?)");

            $req->execute(array($nom, $propriete, $description, $ingredients, $image));

            // Vérifier si l'insertion s'est bien passée
            if ($req) {
                $success = true;
                $msg = "Recette ajoutée avec succès";
            } else {
                $success = false;
                $msg = "Erreur lors de l'ajout de la recette";
            }

        } catch (\Throwable $th) {
            $success = false;
            $msg = "Erreur lors de l'ajout de la recette: " . $th->getMessage();
        }

    } else {
        $success = false;
        $msg = "Tous les champs sont requis";
    }

} else {
    $success = false;
    $msg = "Méthode non autorisée";
}

// Répondre avec un objet JSON unique
echo json_encode([
    "success" => $success,
    "message" => $msg
]);

?>
