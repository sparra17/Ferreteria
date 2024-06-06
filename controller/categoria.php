<?php
    require_once ("../config/conexion.php");
    require_once ("../models/Categoria.php");

    $categoria = new Categoria();

    switch($_GET["op"]){
        case "guardaryeditar":
            if (empty($_POST["idCategoria"])){
                $categoria -> NuevaCategoria($_POST["Categoria"]);
            }
            else{
                $categoria -> UpdateCategorias($_POST["idCategoria"],$_POST["Categoria"]);
            }
            break;

        case "listar":
            $datos = $categoria -> get_ListarCategorias();
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["Categoria"];
                $sub_array[] = $row["FechaCreacion"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["idCategoria"].')" id="'.$row["idCategoria"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["idCategoria"].')" id="'.$row["idCategoria"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
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
            $datos = $categoria -> get_CategoriasPorID($_POST["idCategoria"]);
            if (is_array($datos) == true and count($datos) >0){
                foreach($datos as $row){
                    $output["idCategoria"] = $row["idCategoria"];
                    $output["Categoria"] = $row["Categoria"];
                }
                echo json_encode($output);
            }
            break;

        case "eliminar":
            $categoria -> DeleteCategorias($_POST["idCategoria"]);
            break;

        case "combo":
            $datos = $categoria -> get_ListarCategorias();
            if(is_array($datos)==true and count($datos)>0){
                $html="";
                $html.="<option selected>Seleccionar</option>";
                foreach($datos as $row){
                    $html.="<option value='".$row["idCategoria"]."'>".$row["Categoria"]."</option>";
                }
                echo $html;
            }
            break;
    }

?>