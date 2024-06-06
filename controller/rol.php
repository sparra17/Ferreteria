<?php
    require_once ("../config/conexion.php");
    require_once ("../models/Rol.php");

    $rol = new Rol();

    switch($_GET["op"]){
        case "guardaryeditar":
            if (empty($_POST["idRol"])){
                $rol -> NuevoRol($_POST["Rol"]);
            }
            else{
                $rol -> UpdateRoles($_POST["idRol"],$_POST["Rol"]);
            }
            break;

        case "listar":
            $datos = $rol -> get_ListarRoles();
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["Rol"];
                $sub_array[] = $row["FechaCreacion"];
                $sub_array[] = '<button type="button" onClick="permiso('.$row["idRol"].')" id="'.$row["idRol"].'" class="btn btn-primary btn-icon waves-effect waves-light"><i class="ri-settings-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="editar('.$row["idRol"].')" id="'.$row["idRol"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["idRol"].')" id="'.$row["idRol"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
                $data[] = $sub_array;
            }
            $results = array(
                "sEcho" => 1,
                "iTotalRecors" => count($data),
                "iTotalDisplayRecords" => count($data),
                "aaData" => $data);
            echo json_encode($results);
            break;

        case "mostrar":
            $datos = $rol -> get_RolesPorID($_POST["idRol"]);
            if (is_array($datos) == true and count($datos) >0){
                foreach($datos as $row){
                    $output["idRol"] = $row["idRol"];
                    $output["Rol"] = $row["Rol"];
                }
                echo json_encode($output);
            }
            break;

        case "eliminar":
            $rol -> DeleteRoles($_POST["idRol"]);
            break;

        case "combo":
            $datos = $rol -> get_ListarRoles();
            if(is_array($datos)==true and count($datos)>0){
                $html="";
                $html.="<option selected>Seleccionar</option>";
                foreach($datos as $row){
                    $html.="<option value='".$row["idRol"]."'>".$row["Rol"]."</option>";
                }
                echo $html;
            }
            break;
    }

?>