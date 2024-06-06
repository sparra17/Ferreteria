<?php
    require_once("../../config/conexion.php");
    if(isset($_SESSION["idUsuario"])){
?>

<!doctype html>
<html lang="es" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none">

<head>
    <title>Usuario | Ferreteria</title>
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
                                <h4 class="mb-sm-0">Usuario</h4>
                            </div>

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <button type="button" id="btnnuevo" class="btn btn-primary btn-animation waves-effect waves-light" data-text="Nuevo Registro"><span>Nuevo Registro</span></button>
                                        </div>
                                        <div class="card-body">
                                            <table id="table_data" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>Nombre</th>
                                                        <th>Paterno</th>
                                                        <th>Materno</th>
                                                        <th>Rol</th>
                                                        <th>Sexo</th>
                                                        <th>Direccion</th>
                                                        <th>Telefono</th>
                                                        <th>CURP</th>
                                                        <th>RFC</th>
                                                        <th>Correo</th>
                                                        <th>Contrasena</th>
                                                        <th>Fecha Creacion</th>
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
    <script type="text/javascript" src="mntusuario.js"></script>
</body>

</html>

<?php
    } else {
        header("Location:".Conectar::ruta());
    }
?>
