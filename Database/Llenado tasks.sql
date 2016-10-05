insert into TaskType (id_taskType, taskName, needConfirm, formNeeded) values (0,'Visto Bueno',1,0)
insert into TaskType (id_taskType, taskName, needConfirm, formNeeded) values (1,'Solicitud',1,1)
insert into TaskType (id_taskType, taskName, needConfirm, formNeeded) values (2,'Tarea',1,0)
insert into TaskType (id_taskType, taskName, needConfirm, formNeeded) values (3,'Recordatorio',0,0)


insert into TaskState (id_taskState, state_name, state_color) values (0,'Nuevo','#57b5e3') -- Info 
insert into TaskState (id_taskState, state_name, state_color) values (1,'En progreso','#6f85bf') -- Blueberry
insert into TaskState (id_taskState, state_name, state_color) values (2,'Completado','#53a93f') --Success
insert into TaskState (id_taskState, state_name, state_color) values (3,'Cancelado','#d73d32') --Danger
insert into TaskState (id_taskState, state_name, state_color) values (3,'En espera','#d73d32') -- Warning
insert into TaskState (id_taskState, state_name, state_color) values (3,'Atrasado','#fb6e52') -- Orange
