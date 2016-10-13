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
insert into QuestionType (id_questionType, name) values (2,'N�mero')
insert into QuestionType (id_questionType, name) values (3,'Opci�n unica') 
insert into QuestionType (id_questionType, name) values (4,'Si / No')
insert into QuestionType (id_questionType, name) values (5,'Archivo') 
insert into QuestionType (id_questionType, name) values (6,'Fecha')

-- Tipos de operaciones 
-- delete from OperationType
insert into OperationType (id_operationType, displayName, operation, reg_expr) values (0,'Aumentar', '+','^-?[\d]+([\.|\,][\d]*)?$')
insert into OperationType (id_operationType, displayName, operation, reg_expr) values (1,'Disminuir', '-', '^-?[\d]+([\.|\,][\d]*)?$')
insert into OperationType (id_operationType, displayName, operation, reg_expr) values (2,'Asignaci�n', '=', '^[\s\S]*$')
