<?php
    require_once ("../config/conexion.php");
    require_once ("../models/Unidad.php");

    $unidad = new Unidad();

    switch($_GET["op"]){
        case "guardaryeditar":
            if (empty($_POST["idUnidad"])){
                $unidad -> NuevaUnidad($_POST["Unidad"]);
            }
            else{
                $unidad -> UpdateUnidades($_POST["idUnidad"],$_POST["Unidad"]);
            }
            break;

        case "listar":
            $datos = $unidad -> get_ListarUnidades();
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["Unidad"];
                $sub_array[] = $row["FechaCreacion"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["idUnidad"].')" id="'.$row["idUnidad"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["idUnidad"].')" id="'.$row["idUnidad"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
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
            $datos = $unidad -> get_UnidadesPorID($_POST["idUnidad"]);
            if (is_array($datos) == true and count($datos) >0){
                foreach($datos as $row){
                    $output["idUnidad"] = $row["idUnidad"];
                    $output["Unidad"] = $row["Unidad"];
                }
                echo json_encode($output);
            }
            break;

        case "eliminar":
            $unidad -> DeleteUnidades($_POST["idUnidad"]);
            break;

        case "combo":
            $datos = $unidad -> get_ListarUnidades();
            if(is_array($datos)==true and count($datos)>0){
                $html="";
                $html.="<option selected>Seleccionar</option>";
                foreach($datos as $row){
                    $html.="<option value='".$row["idUnidad"]."'>".$row["Unidad"]."</option>";
                }
                echo $html;
            }
            break;
    }

?>