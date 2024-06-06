$(document).ready(function() {
    $.post("../../controller/usuario.php?op=Contar", function(data) {
        console.log(data);
        data = JSON.parse(data);

        // Suponiendo que aaData tiene siempre un solo registro
        if (data.aaData && data.aaData.length > 0) {
            var counts = data.aaData[0];
            
            // Actualizar el contenido del span con id 'CantidadProductos'
            $('#CantidadProductos').text(counts[0]);
            $('#CantidadCategorias').text(counts[1]);
            $('#CantidadClientes').text(counts[2]);
            $('#CantidadProveedores').text(counts[3]);
        }
    });
});

$.ajax({
  url: "../../controller/venta.php?op=barras",
  method: "POST",

  success: function(data){
    data = JSON.parse(data);

    var fecha = [];
    var total = [];
    for (var i in  data) {
      fecha.push(data[i].FechaCreacion);
      total.push(data[i].Total);
    }

    var barChart,
      isbarchart = document.getElementById("graficoventas");
    (barChartColor = getChartColorsArray("graficoventas")),
      barChartColor &&
        (isbarchart.setAttribute("width", isbarchart.parentElement.offsetWidth),
        (barChart = new Chart(isbarchart, {
          type: "bar",
          data: {
            labels: fecha,
            datasets: [
              {
                label: "Ventas",
                backgroundColor: barChartColor[0],
                borderColor: barChartColor[0],
                borderWidth: 1,
                hoverBackgroundColor: barChartColor[1],
                hoverBorderColor: barChartColor[1],
                data: total,
              },
            ],
          },
          options: {
            x: { ticks: { font: { family: "Poppins" } } },
            y: { ticks: { font: { family: "Poppins" } } },
            plugins: { legend: { labels: { font: { family: "Poppins" } } } },
          },
        })));
  }
});