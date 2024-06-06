<?php
    class Venta extends Conectar{
        public function InsertTempVenta($idUsuario){
            $conectar = parent::Conexion();
            $sql = "SP_InTempVenta ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idUsuario);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

       
        public function InsertDetVenta($idVenta, $idProducto, $PVenta, $DetCantidad){
            $conectar = parent::Conexion();
            $sql = "SP_InsertDetVenta ?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idVenta);
            $query -> bindValue(2,$idProducto);
            $query -> bindValue(3,$PVenta);
            $query -> bindValue(4,$DetCantidad);
            $query -> execute();
            //return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function ListarDetVenta($idVenta){
            $conectar = parent::Conexion();
            $sql = "SP_ListarDetVenta ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idVenta);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function DeleteDetalleVenta($idDetVenta){
            $conectar = parent::Conexion();
            $sql = "SP_DeleteDetVenta ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idDetVenta);
            $query -> execute();     
        }

        public function VentaCalculo($idVenta){
            $conectar = parent::Conexion();
            $sql = "SP_UpdateSubTotalVenta ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idVenta);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function GuardarVenta($idVenta,$idCliente,$CliRFC,$CliTelefono,$CliDireccion,$CliCorreo){
            $conectar = parent::Conexion();
            $sql = "SP_GuardarVenta ?,?,?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idVenta);
            $query -> bindValue(2,$idCliente);
            $query -> bindValue(3,$CliRFC);
            $query -> bindValue(4,$CliTelefono);
            $query -> bindValue(5,$CliDireccion);
            $query -> bindValue(6,$CliCorreo);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function ListarVenta($idVenta){
            $conectar = parent::Conexion();
            $sql = "SP_ListarVenta ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idVenta);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function ListarTodaVenta(){
            $conectar = parent::Conexion();
            $sql = "SP_ListarTodaVenta";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function VentaDias(){
            $conectar = parent::Conexion();
            $sql = "SP_VentaDias";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

    }
?>