<?php
    require_once ("../config/conexion.php");
    require_once ("../models/Cliente.php");

    $cliente = new Cliente();

    switch($_GET["op"]){
        case "guardaryeditar":
            if (empty($_POST["idCliente"])){
                $cliente -> NuevoCliente(
                    $_POST["Nombre"],
                    $_POST["Paterno"],
                    $_POST["Materno"],
                    $_POST["Sexo"],
                    $_POST["Direccion"],
                    $_POST["Telefono"],
                    $_POST["Correo"],
                    $_POST["CURP"],
                    $_POST["RFC"]);
            }
            else{
                $cliente -> UpdateClientes(
                    $_POST["idCliente"],
                    $_POST["Nombre"],
                    $_POST["Paterno"],
                    $_POST["Materno"],
                    $_POST["Sexo"],
                    $_POST["Direccion"],
                    $_POST["Telefono"],
                    $_POST["Correo"],
                    $_POST["CURP"],
                    $_POST["RFC"]);
            }
            break;

        case "listar":
            $datos = $cliente -> get_ListarClientes();
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["Nombre"];
                $sub_array[] = $row["Paterno"];
                $sub_array[] = $row["Materno"];
                $sub_array[] = $row["Sexo"];
                $sub_array[] = $row["Direccion"];
                $sub_array[] = $row["Telefono"];
                $sub_array[] = $row["Correo"];
                $sub_array[] = $row["CURP"];
                $sub_array[] = $row["RFC"];
                $sub_array[] = $row["FechaCreacion"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["idCliente"].')" id="'.$row["idCliente"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["idCliente"].')" id="'.$row["idCliente"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
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
            $datos = $cliente -> get_ClientesPorID($_POST["idCliente"]);
            if (is_array($datos) == true and count($datos) >0){
                foreach($datos as $row){
                    $output["idCliente"] = $row["idCliente"];
                    $output["Nombre"] = $row["Nombre"];
                    $output["Paterno"] = $row["Paterno"];
                    $output["Materno"] = $row["Materno"];
                    $output["Sexo"] = $row["Sexo"];
                    $output["Direccion"] = $row["Direccion"];
                    $output["Telefono"] = $row["Telefono"];
                    $output["Correo"] = $row["Correo"];
                    $output["CURP"] = $row["CURP"];
                    $output["RFC"] = $row["RFC"];
                }
                echo json_encode($output);
            }
            break;

        case "eliminar":
            $cliente -> DeleteClientes($_POST["idCliente"]);
            break;

        case "combo":
            $datos= $cliente -> get_ListarClientes();
            if(is_array($datos)==true and count($datos)>0){
                $html="";
                $html.="<option value='0' selected>Seleccionar</option>";
                foreach($datos as $row){
                    $html.="<option value='".$row["idCliente"]."'>".$row["Nombre"]." ".$row["Paterno"]." ".$row["Materno"]."</option>";
                }
                echo $html;
            }
            break;
    }

?>