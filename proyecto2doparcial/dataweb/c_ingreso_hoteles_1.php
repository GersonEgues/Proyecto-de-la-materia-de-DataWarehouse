<?php
    require_once("coneccion/coneccion.php");
?>

<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Highcharts Example</title>

		<style type="text/css">

		</style>
	</head>
	<body>
<script src="Highcharts-7.2.1/code/highcharts.js"></script>
<script src="Highcharts-7.2.1/code/modules/data.js"></script>
<script src="Highcharts-7.2.1/code/modules/drilldown.js"></script>

<div id="container" style="min-width: 310px; max-width: 600px; height: 400px; margin: 0 auto"></div>

<!-- Data from www.netmarketshare.com. Select Browsers => Desktop share by version. Download as tsv. -->
<pre id="tsv" style="display:none"></pre>



		<script type="text/javascript">
// Create the chart
Highcharts.chart('container', {
    chart: {
        type: 'pie'
    },
    title: {
        text: 'INGRESO GENERADO POR LOS HOTELES 2017, 2018, 2019'
    },    
    plotOptions: {
        series: {
            dataLabels: {
                enabled: true,
                format: '{point.name}: {point.y:.1f}%'
            }
        }
    },

    tooltip: {
        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
    },

    series: [
        {
            name: "Hoteles",
            colorByPoint: true,
            data: [
                <?php
                    $queryHotel = 'select nombre_hotel, sum(ingreso) as ingreso from get_ingreso_hotel_anio_2017_2018_2019() group by nombre_hotel';
                    $resultHotel = pg_query($queryHotel) or die('La consulta fallo: ' . pg_last_error());
                    while ($line = pg_fetch_array($resultHotel, null, PGSQL_ASSOC)) {    
                ?>
                    {
                        name: "<?php echo $line['nombre_hotel']?>",
                        y: <?php echo $line['ingreso']?>,
                        drilldown: "<?php echo $line['nombre_hotel']?>"
                    },
                <?php
                    }
                ?>
            ]
        }
    ],
    drilldown: {
        series: [
            <?php
                $queryHotel2 = 'select nombre_hotel, sum(ingreso) as ingreso from get_ingreso_hotel_anio_2017_2018_2019() group by nombre_hotel';
                $resultHotel2 = pg_query($queryHotel2) or die('La consulta fallo: ' . pg_last_error());
                while ($line2 = pg_fetch_array($resultHotel2, null, PGSQL_ASSOC)) {
            ?>
                {
                    name: "<?php echo $line2['nombre_hotel']?>",
                    id: "<?php echo $line2['nombre_hotel']?>",
                    data: [
                        <?php
                            $queryDetallee = "select anio,ingreso from get_ingreso_hotel_anio_2017_2018_2019() where nombre_hotel = '" . $line2['nombre_hotel'] . "' order by anio";
                            $resultDetallee = pg_query($queryDetallee) or die('La consulta fallo: ' . pg_last_error());
                            while ($lineDetalle = pg_fetch_array($resultDetallee, null, PGSQL_ASSOC)) {
                        ?>
                            [
                                "<?php echo $lineDetalle['anio']?>",
                                <?php echo $lineDetalle['ingreso']?>
                            ],
                        <?php
                            }
                        ?>
                    ]
                },
            <?php
                }
            ?>
        ]
    }
});
		</script>
	</body>
</html>
