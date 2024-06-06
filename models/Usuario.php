<?php
    class Usuario extends Conectar{
        public function get_ListarUsuarios(){
            $conectar = parent::Conexion();
            $sql = "SP_ListarUsuarios";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);

        }

        public function get_UsuariosPorID($idUsuario){
            $conectar = parent::Conexion();
            $sql = "SP_ListarUsuariosID ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idUsuario);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);    
        }

        public function DeleteUsuarios($idUsuario){
            $conectar = parent::Conexion();
            $sql = "SP_DeleteUsuarios ?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idUsuario);
            $query -> execute();     
        }

        public function NuevoUsuario($Nombre,$Paterno,$Materno,$idRol,$Sexo,$Direccion,$Telefono,$CURP,$RFC,$Correo,$Contrasena){
            $conectar = parent::Conexion();
            $sql = "SP_InsertNUsuarios ?,?,?,?,?,?,?,?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$Nombre);
            $query -> bindValue(2,$Paterno);
            $query -> bindValue(3,$Materno);
            $query -> bindValue(4,$idRol);
            $query -> bindValue(5,$Sexo);
            $query -> bindValue(6,$Direccion);
            $query -> bindValue(7,$Telefono);
            $query -> bindValue(8,$CURP);
            $query -> bindValue(9,$RFC);
            $query -> bindValue(10,$Correo);
            $query -> bindValue(11,$Contrasena);
            $query -> execute();
        }

        public function UpdateUsuarios($idUsuario,$Nombre,$Paterno,$Materno,$idRol,$Sexo,$Direccion,$Telefono,$CURP,$RFC,$Correo,$Contrasena){
            $conectar = parent::Conexion();
            $sql = "SP_UpdateUsuarios ?,?,?,?,?,?,?,?,?,?,?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idUsuario);
            $query -> bindValue(2,$Nombre);
            $query -> bindValue(3,$Paterno);
            $query -> bindValue(4,$Materno);
            $query -> bindValue(5,$idRol);
            $query -> bindValue(6,$Sexo);
            $query -> bindValue(7,$Direccion);
            $query -> bindValue(8,$Telefono);
            $query -> bindValue(9,$CURP);
            $query -> bindValue(10,$RFC);
            $query -> bindValue(11,$Correo);
            $query -> bindValue(12,$Contrasena);
            $query -> execute();
        }

        public function update_usuario_pass($idUsuario,$Contrasena){
            $conectar = parent::Conexion();
            $sql = "SP_CambioContUsuarios ?,?";
            $query = $conectar -> prepare($sql);
            $query -> bindValue(1,$idUsuario);
            $query -> bindValue(2,$Contrasena);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);

        }

        public function login(){
            $conectar = parent::Conexion();
            if (isset($_POST['enviar'])) {
                $Correo = $_POST['Correo'];
                $Contrasena = $_POST['Contrasena'];
                if(empty($Correo) and empty($Contrasena)){
                    exit();
                }else{
                    $sql = "SP_AccesoUsuarios ?,?";
                    $query = $conectar -> prepare($sql);
                    $query -> bindValue(1,$Correo);
                    $query -> bindValue(2,$Contrasena);
                    $query -> execute();

                    $resultado = $query -> fetch();
                    if(is_array($resultado) and count($resultado) > 0){
                        $_SESSION['idUsuario'] = $resultado['idUsuario'];
                        $_SESSION['Nombre'] = $resultado['Nombre'];
                        $_SESSION['Paterno'] = $resultado['Paterno'];
                        $_SESSION['idRol'] = $resultado['idRol'];
                        $_SESSION['Rol'] = $resultado['Rol'];
                        $_SESSION['Correo'] = $resultado['Correo'];

                        if ($_SESSION['idRol'] == 2) {
                            header("Location:".conectar::ruta()."view/ListaVenta/");
                        } elseif ($_SESSION['idRol'] == 3) {
                            header("Location:".conectar::ruta()."view/ListaVenta/");
                        } else {
                            header("Location:".conectar::ruta()."view/home/");
                        }

                    }else{
                        exit();
                    }
                }
            }else{
                exit();
            }
        }

        public function Contar(){
            $conectar = parent::Conexion();
            $sql = "SP_Contar";
            $query = $conectar -> prepare($sql);
            $query -> execute();
            return $query -> fetchAll(PDO::FETCH_ASSOC);

        }


    }
?>