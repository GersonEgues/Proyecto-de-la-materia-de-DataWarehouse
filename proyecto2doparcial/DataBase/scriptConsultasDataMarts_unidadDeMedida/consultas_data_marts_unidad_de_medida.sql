-- data mart 1 - pregunta 1
select * from dim_usuario_dm1;
select * from dim_habitacion_dm1;
select * from dim_tipo_habitacion_dm1;
select * from dim_hotel_dm1;
select * from hecho_aloja_dm1;


create or replace function get_habitaciones_usadas_anio_2018() returns table(nombre_hotel_p varchar, direccion_p varchar,anio_p double precision,hab_usadas_p bigint) as $$
begin
	return query(
		select dh.nombre_hotel, dh.direccion, extract(year from th.fecha_inicio) as anio,count(*) as hab_usadas
		from hecho_aloja_dm1 th, dim_hotel_dm1 dh 
		where (th.fecha_inicio >= '2018-01-01' and th.fecha_inicio <= '2018-12-31')
			and th.id_hotel = dh.id_hotel
		group by dh.nombre_hotel, dh.direccion, anio
		order by dh.nombre_hotel, anio
	);
end;
$$ language plpgsql

select * from get_habitaciones_usadas_anio_2018();

-----------------------------------------------------

create or replace function get_habitaciones_usadas_anio_mes_2018() returns table(nombre_hotel_p varchar,direccion_p varchar,anio_p double precision,mes_p double precision,hab_usadas bigint) as $$
begin
	return query(
		select dh.nombre_hotel, dh.direccion, extract(year from th.fecha_inicio) as anio, extract(month from th.fecha_inicio) as mes,count(*) as hab_usadas
		from hecho_aloja_dm1 th, dim_hotel_dm1 dh 
		where (th.fecha_inicio >= '2018-01-01' and th.fecha_inicio <= '2018-12-31')
			and th.id_hotel = dh.id_hotel
		group by dh.nombre_hotel, dh.direccion, anio, mes
		order by dh.nombre_hotel, anio
	);
end;
$$ language plpgsql

select * from get_habitaciones_usadas_anio_mes_2018();
----------------------------------------------

select nombre_hotel_p 
from get_habitaciones_usadas_anio_mes_2018()
group by nombre_hotel_p;

select hab_usadas 
from get_habitaciones_usadas_anio_mes_2018()
where nombre_hotel_p like 'Igloo Hotel Spa'
order by mes_p;

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- data mart 4 - pregunta 2
-- data mart 4 - pregunta 2
select * from dim_paquete_turistico_dm4;
select * from dim_actividad_turistica_dm4;
select * from dim_usuario_dm4;
select * from hecho_contrata_paquete_turistico_dm4;

create or replace function get_demanda_paquetes_tursiticos_anio_2019() returns table(destino varchar,anio double precision,visitas bigint) as $$
begin
	return query(
		select dat.destino, extract(year from th.fecha) as anio, count(*) as visitas
		from hecho_contrata_paquete_turistico_dm4 th, dim_actividad_turistica_dm4 dat
		where (extract(year from th.fecha) = 2019) and th.id_actividad_turistica = dat.id_actividad_turistica
		group by dat.destino, anio	
	);
end;
$$ language plpgsql

select * from get_demanda_paquetes_tursiticos_anio_2019();
------------------------------------------------------------------------------------
create or replace function get_demanda_paquetes_tursiticos_anio_mes_2019() returns table(destino varchar,anio double precision,mes double precision,visitas bigint) as $$
begin
	return query(
		select dat.destino, extract(year from th.fecha) as anio, extract(month from th.fecha) as mes, count(*) as visitado
		from hecho_contrata_paquete_turistico_dm4 th, dim_actividad_turistica_dm4 dat
		where (extract(year from th.fecha) = 2019) and th.id_actividad_turistica = dat.id_actividad_turistica
		group by dat.destino, anio, mes
	);
end;
$$ language plpgsql

select * from get_demanda_paquetes_tursiticos_anio_mes_2019();

select destino 
from get_demanda_paquetes_tursiticos_anio_mes_2019()
group by destino;

select visitas 
from get_demanda_paquetes_tursiticos_anio_mes_2019()
where destino like 'Fuerte de samaipata (santa cruz)'
order by mes;

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- data mart 5
select * from dim_usuario_dm5;
select * from dim_hotel_dm5;
select * from hecho_ingreso_economico_dm5;

create or replace function get_ingreso_hotel_anio_2017_2018_2019() returns table(nombre_hotel varchar, direccion varchar,anio double precision,ingreso bigint) as $$
begin
	return query(
		select dh.nombre_hotel, dh.direccion, extract(year from th.fecha) as anio, sum(th.ingreso) as ingreso
		from hecho_ingreso_economico_dm5 th, dim_hotel_dm5 dh
		where (extract(year from th.fecha) >= 2017 and extract(year from th.fecha) <= 2019) and th.id_hotel = dh.id_hotel
		group by dh.nombre_hotel,dh.direccion, anio	
	);
end;
$$ language plpgsql

select * from get_ingreso_hotel_anio_2017_2018_2019();

select nombre_hotel, sum(ingreso) as ingreso
from get_ingreso_hotel_anio_2017_2018_2019()
group by nombre_hotel

select anio,ingreso
from get_ingreso_hotel_anio_2017_2018_2019()
where nombre_hotel = 'Ecoluxury Hotel'
order by anio





