<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
class Database {
    private $host = 'localhost';
    private $dbname = 'id22366769_mywellbeing_bd';
    private $username = 'id22366769_teamsteph';
    private $password = '@teamSteph2024';
    private $connection;

    public function __construct() {
        $this->connect();
    }

    private function connect() {
        try {
            $dsn = "mysql:host={$this->host};dbname={$this->dbname}";
            $this->connection = new PDO($dsn, $this->username, $this->password);
            $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo "Erreur de connexion à la base de données : " . $e->getMessage();
        }
    }

    public function getConnection() {
        return $this->connection;
    }
    public function testConnection() {
        if ($this->connection) {
            return "Connexion à la base de données réussie.";
        } else {
            return "Erreur de connexion à la base de données.";
        }
    }
}