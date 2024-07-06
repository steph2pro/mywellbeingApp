<?php
// Configurer la connexion à la base de données
$host = 'localhost';
$db = 'id22366769_mywellbeing_bd';
$dsn = "mysql:host=$host;dbname=$db;charset=utf8";
$username = 'id22366769_teamsteph';
$password = '@teamSteph2024';
$success=0;
$result=array();
try {
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $sql = "SELECT * FROM utilisateur u INNER JOIN message m ON(u.id_utilisateur=m.id_utilisateur) WHERE m.type IN ('Actualite', 'ActualiteIMG') ORDER BY m.id_message DESC";
    $req = $pdo->query($sql);
    while($a=$req->fetch()){
        $result[]=$a;
    }
    
} catch (PDOException $e) {
    echo 'Erreur: ' . $e->getMessage();
}

echo json_encode($result);
?>
