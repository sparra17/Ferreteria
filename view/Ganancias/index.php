<?php require_once("../../config/conexion.php"); ?>

<!doctype html>
<html lang="es" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none">

<head>
    <title>Ganancias | Ferreteria</title>
    <?php require_once("../html/head.php"); ?>

    <!-- jsvectormap css -->
    <link href="../../assets/libs/jsvectormap/css/jsvectormap.min.css" rel="stylesheet" type="text/css" />

    <!--Swiper slider css-->
    <link href="../../assets/libs/swiper/swiper-bundle.min.css" rel="stylesheet" type="text/css" />

    <!-- Flatpickr css -->
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet" type="text/css" />
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
                                <h4 class="mb-sm-0">Ganancias</h4>

                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item"><a href="javascript: void(0);">Menu</a></li>
                                        <li class="breadcrumb-item active">Ganancias</li>
                                    </ol>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-xl-12">
                        <div class="card card-height-50">
                            <div class="card-body">
                                <div class="mt-3">
                                    <p style="font-weight: bold;">Seleccione Para Ver La Ganancia Por Dia</p>
                                    <input type="text" id="Fecha" class="form-control" data-provider="flatpickr" data-date-format="Y-m-d">
                                    <button id="consultar" class="btn btn-primary mt-3">Consultar</button>
                                </div>
                            </div><!-- end card body -->

                            <div class="card-body">
                                            <table id="table_data" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                                                <thead>
                                                    <tr>
                                                        <th>Fecha Consultada</th>
                                                        <th>Ganancia Total Del Dia</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    
                                                </tbody>
                                            </table>
                            </div>
                            
                        </div><!-- end card -->
                    </div><!-- end col -->

                <!-- Cambios col -->
                    <div class="col-xl-12">
                        <div class="card card-height-50">
                            <div class="card-body">
                                <div class="mt-3">
                                    <p style="font-weight: bold;">Seleccione Para Ver Los Cambios De Los Productos</p>
                                    <button id="Cambios" class="btn btn-primary mt-3">Cambios De Precios</button>
                                    <button id="GananciasxProductos" class="btn btn-primary mt-3">GananciasxProductos</button>
                                </div>
                            </div><!-- end card body -->
                            
                        </div><!-- end card -->
                    </div><!-- end col -->

            </div>

            <?php require_once("../html/footer.php"); ?>
        </div>
    </div>

    <?php require_once("../html/js.php"); ?>
    <script type="text/javascript" src="ganancias.js"></script>

    <!-- apexcharts -->
    <script src="../../assets/libs/apexcharts/apexcharts.min.js"></script>

    <!-- Vector map-->
    <script src="../../assets/libs/jsvectormap/js/jsvectormap.min.js"></script>
    <script src="../../assets/libs/jsvectormap/maps/world-merc.js"></script>

    <!--Swiper slider js-->
    <script src="../../assets/libs/swiper/swiper-bundle.min.js"></script>

    <!-- Dashboard init -->
    <script src="../../assets/js/pages/dashboard-ecommerce.init.js"></script>

    <!-- Flatpickr js -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <script type="text/javascript" src="ganancias.js"></script>
</body>

</html>