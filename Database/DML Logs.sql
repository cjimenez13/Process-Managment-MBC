USE RRHH;
go

--  Insert ObjectLog
create procedure sp_insert_ObjectLog
@table_name nvarchar(30) as 
begin
	insert into ObjectLog(name, postTime, computer, userName, CHKsum)
	values (@table_name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go

--  Insert EventSourceLog
create procedure sp_insert_EventSourceLog
@name nvarchar(30) as 
begin
	insert into EventSourceLog(sourceName, postTime, computer, userName, CHKsum)
	values (@name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go


--  Insert EventTypeLog
create procedure sp_insert_EventTypeLog
@name nvarchar(30) as 
begin
	insert into EventTypeLog(name, postTime, computer, userName, CHKsum)
	values (@name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go

-- Insert EventLog
create procedure sp_insert_EventLog
@description nvarchar(50), @objectLog_id bigint, @eventTypeLog_id bigint, @eventSource_id int as 
begin
	insert into EventLog(description, objectLog_id, eventTypeLog_id, eventSourceLog_id, postTime, computer, userName, CHKsum)
	values (@description, @objectLog_id, @eventTypeLog_id, @eventSource_id, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go

create procedure sp_insert_Reference
@attribute nvarchar(50), @value nvarchar(50), @EventLog_id bigint as
begin
	insert into Reference(attribute, value, postTime, computer, userName, CHKsum)
	values (@attribute, @value, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
	insert into Reference_by_EventLog (Reference_id, eventLog_id, postTime, computer, userName, CHKsum)
	values (IDENT_CURRENT('Reference_by_EventLog'), @EventLog_id, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end
go

