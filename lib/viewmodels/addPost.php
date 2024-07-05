<?php

 include "connection.php";
 require_once '../models/crypto/crypto.php';

$post=json_decode(decrypt($_POST["data"]));
$id_user=$post->id_utilisateur;
$titre=$post->titre;
$type=$post->type;
$contenue=$post->contenue;
$isok=false;
$msg="";
try{
    $query = "INSERT INTO message (id_utilisateur, titre_message, type, contenu)
                  VALUES (:id_utilisateur, :titre, :type, :contenu)";

        $stmt = $db->prepare($query);
        $stmt->bindValue(':id_utilisateur', $id_user);
        $stmt->bindValue(':titre', $titre);
        $stmt->bindValue(':type', $type);
        $stmt->bindValue(':contenu', $contenue);

    //     if ($stmt->execute()) {}
    // $req=$db->prepare("INSERT INTO message (id_utilisateur, titre, type, contenu, date_envoi) VALUES(?,?,?,?,)");
    // $req->execute(array($id_user,$titre,$type,$contenue));
    if ($stmt->execute()) {
        $msg="Actualite poster avce succes";
        $isok=true;
    } else {
        $msg="echec de la publication de l'actualite";
        # code...
    }
    
    

}catch(\Throwable $th){
    $succes=0;
    $msg=" Erreur serveur: ".$th->getMessage();
} 
echo 
    json_encode(
        [
            $isok,
            $msg
        ]
    
 );