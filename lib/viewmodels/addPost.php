<?php
// Configurer la connexion à la base de données
$host = 'localhost';
$db = 'id22366769_mywellbeing_bd';
$dsn = "mysql:host=$host;dbname=$db;charset=utf8";
$username = 'id22366769_teamsteph';
$password = '@teamSteph2024';
$msg="";
$succes=0;
try {
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $titre = $_POST['titre'];
        $type = $_POST['type'];
        $description = $_POST['description'];
        $id = $_POST['id_utilisateur'];
        $contenu = $_POST['contenu'];

        
        if (!empty($_FILES['photo']['name'])) {
            $photo = $_FILES['photo']['tmp_name'];
            $ext = pathinfo($_FILES['photo']['name'], PATHINFO_EXTENSION);
            $newName = 'profile_' . rand() . '.' . $ext;
            $target = 'actualites/' . $newName;
            move_uploaded_file($photo, $target);
            $type="ActualiteIMG";
            $sql = 'INSERT INTO message (id_utilisateur,titre, type,  contenu, description) VALUES (?, ?, ?, ?, ?)';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$id,$titre, $type, $newName, $description]);
            $succes = 1;
            $msg=  'Actualite poster avec success';
        } else {
            $sql = 'INSERT INTO message (id_utilisateur,titre, type,  contenu, description) VALUES (?, ?, ?, ?, ?)';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$id,$titre, $type, $contenu, $description]);
            $succes = 1;
            $msg= 'Actualite poster avec success';
            
        }
    }
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}

echo json_encode(
    [
        "data" => [
            "message" => $msg,
            "success" => $succes
        ]
    ]
);
?>
