<!DOCTYPE html>
<html>
<head>
    <title>Generar PDF</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <button id="listarCambios">Listar Cambios</button>
    <div id="cambiosTable"></div>

    <script>
        $(document).ready(function() {
            $("#listarCambios").click(function() {
                $.ajax({
                    url: 'producto.php?op=listarCambios',
                    type: 'GET',
                    success: function(response) {
                        var data = JSON.parse(response).aaData;
                        var table = '<table border="1"><tr><th>ID AProductos</th><th>ID Producto</th><th>Nombre Producto</th><th>Fecha</th><th>Accion</th><th>A Precio Compra</th><th>N Precio Compra</th><th>A Precio Venta</th><th>N Precio Venta</th><th>A Stock</th><th>N Stock</th></tr>';
                        for (var i = 0; i < data.length; i++) {
                            table += '<tr>';
                            for (var j = 0; j < data[i].length; j++) {
                                table += '<td>' + data[i][j] + '</td>';
                            }
                            table += '</tr>';
                        }
                        table += '</table>';
                        $('#cambiosTable').html(table);
                    },
                    error: function(error) {
                        console.log(error);
                    }
                });
            });
        });
    </script>
</body>
</html>
