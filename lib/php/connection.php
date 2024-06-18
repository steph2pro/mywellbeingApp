<?php
// script de connection avec pdo
$host="localhost";
$dbname="id22112172_mywellbeing_bd";
$user="id22112172_stephteam";
$pass="@stephTeam2024";

try{
  $db=new PDO("mysql:host=$host; dbname=$dbname",$user,$pass);
  //echo " connection etablir";
}catch(\Throwable $th){
 // echo "erreue : ".$th->getMessage();
}




?>