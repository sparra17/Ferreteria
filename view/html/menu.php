<?php
    require_once("../../models/Menu.php");
    $menu = new Menu();
    $datos = $menu -> get_ListarMenu($_SESSION["idRol"]);
?>


<div class="app-menu navbar-menu">

            <div class="navbar-brand-box">

                <a href="" class="logo logo-dark">
                    <span class="logo-sm">
                        <img src="../../assets/images/logo_constructorachuy.jpg" alt="" width="100" height="100">
                    </span>
                    <span class="logo-lg">
                        <img src="../../assets/images/logo_constructorachuy.jpg" alt="" width="100" height="100">
                    </span>
                </a>
                
                <a class="logo logo-light">
                    <span class="logo-sm">
                        <img src="../../assets/images/logo_materialeschuy.png" alt="" width="200" height="80">
                    </span>
                    <span class="logo-lg">
                        <img src="../../assets/images/logo_materialeschuy.png" alt="" width="200" height="80">
                    </span>
                </a>

                <button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover" id="vertical-hover">
                    <i class="ri-record-circle-line"></i>
                </button>
            </div>

            <div id="scrollbar">
                <div class="container-fluid">

                    <div id="two-column-menu">
                    </div>
                    <ul class="navbar-nav" id="navbar-nav">
                        <li class="menu-title"><span data-key="t-menu">Menu</span></li>

                        <?php
                            foreach ($datos as $row){
                                if($row["Grupo"] == "Inicio" && $row["Permiso"] == "Si"){
                                    ?>
                                        <li class="nav-item">
                                            <a class="nav-link menu-link" href="<?php echo $row["Ruta"]; ?>">
                                                <i class="ri-honour-line"></i> <span data-key="t-widgets"><?php echo $row["Menu"]; ?></span>
                                            </a>
                                        </li>
                                    <?php
                                }
                            }
                        ?>

                        

                        <li class="menu-title"><span data-key="t-menu">Mantenimiento</span></li>
                        
                        <?php
                            foreach ($datos as $row){
                                if($row["Grupo"] == "Mantenimiento" && $row["Permiso"] == "Si"){
                                    ?>
                                        <li class="nav-item">
                                            <a class="nav-link menu-link" href="<?php echo $row["Ruta"]; ?>">
                                                <i class="ri-honour-line"></i> <span data-key="t-widgets"><?php echo $row["Menu"]; ?></span>
                                            </a>
                                        </li>
                                    <?php
                                }
                            }
                        ?>

                        <li class="menu-title"><span data-key="t-menu">Venta</span></li>

                        <?php
                            foreach ($datos as $row){
                                if($row["Grupo"] == "Venta" && $row["Permiso"] == "Si"){
                                    ?>
                                        <li class="nav-item">
                                            <a class="nav-link menu-link" href="<?php echo $row["Ruta"]; ?>">
                                                <i class="ri-honour-line"></i> <span data-key="t-widgets"><?php echo $row["Menu"]; ?></span>
                                            </a>
                                        </li>
                                    <?php
                                }
                            }
                        ?>

                        <li class="menu-title"><span data-key="t-menu">Ganancias</span></li>

                        <?php
                            foreach ($datos as $row){
                                if($row["Grupo"] == "Ganancias" && $row["Permiso"] == "Si"){
                                    ?>
                                        <li class="nav-item">
                                            <a class="nav-link menu-link" href="<?php echo $row["Ruta"]; ?>">
                                                <i class="ri-honour-line"></i> <span data-key="t-widgets"><?php echo $row["Menu"]; ?></span>
                                            </a>
                                        </li>
                                    <?php
                                }
                            }
                        ?>

                    </ul>
                </div>
                
            </div>

            <div class="sidebar-background"></div>
</div>

<div class="vertical-overlay"></div>