<?php
    require_once ("../config/conexion.php");
    require_once ("../models/Proveedor.php");

    $proveedor = new Proveedor();

    switch($_GET["op"]){
        case "guardaryeditar":
            if (empty($_POST["idProveedor"])){
                $proveedor -> NuevoProveedor(
                    $_POST["Proveedor"],
                    $_POST["NombreContacto"],
                    $_POST["RFC"],
                    $_POST["Telefono"],
                    $_POST["Direccion"],
                    $_POST["Correo"]);
            }
            else{
                $proveedor -> UpdateProveedores(
                    $_POST["idProveedor"],
                    $_POST["Proveedor"],
                    $_POST["NombreContacto"],
                    $_POST["RFC"],
                    $_POST["Telefono"],
                    $_POST["Direccion"],
                    $_POST["Correo"]);
            }
            break;

        case "listar":
            $datos = $proveedor -> get_ListarProveedores();
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["Proveedor"];
                $sub_array[] = $row["NombreContacto"];
                $sub_array[] = $row["RFC"];
                $sub_array[] = $row["Telefono"];
                $sub_array[] = $row["Direccion"];
                $sub_array[] = $row["Correo"];
                $sub_array[] = $row["FechaCreacion"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["idProveedor"].')" id="'.$row["idProveedor"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["idProveedor"].')" id="'.$row["idProveedor"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
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
            $datos = $proveedor -> get_ProveedoresPorID($_POST["idProveedor"]);
            if (is_array($datos) == true and count($datos) >0){
                foreach($datos as $row){
                    $output["idProveedor"] = $row["idProveedor"];
                    $output["Proveedor"] = $row["Proveedor"];
                    $output["NombreContacto"] = $row["NombreContacto"];
                    $output["RFC"] = $row["RFC"];
                    $output["Telefono"] = $row["Telefono"];
                    $output["Direccion"] = $row["Direccion"];
                    $output["Correo"] = $row["Correo"];
                    
                }
                echo json_encode($output);
            }
            break;

        case "eliminar":
            $proveedor -> DeleteProveedores($_POST["idProveedor"]);
            break;

        case "combo":
            $datos= $proveedor -> get_ListarProveedores();
            if(is_array($datos)==true and count($datos)>0){
                $html="";
                $html.="<option value='0' selected>Seleccionar</option>";
                foreach($datos as $row){
                    $html.="<option value='".$row["idProveedor"]."'>".$row["Proveedor"]."</option>";
                }
                echo $html;
            }
            break;
    }

?>