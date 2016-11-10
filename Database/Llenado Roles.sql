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
--execute sp_insert_module @id_module = 3, @name = 'Encuestas' -- 300-399
execute sp_insert_module @id_module = 4, @name = 'Consultas' -- 400-499
execute sp_insert_module @id_module = 5, @name = 'Usuarios' -- 500-599
execute sp_insert_module @id_module = 6, @name = 'Seguridad' -- 600-699

------------------------------------- Permissions ----------------------------------------------------
delete from Permissions
--DBCC CHECKIDENT (Permissions, RESEED, 0)
------------------------------------------- Gestiones -------------------------------------------
execute sp_insert_permission @id_permission = 0, @name = 'Ver menú procesos', @module_id = 0
-- General
execute sp_insert_permission @id_permission = 10, @name = 'Crear getión', @module_id = 0
execute sp_insert_permission @id_permission = 11, @name = 'Editar getión', @module_id = 0
-- Etapas
execute sp_insert_permission @id_permission = 12, @name = 'Crear etapa', @module_id = 0 
execute sp_insert_permission @id_permission = 13, @name = 'Editar etapa', @module_id = 0 
execute sp_insert_permission @id_permission = 14, @name = 'Eliminar etapa', @module_id = 0 
-- Tareas
execute sp_insert_permission @id_permission = 15, @name = 'Crear tarea', @module_id = 0 
execute sp_insert_permission @id_permission = 16, @name = 'Editar tarea', @module_id = 0 
execute sp_insert_permission @id_permission = 17, @name = 'Eliminar tarea', @module_id = 0 
execute sp_insert_permission @id_permission = 18, @name = 'Bifurcar proceso', @module_id = 0
execute sp_insert_permission @id_permission = 19, @name = 'Pausar proceso', @module_id = 0

------------------------------------------- Plantillas -------------------------------------------
execute sp_insert_permission @id_permission = 100, @name = 'Ver menú plantilla', @module_id = 1
-- General
execute sp_insert_permission @id_permission = 110, @name = 'Crear plantilla', @module_id = 1
execute sp_insert_permission @id_permission = 111, @name = 'Editar plantilla', @module_id = 1 
execute sp_insert_permission @id_permission = 112, @name = 'Borrar plantilla', @module_id = 1 
-------------------------------------------Categorias -------------------------------------------
execute sp_insert_permission @id_permission = 200, @name = 'Ver menú categoria', @module_id = 2
--General
execute sp_insert_permission @id_permission = 210, @name = 'Agregar categoría', @module_id = 2
execute sp_insert_permission @id_permission = 211, @name = 'Editar categoría', @module_id = 2
execute sp_insert_permission @id_permission = 212, @name = 'Eliminar categoría', @module_id = 2
-- Atributos generales
execute sp_insert_permission @id_permission = 213, @name = 'Agregar atributo general', @module_id = 2
execute sp_insert_permission @id_permission = 214, @name = 'Editar atributo general', @module_id = 2 
execute sp_insert_permission @id_permission = 215, @name = 'Eliminar atributo general', @module_id = 2 
-- Atributos personles
execute sp_insert_permission @id_permission = 216, @name = 'Agregar atributo personal', @module_id = 2
execute sp_insert_permission @id_permission = 217, @name = 'Editar atributo personal', @module_id = 2 
execute sp_insert_permission @id_permission = 218, @name = 'Eliminar atributo personal', @module_id = 2 
-- Atributos listas
execute sp_insert_permission @id_permission = 219, @name = 'Agregar atributo lista', @module_id = 2
execute sp_insert_permission @id_permission = 220, @name = 'Editar atributo lista', @module_id = 2 
execute sp_insert_permission @id_permission = 221, @name = 'Eliminar atributo lista', @module_id = 2 

------------------------------------------- Encuestas -------------------------------------------
--execute sp_insert_permission @id_permission = 300, @name = 'Ver encuestas', @module_id = 3
--execute sp_insert_permission @id_permission = 301, @name = 'Crear encuesta', @module_id = 3
--execute sp_insert_permission @id_permission = 302, @name = 'Editar encuesta', @module_id = 3
--execute sp_insert_permission @id_permission = 303, @name = 'Eliminar encuesta', @module_id = 3

------------------------------------------- Consultas ----------------------------------------------------

execute sp_insert_permission @id_permission = 400, @name = 'Ver menú consultas', @module_id = 4
execute sp_insert_permission @id_permission = 401, @name = 'Realizar consulta', @module_id = 4
execute sp_insert_permission @id_permission = 402, @name = 'Ejecutar consulta historial', @module_id = 4


