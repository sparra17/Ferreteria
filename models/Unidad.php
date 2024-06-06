<?php
    class Unidad extends Conectar{
        public function get_ListarUnidades(){
            $conectar = parent::Conexion();
            $sql = "SP_ListarUnidades";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);

        }

        public function get_UnidadesPorID($idUnidad){
            $conectar = parent::Conexion();
            $sql = "SP_ListarUnidadesID ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idUnidad);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function DeleteUnidades($idUnidad){
            $conectar = parent::Conexion();
            $sql = "SP_DeleteUnidades ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idUnidad);
            $query -> execute();     
        }

        public function NuevaUnidad($Unidad){
            $conectar = parent::Conexion();
            $sql = "SP_InsertNUnidades ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$Unidad);
            $query -> execute();      
        }

        public function UpdateUnidades($idUnidad,$Unidad){
            $conectar = parent::Conexion();
            $sql = "SP_UpdateUnidades ?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idUnidad);
            $query -> bindValue(2,$Unidad);
            $query -> execute();    
        }
    }
?>