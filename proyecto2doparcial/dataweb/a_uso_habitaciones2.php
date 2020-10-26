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
                    text: 'HABITACIONES USADAS/RENTADAS POR MES'
                },
                
                xAxis: {
                    categories: [
                        'Enero',
                        'Febrero',
                        'Marzo',
                        'Abril',
                        'Mayo',
                        'Junio',
                        'Julio',
                        'Agosto',
                        'Septiembre',
                        'Octubre',
                        'Noviembre',
                        'Diciembre'
                    ],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Habitaciones rentadas (hab. rentadas)'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} hab. rentadas </b></td></tr>',
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
                        $queryNombreHoteles = 'select nombre_hotel_p from get_habitaciones_usadas_anio_mes_2018() group by nombre_hotel_p;';
                        $resultNombreHoteles = pg_query($queryNombreHoteles) or die('La consulta fallo: ' . pg_last_error());

                        while($line = pg_fetch_array($resultNombreHoteles, null, PGSQL_ASSOC)){
                    ?>
                            {                         
                                name: "<?php echo $line['nombre_hotel_p'] ?>",                                    
                                data: 
                                [
                                    <?php
                                        $queryHabUsadas = "select hab_usadas from get_habitaciones_usadas_anio_mes_2018() where nombre_hotel_p like '" .  $line['nombre_hotel_p']  . "' order by mes_p";
                                        $resultHabUsadas = pg_query($queryHabUsadas) or die('La consulta fallo: ' . pg_last_error());
                                        while($line2 = pg_fetch_array($resultHabUsadas, null, PGSQL_ASSOC)){
                                    ?>
                                        <?php echo $line2['hab_usadas'] . "," ?>
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
