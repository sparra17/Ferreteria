function init(){
    $("#mantenimiento_form").on("submit",function(e){
        guardaryeditar(e);
    });
}

function guardaryeditar(e){
    e.preventDefault();
    var formData = new FormData($("#mantenimiento_form")[0]);
    $.ajax({
        url: "../../controller/producto.php?op=guardaryeditar",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function(data){
            $('#table_data').DataTable().ajax.reload();
            $('#modalmantenimiento').modal('hide');
            swal.fire({
                title: 'Producto',
                text: 'Registro Confirmado',
                icon: 'success'
            });
        }
        
    });
}

$(document).ready(function(){

    $.post("../../controller/proveedor.php?op=combo",function(data, status){
        $('#idProveedor').html(data);
    });

    $.post("../../controller/categoria.php?op=combo",function(data, status){
        $('#idCategoria').html(data);
    });

    $.post("../../controller/unidad.php?op=combo",function(data, status){
        $('#idUnidad').html(data);
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
            url: "../../controller/producto.php?op=listar",
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

function editar(idProducto){
    $.post("../../controller/producto.php?op=mostrar",{idProducto:idProducto},function(data){
        data=JSON.parse(data);
        console.log(data);
        $('#idProducto').val(data.idProducto);
        $('#Codigo').val(data.Codigo);
        $('#NombreProducto').val(data.NombreProducto);
        
        $('#PCompra').val(data.PCompra);
        $('#PVenta').val(data.PVenta);
        $('#Stock').val(data.Stock);
        $('#FechaVencimiento').val(data.FechaVencimiento);
        $('#Descripcion').val(data.Descripcion); 
        $('#idProveedor').val(data.idProveedor).trigger('change');
        $('#idCategoria').val(data.idCategoria).trigger('change');
        $('#idUnidad').val(data.idUnidad).trigger('change');
        $('#pre_imagen').html(data.Imagen); 
    });
    $('#lbltitulo').html('Editar Registro');
    $('#modalmantenimiento').modal('show');
}

function eliminar(idProducto){
    swal.fire({
        title: "Eliminar!",
        text: "¿Desea Eliminar El Registro?",
        icon: "error",
        confirmButtonText: "Si",
        showCancelButton: true,
        cancelButtonText: "No",
    }).then((result)=>{
        if(result.value){
            $.post("../../controller/producto.php?op=eliminar",{idProducto:idProducto},function(data){
                console.log(data);
            });
            $('#table_data').DataTable().ajax.reload();

            swal.fire({
                title: 'Producto',
                text: 'Registro Eliminado',
                icon: 'success'
            });
        }
    });
}

$(document).on("click","#btnnuevo",function(){
    $('#idProducto').val('');
    $('#Codigo').val('');
    $('#NombreProducto').val('');
    
    $('#PCompra').val('');
    $('#PVenta').val('');
    $('#Stock').val('');
    $('#FechaVencimiento').val('');
    $('#Descripcion').val(''); 
    $('#idProveedor').val('').trigger('change');
    $('#idCategoria').val('').trigger('change');
    $('#idUnidad').val('').trigger('change');

    $('#lbltitulo').html('Nuevo Registro');
    $('#pre_imagen').html('<img src="../../assets/productos/no-imagen.jpeg" class=" avatar-xl img-thumbnail user-profile-image" alt="user-profile-image"></img><input type="hidden" value="" />');
    $("#mantenimiento_form")[0].reset();
    $('#modalmantenimiento').modal('show');
});

function filePreview(input){
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#pre_imagen').html('<img src='+ e.target.result+' class=" avatar-xl img-thumbnail user-profile-image" alt="user-profile-image"></img>');
        }
        reader.readAsDataURL(input.files[0]);
    }
}

$(document).on('change','#Imagen',function(){
    filePreview(this);
});

$(document).on("click","#btnremoverfoto",function(){
    $('#Imagen').val('');
    $('#pre_imagen').html('<img src="../../assets/productos/no-imagen.jpeg" class=" avatar-xl img-thumbnail user-profile-image" alt="user-profile-image"></img><input type="hidden" value="" />');
});

init();