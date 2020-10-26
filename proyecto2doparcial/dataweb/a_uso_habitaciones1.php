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

        <div id="container" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>

		<script type="text/javascript">
            Highcharts.chart('container', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'PORCENTAJE DE HABITACIONES USADAS/RENTADAS'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                        }
                    }
                },
                series: [{
                    name: 'Habitaciones Usadas',
                    colorByPoint: true,
                    data: [
                        <?php
                            $query = 'select * from get_habitaciones_usadas_anio_2018()';           
                            $result = pg_query($query) or die('La consulta fallo: ' . pg_last_error());
                            while($line = pg_fetch_array($result, null, PGSQL_ASSOC)){
                        ?>                            
                            {name: "<?php echo $line['nombre_hotel_p']?>", y: <?php echo $line['hab_usadas_p'] ?> },
                        <?php
                            }
                        ?>            
                    ]
                }]
            });
		</script>        
	</body>
</html>
