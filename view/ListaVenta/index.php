<?php
    require_once("../../config/conexion.php");
    if(isset($_SESSION["idUsuario"])){
?>

<!doctype html>
<html lang="es" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none">

<head>
    <title>Listado de Ventas | Ferreteria</title>
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
                                <h4 class="mb-sm-0">Listado de Ventas</h4>
                            </div>

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <table id="table_data" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>Nro</th>
                                                        <th>Cliente</th>
                                                        <th>RFC</th>
                                                        <th>SubTotal</th>
                                                        <th>IVA</th>
                                                        <th>Descuento</th>
                                                        <th>Total</th>
                                                        <th>Usuario</th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div><!--end col-->
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <?php require_once("../html/footer.php"); ?>
        </div>
    </div>

    <?php require_once("mantenimiento.php"); ?>
    <?php require_once("../html/js.php"); ?>
    <script type="text/javascript" src="listventa.js"></script>
</body>

</html>

<?php
    } else {
        header("Location:".Conectar::ruta());
    }
?>
