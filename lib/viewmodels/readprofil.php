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

    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $id = $_GET['id_utilisateur'];
        
        $sql = 'SELECT * FROM profil WHERE id_utilisateur = ?';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$id]);
        $profile = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($profile) {
            echo json_encode($profile);
        } else {
            echo json_encode(['message' => 'Profile innexistant']);
        }
    }
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>
