-- *** crear la base de datos uno a uno (solo asi soporta postgres)

-- creamos la base de datos
CREATE DATABASE hoteldwh
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

-- creamos los data marts

CREATE DATABASE data_mart_uso_habitaciones
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

CREATE DATABASE data_mart_aseo
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

CREATE DATABASE data_mart_uso_ambientes_especiales
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

CREATE DATABASE data_mart_acceso_paquetes_turisticos
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

CREATE DATABASE data_mart_ingreso_economico
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

CREATE DATABASE data_mart_egreso_economico
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

CREATE DATABASE data_mart_extra_usuario_contrata_servicio
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;
-- creamos las tablas
-- nombre del script:


-- insertamos los datos
-- nombre de script:

-- abrimos los datamart.ktr y ejecutamos manualmente la opcion sql en cada dimencion y la tabla de hechos