-------------------------------------------- Usuarios -------------------------------------------

execute sp_insert_permission @id_permission = 500, @name = 'Ver menú personas', @module_id = 5
-- Usuarios
execute sp_insert_permission @id_permission = 510, @name = 'Registrar usuario', @module_id = 5
execute sp_insert_permission @id_permission = 511, @name = 'Deshabilitar usuario', @module_id = 5 
-- Perfil
execute sp_insert_permission @id_permission = 512, @name = 'Agregar archivo', @module_id = 5
execute sp_insert_permission @id_permission = 513, @name = 'Eliminar archivo', @module_id = 5
execute sp_insert_permission @id_permission = 514, @name = 'Editar datos', @module_id = 5
execute sp_insert_permission @id_permission = 515, @name = 'Cambiar foto', @module_id = 5
execute sp_insert_permission @id_permission = 516, @name = 'Editar información del usuario', @module_id = 5

execute sp_insert_permission @id_permission = 517, @name = 'Agregar rol', @module_id = 5
execute sp_insert_permission @id_permission = 518, @name = 'Eliminar rol', @module_id = 5

-- Grupos
execute sp_insert_permission @id_permission = 550, @name = 'Agregar grupo', @module_id = 5
execute sp_insert_permission @id_permission = 551, @name = 'Editar grupo', @module_id = 5
execute sp_insert_permission @id_permission = 552, @name = 'Eliminar grupo', @module_id = 5
execute sp_insert_permission @id_permission = 553, @name = 'Agregar miembro', @module_id = 5
execute sp_insert_permission @id_permission = 554, @name = 'Eliminar miembro', @module_id = 5

-------------------------------------------- Seguridad -------------------------------------------
execute sp_insert_permission @id_permission = 600, @name = 'Ver menú configuracion', @module_id = 5

execute sp_insert_permission @id_permission = 610, @name = 'Agregar rol', @module_id = 5
execute sp_insert_permission @id_permission = 611, @name = 'Editar rol', @module_id = 5
execute sp_insert_permission @id_permission = 612, @name = 'Eliminar rol', @module_id = 5


---------------------------------- Elements Types ------------------------------------------
execute sp_insert_typesElement @id_elementType = 0, @type = 'Botón'
execute sp_insert_typesElement @id_elementType = 1, @type = 'Entrada de texto'
execute sp_insert_typesElement @id_elementType = 2, @type = 'Menú'
execute sp_insert_typesElement @id_elementType = 3, @type = 'Pantalla'







------------------------------------- Elements --------------------------------------

-- delete from Elements
-- DBCC CHECKIDENT (Elements, RESEED, 0)

------------------------------------------- Gestiones -------------------------------------------
execute sp_insert_element @name = 'Gestión de procesos', @type_id = 2, @permission_id = 0

-- General
execute sp_insert_element @name = 'btnCrearGestion', @type_id = 0, @permission_id = 10
execute sp_insert_element @name = 'btnEditarGestion', @type_id = 0, @permission_id = 11
-- Etapas
execute sp_insert_element @name = 'btnCrearEtapa', @type_id = 0, @permission_id = 12
execute sp_insert_element @name = 'btnEditarEtapa', @type_id = 0, @permission_id = 13
execute sp_insert_element @name = 'btnElmiminarEtapa', @type_id = 0, @permission_id = 14
-- Tareas
execute sp_insert_element @name = 'btnCrearTarea', @type_id = 0, @permission_id = 15
execute sp_insert_element @name = 'btnEditarTarea', @type_id = 0, @permission_id = 16
execute sp_insert_element @name = 'btnElmiminarTarea', @type_id = 0, @permission_id = 17
execute sp_insert_element @name = 'btnbifurcarTarea', @type_id = 0, @permission_id = 18
execute sp_insert_element @name = 'btnPausarTarea', @type_id = 0, @permission_id = 19

execute sp_insert_permission @id_permission = 15, @name = 'Crear tarea', @module_id = 0 
execute sp_insert_permission @id_permission = 16, @name = 'Editar tarea', @module_id = 0 
execute sp_insert_permission @id_permission = 17, @name = 'Eliminar tarea', @module_id = 0 
execute sp_insert_permission @id_permission = 18, @name = 'Bifurcar proceso', @module_id = 0
execute sp_insert_permission @id_permission = 19, @name = 'Pausar proceso', @module_id = 0

-- Gestiones
execute sp_insert_element @name = 'btnBifurcarProceso', @type_id = 0, @permission_id = 0
execute sp_insert_element @name = 'btnEliminarProceso', @type_id = 0, @permission_id = 1

