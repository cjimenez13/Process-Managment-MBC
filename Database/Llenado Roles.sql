execute sp_insert_role 'Administrador', 'Utilizado solo por los gerentes'
execute sp_insert_role 'Desarrollador', 'Equipo de desarrollo'
delete from Users_Roles 
select * from Users_Roles
-------------------------------------- Modulos -------------------------------------------------
-- delete from modules
--select * from Modules
execute sp_insert_module @id_module = 0, @name = 'Gestiones' -- 0-99
execute sp_insert_module @id_module = 1, @name = 'Plantillas' -- 100-199
execute sp_insert_module @id_module = 2, @name = 'Categorías' -- 200-299
execute sp_insert_module @id_module = 3, @name = 'Encuestas' -- 300-399
execute sp_insert_module @id_module = 4, @name = 'Consultas' -- 400-499
execute sp_insert_module @id_module = 5, @name = 'Usuarios' -- 500-599
execute sp_insert_module @id_module = 6, @name = 'Seguridad' -- 600-699

------------------------------------- Permissions ----------------------------------------------------
delete from Permissions
--DBCC CHECKIDENT (Permissions, RESEED, 0)
-- Gestiones
execute sp_insert_permission @id_permission = 0, @name = 'Bifurcar proceso', @module_id = 0
execute sp_insert_permission @id_permission = 1, @name = 'Eliminar proceso', @module_id = 0 
execute sp_insert_permission @id_permission = 2, @name = 'Eliminar etapa', @module_id = 0 
execute sp_insert_permission @id_permission = 3, @name = 'Eliminar tarea', @module_id = 0 
execute sp_insert_permission @id_permission = 4, @name = 'Crear etapa', @module_id = 0 
-- Plantillas
execute sp_insert_permission @id_permission = 100, @name = 'Crear plantilla', @module_id = 1
execute sp_insert_permission @id_permission = 101, @name = 'Editar plantilla', @module_id = 1 
execute sp_insert_permission @id_permission = 102, @name = 'Borrar plantilla', @module_id = 1 
execute sp_insert_permission @id_permission = 103, @name = 'Crear tarea', @module_id = 1 
execute sp_insert_permission @id_permission = 104, @name = 'Eliminar tarea', @module_id = 1
-- Categorias
execute sp_insert_permission @id_permission = 200, @name = 'Ver categorías', @module_id = 2
execute sp_insert_permission @id_permission = 201, @name = 'Crear categoría', @module_id = 2
execute sp_insert_permission @id_permission = 202, @name = 'Editar categoría', @module_id = 2
execute sp_insert_permission @id_permission = 203, @name = 'Eliminar categoría', @module_id = 2
execute sp_insert_permission @id_permission = 204, @name = 'Agregar atributo general', @module_id = 2
execute sp_insert_permission @id_permission = 205, @name = 'Agregar atributo general', @module_id = 2 
-- Encuestas
execute sp_insert_permission @id_permission = 300, @name = 'Ver encuestas', @module_id = 3
execute sp_insert_permission @id_permission = 301, @name = 'Crear encuesta', @module_id = 3
execute sp_insert_permission @id_permission = 302, @name = 'Editar encuesta', @module_id = 3
execute sp_insert_permission @id_permission = 303, @name = 'Eliminar encuesta', @module_id = 3
-- Consultas
execute sp_insert_permission @id_permission = 400, @name = 'Ver consultas', @module_id = 4
execute sp_insert_permission @id_permission = 401, @name = 'Realizar consulta', @module_id = 4
-- Usuarios
execute sp_insert_permission @id_permission = 500, @name = 'Ver usuarios', @module_id = 5
execute sp_insert_permission @id_permission = 501, @name = 'Ver personas', @module_id = 5 
execute sp_insert_permission @id_permission = 502, @name = 'Ver grupos', @module_id = 5
execute sp_insert_permission @id_permission = 503, @name = 'Registrar usuario', @module_id = 5
execute sp_insert_permission @id_permission = 504, @name = 'Eliminar usuario', @module_id = 5


---------------------------------- Elements Types ------------------------------------------
execute sp_insert_typesElement @id_elementType = 0, @type = 'Botón'
execute sp_insert_typesElement @id_elementType = 1, @type = 'Entrada de texto'
execute sp_insert_typesElement @id_elementType = 2, @type = 'Menú'
execute sp_insert_typesElement @id_elementType = 3, @type = 'Pantalla'

------------------------------------- Elements --------------------------------------
-- delete from Elements
-- DBCC CHECKIDENT (Elements, RESEED, 0)
-- Gestiones
execute sp_insert_element @name = 'btnBifurcarProceso', @type_id = 0, @permission_id = 0
execute sp_insert_element @name = 'btnEliminarProceso', @type_id = 0, @permission_id = 1


--Usuarios
execute sp_insert_element @name = 'liPersonas', @type_id = 2, @permission_id = 500
execute sp_insert_element @name = 'divPersonas', @type_id = 3, @permission_id = 501
execute sp_insert_element @name = 'divGrupos', @type_id = 3, @permission_id = 502
execute sp_insert_element @name = 'btnRegistrarUsuario', @type_id = 0, @permission_id = 503
execute sp_insert_element @name = 'btnElmiminarUsuario', @type_id = 0, @permission_id = 504







 