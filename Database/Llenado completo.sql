USE RRHH;
go

--DBCC CHECKIDENT (ObjectLog, RESEED, 0)

-- ObjectLog
-- delete from EventLog
-- delete from ObjectLog
declare cursor_insertObjectLog cursor
for select TABLE_NAME from RRHH.INFORMATION_SCHEMA.TABLES where TABLE_TYPE = 'BASE TABLE';
declare @table_name nvarchar(30);
open cursor_insertObjectLog
fetch next from cursor_insertObjectLog into @table_name
while @@FETCH_STATUS = 0 
begin 
	execute usp_insert_ObjectLog @table_name
	fetch next from cursor_insertObjectLog into @table_name
end
close cursor_insertObjectLog
deallocate cursor_insertObjectLog

-- EventSourceLog
-- delete from EventSourceLog
-- DBCC CHECKIDENT (EventSourceLog, RESEED, 0)
execute usp_insert_EventSourceLog 'insert';
execute usp_insert_EventSourceLog 'update';
execute usp_insert_EventSourceLog 'delete';

--EventTypeLog
-- delete from EventTypeLog
DBCC CHECKIDENT (EventTypeLog, RESEED, 0)
execute usp_insert_EventTypeLog 'success';
execute usp_insert_EventTypeLog 'error';
execute usp_insert_EventTypeLog 'warning';


--Provincias
insert into Provinces (id_province, name) values (1,'San José')
insert into Provinces (id_province, name) values (2,'Alajuela')
insert into Provinces (id_province, name) values (3,'Cartago')
insert into Provinces (id_province, name) values (4,'Heredia')
insert into Provinces (id_province, name) values (5,'Guanacaste')
insert into Provinces (id_province, name) values (6,'Puntarenas')
insert into Provinces (id_province, name) values (7,'Limon')

