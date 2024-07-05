<?php
const key="abcdefghijklmnop";
const iv="hellotoutlemonde";
const method="aes-128-cbc";
function encrypt($text){
    return openssl_encrypt($text,method,key,0,iv);
}
function decrypt($text){
    return openssl_decrypt($text,method,key,0,iv);
}