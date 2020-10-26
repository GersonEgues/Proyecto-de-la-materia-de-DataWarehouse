-- estructura de la base de datos: hoteldwh
CREATE TABLE paqueteTuristico (
  idPaqueteTuristico SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  costo INTEGER NULL,
  PRIMARY KEY(idPaqueteTuristico)
);

CREATE TABLE rol (
  idRol SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  salario INTEGER NULL,
  PRIMARY KEY(idRol)
);

CREATE TABLE hotel (
  idHotel SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  direccion VARCHAR(100) NULL,
  estrellas INTEGER NULL,
  departamentos INTEGER NULL,
  PRIMARY KEY(idHotel)
);

CREATE TABLE mueble (
  idMueble SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  color VARCHAR(100) NULL,
  descripcion VARCHAR(100) NULL,
  PRIMARY KEY(idMueble)
);

CREATE TABLE tipoHabitacion (
  idTipoHabitacion SERIAL NOT NULL,
  categoria INTEGER NULL,
  descripcion VARCHAR(100) NULL,
  ubicacionPiso INTEGER NULL,
  costo INTEGER NULL,
  PRIMARY KEY(idTipoHabitacion)
);

CREATE TABLE usuario (
  idUsuario SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  apellidoPaterno VARCHAR(100) NULL,
  apellidoMaterno VARCHAR(100) NULL,
  ci VARCHAR(100) NULL,
  edad INTEGER NULL,
  genero BOOLEAN NULL,
  PRIMARY KEY(idUsuario)
);

CREATE TABLE servicio (
  idServicio SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  descripcion VARCHAR(100) NULL,
  costo INTEGER NULL,
  PRIMARY KEY(idServicio)
);

CREATE TABLE temporada (
  idTemporada SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  PRIMARY KEY(idTemporada)
);

CREATE TABLE cuadro (
  idCuadro SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  dimencion VARCHAR(100) NULL,
  descripcion VARCHAR(100) NULL,
  PRIMARY KEY(idCuadro)
);

CREATE TABLE ambienteEspecial (
  idAmbienteEspecial SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  capacidad INTEGER NULL,
  ubicacionPiso VARCHAR NULL,
  PRIMARY KEY(idAmbienteEspecial)
);

CREATE TABLE articulo  (
  idArticulo SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  descripcion VARCHAR(100) NULL,
  PRIMARY KEY(idArticulo)
);

CREATE TABLE actividad (
  idActividad SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  destino VARCHAR(100) NULL,
  descripcion VARCHAR(100) NULL,
  PRIMARY KEY(idActividad)
);

