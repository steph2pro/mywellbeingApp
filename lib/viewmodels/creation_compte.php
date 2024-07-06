<?php
 include "connection.php";
 $nom= $_POST['nom'];
 $prenom= $_POST['prenom'];
 //cryptage du mot de pass
 $pass=sha1($_POST['pass']);
  $email= $_POST['email'];
 $residence= $_POST['residence'];
  $sexe= $_POST['sexe'];
  $role="simple_utilisateur";
 try{
    if(isset($nom,$prenom,$email,$pass,$residence,$sexe)){
        //selection des email
        $req=$db->prepare("SELECT * FROM utilisateur WHERE email=?");
        $req->execute(array($email));
        $exist=$req->rowCount();
        //verification si un utilisateur possede deja l'email quon veut enregistrer
        if($exist==0){
            $req=$db->prepare("INSERT INTO utilisateur VALUES(null,?,?,?,?,?,?,?)");
            $req->execute(array($nom,$prenom,$pass,$email,$residence,$sexe,$role));
            if($req){
                $succes=1;
                $msg="compte creer avec succes !";
            }else{
                $succes=0;
                $msg="erreur d'enregistrement";
            }
        }else{
                $succes=0;
                $msg="cette email es deja existante et est utilisee par un autre";
            
        }
    }else{
        $succes=0;
        $msg="erreur les donnees sont vide";

    }
 }catch(\Throwable $th){
    $succes=0;
    $msg=" Erreur: ".$th->getMessage();
} 
//affichage d'un resultat
 echo json_encode(
    [
        "data"=>[
            $msg,
            $succes
        ]
    ]
 );







 //add post 
 
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
?>