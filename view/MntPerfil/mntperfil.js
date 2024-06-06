var idUsuario = $('#idUsuariox').val();

$(document).on("click","#btnguardar",function(){
    var pass = $("#txtpass").val();
    var newpass = $("#txtpassconfirm").val();

    if(pass.length == 0 || newpass.length == 0){
        swal.fire({
            title: 'Error',
            text: 'Campos Vacios',
            icon: 'error'
        });
    }else{
        if(pass == newpass){
            $.post("../../controller/usuario.php?op=actualizar",{idUsuario:idUsuario,Contrasena:newpass},function(data){
            });
            swal.fire({
                title: 'Correcto!',
                text: 'Contraseña Actualizada Correctamente',
                icon: 'success'
            });
        }else{
            swal.fire({
                title: 'Error',
                text: 'La Contraseña No Coincide',
                icon: 'error'
            });
        }
    }
});