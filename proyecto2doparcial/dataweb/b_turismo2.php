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
                    text: 'LUGARES TURISTICOS VISITADOS POR MES, AÑO 2019'
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
                        text: 'Numero de visitas(Num. visistas)'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} Num. visistas </b></td></tr>',
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
                        $queryNombreTurimo = 'select destino from get_demanda_paquetes_tursiticos_anio_mes_2019() group by destino';
                        $resultNombreTurimo = pg_query($queryNombreTurimo) or die('La consulta fallo: ' . pg_last_error());

                        while($line = pg_fetch_array($resultNombreTurimo, null, PGSQL_ASSOC)){
                    ?>
                            {                         
                                name: "<?php echo $line['destino'] ?>",                                    
                                data: 
                                [
                                    <?php
                                        $queryVisistas = "select visitas from get_demanda_paquetes_tursiticos_anio_mes_2019() where destino like '" .  $line['destino']  . "' order by mes";
                                        $resultVisistas = pg_query($queryVisistas) or die('La consulta fallo: ' . pg_last_error());
                                        while($line2 = pg_fetch_array($resultVisistas, null, PGSQL_ASSOC)){
                                    ?>
                                        <?php echo $line2['visitas'] . "," ?>
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
