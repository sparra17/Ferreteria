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
                                <h4 class="mb-sm-0">Vista Compra</h4>
                            </div>
                        </div>
                    </div>

                    <div class="row justify-content-center">
                        <div class="col-xxl-9">
                            <div class="card" id="demo">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="card-header border-bottom-dashed p-4">
                                            <div class="d-flex">
                                                <div class="flex-grow-1">
                                                    <img src="../../assets/images/logo_materialeschuy.png" class="card-logo card-logo-dark" alt="logo dark" height="70">
                                                    <img src="../../assets/images/logo_materialeschuy.png" class="card-logo card-logo-light" alt="logo light" height="70">
                                                    <div class="mt-sm-5 mt-4">
                                                        <h6 class="text-muted text-uppercase fw-semibold">Direccion</h6>
                                                        <p class="txt-muted mb-1">Niños Heroes #1 - Juan Lucas</p>
                                                        <p class="text-muted mb-1" id="txtdireccion"></p>
                                                    </div>
                                                </div>
                                                <div class="flex-shrink-0 mt-sm-0 mt-3">
                                                    </br>
                                                    </br>
                                                    <h6 class="text-muted text-uppercase fw-semibold">Telefono</h6>
                                                        <p class="txt-muted mb-1">4111568181</p>
                                                    </br>
                                                    <h6 class="text-muted text-uppercase fw-semibold">Correo</h6>
                                                        <p class="txt-muted mb-1">ferrematerialeschuy@gmail.com</p>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end card-header-->
                                    </div><!--end col-->

                                    <!--Cliente-->
                                    <div class="col-lg-12">
                                        <div class="card-body p-4">
                                            <div class="row g-3">
                                                <div class="col-lg-3 col-6">
                                                    <p class="text-muted mb-2 text-uppercase fw-semibold">Cliente</p>
                                                    <h5 class="fs-14 mb-0"><span id="NombreC"></span></h5>
                                                </div>
                                                <!--end col-->
                                                <div class="col-lg-3 col-6">
                                                    <p class="text-muted mb-2 text-uppercase fw-semibold">RFC:</p>
                                                    <h5 class="fs-14 mb-0"><span id="CliRFC"></span></h5>
                                                </div>

                                                <div class="col-lg-3 col-6">
                                                    <p class="text-muted mb-2 text-uppercase fw-semibold">Telefono</p>
                                                    <h5 class="fs-14 mb-0"><span id="CliTelefono"></h5>
                                                </div>
                                                <!--end col-->
                                                
                                                <!--end col-->
                                            </div>
                                            <!--end row-->
                                        </div>
                                        <!--end card-body-->
                                    </div><!--end col-->

                                    <!--Venta-->
                                    <div class="col-lg-12">
                                        <div class="card-body p-4">
                                            <div class="row g-3">
                                                <div class="col-lg-3 col-6">
                                                    <p class="text-muted mb-2 text-uppercase fw-semibold">Nro De Venta</p>
                                                    <h5 class="fs-14 mb-0">V -<span id="idVenta"></span></h5>
                                                </div>
                                                <!--end col-->
                                                <div class="col-lg-3 col-6">
                                                    <p class="text-muted mb-2 text-uppercase fw-semibold">Atendido por:</p>
                                                    <h5 class="fs-14 mb-0"><span id="Nombre"></span></h5>
                                                </div>

                                                <div class="col-lg-3 col-6">
                                                    <p class="text-muted mb-2 text-uppercase fw-semibold">Fecha</p>
                                                    <h5 class="fs-14 mb-0"><span id="FechaCreacion"></h5>
                                                </div>
                                                <!--end col-->
                                                <div class="col-lg-3 col-6">
                                                    <p class="text-muted mb-2 text-uppercase fw-semibold">Total</p>
                                                    <h5 class="fs-14 mb-0"><span id="txttotal"></span></h5>
                                                </div>
                                                <!--end col-->
                                            </div>
                                            <!--end row-->
                                        </div>
                                        <!--end card-body-->
                                    </div><!--end col-->
                                    <div class="col-lg-12">
                                        <div class="card-body p-4">
                                            <div class="table-responsive">

                                                <table class="table table-borderless text-center table-nowrap align-middle mb-0">
                                                    <thead>
                                                        <tr class="table-active">
                                                            <th scope="col" style="width: 50px;">Codigo</th>
                                                            <th scope="col">Producto</th>
                                                            <th scope="col">Categoria</th>
                                                            <th scope="col">Unidad</th>

                                                            <th scope="col">P. Venta</th>
                                                            <th scope="col">Fecha Ven.</th>
                                                            <th scope="col">Cantidad</th>

                                                            <th scope="col" class="text-end">Total</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="listardetalleformato">
                                                        
                                                    </tbody>
                                                </table><!--end table-->

                                            </div>
                                            <div class="border-top border-top-dashed mt-2">
                                                
                                                <table class="table table-borderless table-nowrap align-middle mb-0 ms-auto" style="width:250px">
                                                    <tbody>
                                                        <tr>
                                                            <td>Sub Total</td>
                                                            <td class="text-end" id="subtotal_compra"></td>
                                                        </tr>
                                                        <tr>
                                                            <td>IVA (16%)</td>
                                                            <td class="text-end" id="iva_compra"></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Descuento <small class="text-muted" ></small></td>
                                                            <td class="text-end" id="descuento_compra"></td>
                                                        </tr>
                                                        <tr class="border-top border-top-dashed fs-15">
                                                            <th scope="row">Total</th>
                                                            <th class="text-end" id="total_compra"></th>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                
                                            </div>
                                            <div class="hstack gap-2 justify-content-end d-print-none mt-4">
                                                <a href="javascript:window.print()" class="btn btn-success"><i class="ri-printer-line align-bottom me-1"></i> Print</a>
                                            </div>
                                        </div>
                                        <!--end card-body-->
                                    </div><!--end col-->
                                </div><!--end row-->
                            </div>
                            <!--end card-->
                        </div>
                        <!--end col-->
                    </div>
                    <!--end row-->

                </div>
            </div>

            <?php require_once("../html/footer.php"); ?>
        </div>
    </div>

    <?php require_once("../html/js.php"); ?>
    <script type="text/javascript" src="viewventa.js"></script>
</body>

</html>

<?php
    } else {
        header("Location:".Conectar::ruta());
    }
?>
