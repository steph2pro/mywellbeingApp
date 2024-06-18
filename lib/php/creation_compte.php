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
?>