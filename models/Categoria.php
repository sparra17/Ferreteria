<?php
    class Categoria extends Conectar{
        public function get_ListarCategorias(){
            $conectar = parent::Conexion();
            $sql = "SP_ListarCategorias";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);

        }

        public function get_CategoriasPorID($idCategoria){
            $conectar = parent::Conexion();
            $sql = "SP_ListarCategoriasID ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idCategoria);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function DeleteCategorias($idCategoria){
            $conectar = parent::Conexion();
            $sql = "SP_DeleteCategorias ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idCategoria);
            $query -> execute();     
        }

        public function NuevaCategoria($Categoria){
            $conectar = parent::Conexion();
            $sql = "SP_InsertNCategorias ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$Categoria);
            $query -> execute();      
        }

        public function UpdateCategorias($idCategoria,$Categoria){
            $conectar = parent::Conexion();
            $sql = "SP_UpdateCategorias ?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idCategoria);
            $query -> bindValue(2,$Categoria);
            $query -> execute();    
        }
    }
?>