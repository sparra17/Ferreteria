<?php
    class Proveedor extends Conectar{
        public function get_ListarProveedores(){
            $conectar = parent::Conexion();
            $sql = "SP_ListarProveedores";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);

        }

        public function get_ProveedoresPorID($idProveedor){
            $conectar = parent::Conexion();
            $sql = "SP_ListarProveedoresID ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idProveedor);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);
        }

        public function DeleteProveedores($idProveedor){
            $conectar = parent::Conexion();
            $sql = "SP_DeleteProveedores ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idProveedor);
            $query -> execute();
        }

        public function NuevoProveedor($Proveedor,$NombreContacto,$RFC,$Telefono,$Direccion,$Correo){
            $conectar = parent::Conexion();
            $sql = "SP_InsertNProveedores ?,?,?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$Proveedor);
            $query -> bindValue(2,$NombreContacto);
            $query -> bindValue(3,$RFC);
            $query -> bindValue(4,$Telefono);
            $query -> bindValue(5,$Direccion);
            $query -> bindValue(6,$Correo);
            $query -> execute();
        }

        public function UpdateProveedores($idProveedor,$Proveedor,$NombreContacto,$RFC,$Telefono,$Direccion,$Correo){
            $conectar = parent::Conexion();
            $sql = "SP_UpdateProveedores ?,?,?,?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idProveedor);
            $query -> bindValue(2,$Proveedor);
            $query -> bindValue(3,$NombreContacto);
            $query -> bindValue(4,$RFC);
            $query -> bindValue(5,$Telefono);
            $query -> bindValue(6,$Direccion);
            $query -> bindValue(7,$Correo);
            $query -> execute();
        }
    }
?>