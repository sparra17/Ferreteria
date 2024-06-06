<?php
    require_once ("../config/conexion.php");
    require_once ("../models/Venta.php");

    $venta = new Venta();

    switch($_GET["op"]){
        case "registrar":
            $datos = $venta -> InsertTempVenta($_POST["idUsuario"]);
                foreach($datos as $row){
                    $output["idVenta"] = $row["idVenta"];
                }
                echo json_encode($output);
            break;

        case "guardardetalle":
            $datos = $venta -> InsertDetVenta($_POST["idVenta"],$_POST["idProducto"],$_POST["PVenta"],$_POST["DetCantidad"]);
            break;
        
        case "eliminardetalle":
            $venta -> DeleteDetalleVenta($_POST["idDetVenta"]);
            break;

        case "listardetalle":
            $datos = $venta -> ListarDetVenta($_POST["idVenta"]);
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["Codigo"];
                $sub_array[] = $row["NombreProducto"];
                
                $sub_array[] = $row["Categoria"];

                $sub_array[] = $row["Unidad"];
                $sub_array[] = $row["PVenta"];
                $sub_array[] = $row["FechaVencimiento"];
                $sub_array[] = $row["DetCantidad"];
                $sub_array[] = $row["DetTotal"];

                $sub_array[] = '<button type="button" onClick="eliminar('.$row["idDetVenta"].','.$row["idVenta"].')" id="'.$row["idDetVenta"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
                $data[] = $sub_array;
            }
            $results = array(
                "sEcho" => 1,
                "iTotalRecors" => count($data),
                "iTotalDisplayRecords" => count($data),
                "aaData" => $data);
            echo json_encode($results);
            break;

        case "calculo":
            $datos = $venta -> VentaCalculo($_POST["idVenta"]);
            foreach($datos as $row){
                $output["Subtotal"] = $row["Subtotal"];
                $output["IVA"] = $row["IVA"];
                $output["Descuento"] = $row["Descuento"];
                $output["Total"] = $row["Total"];
            }
            echo json_encode($output);
            break;
        
        case "guardar":
            $datos = $venta -> GuardarVenta(
                $_POST["idVenta"],
                $_POST["idCliente"],
                $_POST["CliRFC"],
                $_POST["CliTelefono"],
                $_POST["CliDireccion"],
                $_POST["CliCorreo"]);

            break;

        case "mostrar":
            $datos = $venta -> ListarVenta($_POST["idVenta"]);
            foreach($datos as $row){
                $output["idVenta"] = $row["idVenta"];
                $output["idCliente"] = $row["idCliente"];
                $output["CliRFC"] = $row["CliRFC"];
                $output["CliTelefono"] = $row["CliTelefono"];
                $output["CliDireccion"] = $row["CliDireccion"];
                $output["CliCorreo"] = $row["CliCorreo"];
                
                $output["Subtotal"] = $row["Subtotal"];
                $output["IVA"] = $row["IVA"];
                $output["Descuento"] = $row["Descuento"];
                $output["Total"] = $row["Total"];
                
                $output["idUsuario"] = $row["idUsuario"];
                $output["FechaCreacion"] = $row["FechaCreacion"];

                $output["Nombre"] = $row["Nombre"];
                $output["Paterno"] = $row["Paterno"];
                $output["Materno"] = $row["Materno"];
                $output["Correo"] = $row["Correo"];
                $output["Telefono"] = $row["Telefono"];
                $output["Rol"] = $row["Rol"];

                $output["NombreC"] = $row["NombreC"];
                $output["PaternoC"] = $row["PaternoC"];
                $output["MaternoC"] = $row["MaternoC"];
            }
            echo json_encode($output);
            break;



        case "listardetalleformato":
            $datos = $venta -> ListarDetVenta($_POST["idVenta"]);
            foreach($datos as $row){
                ?>
                    <tr>
                        <th scope="row"><?php echo  $row["Codigo"]; ?></th>
                        <td><?php echo  $row["NombreProducto"]; ?></td>
                        <td><?php echo  $row["Categoria"]; ?></td>
                        <td><?php echo  $row["Unidad"]; ?></td>
                        <td><?php echo  $row["PVenta"]; ?></td>
                        <td><?php echo  $row["FechaVencimiento"]; ?></td>
                        <td><?php echo  $row["DetCantidad"]; ?></td>
                        <td class="text-end"><?php echo  $row["DetTotal"]; ?></td>
                    </tr>
                <?php
            }
            break;



            case "ListarTodaVenta":
                $datos = $venta -> ListarTodaVenta();
                $data = Array();
                foreach($datos as $row){
                    $sub_array = array();
                    $sub_array[] = $row["idVenta"];
                    $sub_array[] = $row["NombreC"]." ".$row["PaternoC"]." ".$row["MaternoC"];
                    $sub_array[] = $row["CliRFC"];

                    $sub_array[] = $row["Subtotal"];
                    $sub_array[] = $row["IVA"];
                    $sub_array[] = $row["Descuento"];
                    $sub_array[] = $row["Total"];

                    $sub_array[] = $row["Nombre"]." ".$row["Paterno"];
                    
    
                    $sub_array[] = '<a href="../ViewVenta/?v='.$row["idVenta"].'" target="_blank" class="btn btn-primary btn-icon waves-effect waves-light"><i class="ri-printer-line"></i></a>';
                    $sub_array[] = '<button type="button" onClick="ver('.$row["idVenta"].')" id="'.$row["idVenta"].'" class="btn btn-success btn-icon waves-effect waves-light"><i class="ri-settings-2-line"></i></button>';

                    $data[] = $sub_array;
                }
                $results = array(
                    "sEcho" => 1,
                    "iTotalRecors" => count($data),
                    "iTotalDisplayRecords" => count($data),
                    "aaData" => $data);
                echo json_encode($results);
                break;

            case "barras":
                $datos = $venta -> VentaDias();
                $data = Array();
                foreach($datos as $row){
                    $data[] = $row;
                }
                echo json_encode($data);
                break;
    }

?>