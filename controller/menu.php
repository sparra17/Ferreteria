<?php
    require_once ("../config/conexion.php");
    require_once ("../models/Menu.php");

    $menu = new Menu();

    switch($_GET["op"]){
        

        case "listar":
            $datos = $menu -> get_ListarMenu($_POST["idRol"]);
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["Menu"];
                if($row["Permiso"] == 'Si'){
                    $sub_array[] = '<button type="button" onClick="deshabilitar('.$row["idMenuDetalle"].')" id="'.$row["idMenuDetalle"].'" class="btn btn-success">'.$row["Permiso"].'</button>';
                }
                else{
                    $sub_array[] = '<button type="button" onClick="habilitar('.$row["idMenuDetalle"].')" id="'.$row["idMenuDetalle"].'" class="btn btn-danger">'.$row["Permiso"].'</button>';
                }
                $data[] = $sub_array;
            }
            $results = array(
                "sEcho" => 1,
                "iTotalRecors" => count($data),
                "iTotalDisplayRecords" => count($data),
                "aaData" => $data);
            echo json_encode($results);
            break;

        case "habilitar":
            $menu -> UpdateMenuHab($_POST["idMenuDetalle"]);
            break;

        case "deshabilitar":
            $menu -> UpdateMenuDesHab($_POST["idMenuDetalle"]);
            break;

    }

?>