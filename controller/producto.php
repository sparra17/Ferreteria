<?php
    require('../assets/fpdf/fpdf.php');
    require_once ("../config/conexion.php");
    require_once ("../models/Producto.php");

    $producto = new Producto();

    switch($_GET["op"]){
        case "guardaryeditar":
            if (empty($_POST["idProducto"])){
                $producto -> NuevoProducto(
                    $_POST["Codigo"],
                    $_POST["NombreProducto"],
                    $_POST["idProveedor"],
                    $_POST["idCategoria"],
                    $_POST["idUnidad"],
                    $_POST["PCompra"],
                    $_POST["PVenta"],
                    $_POST["Stock"],
                    $_POST["FechaVencimiento"],
                    $_POST["Descripcion"],
                    $_POST["Imagen"]);
            }
            else{
                $producto -> UpdateProductos(
                    $_POST["idProducto"],
                    $_POST["Codigo"],
                    $_POST["NombreProducto"],
                    $_POST["idProveedor"],
                    $_POST["idCategoria"],
                    $_POST["idUnidad"],
                    $_POST["PCompra"],
                    $_POST["PVenta"],
                    $_POST["Stock"],
                    $_POST["FechaVencimiento"],
                    $_POST["Descripcion"],
                    $_POST["Imagen"]);
            }
            break;

        case "listar":
            $datos = $producto -> get_ListarProductos();
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();

                if ($row["Imagen"] != '') {
                    $sub_array[] = 
                    "<div class='d-flex align-items-center'>".
                        "<div class='flex-shrink-0 me-2'>".
                            "<img src='../../assets/productos/".$row["Imagen"]."' alt='' class='avatar-xs rounded-circle'>".
                        "</div>".
                    "</div>";
                } else {
                    $sub_array[] = 
                    "<div class='d-flex align-items-center'>".
                        "<div class='flex-shrink-0 me-2'>".
                            "<img src='../../assets/productos/no-imagen.jpeg' alt='' class='avatar-xs rounded-circle'>".
                        "</div>".
                    "</div>";
                }

                $sub_array[] = $row["Codigo"];
                $sub_array[] = $row["NombreProducto"];

                $sub_array[] = $row["Proveedor"];
                $sub_array[] = $row["Categoria"];
                $sub_array[] = $row["Unidad"];
                $sub_array[] = $row["PCompra"];
                
                $sub_array[] = $row["PVenta"];
                $sub_array[] = $row["Stock"];
                $sub_array[] = $row["FechaVencimiento"];
                $sub_array[] = $row["Descripcion"];

                $sub_array[] = $row["FechaCreacion"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["idProducto"].')" id="'.$row["idProducto"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["idProducto"].')" id="'.$row["idProducto"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
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
            $datos = $producto -> get_ProductosPorID($_POST["idProducto"]);
            if (is_array($datos) == true and count($datos) >0){
                foreach($datos as $row){
                    $output["idProducto"] = $row["idProducto"];
                    $output["Codigo"] = $row["Codigo"];
                    $output["NombreProducto"] = $row["NombreProducto"];
                    $output["idProveedor"] = $row["idProveedor"];
                    $output["idCategoria"] = $row["idCategoria"];
                    $output["idUnidad"] = $row["idUnidad"];
                    $output["Unidad"] = $row["Unidad"];
                    $output["PCompra"] = $row["PCompra"];
                    $output["PVenta"] = $row["PVenta"];
                    $output["Stock"] = $row["Stock"];
                    $output["FechaVencimiento"] = $row["FechaVencimiento"];
                    $output["Descripcion"] = $row["Descripcion"];
                    $output["FechaCreacion"] = $row["FechaCreacion"];
                    if ($row["Imagen"] != ''){
                        $output["Imagen"] = '<img src="../../assets/productos/'.$row["Imagen"].'" class=" avatar-xl img-thumbnail user-profile-image" alt="user-profile-image"></img><input type="hidden" value="'.$row["Imagen"].'" />';
                    } else {
                        $output["Imagen"] = '<img src="../../assets/productos/no-imagen.jpeg " class=" avatar-xl img-thumbnail user-profile-image" alt="user-profile-image"></img><input type="hidden" value="" />';

                    }
                    

                }
                echo json_encode($output);
            }
            break;

        case "eliminar":
            $producto -> DeleteProductos($_POST["idProducto"]);
            break;

        case "combo":
            $datos = $producto -> get_ProductosPorCat($_POST["idCategoria"]);
            if(is_array($datos)==true and count($datos)>0){
                $html="";
                $html.="<option selected>Seleccionar</option>";
                foreach($datos as $row){
                    $html.="<option value='".$row["idProducto"]."'>".$row["NombreProducto"]."</option>";
                }
                echo $html;
            }
            break;

            case "listartabla":
                $datos = $producto -> get_ListarProductos();
                $data = Array();
                foreach($datos as $row){
                    $sub_array = array();
                    $sub_array[] = $row["Codigo"];
                    // Campo oculto para almacenar el idProducto
                    $sub_array[] = '<input type="hidden" id="idProducto" name="idProducto" value="'.$row["idProducto"].'" />' .$row["NombreProducto"];

                    // Campo de texto para mostrar el NombreProducto
                    

                    $sub_array[] = '<input type="text" class="form-control" id="idCategoria" name="idCategoria" value="'.$row["Categoria"].'" placeholder="Categoria" readonly/>';
                    $sub_array[] = '<input type="number" class="form-control" id="PVenta" name="PVenta" value="'.$row["PVenta"].'" placeholder="Precio V." readonly/>';
                    $sub_array[] = '<input type="number" class="form-control" id="Stock" name="Stock" value="'.$row["Stock"].'" placeholder="Stock" readonly/>';
                    $sub_array[] = '<input type="text" class="form-control" id="Unidad" name="Unidad" value="'.$row["Unidad"].'" placeholder="Und Medida" readonly/>';

                    $sub_array[] = '<input type="number" class="form-control" id="DetCantidad" name="DetCantidad" placeholder="Cant." />';

                    $sub_array[] = '<button type="button" id="btnagregar" class="btn btn-primary btn-animation waves-effect waves-light" data-text="Agregar"><span>Agregar</span></button>';
                    $data[] = $sub_array;
                    
                }
                $results = array(
                    "sEcho" => 1,
                    "iTotalRecors" => count($data),
                    "iTotalDisplayRecords" => count($data),
                    "aaData" => $data);
                echo json_encode($results);
                break;

        case "listarGanancia":
                $datos = $producto -> GananciaDiaria($_POST["Fecha"]);
                $data = Array();
                foreach($datos as $row){
                    $sub_array = array();

                    $sub_array[] = $row["Fecha"];
                    $sub_array[] = $row["Ganancia"] == null ? "No Hay Ganancias Este Dia" :  $row["Ganancia"];
                    
                    $data[] = $sub_array;
                    
                }
                $results = array(
                    "sEcho" => 1,
                    "iTotalRecors" => count($data),
                    "iTotalDisplayRecords" => count($data),
                    "aaData" => $data);
                echo json_encode($results);
               
                break;


        case "generarPDF":
            $datos = $producto->Cambios();
    
            class PDF extends FPDF {
                function Header() {
                    $this->SetFont('Arial', 'B', 10);
                    $this->Cell(0, 10, 'Reporte de Cambios de Precios', 0, 1, 'C');
                    $this->Cell(45, 10, 'Nombre Producto', 1);
                    $this->Cell(25, 10, 'Fecha', 1);
                    $this->Cell(45, 10, 'Accion', 1);
                    $this->Cell(42, 10, 'Anterior Precio Compra', 1);
                    $this->Cell(40, 10, 'Nuevo Precio Compra', 1);
                    $this->Cell(40, 10, 'Anterior Precio Venta', 1);
                    $this->Cell(40, 10, 'Nuevo Precio Venta', 1);
                    $this->Ln();
                }
    
                function Footer() {
                    $this->SetY(-15);
                    $this->SetFont('Arial', 'I', 8);
                    $this->Cell(0, 10, 'Pagina ' . $this->PageNo(), 0, 0, 'C');
                }
            }
    
            $pdf = new PDF('L');
            $pdf->AddPage();
            $pdf->SetFont('Arial', 'B', 10);
    
            foreach ($datos as $row) {
                $pdf->Cell(45, 6, $row['NombreProducto'], 1);
                $pdf->Cell(25, 6, $row['Fecha'], 1);
                $pdf->Cell(45, 6, $row['Accion'], 1);
                $pdf->Cell(42, 6, $row['APrecioCompra'], 1);
                $pdf->Cell(40, 6, $row['NPrecioCompra'], 1);
                $pdf->Cell(40, 6, $row['APrecioVenta'], 1);
                $pdf->Cell(40, 6, $row['NPrecioVenta'], 1);
                $pdf->Ln();
            }
    
            $pdf->Output();
            break;

            //------------

            case "generarPDFGanancias":
                $datos = $producto->GananciaxProducto();
        
                class PDF extends FPDF {
                    function Header() {
                        $this->SetFont('Arial', 'B', 10);
                        $this->Cell(0, 10, 'Reporte de Ganancias Por Producto', 0, 1, 'C');
                        $this->Cell(17, 10, '# Venta', 1);
                        $this->Cell(31, 10, 'Fecha', 1);
                        $this->Cell(50, 10, 'Producto', 1);
                        $this->Cell(30, 10, 'Precio Compra', 1);
                        $this->Cell(30, 10, 'Precio Venta', 1);
                        $this->Cell(22, 10, 'Cantidad', 1);
                        $this->Cell(22, 10, 'Total', 1);
                        $this->Cell(40, 10, 'Descuento x Producto', 1);
                        $this->Cell(40, 10, 'Ganancia x Producto', 1);
                        $this->Ln();
                    }
        
                    function Footer() {
                        $this->SetY(-15);
                        $this->SetFont('Arial', 'I', 8);
                        $this->Cell(0, 10, 'Pagina ' . $this->PageNo(), 0, 0, 'C');
                    }
                }
        
                $pdf = new PDF('L');
                $pdf->AddPage();
                $pdf->SetFont('Arial', 'B', 10);
        
                foreach ($datos as $row) {
                    $pdf->Cell(17, 6, $row['idVenta'], 1);
                    $pdf->Cell(31, 6, $row['FechaCreacion'], 1);
                    $pdf->Cell(50, 6, $row['NombreProducto'], 1);
                    $pdf->Cell(30, 6, $row['PCompra'], 1);
                    $pdf->Cell(30, 6, $row['PVenta'], 1);
                    $pdf->Cell(22, 6, $row['DetCantidad'], 1);
                    $pdf->Cell(22, 6, $row['DetTotal'], 1);
                    $pdf->Cell(40, 6, $row['DescuentoProducto'], 1);
                    $pdf->Cell(40, 6, $row['GananciasXP'], 1);
                    $pdf->Ln();
                }
        
                $pdf->Output();
                break;
    }

?>