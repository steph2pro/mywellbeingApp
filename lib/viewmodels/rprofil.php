<?php
// Configurer la connexion à la base de données
$host = 'localhost';
$db = 'id22366769_mywellbeing_bd';
$dsn = "mysql:host=$host;dbname=$db;charset=utf8";
$username = 'id22366769_teamsteph';
$password = '@teamSteph2024';
$success=0;
$result=array();
$id=$_POST["id"];
try {
    
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $sql = "SELECT * FROM utilisateur u INNER JOIN profil p ON(u.id_utilisateur=p.id_utilisateur) WHERE p.id_utilisateur=$id";
    $req = $pdo->query($sql);
    while($a=$req->fetch()){
        $result[]=$a;
    }
    
} catch (PDOException $e) {
    echo 'Erreur: ' . $e->getMessage();
}

echo json_encode($result);
?>
