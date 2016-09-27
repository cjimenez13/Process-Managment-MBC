USE RRHH;
go

--drop procedure usp_insert_ObjectLog
create procedure usp_insert_ObjectLog
@table_name nvarchar(30) as 
begin
	insert into ObjectLog(name, postTime, computer, userName, CHKsum)
	values (@table_name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go


--drop procedure usp_insert_EventSourceLog
create procedure usp_insert_EventSourceLog
@name nvarchar(30) as 
begin
	insert into EventSourceLog(sourceName, postTime, computer, userName, CHKsum)
	values (@name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go


--drop procedure usp_insert_EventTypeLog
create procedure usp_insert_EventTypeLog
@name nvarchar(30) as 
begin
	insert into EventTypeLog(name, postTime, computer, userName, CHKsum)
	values (@name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go
--/-- Just for full database

-- Insert EventLog
--drop procedure usp_insert_EventLog
create procedure usp_insert_EventLog
@description nvarchar(50), @objectLog_id bigint, @eventTypeLog_id bigint, @eventSource_id int, @user int as 
begin
	insert into EventLog(description, objectLog_id, eventTypeLog_id, eventSourceLog_id, postTime, computer, [user], CHKsum)
	values (@description, @objectLog_id, @eventTypeLog_id, @eventSource_id, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), @user,0);
	return SCOPE_IDENTITY()
end
go

-- drop procedure usp_insert_Reference
create procedure usp_insert_Reference
@attribute nvarchar(50), @value nvarchar(50), @EventLog_id bigint as
begin
	declare @id_reference int = NULL
	set @id_reference = (select r.Reference_id from Reference r where attribute = @attribute and value = @value)
	if @id_reference is null
	begin 
		insert into Reference(attribute, value, postTime, computer, [user], CHKsum)
		values (@attribute, @value, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
		set @id_reference = (select SCOPE_IDENTITY())
	end
	insert into EventLog_Reference (Reference_id, eventLog_id, postTime)
	values (@id_reference, @EventLog_id, GETDATE());
end
go
