<?php
// Configurer la connexion à la base de données
$host = 'localhost';
$db = 'id22366769_mywellbeing_bd';
$dsn = "mysql:host=$host;dbname=$db;charset=utf8";
$username = 'id22366769_teamsteph';
$password = '@teamSteph2024';
 $success = 0;
$msg = "";
try {
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $age = $_POST['age'];
        $taille = $_POST['taille'];
        $poids = $_POST['poids'];
        $ville_residence = $_POST['ville'];
        $objectif = $_POST['objectif'];
        $id=$_POST['id_utilisateur'];
        
       
        
            $sql = 'INSERT INTO profil (id_utilisateur,age, taille, poids, ville_residence, objectifs) VALUES (?, ?, ?, ?, ?,?)';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$id,$age, $taille, $poids, $ville_residence, $objectif]);

            $query = "SELECT * FROM profil WHERE id_utilisateur = :id_utilisateur";
        
                $stmt = $pdo->prepare($query);
                $stmt->bindValue(':id_utilisateur', $id);
                $stmt->execute();
                $profil = $stmt->fetch(PDO::FETCH_ASSOC);
                if ($stmt->rowCount() > 0) {
                    // profil trouvé, récupérer les informations et les renvoyer sous forme de tableau associatif
                    
                    $success = 1;
                    $msg = "Profile enregistrer avec success!";
                } else {
                    // profil non trouvé, retourner null
                    $success = 0;
                    $msg = "impossible d'enregister le profil.";
                }
                    echo json_encode(
                        [
                            "data" => [
                                "message" => $msg,
                                "success" => $success,
                                "profil" => $profil
                            ]
                        ]
                    );
    }
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>