------------------------------------------- Plantillas -------------------------------------------
execute sp_insert_element @name = 'Plantillas', @type_id = 2, @permission_id = 100
-- General
execute sp_insert_element @name = 'btnCrearPlantilla', @type_id = 0, @permission_id = 110
execute sp_insert_element @name = 'btnEditarPlantilla', @type_id = 0, @permission_id = 110
execute sp_insert_element @name = 'btnEliminarPlantilla', @type_id = 0, @permission_id = 110

-------------------------------------------Categorias -------------------------------------------
execute sp_insert_element @name = 'Categorias', @type_id = 2, @permission_id = 200
--General
execute sp_insert_element @name = 'btnCrearPlantilla', @type_id = 0, @permission_id = 210
execute sp_insert_element @name = 'btnEditarPlantilla', @type_id = 0, @permission_id = 211
execute sp_insert_element @name = 'btnEliminarPlantilla', @type_id = 0, @permission_id = 212
-- Atributos generales
execute sp_insert_element @name = 'btnAgregarAtributoGeneral', @type_id = 0, @permission_id = 213
execute sp_insert_element @name = 'btnsEditarAtributoGeneral', @type_id = 0, @permission_id = 214
execute sp_insert_element @name = 'btnsEliminarAtributoGeneral', @type_id = 0, @permission_id = 215
-- Atributos personales
execute sp_insert_element @name = 'btnAgregarAtributoPersonal', @type_id = 0, @permission_id = 216
execute sp_insert_element @name = 'btnsEditarAtributPersonal', @type_id = 0, @permission_id = 217
execute sp_insert_element @name = 'btnsEliminarAtributoPersonal', @type_id = 0, @permission_id = 218
-- Atributos lista
execute sp_insert_element @name = 'btnAgregarAtributoLista', @type_id = 0, @permission_id = 219
execute sp_insert_element @name = 'btnsEditarAtributoLista', @type_id = 0, @permission_id = 220
execute sp_insert_element @name = 'btbsEliminarAtributoLista', @type_id = 0, @permission_id = 221

------------------------------------------- Consultas ----------------------------------------------------
execute sp_insert_element @name = 'Consultas', @type_id = 2, @permission_id = 400
execute sp_insert_element @name = 'btnRealizarConsulta', @type_id = 0, @permission_id = 401
execute sp_insert_element @name = 'btnsEjecutarConsulta', @type_id = 0, @permission_id = 402

-------------------------------------------- Usuarios -------------------------------------------
execute sp_insert_element @name = 'Personas', @type_id = 2, @permission_id = 500
-- Usuarios
execute sp_insert_element @name = 'btnRegistrarUsuario', @type_id = 0, @permission_id = 510
execute sp_insert_element @name = 'btnDeshabilitarUsuario', @type_id = 0, @permission_id = 511
-- Perfil
execute sp_insert_element @name = 'btnAgregarArchivoUsuario', @type_id = 0, @permission_id = 512
execute sp_insert_element @name = 'btnEliminarArchivoUsuario', @type_id = 0, @permission_id = 513
execute sp_insert_element @name = 'btnsEditarDatosUsuario', @type_id = 0, @permission_id = 514
execute sp_insert_element @name = 'btnCambiarFotoUsuario', @type_id = 0, @permission_id = 515
execute sp_insert_element @name = 'btnEditarInformacionUsuario', @type_id = 0, @permission_id = 516
execute sp_insert_element @name = 'btnAgregarRolUsuario', @type_id = 0, @permission_id = 517
execute sp_insert_element @name = 'btnsEliminarRolUsuario', @type_id = 0, @permission_id = 518

-- Grupos 
execute sp_insert_element @name = 'btnAgregarGrupo', @type_id = 0, @permission_id = 550
execute sp_insert_element @name = 'btnEditarGrupo', @type_id = 0, @permission_id = 551
execute sp_insert_element @name = 'btnEliminarGrupo', @type_id = 0, @permission_id = 552
execute sp_insert_element @name = 'btnAgregarMiembro', @type_id = 0, @permission_id = 553
execute sp_insert_element @name = 'btnEliminarMiembro', @type_id = 0, @permission_id = 554
-------------------------------------------- Seguridad -------------------------------------------
execute sp_insert_element @name = 'Configuracion', @type_id = 2, @permission_id = 600

execute sp_insert_element @name = 'btnAgregarRol', @type_id = 0, @permission_id = 610
execute sp_insert_element @name = 'btnEditarRol', @type_id = 0, @permission_id = 611
execute sp_insert_element @name = 'btnEliminarRol', @type_id = 0, @permission_id = 612














 