CREATE TABLE personal (
  idPersonal SERIAL NOT NULL,
  idRol SERIAL NOT NULL,
  nombre VARCHAR(100) NULL,
  apellidoPaterno VARCHAR(100) NULL,
  apellidoMaterno VARCHAR(100) NULL,
  ci VARCHAR(100) NULL,
  direccion VARCHAR(100) NULL,
  PRIMARY KEY(idPersonal),
  FOREIGN KEY(idRol)
    REFERENCES rol(idRol)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE habitacion (
  idHabitacion SERIAL NOT NULL,
  idTipoHabitacion SERIAL NOT NULL,
  numeroHabitacion INTEGER NULL,
  metrosCuadrados INTEGER NULL,
  capacidad INTEGER NULL,
  PRIMARY KEY(idHabitacion),
  FOREIGN KEY(idTipoHabitacion)
    REFERENCES tipoHabitacion(idTipoHabitacion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE poseeMueble (
  idTipoHabitacion SERIAL NOT NULL,
  idMueble SERIAL NOT NULL,
  unidades INTEGER NULL,
  PRIMARY KEY(idTipoHabitacion, idMueble),
  FOREIGN KEY(idMueble)
    REFERENCES mueble(idMueble)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idTipoHabitacion)
    REFERENCES tipoHabitacion(idTipoHabitacion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE aseo (
  idAseo SERIAL NOT NULL,
  idPersonal SERIAL NOT NULL,
  idHabitacion SERIAL NOT NULL,
  hora TIME WITHOUT TIME ZONE NULL,
  fecha DATE NULL,
  PRIMARY KEY(idAseo, idPersonal, idHabitacion),
  FOREIGN KEY(idPersonal)
    REFERENCES personal(idPersonal)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idHabitacion)
    REFERENCES habitacion(idHabitacion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE acceso (
  idTipoHabitacion SERIAL NOT NULL,
  idAmbienteEspecial SERIAL NOT NULL,
  horaInicio TIME WITHOUT TIME ZONE NULL,
  horaFin TIME WITHOUT TIME ZONE NULL,
  activo BOOLEAN NULL,
  PRIMARY KEY(idTipoHabitacion, idAmbienteEspecial),
  FOREIGN KEY(idTipoHabitacion)
    REFERENCES tipoHabitacion(idTipoHabitacion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idAmbienteEspecial)
    REFERENCES ambienteEspecial(idAmbienteEspecial)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE contrato (
  idContrato SERIAL NOT NULL,
  idPersonal SERIAL NOT NULL,
  idHotel SERIAL NOT NULL,
  fechaInicio DATE NULL,
  fechaFin DATE NULL,
  activo BOOLEAN DEFAULT TRUE NULL,
  PRIMARY KEY(idContrato),
  FOREIGN KEY(idHotel)
    REFERENCES hotel(idHotel)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idPersonal)
    REFERENCES personal(idPersonal)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE ingresoUsuario (
  idIngresoUsuario SERIAL NOT NULL,
  idUsuario SERIAL NOT NULL,
  idHotel SERIAL NOT NULL,
  fecha DATE NULL,
  ingreso INTEGER NULL,
  PRIMARY KEY(idIngresoUsuario),
  FOREIGN KEY(idUsuario)
    REFERENCES usuario(idUsuario)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idHotel)
    REFERENCES hotel(idHotel)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE descuento (
  idTipoHabitacion SERIAL NOT NULL,
  idTemporada SERIAL NOT NULL,
  descuentoPorcentage INTEGER NULL,
  PRIMARY KEY(idTipoHabitacion, idTemporada),
  FOREIGN KEY(idTipoHabitacion)
    REFERENCES tipoHabitacion(idTipoHabitacion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idTemporada)
    REFERENCES temporada(idTemporada)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE paqueteTuristicoActividad (
  idPaqueteTuristico SERIAL NOT NULL,
  idActividad SERIAL NOT NULL,
  activo BOOLEAN NULL,
  PRIMARY KEY(idPaqueteTuristico, idActividad),
  FOREIGN KEY(idPaqueteTuristico)
    REFERENCES paqueteTuristico(idPaqueteTuristico)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idActividad)
    REFERENCES actividad(idActividad)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE poseeCuadro (
  idTipoHabitacion SERIAL NOT NULL,
  idCuadro SERIAL NOT NULL,
  unidades INTEGER NULL,
  PRIMARY KEY(idTipoHabitacion, idCuadro),
  FOREIGN KEY(idTipoHabitacion)
    REFERENCES tipoHabitacion(idTipoHabitacion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idCuadro)
    REFERENCES cuadro(idCuadro)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE poseeArticulo (
  idTipoHabitacion SERIAL NOT NULL,
  idArticulo SERIAL NOT NULL,
  unidades INTEGER NULL,
  PRIMARY KEY(idTipoHabitacion, idArticulo),
  FOREIGN KEY(idTipoHabitacion)
    REFERENCES tipoHabitacion(idTipoHabitacion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idArticulo)
    REFERENCES articulo (idArticulo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE usuarioContrataServicio (
  idUsuarioContrataServicio SERIAL NOT NULL,
  idServicio SERIAL NOT NULL,
  idUsuario SERIAL NOT NULL,
  idPersonal SERIAL NOT NULL,
  idHotel SERIAL NOT NULL,
  numeroPersonas INTEGER NULL,
  activo BOOLEAN NULL,
  fecha DATE NULL,
  aCuenta INTEGER NULL,
  saldo INTEGER NULL,
  descuento INTEGER NULL,
  PRIMARY KEY(idUsuarioContrataServicio, idServicio, idUsuario),
  FOREIGN KEY(idServicio)
    REFERENCES servicio(idServicio)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idUsuario)
    REFERENCES usuario(idUsuario)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idPersonal)
    REFERENCES personal(idPersonal)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idHotel)
    REFERENCES hotel(idHotel)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE usuarioContrataPaqueteTuristico (
  idUsuarioContrataPaqueteTuristico SERIAL NOT NULL,
  idUsuario SERIAL NOT NULL,
  idPaqueteTuristico SERIAL NOT NULL,
  idPersonal SERIAL NOT NULL,
  idHotel SERIAL NOT NULL,
  activo BOOLEAN NULL,
  fecha DATE NULL,
  aCuenta INTEGER NULL,
  saldo INTEGER NULL,
  descuento INTEGER NULL,
  PRIMARY KEY(idUsuarioContrataPaqueteTuristico, idUsuario, idPaqueteTuristico),
  FOREIGN KEY(idUsuario)
    REFERENCES usuario(idUsuario)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idPaqueteTuristico)
    REFERENCES paqueteTuristico(idPaqueteTuristico)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idPersonal)
    REFERENCES personal(idPersonal)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idHotel)
    REFERENCES hotel(idHotel)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE reserva (
  idReserva SERIAL NOT NULL,
  idUsuario SERIAL NOT NULL,
  idHabitacion SERIAL NOT NULL,
  idPersonal SERIAL NOT NULL,
  idHotel SERIAL NOT NULL,
  fechaInicio DATE NULL,
  fechaFin DATE NULL,
  costo INTEGER NULL,
  aCuenta INTEGER NULL,
  saldo INTEGER NULL,
  descuento INTEGER NULL,
  PRIMARY KEY(idReserva, idUsuario, idHabitacion, idPersonal),
  FOREIGN KEY(idUsuario)
    REFERENCES usuario(idUsuario)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idHabitacion)
    REFERENCES habitacion(idHabitacion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idPersonal)
    REFERENCES personal(idPersonal)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idHotel)
    REFERENCES hotel(idHotel)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE egreso (
  idEgreso SERIAL NOT NULL,
  idPersonal SERIAL NOT NULL,
  fecha DATE NULL,
  egreso INTEGER NULL,
  PRIMARY KEY(idEgreso),
  FOREIGN KEY(idPersonal)
    REFERENCES personal(idPersonal)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);


-- procedimientos alamcenados

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
$$ language plpgsql;

-- select * from get_habitaciones_usadas_anio_2018();

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
$$ language plpgsql;

-- select * from get_habitaciones_usadas_anio_mes_2018();
----------------------------------------------

-- data mart 4 - pregunta 2
create or replace function get_demanda_paquetes_tursiticos_anio_2019() returns table(destino varchar,anio double precision,visitas bigint) as $$
begin
	return query(
		select dat.destino, extract(year from th.fecha) as anio, count(*) as visitas
		from hecho_contrata_paquete_turistico_dm4 th, dim_actividad_turistica_dm4 dat
		where (extract(year from th.fecha) = 2019) and th.id_actividad_turistica = dat.id_actividad_turistica
		group by dat.destino, anio	
	);
end;
$$ language plpgsql;

-- select * from get_demanda_paquetes_tursiticos_anio_2019();
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
$$ language plpgsql;

-- select * from get_demanda_paquetes_tursiticos_anio_mes_2019();


-----------------------------------------------------------------------------------------
-- data mart 5
create or replace function get_ingreso_hotel_anio_2017_2018_2019() returns table(nombre_hotel varchar, direccion varchar,anio double precision,ingreso bigint) as $$
begin
	return query(
		select dh.nombre_hotel, dh.direccion, extract(year from th.fecha) as anio, sum(th.ingreso) as ingreso
		from hecho_ingreso_economico_dm5 th, dim_hotel_dm5 dh
		where (extract(year from th.fecha) >= 2017 and extract(year from th.fecha) <= 2019) and th.id_hotel = dh.id_hotel
		group by dh.nombre_hotel,dh.direccion, anio	
	);
end;
$$ language plpgsql;

-- select * from get_ingreso_hotel_anio_2017_2018_2019();


