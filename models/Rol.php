<?php
    class Rol extends Conectar{
        public function get_ListarRoles(){
            $conectar = parent::Conexion();
            $sql = "SP_ListarRoles";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);

        }

        public function get_RolesPorID($idRol){
            $conectar = parent::Conexion();
            $sql = "SP_ListarRolesID ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idRol);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function DeleteRoles($idRol){
            $conectar = parent::Conexion();
            $sql = "SP_DeleteRoles ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idRol);
            $query -> execute();     
        }

        public function NuevoRol($Rol){
            $conectar = parent::Conexion();
            $sql = "SP_InsertNRoles ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$Rol);
            $query -> execute();      
        }

        public function UpdateRoles($idRol,$Rol){
            $conectar = parent::Conexion();
            $sql = "SP_UpdateRoles ?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idRol);
            $query -> bindValue(2,$Rol);
            $query -> execute();    
        }
    }
?>