-- Cantones
--DBCC CHECKIDENT (Cantones, RESEED, 0)
insert into Cantones(name, province_id) values ('San José',1);
insert into Cantones(name, province_id) values ('Escazú',1);
insert into Cantones(name, province_id) values ('Desamparados',1);
insert into Cantones(name, province_id) values ('Puriscal',1);
insert into Cantones(name, province_id) values ('Tarrazú',1);
insert into Cantones(name, province_id) values ('Aserri',1);
insert into Cantones(name, province_id) values ('Mora',1);
insert into Cantones(name, province_id) values ('Goicoechea',1);
insert into Cantones(name, province_id) values ('Santa Ana',1);
insert into Cantones(name, province_id) values ('Alajuelita',1);
insert into Cantones(name, province_id) values ('Vázques de Coronado',1);
insert into Cantones(name, province_id) values ('Acosta',1);
insert into Cantones(name, province_id) values ('Tibas',1);
insert into Cantones(name, province_id) values ('Moravia',1);
insert into Cantones(name, province_id) values ('Montes de Oca',1);
insert into Cantones(name, province_id) values ('Turrubares',1);
insert into Cantones(name, province_id) values ('Dota',1);
insert into Cantones(name, province_id) values ('Curridabat',1);
insert into Cantones(name, province_id) values ('Pérez Zeledón',1);
insert into Cantones(name, province_id) values ('Alajuela',2);
insert into Cantones(name, province_id) values ('San Ramón',2);
insert into Cantones(name, province_id) values ('Grecia',2);
insert into Cantones(name, province_id) values ('San Mateo',2);
insert into Cantones(name, province_id) values ('Atenas',2);
insert into Cantones(name, province_id) values ('Naranjo',2);
insert into Cantones(name, province_id) values ('Palmares',2);
insert into Cantones(name, province_id) values ('Poás',2);
insert into Cantones(name, province_id) values ('Orotina',2);
insert into Cantones(name, province_id) values ('San Carlos',2);
insert into Cantones(name, province_id) values ('Zarcero',2);
insert into Cantones(name, province_id) values ('Valverde Vega',2);
insert into Cantones(name, province_id) values ('Upala',2);
insert into Cantones(name, province_id) values ('Los Chiles',2);
insert into Cantones(name, province_id) values ('Guatuso',2);
insert into Cantones(name, province_id) values ('Cartago',3);
insert into Cantones(name, province_id) values ('Paraíso',3);
insert into Cantones(name, province_id) values ('La Unión',3);
insert into Cantones(name, province_id) values ('Jiménez',3);
insert into Cantones(name, province_id) values ('Turrialba',3);
insert into Cantones(name, province_id) values ('Alvarado',3);
insert into Cantones(name, province_id) values ('Oreamuno',3);
insert into Cantones(name, province_id) values ('El guarco',3);
insert into Cantones(name, province_id) values ('Heredia',4);
insert into Cantones(name, province_id) values ('Barva',4);
insert into Cantones(name, province_id) values ('Santo Domingo',4);
insert into Cantones(name, province_id) values ('Santa Bárvara',4);
insert into Cantones(name, province_id) values ('San Rafael',4);
insert into Cantones(name, province_id) values ('San Isidro',4);
insert into Cantones(name, province_id) values ('Belen',4);
insert into Cantones(name, province_id) values ('Flores',4);
insert into Cantones(name, province_id) values ('San Pablo',4);
insert into Cantones(name, province_id) values ('Sarapiquí',4);
insert into Cantones(name, province_id) values ('Liberia',5);
insert into Cantones(name, province_id) values ('Nicoya',5);
insert into Cantones(name, province_id) values ('Santa Cruz',5);
insert into Cantones(name, province_id) values ('Bagaces',5);
insert into Cantones(name, province_id) values ('Carrillo',5);
insert into Cantones(name, province_id) values ('Cañas',5);
insert into Cantones(name, province_id) values ('Abangares',5);
insert into Cantones(name, province_id) values ('Tilarán',5);
insert into Cantones(name, province_id) values ('Nandayure',5);
insert into Cantones(name, province_id) values ('La Cruz',5);
insert into Cantones(name, province_id) values ('Hojancha',5);
insert into Cantones(name, province_id) values ('Puntarenas',6);
insert into Cantones(name, province_id) values ('Esparza',6);
insert into Cantones(name, province_id) values ('Buenos Aires',6);
insert into Cantones(name, province_id) values ('Montes de Oro',6);
insert into Cantones(name, province_id) values ('Osa',6);
insert into Cantones(name, province_id) values ('Quepos',6);
insert into Cantones(name, province_id) values ('Golfito',6);
insert into Cantones(name, province_id) values ('Coto Brus',6);
insert into Cantones(name, province_id) values ('Parrita',6);
insert into Cantones(name, province_id) values ('Corredores',6);
insert into Cantones(name, province_id) values ('Garabito',6);
insert into Cantones(name, province_id) values ('Limón',7);
insert into Cantones(name, province_id) values ('Pococí',7);
insert into Cantones(name, province_id) values ('Siquirres',7);
insert into Cantones(name, province_id) values ('Talamanca',7);
insert into Cantones(name, province_id) values ('Matina',7);
insert into Cantones(name, province_id) values ('Guácimo',7);

-- Tipos de Notificaciones
--insert into Notifications_Types(id_Notification, id_type) values (1,'Telegram')
--insert into Notifications_Types(id_Notification, id_type) values (1,'Correo')
--insert into Notifications_Types(id_Notification, id_type) values (1,'Notificación interna')

--Usuarios
--delete from Users;
execute usp_insert_User @name='Christian', @fLastName='Jimenez', @email='cjimenez13@outlook.com', @password='Password12', @birthdate='13/06/1995', 
@phoneNumber='83369277', @direction= 'De la eentrada de las azaleas 500 al este', @id = 116080577, @sLastName = 'Céspedes', @username = 'cjimenez13';
execute usp_insert_User @name='Yorley', @fLastName='Aguilar', @email='yorley_maria96@gmail.com', @password='Password12';

 
execute usp_insert_role 'Administrador', 'Utilizado solo por los gerentes'
execute usp_insert_role 'Desarrollador', 'Equipo de desarrollo'
-------------------------------------- Modulos -------------------------------------------------
-- delete from modules
--select * from Modules
execute usp_insert_module @id_module = 0, @name = 'Gestiones' -- 0-99
execute usp_insert_module @id_module = 1, @name = 'Plantillas' -- 100-199
execute usp_insert_module @id_module = 2, @name = 'Categorías' -- 200-299
execute usp_insert_module @id_module = 3, @name = 'Encuestas' -- 300-399
execute usp_insert_module @id_module = 4, @name = 'Consultas' -- 400-499
execute usp_insert_module @id_module = 5, @name = 'Usuarios' -- 500-599
execute usp_insert_module @id_module = 6, @name = 'Seguridad' -- 600-699

