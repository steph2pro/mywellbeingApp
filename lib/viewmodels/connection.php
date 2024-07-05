<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// script de connection avec pdo
$host="localhost";
$dbname="id22366769_mywellbeing_bd";
$user="id22366769_teamsteph";
$pass="@teamSteph2024";

try{
  $db=new PDO("mysql:host=$host; dbname=$dbname",$user,$pass);
  //echo " connection etablir";
}catch(\Throwable $th){
 // echo "erreue : ".$th->getMessage();
}




?>