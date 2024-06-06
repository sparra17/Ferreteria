<?php
    require_once ("../config/conexion.php");
    require_once ("../models/Usuario.php");

    $usuario = new Usuario();

    switch($_GET["op"]){
        case "guardaryeditar":
            if (empty($_POST["idUsuario"])){
                $usuario -> NuevoUsuario(
                    $_POST["Nombre"],
                    $_POST["Paterno"],
                    $_POST["Materno"],
                    $_POST["idRol"],
                    $_POST["Sexo"],
                    $_POST["Direccion"],
                    $_POST["Telefono"],
                    $_POST["CURP"],
                    $_POST["RFC"],
                    $_POST["Correo"],
                    $_POST["Contrasena"]);
            }
            else{
                $usuario -> UpdateUsuarios(
                    $_POST["idUsuario"],
                    $_POST["Nombre"],
                    $_POST["Paterno"],
                    $_POST["Materno"],
                    $_POST["idRol"],
                    $_POST["Sexo"],
                    $_POST["Direccion"],
                    $_POST["Telefono"],
                    $_POST["CURP"],
                    $_POST["RFC"],
                    $_POST["Correo"],
                    $_POST["Contrasena"]);
            }
            break;

        case "listar":
            $datos = $usuario -> get_ListarUsuarios();
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["Nombre"];
                $sub_array[] = $row["Paterno"];
                $sub_array[] = $row["Materno"];
                $sub_array[] = $row["Rol"];
                $sub_array[] = $row["Sexo"];
                $sub_array[] = $row["Direccion"];
                $sub_array[] = $row["Telefono"];
                $sub_array[] = $row["CURP"];
                $sub_array[] = $row["RFC"];
                $sub_array[] = $row["Correo"];
                $sub_array[] = $row["Contrasena"];
                $sub_array[] = $row["FechaCreacion"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["idUsuario"].')" id="'.$row["idUsuario"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["idUsuario"].')" id="'.$row["idUsuario"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
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
            $datos = $usuario -> get_UsuariosPorID($_POST["idUsuario"]);
            if (is_array($datos) == true and count($datos) >0){
                foreach($datos as $row){
                    $output["idUsuario"] = $row["idUsuario"];
                    $output["Nombre"] = $row["Nombre"];
                    $output["Paterno"] = $row["Paterno"];
                    $output["Materno"] = $row["Materno"];
                    $output["idRol"] = $row["idRol"];
                    $output["Sexo"] = $row["Sexo"];
                    $output["Direccion"] = $row["Direccion"];
                    $output["Telefono"] = $row["Telefono"];
                    $output["CURP"] = $row["CURP"];
                    $output["RFC"] = $row["RFC"];
                    $output["Correo"] = $row["Correo"];
                    $output["Contrasena"] = $row["Contrasena"];
                }
                echo json_encode($output);
            }
            break;

        case "eliminar":
            $usuario -> DeleteUsuarios($_POST["idUsuario"]);
            break;

        case "actualizar":
            $usuario -> update_usuario_pass($_POST["idUsuario"],$_POST["Contrasena"]);
            break;

            case "Contar":
                $datos = $usuario -> Contar();
                $data = Array();
                foreach($datos as $row){
                    $sub_array = array();
                    $sub_array[] = $row["CantidadProductos"];
                    $sub_array[] = $row["CantidadCategorias"];
                    $sub_array[] = $row["CantidadClientes"];
                    $sub_array[] = $row["CantidadProveedores"];
                    $data[] = $sub_array;
                }
                $results = array(
                    "sEcho" => 1,
                    "iTotalRecors" => count($data),
                    "iTotalDisplayRecords" => count($data),
                    "aaData" => $data);
                echo json_encode($results);
                break;
    }

?>