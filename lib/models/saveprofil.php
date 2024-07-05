<?php
// Configurer la connexion à la base de données
$host = 'localhost';
$db = 'id22366769_mywellbeing_bd';
$dsn = "mysql:host=$host;dbname=$db;charset=utf8";
$username = 'id22366769_teamsteph';
$password = '@teamSteph2024';

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
        
        if (!empty($_FILES['photo']['name'])) {
            $photo = $_FILES['photo']['tmp_name'];
            $ext = pathinfo($_FILES['photo']['name'], PATHINFO_EXTENSION);
            $newName = 'profile_' . rand() . '.' . $ext;
            $target = 'profils/' . $newName;
            move_uploaded_file($photo, $target);
            
            $sql = 'INSERT INTO profil (id_utilisateur,age, taille, poids, ville_residence, objectifs, photo) VALUES (?, ?, ?, ?, ?, ?)';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$id,$age, $taille, $poids, $ville_residence, $objectif, $newName]);

            echo json_encode(['message' => 'Profile registered successfully']);
        } else {
            echo json_encode(['message' => 'No photo uploaded']);
        }
    }
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>
