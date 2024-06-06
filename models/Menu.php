<?php
    class Menu extends Conectar{

        public function get_ListarMenu($idRol){
            $conectar = parent::Conexion();
            $sql = "SP_ListarMenu ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idRol);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function UpdateMenuHab($idMenuDetalle){
            $conectar = parent::Conexion();
            $sql = "SP_UpdateMenuS ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idMenuDetalle);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function UpdateMenuDesHab($idMenuDetalle){
            $conectar = parent::Conexion();
            $sql = "SP_UpdateMenuN ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idMenuDetalle);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }
    }
?>