$(document).ready(function(){
    var idVenta = getUrlParameter('v');

    $.post("../../controller/venta.php?op=mostrar",{idVenta,idVenta}, function(data){
        data=JSON.parse(data);

        $('#idVenta').html(data.idVenta);
        $('#Nombre').html(data.Nombre +' '+ data.Paterno + ' '+ data.Materno);
        $('#FechaCreacion').html(data.FechaCreacion);
        $('#txttotal').html(data.Total);

        $('#subtotal_compra').html(data.Subtotal);
        $('#iva_compra').html(data.IVA);
        $('#descuento_compra').html(data.Descuento);
        $('#total_compra').html(data.Total);

        $('#NombreC').html(data.NombreC+' '+data.PaternoC+' '+data.MaternoC);
        $('#CliRFC').html(data.CliRFC);
        $('#CliTelefono').html(data.CliTelefono);
    });

    $.post("../../controller/venta.php?op=listardetalleformato",{idVenta,idVenta}, function(data){
        $('#listardetalleformato').html(data);
        
    });
});


var getUrlParameter = function getUrlParameter(sParam){
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i

    for (i = 0; i < sURLVariables.length; i++){
        sParameterName = sURLVariables[i].split('=')

        if (sParameterName[0] === sParam){
            return sParameterName[1] === undefined ? true : sParameterName[1]
        }
    }
};