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
<script src="Highcharts-7.2.1/code/modules/exporting.js"></script>
<script src="Highcharts-7.2.1/code/modules/export-data.js"></script>

<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>



		<script type="text/javascript">
            Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'INGRESO GENERADO POR LOS HOTELES 2017, 2018, 2019'
                },
                
                xAxis: {
                    categories: [
                        '2017',
                        '2018',
                        '2019'
                    ],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Ingreso generado en Bs(Ingreso Bs)'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} Ingreso Bs </b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.1,
                        borderWidth: 0
                    }
                },
                series: 
                [
                    <?php
                        $queryHotel = 'select nombre_hotel, sum(ingreso) as ingreso from get_ingreso_hotel_anio_2017_2018_2019() group by nombre_hotel';
                        $resultHotel = pg_query($queryHotel) or die('La consulta fallo: ' . pg_last_error());
                        while ($line = pg_fetch_array($resultHotel, null, PGSQL_ASSOC)) {
                    ?>
                            {                         
                                name: "<?php echo $line['nombre_hotel'] ?>",                                    
                                data: 
                                [
                                    <?php
                                        $queryDetallee = "select anio, ingreso from get_ingreso_hotel_anio_2017_2018_2019() where nombre_hotel = '" . $line['nombre_hotel'] . "' order by anio";
                                        $resultDetallee = pg_query($queryDetallee) or die('La consulta fallo: ' . pg_last_error());
                                        while ($lineDetalle = pg_fetch_array($resultDetallee, null, PGSQL_ASSOC)) {
                                    ?>
                                        <?php echo $lineDetalle['ingreso'] . "," ?>
                                    <?php
                                        }
                                    ?>
                                ]
                            },
                    <?php
                        }
                    ?>
                ]
            });
		</script>
	</body>
</html>
