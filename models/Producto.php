<?php
    class Producto extends Conectar{
        public function get_ListarProductos(){
            $conectar = parent::Conexion();
            $sql = "SP_ListarProductos";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);

        }

        public function get_ProductosPorID($idProducto){
            $conectar = parent::Conexion();
            $sql = "SP_ListarProductosID ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idProducto);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);
        }

        public function get_ProductosPorCat($idCategoria){
            $conectar = parent::Conexion();
            $sql = "SP_ListarProductosCat ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idCategoria);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);
        }

        public function get_ProductosPorCOD($Codigo){
            $conectar = parent::Conexion();
            $sql = "SP_ListarProductosCOD ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$Codigo);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);
        }

        public function DeleteProductos($idProducto){
            $conectar = parent::Conexion();
            $sql = "SP_DeleteProductos ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idProducto);
            $query -> execute();
        }

        public function NuevoProducto($Codigo,$NombreProducto,$idProveedor,$idCategoria,$idUnidad,$PCompra,$PVenta,$Stock,$FechaVencimiento,$Descripcion,$Imagen){
            $conectar = parent::Conexion();
            
            require_once("Producto.php");
            $prod = new Producto();
            $Imagen  = '';
            if($_FILES["Imagen"]["name"] != ''){
                $Imagen = $prod -> subir_imagen();
            }
            
            $sql = "SP_InsertNProductos ?,?,?,?,?,?,?,?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$Codigo);
            $query -> bindValue(2,$NombreProducto);
            $query -> bindValue(3,$idProveedor);
            $query -> bindValue(4,$idCategoria);
            $query -> bindValue(5,$idUnidad);
            $query -> bindValue(6,$PCompra);
            $query -> bindValue(7,$PVenta);
            $query -> bindValue(8,$Stock);
            $query -> bindValue(9,$FechaVencimiento);
            $query -> bindValue(10,$Descripcion);
            $query -> bindValue(11,$Imagen);
            $query -> execute();
        }

        public function UpdateProductos($idProducto,$Codigo,$NombreProducto,$idProveedor,$idCategoria,$idUnidad,$PCompra,$PVenta,$Stock,$FechaVencimiento,$Descripcion,$Imagen){
            $conectar = parent::Conexion();

            require_once("Producto.php");
            $prod = new Producto();
            $Imagen  = '';
            if($_FILES["Imagen"]["name"] != ''){
                $Imagen = $prod -> subir_imagen();
            }else{
                $Imagen = $_POST["hiden_producto_imagen"];
            }

            $sql = "SP_UpdateProductos ?,?,?,?,?,?,?,?,?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idProducto);
            $query -> bindValue(2,$Codigo);
            $query -> bindValue(3,$NombreProducto);
            
            $query -> bindValue(4,$idProveedor);
            $query -> bindValue(5,$idCategoria);
            $query -> bindValue(6,$idUnidad);
            $query -> bindValue(7,$PCompra);
            $query -> bindValue(8,$PVenta);
            $query -> bindValue(9,$Stock);
            $query -> bindValue(10,$FechaVencimiento);
            $query -> bindValue(11,$Descripcion);
            $query -> bindValue(12,$Imagen);
            $query -> execute();
        }

        public function subir_imagen(){
            if (isset($_FILES["Imagen"])) {
                $extension = explode('.',$_FILES['Imagen']['name']);
                $new_name = rand() . '.' . $extension[1];
                $destino = '../assets/productos/' . $new_name;
                move_uploaded_file($_FILES['Imagen']['tmp_name'], $destino);
                return $new_name;
            }
        }

        public function GananciaDiaria($Fecha){
            $conectar = parent::Conexion();
            $sql = "SP_GananciaDiaria ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$Fecha);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);
        }

        public function Cambios() {
            $conectar = parent::Conexion();
            $sql = "SELECT * FROM Cambios ORDER BY Fecha DESC";
            $query = $conectar->prepare($sql);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }

        public function GananciaxProducto() {
            $conectar = parent::Conexion();
            $sql = "SELECT * FROM GananciaxProducto ORDER BY idVenta DESC";
            $query = $conectar->prepare($sql);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }


    }
?>