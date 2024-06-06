<?php

    session_start();
    class Conectar{
        protected $dbh;

        protected function Conexion(){
            try{
                $conectar = $this->dbh = new PDO("sqlsrv:Server=localhost;Database=Ferreteria","sa","Passw0rd");
                return $conectar;
            }catch(Exception $e){
                print "¡Error Conexion BD!: " . $e->getMessage() . "<br/>";
                die();
            }
        }

        public static function ruta(){
            return "http://localhost/Ferreteria/";
        }
    }

?>