------------------------------------- Permissions ----------------------------------------------------
--DBCC CHECKIDENT (Permissions, RESEED, 0)
-- Gestiones
execute usp_insert_permission @id_permission = 0, @name = 'Bifurcar proceso', @module_id = 0
execute usp_insert_permission @id_permission = 1, @name = 'Eliminar proceso', @module_id = 0 
execute usp_insert_permission @id_permission = 2, @name = 'Eliminar etapa', @module_id = 0 
execute usp_insert_permission @id_permission = 3, @name = 'Eliminar tarea', @module_id = 0 
execute usp_insert_permission @id_permission = 4, @name = 'Crear etapa', @module_id = 0 
-- Plantillas
execute usp_insert_permission @id_permission = 100, @name = 'Crear plantilla', @module_id = 1
execute usp_insert_permission @id_permission = 101, @name = 'Editar plantilla', @module_id = 1 
execute usp_insert_permission @id_permission = 102, @name = 'Borrar plantilla', @module_id = 1 
execute usp_insert_permission @id_permission = 103, @name = 'Crear tarea', @module_id = 1 
execute usp_insert_permission @id_permission = 104, @name = 'Eliminar tarea', @module_id = 1
-- Categorias
execute usp_insert_permission @id_permission = 200, @name = 'Ver categorías', @module_id = 2
execute usp_insert_permission @id_permission = 201, @name = 'Crear categoría', @module_id = 2
execute usp_insert_permission @id_permission = 202, @name = 'Editar categoría', @module_id = 2
execute usp_insert_permission @id_permission = 203, @name = 'Eliminar categoría', @module_id = 2
execute usp_insert_permission @id_permission = 204, @name = 'Agregar atributo general', @module_id = 2
execute usp_insert_permission @id_permission = 205, @name = 'Agregar atributo general', @module_id = 2 
-- Encuestas
execute usp_insert_permission @id_permission = 300, @name = 'Ver encuestas', @module_id = 3
execute usp_insert_permission @id_permission = 301, @name = 'Crear encuesta', @module_id = 3
execute usp_insert_permission @id_permission = 302, @name = 'Editar encuesta', @module_id = 3
execute usp_insert_permission @id_permission = 303, @name = 'Eliminar encuesta', @module_id = 3
-- Consultas
execute usp_insert_permission @id_permission = 400, @name = 'Ver consultas', @module_id = 4
execute usp_insert_permission @id_permission = 401, @name = 'Realizar consulta', @module_id = 4
-- Usuarios
execute usp_insert_permission @id_permission = 500, @name = 'Ver usuarios', @module_id = 5
execute usp_insert_permission @id_permission = 501, @name = 'Ver personas', @module_id = 5 
execute usp_insert_permission @id_permission = 502, @name = 'Ver grupos', @module_id = 5
execute usp_insert_permission @id_permission = 503, @name = 'Registrar usuario', @module_id = 5
execute usp_insert_permission @id_permission = 504, @name = 'Eliminar usuario', @module_id = 5


---------------------------------- Elements Types ------------------------------------------
execute usp_insert_typesElement @id_elementType = 0, @type = 'Botón'
execute usp_insert_typesElement @id_elementType = 1, @type = 'Entrada de texto'
execute usp_insert_typesElement @id_elementType = 2, @type = 'Menú'
execute usp_insert_typesElement @id_elementType = 3, @type = 'Pantalla'

------------------------------------- Elements --------------------------------------
-- delete from Elements
-- DBCC CHECKIDENT (Elements, RESEED, 0)
-- Gestiones
execute usp_insert_element @name = 'btnBifurcarProceso', @type_id = 0, @permission_id = 0
execute usp_insert_element @name = 'btnEliminarProceso', @type_id = 0, @permission_id = 1


