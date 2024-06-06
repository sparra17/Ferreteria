<?php
    class Cliente extends Conectar{
        public function get_ListarClientes(){
            $conectar = parent::Conexion();
            $sql = "SP_ListarClientes";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);

        }

        public function get_ClientesPorID($idCliente){
            $conectar = parent::Conexion();
            $sql = "SP_ListarClientesID ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idCliente);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function DeleteClientes($idCliente){
            $conectar = parent::Conexion();
            $sql = "SP_DeleteClientes ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idCliente);
            $query -> execute();     
        }

        public function NuevoCliente($Nombre,$Paterno,$Materno,$Sexo,$Direccion,$Telefono,$Correo,$CURP,$RFC){
            $conectar = parent::Conexion();
            $sql = "SP_InsertNClientes ?,?,?,?,?,?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$Nombre);
            $query -> bindValue(2,$Paterno);
            $query -> bindValue(3,$Materno);
            $query -> bindValue(4,$Sexo);
            $query -> bindValue(5,$Direccion);
            $query -> bindValue(6,$Telefono);
            $query -> bindValue(7,$Correo);
            $query -> bindValue(8,$CURP);
            $query -> bindValue(9,$RFC);
            $query -> execute();      
        }

        public function UpdateClientes($idCliente,$Nombre,$Paterno,$Materno,$Sexo,$Direccion,$Telefono,$Correo,$CURP,$RFC){
            $conectar = parent::Conexion();
            $sql = "SP_UpdateClientes ?,?,?,?,?,?,?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idCliente);
            $query -> bindValue(2,$Nombre);
            $query -> bindValue(3,$Paterno);
            $query -> bindValue(4,$Materno);
            $query -> bindValue(5,$Sexo);
            $query -> bindValue(6,$Direccion);
            $query -> bindValue(7,$Telefono);
            $query -> bindValue(8,$Correo);
            $query -> bindValue(9,$CURP);
            $query -> bindValue(10,$RFC);
            $query -> execute();    
        }
    }
?>