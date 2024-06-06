<?php 
    require_once("../../config/conexion.php");

    header("Location:".conectar::ruta());
    session_destroy();
    exit();
?>