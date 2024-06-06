function init(){
    $("#mantenimiento_form").on("submit",function(e){
        guardaryeditar(e);
    });
}

function guardaryeditar(e){
    e.preventDefault();
    var formData = new FormData($("#mantenimiento_form")[0]);
    $.ajax({
        url: "../../controller/usuario.php?op=guardaryeditar",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function(data){
            $('#table_data').DataTable().ajax.reload();
            $('#modalmantenimiento').modal('hide');
            
            swal.fire({
                title: 'Usuario',
                text: 'Registro Confirmado',
                icon: 'success'
            });
        }
        
    });
}

$(document).ready(function(){

    $.post("../../controller/rol.php?op=combo",function(data, status){
        $('#idRol').html(data);
    });

    $('#table_data').DataTable({
        "aProcessing": true,
        "aServerSide": true,
        dom: 'Bfrtip',
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5',
        ],
        "ajax": {
            url: "../../controller/usuario.php?op=listar",
            type: "post"
        },
        "bDestroy": true,
        "responsive": true,
        "bInfo": true,
        "iDisplayLength": 10,
        "order": [[0, "asc"]],
        "language":{
            "sProcessing":     "Procesando...",
            "sLengthMenu":     "Mostrar _MENU_ registros",
            "sZeroRecords":    "No se encontraron resultados",
            "sEmptyTable":     "Ningún dato disponible en esta tabla",
            "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
            "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
            "sInfoPostFix":    "",
            "sSearch":         "Buscar:",
            "sUrl":            "",
            "sInfoThousands":  ",",
            "sLoadingRecords": "Cargando...",
            "oPaginate": {
                "sFirst":    "Primero",
                "sLast":     "Último",
                "sNext":     "Siguiente",
                "sPrevious": "Anterior"
            },
            "oAria": {
                "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                "sSortDescending": ": Activar para ordenar la columna de manera descendente"
            }
        },
    });

});

function editar(idUsuario){
    $.post("../../controller/usuario.php?op=mostrar",{idUsuario:idUsuario},function(data){
        data=JSON.parse(data);
        console.log(data);
        $('#idUsuario').val(data.idUsuario);
        $('#Nombre').val(data.Nombre);
        $('#Paterno').val(data.Paterno);
        $('#Materno').val(data.Materno);
        $('#idRol').val(data.idRol).trigger('change');
        $('#Sexo').val(data.Sexo).trigger('change');
        $('#Direccion').val(data.Direccion);
        $('#Telefono').val(data.Telefono);
        $('#CURP').val(data.CURP);
        $('#RFC').val(data.RFC);
        $('#Correo').val(data.Correo);
        $('#Contrasena').val(data.Contrasena);

    });
    $('#lbltitulo').html('Editar Registro');
    $('#modalmantenimiento').modal('show');
}

function eliminar(idUsuario){
    swal.fire({
        title: "Eliminar!",
        text: "¿Desea Eliminar El Registro?",
        icon: "error",
        confirmButtonText: "Si",
        showCancelButton: true,
        cancelButtonText: "No",
    }).then((result)=>{
        if(result.value){
            $.post("../../controller/usuario.php?op=eliminar",{idUsuario:idUsuario},function(data){
                console.log(data);
            });
            $('#table_data').DataTable().ajax.reload();

            swal.fire({
                title: 'Usuario',
                text: 'Registro Eliminado',
                icon: 'success'
            });
        }
    });
}

$(document).on("click","#btnnuevo",function(){
    $('#idUsuario').val('');
    $('#Usuario').val('');
    $('#lbltitulo').html('Nuevo Registro');
    $("#mantenimiento_form")[0].reset();
    $('#modalmantenimiento').modal('show');
});

init();