--Usuarios
execute usp_insert_element @name = 'liPersonas', @type_id = 2, @permission_id = 500
execute usp_insert_element @name = 'divPersonas', @type_id = 3, @permission_id = 501
execute usp_insert_element @name = 'divGrupos', @type_id = 3, @permission_id = 502
execute usp_insert_element @name = 'btnRegistrarUsuario', @type_id = 0, @permission_id = 503
execute usp_insert_element @name = 'btnElmiminarUsuario', @type_id = 0, @permission_id = 504


insert into AttributeTypes (id_type, [type], reg_expr) values (0,'Número entero','^\d+$')
insert into AttributeTypes (id_type, [type], reg_expr) values (1,'Número decimal','^-?[\d]+([\.|\,][\d]*)')
insert into AttributeTypes (id_type, [type], reg_expr) values (2,'Texto','^[\s\S]*$')
insert into AttributeTypes (id_type, [type], reg_expr) values (3,'Fecha','^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$')
insert into AttributeTypes (id_type, [type], reg_expr) values (4,'Lista',null)



-- Categorias 

insert into AttributeTypes (id_type, [type], reg_expr) values (0,'Número entero','^\d+$')
insert into AttributeTypes (id_type, [type], reg_expr) values (1,'Número decimal','^-?[\d]+([\.|\,][\d]*)$')
insert into AttributeTypes (id_type, [type], reg_expr) values (2,'Texto','^[\s\S]*$')
insert into AttributeTypes (id_type, [type], reg_expr) values (3,'Fecha','^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$')
insert into AttributeTypes (id_type, [type], reg_expr) values (4,'Lista',null)

-- Tareas 
-- Tipos de tarea (Parametrizable todo)
insert into TaskType (id_taskType, taskName, needConfirm, formNeeded) values (0,'Visto Bueno',1,0)
insert into TaskType (id_taskType, taskName, needConfirm, formNeeded) values (1,'Solicitud',1,1)
insert into TaskType (id_taskType, taskName, needConfirm, formNeeded) values (2,'Tarea',1,0)
insert into TaskType (id_taskType, taskName, needConfirm, formNeeded) values (3,'Recordatorio',0,0)

-- Estados de la tarea (Colores y nombres parametrizables)
insert into TaskState (id_taskState, state_name, state_color) values (0,'Nuevo','#57b5e3') -- Info 
insert into TaskState (id_taskState, state_name, state_color) values (1,'En progreso','#6f85bf') -- Blueberry
insert into TaskState (id_taskState, state_name, state_color) values (2,'Completado','#53a93f') --Success
insert into TaskState (id_taskState, state_name, state_color) values (3,'Cancelado','#d73d32') --Danger
insert into TaskState (id_taskState, state_name, state_color) values (4,'En espera','#d73d32') -- Warning
insert into TaskState (id_taskState, state_name, state_color) values (5,'Atrasado','#fb6e52') -- Orange

-- Tipos de preguntas (No parametrizable)
insert into QuestionType (id_questionType, name) values (0,'Respuesta corta')
insert into QuestionType (id_questionType, name) values (1,'Parrafo')
insert into QuestionType (id_questionType, name) values (2,'Número')
insert into QuestionType (id_questionType, name) values (3,'Opción unica') 
insert into QuestionType (id_questionType, name) values (4,'Si / No')
insert into QuestionType (id_questionType, name) values (5,'Archivo') 
insert into QuestionType (id_questionType, name) values (6,'Fecha')

-- Tipos de operaciones 
-- delete from OperationType
insert into OperationType (id_operationType, displayName, operation, reg_expr) values (0,'Aumentar', '+','^-?[\d]+([\.|\,][\d]*)?$')
insert into OperationType (id_operationType, displayName, operation, reg_expr) values (1,'Disminuir', '-', '^-?[\d]+([\.|\,][\d]*)?$')
insert into OperationType (id_operationType, displayName, operation, reg_expr) values (2,'Asignación', '=', '^[\s\S]*$')


 