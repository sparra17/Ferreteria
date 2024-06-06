<?php
    require_once("../../config/conexion.php");
    if(isset($_SESSION["idUsuario"])){
?>

<!doctype html>
<html lang="es" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none">

<head>
    <title>Perfil | Ferreteria</title>
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
                                <h4 class="mb-sm-0">Perfil</h4>
                            </div>
    
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">

                                    <div class="card-body">
                                    <div class="live-preview">
                                        <div class="row gy-4">
                                            <div class="col-xxl-3 col-md-6">
                                                <div>
                                                    <label for="basiInput" class="form-label">Contraseña</label>
                                                    <input type="password" class="form-control" id="txtpass">
                                                </div>
                                            </div>
                                            
                                            <div class="col-xxl-3 col-md-6">
                                                <div>
                                                    <label for="labelInput" class="form-label">Confirmar Contraseña</label>
                                                    <input type="password" class="form-control" id="txtpassconfirm">
                                                </div>
                                            </div>

                                            <div class="col-xxl-3 col-md-6">
                                                <div>
                                                    <label for="labelInput" class="form-label"> &nbsp; </label>
                                                    <button type="button" id="btnguardar" class="form-control btn btn-primary btn-animation waves-effect waves-light" data-text="Guardar"><span>Guardar</span></button>
                                                </div>
                                            </div>



                                        </div>
                                    </div>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <?php require_once("../html/footer.php"); ?>
    </div>
    </div>

    <?php require_once("../html/js.php"); ?>
    <script type="text/javascript" src="mntperfil.js"></script>
</body>

</html>

<?php
    } else {
        header("Location:".Conectar::ruta());
    }
?>
