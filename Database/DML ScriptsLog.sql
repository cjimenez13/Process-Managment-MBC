create procedure usp_insert_scriptLog 
@script nvarchar(max), @userLog int as
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int, @id_scriptLog int
	insert into ScriptsLog (script, ejecutedBy, ejecutedDate)
	values (@script, @userLog, GETDATE())
	set @id_scriptLog = (select @@IDENTITY)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'ScriptsLog')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted script log', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_scriptLog', @value = @id_scriptLog, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'script', @value = @script, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'ejecutedBy', @value = @userLog, @EventLog_id = @event_log_id
commit transaction
end
go

-- drop procedure usp_get_scriptsLog
create procedure usp_get_scriptsLog as
begin 
	select sl.id_scriptLog, sl.ejecutedDate, sl.ejecutedBy, sl.script, u.name, u.fLastName, u.sLastName
	from ScriptsLog sl inner join Users u on u.id_user = sl.ejecutedBy
	order by sl.ejecutedDate desc
end