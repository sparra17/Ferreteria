<?php
    require_once("../../config/conexion.php");
    if(isset($_SESSION["idUsuario"])){
?>

<!doctype html>
<html lang="es" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none">

<head>
    <title>Venta | Ferreteria</title>
    <?php require_once("../html/head.php"); ?>

</head>

<body>

    <div id="layout-wrapper">

        <?php require_once("../html/header.php"); ?>
        <?php require_once("../html/menu.php"); ?>

        <div class="main-content">
            <div class="page-content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                <h4 class="mb-sm-0">Nueva Venta</h4>
                            </div>
                            
                            <input type="hidden" name="idVenta" id="idVenta">
                            
                            <!-- Datos del Cliente -->
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-header align-items-center d-flex">
                                            <h4 class="card-title mb-0 flex-grow-1">Datos Del Cliente</h4>
                                            <div class="flex-shrink-0">
                                            </div>
                                        </div>

                                        <div class="card-body">
                                            <div class="live-preview">
                                                <div class="row align-items-center g-3">
                                                    <div class="col-lg-4">
                                                        <label for="idCliente" class="form-label">Cliente</label>
                                                        <select id="idCliente" name="idCliente" class="form-control form-select" aria-label="Seleccionar">
                                                            <option value="0" selected>Seleccionar</option>
                                                        </select>
                                                    </div>

                                                    <div class="col-lg-4">
                                                        <label for="RFC" class="form-label">RFC</label>
                                                        <input type="text" class="form-control" id="RFC" name="RFC" placeholder="RFC" readonly/>
                                                    </div>

                                                    <div class="col-lg-4">
                                                        <label for="Telefono" class="form-label">Telefono</label>
                                                        <input type="text" class="form-control" id="Telefono" name="Telefono" placeholder="Telefono" readonly/>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <label for="Correo" class="form-label">Correo</label>
                                                        <input type="text" class="form-control" id="Correo" name="Correo" placeholder="Nombre Del Contacto" readonly/>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <label for="Direccion" class="form-label">Dirección</label>
                                                        <input type="text" class="form-control" id="Direccion" name="Direccion" placeholder="Dirección" readonly/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div> 
                            </div><!-- end col -->

                            <!-- Agregar Producto -->
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-header align-items-center d-flex">
                                            <h4 class="card-title mb-0 flex-grow-1">Agregar Producto</h4>
                                            <div class="flex-shrink-0">
                                            </div>
                                        </div>

                                        <div class="card-body">
                                            <table id="table_agregar" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                            
                                                    <thead>
                                                    <tr>
                                                        <th>Codigo</th>
                                                        <th>Producto</th>
                                                        <th>Categoria</th>
                                                        <th>Precio</th>
                                                        <th>Stock</th>
                                                        <th>Unidad</th>
                                                        <th>Cantidad</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                                
                                                </tbody>
                                            </table>
                                        </div>

                                    </div>
                                </div>
                            </div><!-- end col -->

                            <!-- Detalle de Venta -->
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-header align-items-center d-flex">
                                            <h4 class="card-title mb-0 flex-grow-1">Detalle de Venta</h4>
                                            <div class="flex-shrink-0">
                                            </div>
                                        </div>

                                        <div class="card-body">
                                            <table id="table_data" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>Codigo</th>
                                                        <th>Producto</th>
                                                        <th>Categoria</th>
                                                        <th>Unidad</th>
                                                        <th>Precio Venta</th>
                                                        <th>Fecha Vencimiento</th>
                                                        <th>Cantidad</th>
                                                        <th>Total</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    
                                                </tbody>
                                            </table>

                                            <table class="table table-borderless table-nowrap align-middle mb-0 ms-auto" style="width:250px">
                                                <tbody>
                                                    <tr>
                                                        <td>Sub Total</td>
                                                        <td class="text-end" id="txtsubtotal">$0</td>
                                                    </tr>
                                                    <tr>
                                                        <td>IVA (16%)</td>
                                                        <td class="text-end" id="txtiva">0</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Descuento <small class="text-muted"></small></td>
                                                        <td class="text-end" id="txtdescuento">0</td>
                                                    </tr>
                                                    <tr class="border-top border-top-dashed fs-15">
                                                        <th scope="row">Total</th>
                                                        <th class="text-end" id="txttotal">0</th>
                                                    </tr>
                                                </tbody>
                                            </table>

                                            <div class="hstack gap-2 left-content-end d-print-none mt-4">
                                                <button type="button" id="btnguardar" class="btn btn-success"><i class="ri-printer-line align-bottom me-1"></i> Guardar</button>
                                                <a id="btnlimpiar" class="btn btn-warning"><i class="ri-send-plane-fill align-bottom me-1"></i> Limpiar</a>
                                            </div>
                                                <!--end table-->
                                        </div>
                                    </div>
                                </div>
                            </div><!-- end col -->
                        </div>
                    </div>

                </div>
            </div>

            <?php require_once("../html/footer.php"); ?>
        </div>
    </div>



    <?php require_once("../html/js.php"); ?>
    <script type="text/javascript" src="mntventa.js"></script>
</body>

</html>

<?php
    } else {
        header("Location:".Conectar::ruta());
    }
?>
