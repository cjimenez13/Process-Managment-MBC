--exec usp_insert_template 'solicitud vacaciones', 17, 75
--exec usp_insert_template 'Aumeento vacaciones', 17, 75

--drop procedure usp_get_templates
create procedure usp_get_templates as
begin
	select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id, c.name as categorie_name
	from ProcessManagment pm inner join Categories c on pm.categorie_id = c.id_categorie
	where pm.isProcess = 0 
end
go 

--drop procedure usp_get_template
create procedure usp_get_template 
@id_template bigint as
begin 
	select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id, c.name as categorie_name
	from ProcessManagment pm inner join Categories c on pm.categorie_id = c.id_categorie
	where pm.id_processManagment = @id_template and pm.isProcess = 0
end 
go
--drop procedure usp_insert_template
create procedure usp_insert_template
@name nvarchar(100), @categorie_id int = null, @userLog int as
begin
begin transaction 
	declare @processManagment_id  int, @event_log_id int, @table int
	insert into ProcessManagment (name, createdBy, createdDate, categorie_id, isProcess)
	values (@name, @userLog, GETDATE(), @categorie_id,0)
	set @processManagment_id = (SCOPE_IDENTITY())
	insert into Template (processManagment_id) values (@processManagment_id)

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Template')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted template', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'categorie_id', @value = @categorie_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_template', @value = @processManagment_id, @EventLog_id = @event_log_id
commit transaction 
end
go
-- drop procedure usp_update_template
create procedure usp_update_template
@id_template bigint, @name nvarchar(100), @userLog int as
begin 
begin transaction
	declare @event_log_id int, @table int
	update ProcessManagment set name = @name where id_processManagment = @id_template

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Template')
	exec @event_log_id = usp_insert_EventLog @description = 'updated template', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_template', @value = @id_template, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
commit transaction
end
go
-- drop procedure usp_delete_template
create procedure usp_delete_template 
@id_template bigint, @userLog int as 
begin 
begin transaction 
	declare @processManagment_id  int, @event_log_id int, @table int
	delete from ProcessManagment where id_processManagment = @id_template
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Template')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted template', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_template', @value = @id_template, @EventLog_id = @event_log_id
commit transaction
end
go
