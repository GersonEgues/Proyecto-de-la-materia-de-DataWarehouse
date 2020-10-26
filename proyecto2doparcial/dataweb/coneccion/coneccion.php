<?php
    $dbconn = pg_connect("host=localhost dbname=data_ware_house_hotel user=postgres password=Curso123")
    or die('No se ha podido conectar: ' . pg_last_error());
?>