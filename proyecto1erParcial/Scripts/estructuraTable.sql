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
  ubicacionPiso VARCHAR(100) NULL,
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

