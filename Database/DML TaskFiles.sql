-- drop procedure usp_insert_taskFile
-- drop procedure usp_get_userFiles
create procedure usp_get_taksFiles
@id_task nvarchar(50)
as
begin
	select tf.name,tf.createdDate,tf.[description],tf.id_taskFile,tf.fileType, tf.[fileName], tf.task_id, CONVERT(varbinary(max),tf.fileData) as fileData 
	from TaskFiles tf 
	where tf.task_id = @id_task
end
go

create procedure usp_insert_taskFile
@id_task bigint, @fileData varbinary(MAX), @name nvarchar(30), @description nvarchar(50) = null, @fileType nvarchar(100), @fileName nvarchar(200), @userLog int
as
begin
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int, @id_taskFile bigint
	insert into TaskFiles(task_id,fileData, name, [description], createdDate, fileType, [fileName]) 
	values (@id_task, @fileData, @name, @description,GETDATE(), @fileType, @fileName);
	set @id_taskFile = (select @@IDENTITY)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'TaskFiles')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted task file', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_taskFile', @value = @id_taskFile, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'description', @value = @description, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'fileType', @value = @fileType, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'fileName', @value = @fileName, @EventLog_id = @event_log_id
commit transaction
end
go

-- drop procedure sp_delete_userFile
create procedure usp_delete_taskFile
@id_taskFile nvarchar(50), @userLog int as
begin
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	delete from TaskFiles where id_taskFile = @id_taskFile;
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'TaskFiles')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted task file', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_taskFile', @value = @id_taskFile, @EventLog_id = @event_log_id
commit transaction
end

------------------------------------- // Task Notifications // ----------------------------------
-- drop procedure usp_get_taskNotifications
create procedure usp_get_taskNotifications
@id_task bigint as
begin
	select n.id_Notification, n.[message], n.task_id, n.isStarting from Notifications n where n.task_id = @id_task
end
go

-- drop procedure usp_insertTaskNotification
create procedure usp_insert_TaskNotification
@task_id bigint, @message nvarchar(1000), @isStarting bit, @isTelegram bit, @isIntern bit, @isEmail bit, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int, @id_notification int
	insert into Notifications ([message], task_id, isStarting) values (@message, @task_id, @isStarting)
	set @id_notification = (select @@IDENTITY)
	if @isTelegram = 0
	begin
		insert into Notifications_Types (id_Notification, id_type, isSended) values (@id_notification, 2, 0)
	end
	if @isIntern = 0
	begin
		insert into Notifications_Types (id_Notification, id_type, isSended) values (@id_notification, 0, 0)
	end
	if @isEmail = 0
	begin
		insert into Notifications_Types (id_Notification, id_type, isSended) values (@id_notification, 1, 0)
	end
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Notifications')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted task notification', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_notification', @value = @id_notification, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_task', @value = @task_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'message', @value = @message, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isStarting', @value = @isStarting, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isTelegram', @value = @isTelegram, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isIntern', @value = @isIntern, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isEmail', @value = @isEmail, @EventLog_id = @event_log_id
commit transaction
end
go

-- drop procedure usp_updateTaskNotification
create procedure usp_update_TaskNotification 
@id_notification bigint, @message nvarchar(1000) = null, @isStarting bit = null, @userLog int as 
begin
	set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	update Notifications set [message] = ISNULL(@message, [message]),
							isStarting = ISNULL(@isStarting, isStarting)
	where id_Notification = @id_notification
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Notifications')
	exec @event_log_id = usp_insert_EventLog @description = 'updated task notification', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_notification', @value = @id_notification, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'message', @value = @message, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isStarting', @value = @isStarting, @EventLog_id = @event_log_id
commit transaction
end
go

create procedure usp_delete_notification
@id_notification int, @userLog int as
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	delete from Notifications where id_Notification = @id_notification
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Notifications')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted task notification', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_notification', @value = @id_notification, @EventLog_id = @event_log_id
commit transaction
end
go

create procedure usp_insert_taskNotificationType
@id_notification int, @id_notificationType int, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	insert into Notifications_Types (id_Notification, id_type, isSended) values ( @id_notification, @id_notificationType, 0)
commit transaction
end
go

-- drop procedure usp_delete_notificationType
create procedure usp_delete_taskNotificationType
@id_notification int, @id_notificationType int, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	delete from Notifications_Types where id_Notification = @id_notification and id_type = @id_notificationType
commit transaction
end
go
-- drop procedure usp_get_taskNotificationUser
create procedure usp_get_taskNotificationUser
@id_notification int as 
begin
	select part.notification_id, part.[user_id], u.name, u.sLastName, u.fLastName, u.userName, u.email,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from (select nu.[user_id], nu.notification_id from Notifications_Users nu where nu.notification_id = @id_notification)part 
	inner join Users u on part.[user_id] = u.id_user
	where u.isEnabled = 1
end
-- drop procedure usp_insert_TaskNotificationUser
create procedure usp_insert_taskNotificationUser
@id_notification int, @user_id int, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	insert into Notifications_Users(notification_id,[user_id]) values ( @id_notification, @user_id)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Notifications_Users')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted task notification user', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_notification', @value = @id_notification, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end
go

create procedure usp_delete_taskNotificationUser
@id_notification int, @user_id int, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	delete from Notifications_Users where notification_id = @id_notification and [user_id] = @user_id
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Notifications_Users')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted task notification user', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_notification', @value = @id_notification, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end
go

