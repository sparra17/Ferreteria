var idUsuario = $('#idUsuariox').val()

$(document).ready(function(){


    $.post("../../controller/venta.php?op=registrar",{idUsuario:idUsuario},function(data){
        console.log(data);
        data=JSON.parse(data);
        $('#idVenta').val(data.idVenta);
    });

    $('#idCliente').select2();

    $.post("../../controller/cliente.php?op=combo",function(data){
        $('#idCliente').html(data);
    });

    $("#idCliente").change(function(){
        $("#idCliente").each(function(){
            idCliente = $(this).val();

            $.post("../../controller/cliente.php?op=mostrar",{idCliente,idCliente},function(data){
                console.log(data);
                data=JSON.parse(data);
                $('#Direccion').val(data.Direccion);
                $('#Telefono').val(data.Telefono);
                $('#RFC').val(data.RFC);
                $('#Correo').val(data.Correo);
                
            });
        });
    });



        $('#table_agregar').DataTable({
            "aProcessing": true,
            "aServerSide": true,
            dom: 'Bfrtip',
            buttons: [

            ],
            "ajax": {
                url: "../../controller/producto.php?op=listartabla",
                type: "post",
            },
            "bDestroy": true,
            "responsive": true,
            "bInfo": true,
            "iDisplayLength": 1,
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
                "sSearch":         "Buscar Por Codigo:",
                "sUrl":            "",
                "sInfoThousands":  ",",
                "sLoadingRecords": "Cargando...",
                "oPaginate": {
                    "sFirst":    "",
                    "sLast":     "",
                    "sNext":     "",
                    "sPrevious": ""
                },
                "oAria": {
                    "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                }
            },
        });
    
    

});

$(document).on("click", "#btnagregar", function() {
    var idVenta = $("#idVenta").val();
    var idProducto = $("#idProducto").val();
    var PVenta = $("#PVenta").val();
    var DetCantidad = $("#DetCantidad").val();
    var Stock = $("#Stock").val();

    // Convertir las variables a números para asegurar la comparación correcta
    var cantidad = parseFloat(DetCantidad);
    var stock = parseFloat(Stock);

    // Mostrar valores en la consola para depuración
    console.log("Cantidad: ", cantidad);
    console.log("Stock: ", stock);

    // Verificar si la cantidad está vacía, no es un número o es mayor que el stock
    if (isNaN(cantidad) || cantidad <= 0 || cantidad > stock) {
        swal.fire({
            title: 'Venta',
            text: 'Error En La Cantidad',
            icon: 'error'
        });
    } else {
        $.post("../../controller/venta.php?op=guardardetalle", {
            idVenta: idVenta,
            idProducto: idProducto,
            PVenta: PVenta,
            DetCantidad: DetCantidad
        }, function(data) {
            console.log(data);
            listar(idVenta);

            $.post("../../controller/venta.php?op=calculo", { idVenta: idVenta }, function(data) {
                console.log(data);
                data = JSON.parse(data);
                $("#txtsubtotal").html(data.Subtotal);
                $("#txtiva").html(data.IVA);
                $("#txtdescuento").html(data.Descuento);
                $("#txttotal").html(data.Total);
            });
        });
    }
});


function eliminar(idDetVenta,idVenta){
    swal.fire({
        title: "Eliminar!",
        text: "¿Desea Eliminar El Registro?",
        icon: "error",
        confirmButtonText: "Si",
        showCancelButton: true,
        cancelButtonText: "No",
    }).then((result)=>{
        if(result.value){
            $.post("../../controller/venta.php?op=eliminardetalle",{idDetVenta:idDetVenta},function(data){
                console.log(data);
            });
            listar(idVenta);
            $.post("../../controller/venta.php?op=calculo",{idVenta:idVenta},function(data){
                console.log(data);
                data= JSON.parse(data);
                $("#txtsubtotal").html(data.Subtotal);
                $("#txtiva").html(data.IVA);
                $("#txtdescuento").html(data.Descuento);
                $("#txttotal").html(data.Total);
            });

            

            swal.fire({
                title: 'Venta',
                text: 'Registro Eliminado',
                icon: 'success'
            });
        }
    });
}

function listar(idVenta){

    $('#table_data').DataTable({
            "aProcessing": true,
            "aServerSide": true,
            dom: 'Bfrtip',
            buttons: [

            ],
            "ajax": {
                url: "../../controller/venta.php?op=listardetalle",
                type: "post",
                data:{idVenta:idVenta}
            },
            "bDestroy": true,
            "responsive": true,
            "bInfo": true,
            "iDisplayLength": 100,
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
                    "sFirst":    "",
                    "sLast":     "",
                    "sNext":     "",
                    "sPrevious": ""
                },
                "oAria": {
                    "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                }
            },
        });
}

$(document).on("click","#btnguardar",function(){
    var idVenta = $("#idVenta").val();
    var idCliente = $("#idCliente").val();
    var CliRFC = $("#RFC").val();
    var CliTelefono = $("#Telefono").val();
    var CliDireccion = $("#Direccion").val();
    var CliCorreo = $("#Correo").val();

    if ($("#idCliente").val() == '0') {
        swal.fire({
            title: 'Venta',
            text: 'Error Campos Del Cliente Vacios',
            icon: 'error'
        });
    } else {

        $.post("../../controller/venta.php?op=calculo",{idVenta:idVenta},function(data){
            data= JSON.parse(data);
            if (data.Total == null) {
                swal.fire({
                    title: 'Venta',
                    text: 'Error No Hay Productos Agregados',
                    icon: 'error'
                });
            } else {
                $.post("../../controller/venta.php?op=guardar",{
                    idVenta:idVenta,
                    idCliente:idCliente,
                    CliRFC:CliRFC,
                    CliTelefono:CliTelefono,
                    CliDireccion:CliDireccion,
                    CliCorreo:CliCorreo
                    },function(data){
                        swal.fire({
                            title: 'Venta',
                            text: 'Venta Registrada Correctamente con Nro: V-'+idVenta,
                            icon: 'success',
                            footer: "<a href='../ViewVenta/?v="+idVenta+"' target='_blank'>¿Desea Ver El Comprobante?</a>"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload();
                            }
                        });
                });
            }
        });
    }
    
});


$(document).on("click","#btnlimpiar",function(){
    location.reload();
});