$(document).on("click","#consultar",function(){
    
    var Fecha = $("#Fecha").val();

    $('#table_data').DataTable({
        "aProcessing": true,
        "aServerSide": true,
        dom: 'Bfrtip',
        buttons: [

        ],
        "ajax": {
            url: "../../controller/producto.php?op=listarGanancia",
            type: "post",
            data:{Fecha:Fecha}
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
    
});



$(document).ready(function() {
    $("#Cambios").click(function() {
        window.open('../../controller/producto.php?op=generarPDF', '_blank');
    });
});


$(document).ready(function() {
    $("#GananciasxProductos").click(function() {
        window.open('../../controller/producto.php?op=generarPDFGanancias', '_blank');
    });
});