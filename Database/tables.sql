USE [master]
GO
/****** Object:  Database [RRHH]    Script Date: 09/11/2016 05:26:58 p.m. ******/
CREATE DATABASE [RRHH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RRHH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MBCTEC\MSSQL\DATA\RRHH.mdf' , SIZE = 13312KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RRHH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MBCTEC\MSSQL\DATA\RRHH_log.ldf' , SIZE = 43264KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RRHH] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RRHH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RRHH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RRHH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RRHH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RRHH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RRHH] SET ARITHABORT OFF 
GO
ALTER DATABASE [RRHH] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RRHH] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [RRHH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RRHH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RRHH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RRHH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RRHH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RRHH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RRHH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RRHH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RRHH] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RRHH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RRHH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RRHH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RRHH] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [RRHH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RRHH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RRHH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RRHH] SET RECOVERY FULL 
GO
ALTER DATABASE [RRHH] SET  MULTI_USER 
GO
ALTER DATABASE [RRHH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RRHH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RRHH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RRHH] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'RRHH', N'ON'
GO
USE [RRHH]
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_AttributeList]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_AttributeList]
@id_attributeValue bigint, @pUser int as
begin
begin transaction;
	declare @table int, @event_log_id int
	delete from AttributeList where id_attributeValue = @id_attributeValue
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'AttributeList')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted personal attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @pUser;
	exec usp_insert_Reference @attribute = 'id_attributeValue', @value = @id_attributeValue, @EventLog_id = @event_log_id
	select @@ROWCOUNT
commit transaction;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_categorie]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_categorie]
@id_categorie int as
begin
	delete from Categories where id_categorie = @id_categorie
	select @@ROWCOUNT
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_formUser]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_formUser]
@taskForm_id bigint, @user_id nvarchar(300), @userLog int as 
begin 
declare @event_log_id int, @table int
set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Form_Users')
set transaction isolation level snapshot
begin transaction
begin try 
	delete from Form_Users where [user_id] = @user_id and taskForm_id = @taskForm_id
	exec @event_log_id = usp_insert_EventLog @description = 'deleted form user', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	select '1'
commit transaction
end try
begin catch 
	declare @errorMessage nvarchar(max) = (SELECT ERROR_MESSAGE() AS ErrorMessage);  
	exec @event_log_id = usp_insert_EventLog @description = @errorMessage, @objectLog_id = @table, @eventTypeLog_id = 2, @eventSource_id = 3, @user = @userLog;
	select '0'
	rollback transaction
end catch
exec usp_insert_Reference @attribute = 'taskForm_id', @value = @taskForm_id, @EventLog_id = @event_log_id
exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_generalAttribute]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_generalAttribute]
@id_attribute bigint, @pUser int as
begin
begin transaction;
	declare @table int, @event_log_id int
	delete from CategorieAttributes where id_attribute = @id_attribute
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'AttributeList')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted personal attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @pUser;
	exec usp_insert_Reference @attribute = 'id_attribute', @value = @id_attribute, @EventLog_id = @event_log_id
	select @@ROWCOUNT
commit transaction;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_group]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_group]
@id_group int
as
begin 
	delete from Groups where @id_group = id_group
	select @@ROWCOUNT 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_groupUser]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_groupUser]
@user_id int, @group_id int as
begin
	delete from Group_Users where [user_id] = @user_id and group_id = @group_id
	select @@ROWCOUNT
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_notification]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_notification]
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

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_personalAttribute]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_personalAttribute]
@id_attribute bigint, @userLog int as
begin
begin transaction;
	declare @table int, @event_log_id int
	delete from CategorieAttributes where id_attribute = @id_attribute
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'CategorieAttributes')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted personal attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_attribute', @value = @id_attribute, @EventLog_id = @event_log_id
	select @@ROWCOUNT
commit transaction;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_process]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_process]
@id_process bigint, @userLog int as
begin 
begin transaction 
	declare @event_log_id int, @table int
	delete from ProcessManagment where id_processManagment = @id_process
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Process')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted process', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_process', @value = @id_process, @EventLog_id = @event_log_id
commit transaction 
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_process_participant]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_process_participant]
@id_processManagment bigint, @user_id int, @userLog int as 
begin 
begin transaction
	declare @event_log_id int, @table int
	delete from Process_Participants where processManagment_id = @id_processManagment and [user_id] = @user_id
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Process_Participants')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted participant', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_template', @value = @id_processManagment, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_question]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_question]
@id_taskQuestion int, @userLog int as
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	delete from FormQuestions where id_taskQuestion = @id_taskQuestion

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'FormQuestions')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted question', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_taskQuestion', @value = @id_taskQuestion, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_role]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_role]
@id_role int
as
begin 
	delete from Roles where @id_role = id_role
	select @@ROWCOUNT 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_stage]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[usp_delete_stage]
@id_stage bigint, @userLog int as
begin 
begin transaction 
	declare @event_log_id int, @table int
	delete from Stage where id_stage = @id_stage
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Stage')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted stage', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_stage', @value = @id_stage, @EventLog_id = @event_log_id
commit transaction 
end 
 
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_task]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[usp_delete_task]
@id_task bigint, @userLog int as
begin 
begin transaction 
	declare @event_log_id int, @table int
	delete from Task where id_task = @id_task
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted task', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_task', @value = @id_task, @EventLog_id = @event_log_id
commit transaction 
end 
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_taskChange]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_taskChange]
@id_taskChange int, @userLog int as
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	delete from TaskChanges where id_taskChange = @id_taskChange

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'TaskChanges')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted task change', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_taskChange', @value = @id_taskChange, @EventLog_id = @event_log_id
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_taskFile]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_taskFile]
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
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_taskNotificationType]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_taskNotificationType]
@id_notification int, @id_notificationType int, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	delete from Notifications_Types where notification_id = @id_notification and [type_id] = @id_notificationType
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_taskNotificationUser]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_taskNotificationUser]
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

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_taskTarget]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_taskTarget]
@user_id int, @id_task bigint, @userLog int as
begin
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	delete from Task_Targets where [user_id]=@user_id and task_id = @id_task

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task_Targets')
	exec @event_log_id = usp_insert_EventLog @description = 'deleted responsable', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 3, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_task', @value = @id_task, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_delete_template]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_template] 
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
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_userFile]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_userFile]
@id_file nvarchar(50)
as
begin
	delete from UsersFiles where id_file = @id_file;
	select @@ROWCOUNT 
end
GO
/****** Object:  StoredProcedure [dbo].[usp_delete_userRole]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_delete_userRole]
@role_id int, @user_id int as
begin
begin transaction 
	delete from Users_Roles where role_id = @role_id and [user_id] = @user_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_AttributeList]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_AttributeList] 
@id_attributeValue bigint as
begin 
	select at.id_attributeValue, at.attribute_id, at.name, at.[type_id], at.value, at.isEnabled, at.createdBy, at.createdDate 
	from AttributeList at where at.id_attributeValue = @id_attributeValue;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_AttributesList]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_AttributesList] 
@id_attribute bigint as
begin 
	select at.id_attributeValue, at.attribute_id, at.name, at.[type_id], at.value, at.isEnabled, at.createdBy, at.createdDate 
	from AttributeList at where at.attribute_id = @id_attribute;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_attributeType]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_attributeType]
@id_type int as
begin
	select at.id_type, at.reg_expr, at.[type] 
	from AttributeTypes at where at.id_type = @id_type
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_attributeTypes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_attributeTypes] as
begin
	select at.id_type, at.reg_expr, at.[type] from AttributeTypes at 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_availableAttributesbyTask]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_availableAttributesbyTask]
@task_id int as 
begin 
	declare @stage_id int, @process_id int, @categorie_id int 
	set @stage_id = (select t.stage_id from Task t where t.id_task = @task_id)
	set @process_id = (select s.processManagment_id from Stage s where s.id_stage = @stage_id)
	set @categorie_id = (select pm.categorie_id from ProcessManagment pm where pm.id_processManagment = @process_id)
	
	select ca.categorie_id, ca.id_attribute, ca.name, ca.[type], ca.isGeneral
	from CategorieAttributes ca 
	where ca.isEnabled = 1 and ca.categorie_id = @categorie_id;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_cantones]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_cantones] 
@province_id tinyint as
begin
	select c.id_canton, c.name, c.province_id, p.name as province_name from Cantones c inner join Provinces p on c.province_id = p.id_province
	where c.province_id = @province_id;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_categorie]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_categorie]
@id_categorie int as 
begin 
	select c.id_categorie, c.name, c.[description], c.createdBy_name, c.createdBy_id, c.createdDate, c.isEnabled 
	from Categories c where c.id_categorie = @id_categorie
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_categories]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_categories] as
begin 
	select c.id_categorie, c.name, c.[description], c.createdBy_name, c.createdBy_id, c.createdDate, c.isEnabled 
	from Categories c order by c.name
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_Elements]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_Elements]
@role_permission_id int
as
begin
	select rpe.role_permission_id, rpe.isEnabled, e.name, rpe.element_id, (select et.[type] from ElementTypes et where et.id_elementType = e.type_id) as [type]
	from Roles_Permissions_Elements rpe inner join Elements e on rpe.element_id = e.id_element
	where rpe.role_permission_id = @role_permission_id

end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_formUsers]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_formUsers]
@taskForm_id bigint as
begin
	select part.[user_id], part.taskForm_id,  part.isAnswered, u.name, u.sLastName, u.fLastName, u.userName, u.email,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from (select fu.[user_id], fu.isAnswered, fu.taskForm_id from Form_Users fu where fu.taskForm_id = @taskForm_id) part 
	inner join Users u on part.[user_id] = u.id_user
	where u.isEnabled = 1
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_generalAttribute]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_generalAttribute]
@id_attribute bigint as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type],ca.value, ca.isEnabled, ca.createdBy, ca.createdDate 
	from CategorieAttributes ca
	where ca.id_attribute = @id_attribute
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_generalAttributes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_generalAttributes] 
@categorie_id int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type], ca.value, ca.isEnabled, ca.createdBy, ca.createdDate 
	from CategorieAttributes ca right outer join GeneralAttributes ga on ga.attribute_id = ca.id_attribute
	where ca.categorie_id = @categorie_id
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_group]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_group]
@group_id int as
begin
	select g.id_group, g.groupName, g.createdDate, g.isEnabled
	from Groups g 
	where g.id_group = @group_id
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_groupMembers]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_groupMembers]
@group_id int as
begin
	select g.id_group, u.name, u.id_user, u.fLastName, u.sLastName, u.email, u.[userName], (select photoData from UsersPhotos up where up.[user_id] = u.id_user) as photoData
	from Groups g inner join Group_Users gu on g.id_group = gu.group_id left outer join Users u on u.id_user = gu.[user_id]
	where g.id_group = @group_id
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_groups]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_groups] as
begin
	select g.id_group, g.groupName, g.createdDate, g.isEnabled
	from Groups g
	order by g.groupName
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_internNotifications]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_internNotifications]
@user_id int as 
begin 
	select n.id_notification, n.[message], n.isStarting, nt.sended_date, 
	t.name as task_name, t.id_task as task_id, s.id_stage as stage_id, s.name as stage_name, pm.id_processManagment as process_id, pm.name as process_name 
	from Notifications_Users nu inner join Notifications_Types nt on nt.notification_id = nu.notification_id inner join Notifications n on n.id_notification = nu.notification_id
	inner join Task t on t.id_task = n.task_id inner join Stage s on s.id_stage = t.stage_id inner join ProcessManagment pm on pm.id_processManagment = s.processManagment_id
	where nu.[user_id] = @user_id and nt.[type_id] = 0 and nt.isSended = 1
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_modules]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_modules] as
begin
	select id_module, name from Modules order by id_module
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_OperationTypes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_OperationTypes] as 
begin 
	select ot.id_operationType, ot.displayName, ot.operation, ot.reg_expr from OperationType ot
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_participantsTask]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_participantsTask]
@id_task bigint as 
begin
	declare @id_processManagment int 
	set @id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = (select t.stage_id from Task t where t.id_task = 26))
	select part.processManagment_id, part.[user_id], u.name, u.sLastName, u.fLastName, u.userName, u.email,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from (select pp.processManagment_id, pp.[user_id] 	from Process_Participants pp where pp.processManagment_id = @id_processManagment) part 
	inner join Users u on part.[user_id] = u.id_user
	where u.isEnabled = 1 
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_personalAttribute]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_personalAttribute]
@id_attribute int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type],ca.value, ca.isEnabled, ca.createdBy, ca.createdDate
	from CategorieAttributes ca
	where ca.id_attribute = @id_attribute
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_personalAttributes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_personalAttributes] 
@categorie_id int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type],ca.value, ca.isEnabled, ca.createdBy, ca.createdDate
	from CategorieAttributes ca
	where ca.categorie_id = @categorie_id and ca.isGeneral = 0
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_process]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_process] 
@id_process bigint as
begin
	select pm2.id_ProcessManagment, pm2.name, pm2.createdBy, pm2.createdDate, pm2.categorie_id, p.completedPorcentage, p.template_id, p.state_id, 
	p.nextProcess, p.previousProcess, report.completedTasks, report.totalTasks,
	ps.state_name, ps.state_color, (select c. name from Categories c where c.id_categorie = pm2.categorie_id) as categorie_name, 
	(select t.name from ProcessManagment t where t.id_processManagment = p.template_id) as template_name
	from (select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id from ProcessManagment pm where pm.isProcess = 1 and pm.id_processManagment = @id_process)pm2
	inner join Process p on p.processManagment_id = pm2.id_ProcessManagment
	inner join ProcessState ps on ps.id_processState = p.state_id
	inner join (
	select pm.id_processManagment, sum(case when t.completedDate <> '' then 1 else 0 end) as completedTasks, count(t.id_task) as totalTasks from ProcessManagment pm	
	left outer join Stage s on s.processManagment_id = pm.id_processManagment 
	left outer join Task t on t.stage_id = s.id_stage
	where pm.isProcess = 1  and pm.id_processManagment = @id_process
	group by pm.id_processManagment )report on report.id_processManagment = pm2.id_processManagment 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_process_participants]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_process_participants] 
@id_processManagment bigint as 
begin 
	select part.processManagment_id, part.[user_id], u.name, u.sLastName, u.fLastName, u.userName, u.email,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from (select pp.processManagment_id, pp.[user_id] 	from Process_Participants pp where pp.processManagment_id = @id_processManagment) part 
	inner join Users u on part.[user_id] = u.id_user
	where u.isEnabled = 1
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_process_stage]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_process_stage] 
@id_stage bigint as
begin 
	select s.id_stage, s.name, s.processManagment_id, s.stagePosition, s.createdBy, s.createdDate, s.isCompleted, s.startDate, s.completedDate,
	(select p.isProcess from ProcessManagment p where p.id_processManagment = s.processManagment_id) as isProcess
	from Stage s where  s.id_stage = @id_stage
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_process_stages]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_process_stages]
@id_processManagment bigint as
begin 
	select s.id_stage, s.name, s.processManagment_id, s.stagePosition, s.createdBy, s.createdDate, s.isCompleted, s.startDate, s.completedDate,
	(select p.isProcess from ProcessManagment p where p.id_processManagment = s.processManagment_id) as isProcess
	from Stage s where  s.processManagment_id = @id_processManagment
	order by s.stagePosition
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_process_task]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_process_task]
@id_task bigint as
begin 
	select t.id_task, t.stage_id, t.name, t.[description], t.[type_id], t.taskState_id, t.completedDate, t.createdBy, t.finishDate, t.taskPosition, t.createdDate, 
	t.beginDate, t.daysAvailable, t.hoursAvailable,
	(select pm.isProcess from ProcessManagment pm where pm.id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = t.stage_id)) as isProcess
	from Task t where t.id_task = @id_task
	order by t.taskPosition
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_process_tasks]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_process_tasks]
@id_stage bigint as
begin 
	select t.id_task, t.stage_id, t.name, t.[description], t.[type_id], t.taskState_id, t.completedDate, t.createdBy, t.finishDate, t.taskPosition, t.createdDate, 
	t.beginDate, t.daysAvailable, t.hoursAvailable,
	(select pm.isProcess from ProcessManagment pm where pm.id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = @id_stage)) as isProcess
	from Task t where t.stage_id = @id_stage
	order by t.taskPosition
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_processes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_processes] as
begin
	select pm2.id_ProcessManagment, pm2.name, pm2.createdBy, pm2.createdDate, pm2.categorie_id, p.completedPorcentage, p.template_id, p.state_id,
	p.nextProcess, p.previousProcess, report.completedTasks, report.totalTasks,
	ps.state_name, ps.state_color, (select c. name from Categories c where c.id_categorie = pm2.categorie_id) as categorie_name, 
	(select t.name from ProcessManagment t where t.id_processManagment = p.template_id) as template_name
	from (select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id from ProcessManagment pm where pm.isProcess = 1)pm2
	inner join Process p on p.processManagment_id = pm2.id_ProcessManagment
	inner join ProcessState ps on ps.id_processState = p.state_id
	inner join (
	select pm.id_processManagment, sum(case when t.completedDate <> '' then 1 else 0 end) as completedTasks, count(t.id_task) as totalTasks from ProcessManagment pm	
	left outer join Stage s on s.processManagment_id = pm.id_processManagment 
	left outer join Task t on t.stage_id = s.id_stage
	where pm.isProcess = 1 
	group by pm.id_processManagment )report on report.id_processManagment = pm2.id_processManagment 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_processesStates]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_processesStates] as
begin 
	select ps.id_processState, ps.state_color, ps.state_name from ProcessState ps 
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_provinces]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_provinces] as
begin
	select id_province, name from Provinces;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_questionAnswers]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_questionAnswers]
@id_taskForm bigint, @user_id int as
begin
	select fq.question, fq.questionPosition, fq.questionType_id, (select qt.name from QuestionType qt where qt.id_questionType = fq.questionType_id) as questionType_name, 
	qr.taskQuestion_id, qr.response, qr.[user_id]
	from FormQuestions fq inner join QuestionResponse qr  on qr.taskQuestion_id = fq.id_taskQuestion inner join TaskForm tf on tf.id_taskForm = fq.taskForm_id
	inner join Users u on u.id_user = qr.[user_id]
	where tf.id_taskForm = @id_taskForm and qr.[user_id] = @user_id
	order by fq.questionPosition
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_questionTypes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_questionTypes] as
begin 
	select qt.id_questionType, qt.name from QuestionType qt 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_role]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_role]
@id_role int as
begin
	select id_role, name, [description] from Roles  where id_role = @id_role
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_rolePermissions_byModule]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_rolePermissions_byModule]
@role_id int, @id_module int as
begin
	select per.id_permission, per.name, per.module_id, rp.isEnabled, rp.id_role_permission
	from Permissions per inner join Roles_Permissions rp on per.id_permission = rp.permission_id
	where per.module_id = @id_module and rp.role_id = @role_id
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_roles]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_roles]
as
begin
	select r.id_role, r.name, r.[description], sum(case rp.isEnabled when 1 then 1 else 0 end) as [permissions]
	from Roles r left outer join Roles_Permissions rp on r.id_role = rp.role_id
	group by r.id_role, r.name, r.[description]
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_scriptsLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_scriptsLog] as
begin 
	select sl.id_scriptLog, sl.ejecutedDate, sl.ejecutedBy, sl.script, u.name, u.fLastName, u.sLastName
	from ScriptsLog sl inner join Users u on u.id_user = sl.ejecutedBy
	order by sl.ejecutedDate desc
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_TaskChanges]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_TaskChanges] 
@id_task bigint as 
begin 
	select tc.id_taskChange, tc.task_id, tc.attribute_id, tc.operation_id, tc.value, tc.attributeList_id, 
	(select ca.[type] from CategorieAttributes ca where ca.id_attribute = tc.attribute_id) as attribute_type,
	(select al.[type_id] from AttributeList al where al.id_attributeValue = tc.attributeList_id) as attributeList_type
	from TaskChanges tc
	where tc.task_id = @id_task
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_taskFiles]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_taskFiles]
@id_task nvarchar(50)
as
begin
	select tf.name,tf.createdDate,tf.[description],tf.id_taskFile,tf.fileType, tf.[fileName], tf.task_id, CONVERT(varbinary(max),tf.fileData) as fileData 
	from TaskFiles tf 
	where tf.task_id = @id_task
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_taskNotifications]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_taskNotifications]
@id_task bigint as
begin
	select n.id_Notification, n.[message], n.task_id, n.isStarting, 
	CASE WHEN EXISTS (select * from Notifications_Types nt where notification_id = n.id_notification and nt.[type_id] = '2')
       THEN 'True' 
       ELSE 'False'
	END AS isTelegram,
	CASE WHEN EXISTS (select * from Notifications_Types nt where notification_id = n.id_notification and nt.[type_id] = '1')
       THEN 'True' 
       ELSE 'False'
	END AS isEmail,
	CASE WHEN EXISTS (select * from Notifications_Types nt where notification_id = n.id_notification and nt.[type_id] = '0')
       THEN 'True' 
       ELSE 'False'
	END AS isIntern
	from Notifications n 
	where n.task_id = @id_task
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_taskNotificationUser]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_taskNotificationUser]
@id_notification int as 
begin
	select part.notification_id, part.[user_id], u.name, u.sLastName, u.fLastName, u.userName, u.email, u.telegram_id,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from (select nu.[user_id], nu.notification_id from Notifications_Users nu where nu.notification_id = @id_notification)part 
	inner join Users u on part.[user_id] = u.id_user
	where u.isEnabled = 1
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_taskState]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_taskState] 
@id_taskState int as 
begin 
	select ts.id_taskState, state_name, state_color, state_sColor
	from taskState ts
	where ts.id_taskState = @id_taskState
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_taskStates]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_taskStates] as 
begin 
	select ts.id_taskState, state_name, state_color, state_sColor
	from taskState ts
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_taskTargets]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_taskTargets]
@task_id bigint as
begin
	select part.task_id, part.[user_id],  part.isConfirmed, u.name, u.sLastName, u.fLastName, u.userName, u.email,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from (select tt.task_id, tt.[user_id], tt.isConfirmed from Task_Targets tt where tt.task_id = @task_id) part 
	inner join Users u on part.[user_id] = u.id_user
	where u.isEnabled = 1
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_taskType]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_taskType]
@id_taskType tinyint as
begin 
	select tt.id_taskType, tt.taskName, tt.needConfirm, tt.formNeeded
	from TaskType tt
	where tt.id_taskType = @id_taskType 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_taskTypes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_taskTypes] as
begin 
	select tt.id_taskType, tt.taskName, tt.needConfirm, tt.formNeeded
	from TaskType tt 
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_template]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_template] 
@id_template bigint as
begin 
	select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id, c.name as categorie_name
	from ProcessManagment pm inner join Categories c on pm.categorie_id = c.id_categorie
	where pm.id_processManagment = @id_template and pm.isProcess = 0
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_get_templates]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_templates] as
begin
	select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id, c.name as categorie_name
	from ProcessManagment pm inner join Categories c on pm.categorie_id = c.id_categorie
	where pm.isProcess = 0 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_templatesbyCategorie]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_templatesbyCategorie] 
@categorie_id int as 
begin
	select pm.id_ProcessManagment, pm.name 
	from ProcessManagment pm 
	where pm.isProcess = 0 and pm.categorie_id = @categorie_id
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_user]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_user] 
@user nvarchar(50) as
begin
	begin 
		select u.id_user, u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
		u.direction, convert(nvarchar, u.birthdate, 103) as birthdate, u.[password], u.telegram_id, u.telegram_user, 
		(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
		(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
		(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id,
		(select up.photoData from UsersPhotos up where up.[user_id] = u.id_user) as photoData
		from Users u 
		where u.isEnabled = 1 and (u.userName = @user or u.email = @user) ;
	end
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_user_byID]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_user_byID] 
@user_id nvarchar(50) as
begin
	begin 
		select u.id_user, u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
		u.direction, convert(nvarchar, u.birthdate, 103) as birthdate, u.[password], u.telegram_id, u.telegram_user, 
		(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
		(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
		(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id,
		(select up.photoData from UsersPhotos up where up.[user_id] = u.id_user) as photoData
		from Users u 
		where u.isEnabled = 1 and (u.id_user = @user_id) ;
	end
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_userActivity]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userActivity]
@user_id int as 
begin 
	select tt.[user_id], tt.task_id, tt.isConfirmed, tt.confirm_date, t.name as task_name,
	s.name as stage_name, s.id_stage as stage_id, pm.id_processManagment as process_id, pm.name as process_name, 1 as isConfirmation
	from Task_Targets tt inner join Task t on t.id_task = tt.task_id inner join Stage s on s.id_stage = t.stage_id inner join ProcessManagment pm on pm.id_processManagment = s.processManagment_id
	where tt.[user_id] = 75 and isConfirmed = 1
	union
	select fu.[user_id], t.id_task as task_id, fu.isAnswered as isConfirmed, fu.answered_date as confirmed_date, t.name as task_name, 
	s.name as stage_name, s.id_stage as stage_id, pm.id_processManagment as process_id, pm.name as process_name, 0 as isConfirmation
	from Form_Users fu inner join TaskForm tf on tf.id_taskForm = fu.taskForm_id inner join Task t on t.id_task = tf.task_id inner join Stage s on s.id_stage = t.stage_id inner join ProcessManagment pm on pm.id_processManagment = s.processManagment_id
	where fu.[user_id] = 75 and fu.isAnswered = 1
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_userAttributes_byCategorie]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userAttributes_byCategorie]
@id_user int, @id_categorie int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type],ca.value as defaultValue, ca.isEnabled, ca.createdBy, ca.createdDate, pa.value
	from CategorieAttributes ca inner join 
	(select pa.attribute_id, pa.[user_id], pa.value from PersonalAttributes pa where pa.[user_id] = @id_user)pa
	on pa.attribute_id = ca.id_attribute
	where ca.categorie_id = @id_categorie and ca.isEnabled = 1
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_userCategories]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userCategories]
@id_user int as
begin 
	select c.id_categorie, c.name, c.[description], c.isEnabled
	from CategorieAttributes ca inner join 
	(select pa.attribute_id, pa.[user_id], pa.value from PersonalAttributes pa where pa.[user_id] = @id_user)pa
	on pa.attribute_id = ca.id_attribute
	inner join Categories c on c.id_categorie = ca.categorie_id
	where c.isEnabled = 1
	group by c.id_categorie, c.name, c.[description], c.isEnabled
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_userElements]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userElements]
@user_id int, @isEnabled int as
begin 
	select distinct e.id_element, e.name, (select type from ElementTypes et where et.id_elementType = e.[type_id]) as [type]
	from Users_Roles ur inner join Roles_Permissions rp on rp.role_id = ur.role_id
	inner join Roles_Permissions_Elements rpe on rp.id_role_permission= rpe.role_permission_id
	left outer join Elements e on e.id_element = rpe.element_id
	where ur.[user_id] = @user_id and rpe.isEnabled = @isEnabled
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_userFiles]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userFiles]
@user nvarchar(50)
as
begin
	declare @id int;
	set @id = (select [id_user] from Users where email = @user or userName = @user);
	select uf.name,uf.createdDate,uf.[description],uf.id_file,uf.fileType, uf.[fileName], CONVERT(varbinary(max),uf.fileData) as fileData from UsersFiles uf where uf.[user_id] = @id
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_userProcess]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userProcess]
@user_id int as
begin 
	select pm2.id_ProcessManagment, pm2.name, pm2.createdBy, pm2.createdDate, pm2.categorie_id, p.completedPorcentage, p.template_id, p.state_id,
	p.nextProcess, p.previousProcess, report.completedTasks, report.totalTasks,
	ps.state_name, ps.state_color, (select c. name from Categories c where c.id_categorie = pm2.categorie_id) as categorie_name, 
	(select t.name from ProcessManagment t where t.id_processManagment = p.template_id) as template_name
	from 
	(select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id 
	from ProcessManagment pm inner join Process_Participants pp on pp.processManagment_id = pm.id_processManagment 
	where pm.isProcess = 1 and pp.[user_id] = @user_id )pm2
	inner join Process p on p.processManagment_id = pm2.id_ProcessManagment
	inner join ProcessState ps on ps.id_processState = p.state_id
	inner join (
	select pm.id_processManagment, sum(case when t.completedDate <> '' then 1 else 0 end) as completedTasks, count(t.id_task) as totalTasks from ProcessManagment pm	
	left outer join Stage s on s.processManagment_id = pm.id_processManagment 
	left outer join Task t on t.stage_id = s.id_stage
	where pm.isProcess = 1 
	group by pm.id_processManagment )report on report.id_processManagment = pm2.id_processManagment 
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_userRoles]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userRoles]
@user_id int
as
begin 
	select r.id_role, r.name, r.[description], ur.[user_id] from Roles r inner join Users_Roles ur on r.id_role = ur.role_id 
	where ur.[user_id] = @user_id
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_Users]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_Users] as
begin
	select u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
	u.direction, u.birthdate, u.[password], u.id_user , u.[password], u.telegram_id, u.telegram_user, 
	(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
	(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
	(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from Users u 
	where u.isEnabled = 1
	order by u.name
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_usersAnsweredForm]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_usersAnsweredForm] 
@id_taskForm bigint as
begin 
	select qr.[user_id], u.name, u.fLastName, u.sLastName, u.email
	from FormQuestions fq inner join QuestionResponse qr  on qr.taskQuestion_id = fq.id_taskQuestion inner join TaskForm tf on tf.id_taskForm = fq.taskForm_id
	inner join Users u on u.id_user = qr.[user_id]
	where tf.id_taskForm = @id_taskForm
	group by qr.[user_id], u.name, u.fLastName, u.sLastName, u.email
end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_userTasks]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userTasks]
@user_id int as 
begin 
	select t.id_task, t.stage_id, t.name, t.[description], t.[type_id], t.stage_id, t.taskState_id, t.createdBy, t.finishDate, t.taskPosition, t.createdDate, 
	t.beginDate, t.daysAvailable, t.hoursAvailable, tt.[user_id],
	(select pm.name from ProcessManagment pm where pm.id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = t.stage_id)) as process_name
	from Task_Targets tt inner join Task t on t.id_task = tt.task_id
	where tt.[user_id] = @user_id and tt.isConfirmed = 0 and (t.taskState_id = 1 or t.taskState_id = 0) and 
	(select pm.isProcess from ProcessManagment pm where pm.id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = t.stage_id)) = 1 
	union
	select t.id_task, t.stage_id, t.name, t.[description], t.[type_id], t.stage_id, t.taskState_id, t.createdBy, t.finishDate, t.taskPosition, t.createdDate, 
	t.beginDate, t.daysAvailable, t.hoursAvailable, fu.[user_id],
	(select pm.name from ProcessManagment pm where pm.id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = t.stage_id)) as process_name
	from Form_Users fu inner join Task t on fu.taskForm_id = (select tf.id_taskForm from TaskForm tf where tf.task_id = t.id_task)
	where fu.[user_id] = @user_id and fu.isAnswered = 0 and (t.taskState_id = 1 or t.taskState_id = 0) and 
	(select pm.isProcess from ProcessManagment pm where pm.id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = t.stage_id)) = 1 
	order by t.taskState_id desc, finishDate desc
end
GO
/****** Object:  StoredProcedure [dbo].[usp_getQuestionChanges]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_getQuestionChanges]
@id_taskQuestion bigint as 
begin 
	select qc2.taskQuestion_id, qc2.taskChange_id, tc.task_id, tc.id_attribute, tc.operation_id, tc.value from (select qc.taskQuestion_id, qc.taskChange_id from QuestionChanges qc
	where qc.taskQuestion_id = @id_taskQuestion) qc2
	inner join TaskChanges tc on tc.id_taskChange = qc2.taskChange_id
end

GO
/****** Object:  StoredProcedure [dbo].[usp_getTaskForm]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_getTaskForm]
@id_taskForm bigint as
begin
	select tf.id_taskForm, tf.[description], tf.task_id
	from TaskForm tf 
	where tf.id_taskForm = @id_taskForm
end

GO
/****** Object:  StoredProcedure [dbo].[usp_getTaskFormbyTask]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_getTaskFormbyTask]
@id_task bigint as
begin
	select tf.id_taskForm, tf.[description], tf.task_id
	from TaskForm tf 
	where tf.task_id = @id_task
end

GO
/****** Object:  StoredProcedure [dbo].[usp_getTaskQuestion]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_getTaskQuestion]
@id_taskQuestion bigint as
begin
	select fq.id_TaskQuestion, fq.taskForm_id, fq.question, fq.generalAttributeList, fq.questionType_id, fq.questionPosition, fq.isRequired
	from FormQuestions fq 
	where fq.id_taskQuestion = @id_taskQuestion
end

GO
/****** Object:  StoredProcedure [dbo].[usp_getTaskQuestions]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_getTaskQuestions]
@taskForm_id bigint as
begin
	select fq.id_taskQuestion, fq.taskForm_id, fq.question, fq.generalAttributeList, fq.questionType_id,fq.questionPosition, fq.isRequired
	from FormQuestions fq 
	where fq.taskForm_id = @taskForm_id
	order by fq.questionPosition
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_AttributeList]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_AttributeList]
@attribute_id bigint, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @createdBy int, @userLog int as
begin
begin transaction;
	declare @table int, @event_log_id int, @id_attributeValue int
	insert into AttributeList(attribute_id, name, [type_id], value, isEnabled, createdBy, createdDate) 
	values (@attribute_id, @name, @type_id, @value, 1, @createdBy, GETDATE());

	set @id_attributeValue = (SCOPE_IDENTITY())
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'AttributeList')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted new attribute list', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'attribute_id', @value = @attribute_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_attributeValue', @value = @id_attributeValue, @EventLog_id = @event_log_id
commit transaction;
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_categorie]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_categorie]
@name nvarchar(30), @description nvarchar(100), @createdBy_name nvarchar(80), @createdBy_id int as
begin
	insert into Categories (name, [description], createdBy_name, createdBy_id, createdDate, isEnabled)
	values (@name, @description, @createdBy_name, @createdBy_id, GETDATE(), 1)
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_element]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_element]
@name nvarchar(50), @type_id tinyint, @permission_id int
as
begin
	insert into Elements(name, type_id,permission_id)
	values (@name, @type_id, @permission_id)
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_EventLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_EventLog]
@description nvarchar(50), @objectLog_id bigint, @eventTypeLog_id bigint, @eventSource_id int, @user int as 
begin
	insert into EventLog(description, objectLog_id, eventTypeLog_id, eventSourceLog_id, postTime, computer, [user], CHKsum)
	values (@description, @objectLog_id, @eventTypeLog_id, @eventSource_id, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), @user,0);
	return SCOPE_IDENTITY()
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_EventSourceLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_EventSourceLog]
@name nvarchar(30) as 
begin
	insert into EventSourceLog(sourceName, postTime, computer, userName, CHKsum)
	values (@name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_EventTypeLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_EventTypeLog]
@name nvarchar(30) as 
begin
	insert into EventTypeLog(name, postTime, computer, userName, CHKsum)
	values (@name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_form]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_form]
@id_task bigint, @description nvarchar(300), @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int, @id_taskForm bigint
	insert into TaskForm (task_id, [description])
	values (@id_task, @description)
	set @id_taskForm = (select @@IDENTITY)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'TaskForm')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted form', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_task', @value = @id_task, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_taskForm', @value = @id_taskForm, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'description', @value = @description, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_formUser]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_formUser]
@taskForm_id bigint, @user_id nvarchar(300), @userLog int as 
begin
declare @event_log_id int, @table int, @id_taskForm bigint
set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Form_Users')
set transaction isolation level snapshot
begin transaction
	insert into Form_Users ([user_id],taskForm_id, isAnswered)
	values (@user_id, @taskForm_id,0)
	exec @event_log_id = usp_insert_EventLog @description = 'inserted form user', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	select '1'
commit transaction
--end try
--begin catch
--	declare @errorMessage nvarchar(max) = (SELECT ERROR_MESSAGE() AS ErrorMessage);  
--	exec @event_log_id = usp_insert_EventLog @description = @errorMessage, @objectLog_id = @table, @eventTypeLog_id = 2, @eventSource_id = 1, @user = @userLog;
--	rollback transaction
--	select '0'
--end catch
exec usp_insert_Reference @attribute = 'taskForm_id', @value = @taskForm_id, @EventLog_id = @event_log_id
exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_generalAttribute]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_generalAttribute]
@categorie_id int, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @createdBy int, @pUser int as
begin
begin transaction;
	declare @table int, @event_log_id int, @id_attribute int
	insert into CategorieAttributes (categorie_id, name, [type], value, isEnabled, createdBy, createdDate, isGeneral) 
	values (@categorie_id, @name, @type_id, @value, 1, @createdBy, GETDATE(), 1);
	set @id_attribute = (SCOPE_IDENTITY())
	insert into GeneralAttributes (attribute_id) values (@id_attribute)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'CategorieAttributes')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted new general attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @pUser;
	exec usp_insert_Reference @attribute = 'categorie_id', @value = @categorie_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isGeneral', @value = '1', @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_attribute', @value = @id_attribute, @EventLog_id = @event_log_id
commit transaction;
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_group]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_group]
@groupName nvarchar(50)
as
begin
	insert into Groups(groupName, createdDate, isEnabled)
	values (@groupName, GETDATE(), 1)
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_grouptaskTargets]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[usp_insert_grouptaskTargets]
@task_id bigint, @group_id int, @userLog int as
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int

	declare cursor_users cursor
	for select gu.[user_id] from Group_Users gu where gu.group_id = @group_id 
	declare @user_id nvarchar(30);
	open cursor_users
	fetch next from cursor_users into @user_id
	while @@FETCH_STATUS = 0 
	begin 
		if exists(select 1 from Process_Participants pp where pp.processManagment_id = 
		(select s.processManagment_id from (select t.stage_id from Task t where t.id_task = @task_id)t2 left outer join Stage s on s.id_stage = t2.stage_id) and pp.[user_id] = @user_id)
		begin 
			insert into Task_Targets(task_id , [user_id], isConfirmed)
			values (@task_id, @user_id, 0)

			set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task_Targets')
			exec @event_log_id = usp_insert_EventLog @description = 'inserted responsable through group', 
			@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
			exec usp_insert_Reference @attribute = 'id_task', @value = @task_id, @EventLog_id = @event_log_id
			exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
		end
		fetch next from cursor_users into @user_id
	end
	close cursor_users
	deallocate cursor_users
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[usp_insert_groupUser]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_groupUser] 
@user_id int, @group_id int as
begin
begin transaction 
		insert into Group_Users ([user_id], group_id)
		values (@user_id, @group_id)
commit transaction 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_module]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_module]
@id_module tinyint, @name nvarchar(50)
as
begin
	insert into Modules(id_module, name)
	values (@id_module, @name)
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_ObjectLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_ObjectLog]
@table_name nvarchar(30) as 
begin
	insert into ObjectLog(name, postTime, computer, userName, CHKsum)
	values (@table_name, GETDATE(),CAST(CONNECTIONPROPERTY('client_net_address')  AS nvarchar(30)), SYSTEM_USER,0);
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_permission]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_permission]
@id_permission int, @name nvarchar(50), @module_id tinyint 
as
begin
	insert into Permissions(id_permission, name, module_id)
	values (@id_permission, @name, @module_id)
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_personalAttribute]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_personalAttribute]
@categorie_id int, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @createdBy int, @userLog int as
begin
begin transaction;
	declare @table int, @event_log_id int, @id_attribute int
	insert into CategorieAttributes (categorie_id, name, [type], value, isEnabled, createdBy, createdDate, isGeneral) 
	values (@categorie_id, @name, @type_id, @value, 1, @createdBy, GETDATE(), 0);
	set @id_attribute = (SCOPE_IDENTITY())
	-- insert attribute for every user
	declare cursor_users cursor
	for select u.id_user from Users u
	declare @user_id nvarchar(30);
	open cursor_users
	fetch next from cursor_users into @user_id
	while @@FETCH_STATUS = 0 
	begin 
		insert into PersonalAttributes(attribute_id, [user_id], value) values (@id_attribute, @user_id, @value)
		-- Log for every personal attribute
		set @table = (select objectLog_id from ObjectLog ol where ol.name = 'PersonalAttributes')
		exec @event_log_id = usp_insert_EventLog @description = 'inserted new personal attribute', 
		@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
		exec usp_insert_Reference @attribute = 'attribute_id', @value = @id_attribute, @EventLog_id = @event_log_id
		exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
		exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
		fetch next from cursor_users into @user_id
	end
	close cursor_users
	deallocate cursor_users
	
	-- Log for categorie attribute
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'CategorieAttributes')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted new personal attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'categorie_id', @value = @categorie_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isGeneral', @value = '0', @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_attribute', @value = @id_attribute, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction;
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_process]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_process] 
@name nvarchar(100), @categorie_id int = null, @template_id bigint, @previousProcess bigint = null, @userLog int as
begin
begin transaction
begin try 
	declare @processManagment_id  int, @event_log_id int, @table int
	insert into ProcessManagment (name, createdBy, createdDate, categorie_id, isProcess)
	values (@name, @userLog, GETDATE(), @categorie_id,1)
	set @processManagment_id = (SCOPE_IDENTITY())
	insert into Process(processManagment_id, template_id, state_id, completedPorcentage, previousProcess) values (@processManagment_id, @template_id, 1, 0, @previousProcess)
	if (@template_id is not null)
	begin 
		-- Participants
		insert into Process_Participants(processManagment_id, [user_id]) 
		select @processManagment_id, pp.[user_id] from Process_Participants pp where pp.processManagment_id = @template_id
		if NOT EXISTS (select * from Process_Participants pp where pp.processManagment_id = @processManagment_id and pp.[user_id] = @userLog)
		   begin
				insert into Process_Participants(processManagment_id, [user_id]) 
				values (@processManagment_id, @userLog)
		   end
		-- stages 
		declare cursor_stages cursor forward_only fast_forward
		for select s.name, @processManagment_id, s.stagePosition, s.id_stage from Stage s where s.processManagment_id = @template_id order by s.stagePosition
		declare @stage_name nvarchar(100), @stage_processManagment_id bigint, @stage_stagePosition int, @stage_id bigint, @oldStage_id bigint;
		declare @isFirstTask bit = 0, @isFirstStage bit = 0
		declare @lastFinishDate datetime = GETDATE(), @lastStartDate datetime 
		open cursor_stages
		fetch next from cursor_stages into @stage_name, @stage_processManagment_id, @stage_stagePosition, @oldStage_id
		while @@FETCH_STATUS = 0 
		begin
			if (@isFirstStage = 0)
			begin
			insert into Stage(name, processManagment_id, stagePosition, createdBy, createdDate, startDate) values (@stage_name, @stage_processManagment_id, @stage_stagePosition, @userLog, GETDATE(), GETDATE())
			set @isFirstStage = 1
			end
			else
			begin 
			insert into Stage(name, processManagment_id, stagePosition, createdBy, createdDate) values (@stage_name, @stage_processManagment_id, @stage_stagePosition, @userLog, GETDATE())
			end

			set @stage_id = (select SCOPE_IDENTITY())
			------ Tasks
			declare cursor_tasks cursor forward_only fast_forward
			for select t.id_task, t.name, t.[description], t.[type_id], t.taskState_id, t.taskPosition, t.daysAvailable, t.hoursAvailable 
			from Task t where t.stage_id = @oldStage_id order by t.taskPosition
			declare @task_name nvarchar(100), @old_task_id bigint, @task_description nvarchar(150), @task_type_id int, @taskState_id int, @taskPosition int, @task_daysAvailable int, @task_hoursAvailable int;
			open cursor_tasks
			fetch next from cursor_tasks into @old_task_id, @task_name, @task_description, @task_type_id, @taskState_id, @taskPosition, @task_daysAvailable, @task_hoursAvailable
			while @@FETCH_STATUS = 0 
			begin
				declare @id_task bigint, @id_taskForm bigint
				set @lastStartDate = @lastFinishDate
				set @lastFinishDate = DATEADD(hour, @task_hoursAvailable, (DATEADD(day, @task_daysAvailable, @lastFinishDate)));
				if (@isFirstTask = 0)
				begin
				insert into Task (stage_id, name, [description], [type_id], taskState_id, completedDate, createdBy, finishDate, taskPosition, createdDate, beginDate, daysAvailable, hoursAvailable)
				values (@stage_id, @task_name, @task_description, @task_type_id, 1, null, @userLog, @lastFinishDate, @taskPosition, GETDATE(), @lastStartDate, @task_daysAvailable, @task_hoursAvailable) 
				set @isFirstTask = 1
				end
				else
				begin
				insert into Task (stage_id, name, [description], [type_id], taskState_id, completedDate, createdBy, finishDate, taskPosition, createdDate, beginDate, daysAvailable, hoursAvailable)
				values (@stage_id, @task_name, @task_description, @task_type_id, 0, null, @userLog, @lastFinishDate, @taskPosition, GETDATE(), @lastStartDate, @task_daysAvailable, @task_hoursAvailable) 
				end
				set @id_task = (SCOPE_IDENTITY())
				-- Task Targets
				insert into Task_Targets ([user_id],task_id) select tt.[user_id], @id_task from Task_Targets tt where task_id = @old_task_id
				-- Task Form
				declare @old_taskForm_id bigint = (select tf.id_taskForm from TaskForm tf where tf.task_id = @old_task_id)
				insert into TaskForm (task_id, [description]) values (@id_task, (select tf.[description] from TaskForm tf where tf.task_id = @old_task_id))
				set @id_taskForm = (SCOPE_IDENTITY())
				insert into FormQuestions(taskForm_id, question, generalAttributeList, questionType_id, questionPosition, isRequired) 
				select @id_taskForm, fq.question, fq.generalAttributeList, fq.questionType_id, fq.questionPosition, fq.isRequired from FormQuestions fq where fq.taskForm_id = @old_taskForm_id
				--Task
				fetch next from cursor_tasks into @old_task_id, @task_name, @task_description, @task_type_id, @taskState_id, @taskPosition, @task_daysAvailable, @task_hoursAvailable
			end
			close cursor_tasks
			deallocate cursor_tasks
		fetch next from cursor_stages into @stage_name, @stage_processManagment_id, @stage_stagePosition, @oldStage_id
		end
		close cursor_stages
		deallocate cursor_stages
	end
commit transaction 
	select @processManagment_id
end try
begin catch
	rollback transaction;
	select -1
end catch
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_process_participant]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_process_participant]
@id_processManagment bigint, @user_id int, @userLog int as
begin
begin transaction
	declare @event_log_id int, @table int
	insert into Process_Participants (processManagment_id, [user_id])
	values (@id_processManagment, @user_id)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Process_Participants')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted participant', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_template', @value = @id_processManagment, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_processGroup]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_processGroup]
@id_processManagment bigint, @group_id int, @userLog int as
begin
begin transaction
	declare @event_log_id int, @table int

	declare cursor_users cursor
	for select gu.[user_id] from Group_Users gu where gu.group_id = @group_id 
	declare @user_id nvarchar(30);
	open cursor_users
	fetch next from cursor_users into @user_id
	while @@FETCH_STATUS = 0 
	begin 
		insert into Process_Participants (processManagment_id, [user_id])
		values (@id_processManagment, @user_id)

		set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Process_Participants')
		exec @event_log_id = usp_insert_EventLog @description = 'inserted participant', 
		@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
		exec usp_insert_Reference @attribute = 'id_template', @value = @id_processManagment, @EventLog_id = @event_log_id
		exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id

		fetch next from cursor_users into @user_id
	end
	close cursor_users
	deallocate cursor_users
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_question]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_question]
@taskForm_id bigint, @question nvarchar(250), @generalAttributeList int = null, @questionType_id int, @userLog int, @questionPosition int, @isRequired bit as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int, @id_taskQuestion int
	insert into FormQuestions(taskForm_id,question, generalAttributeList, questionType_id, questionPosition, isRequired)
	values (@taskForm_id, @question, @generalAttributeList, @questionType_id,@questionPosition, @isRequired)
	set @id_taskQuestion = (select @@IDENTITY)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'FormQuestions')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted question', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_taskQuestion', @value = @id_taskQuestion, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_taskForm', @value = @taskForm_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'question', @value = @question, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'generalAttributeList', @value = @generalAttributeList, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_questionType', @value = @generalAttributeList, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'questionPosition', @value = @questionPosition, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_questionAnswer]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_questionAnswer] 
@taskQuestion_id bigint, @user_id int, @response varbinary(MAX), @userLog int as
begin
	set transaction isolation level snapshot
	begin transaction
	declare @event_log_id int, @table int, @id_taskChange bigint
	insert into QuestionResponse(taskQuestion_id, [user_id], response)
	values (@taskQuestion_id, @user_id, @response)
	set @id_taskChange = (select @@IDENTITY)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'QuestionResponse')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted question answer', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'taskQuestion_id', @value = @taskQuestion_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_Reference]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_Reference]
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

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_role]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_role]
@name nvarchar(30), @description nvarchar(50) = null as
begin
	insert into Roles(name,[description])
	values (@name, @description);

	insert into Roles_Permissions
	select (SELECT TOP 1 id_role FROM Roles ORDER BY id_role DESC), per.id_permission, 0 from Permissions per 
	-- Copy the avaible elements
	insert into Roles_Permissions_Elements
	select rp.id_role_permission, ele.id_element, 0 as isEnabled 
	from Elements ele inner join Roles_Permissions rp on rp.permission_id = ele.permission_id
	where (SELECT TOP 1 id_role FROM Roles ORDER BY id_role DESC) = rp.role_id
	SELECT TOP 1 id_role FROM Roles ORDER BY id_role DESC
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_scriptLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_scriptLog] 
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

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_stage]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_stage]
@name nvarchar(100), @processManagment_id bigint, @stagePosition int, @userLog int as
begin 
begin transaction 
	declare @id_stage int, @event_log_id int, @table int
	insert into Stage (name, processManagment_id, stagePosition, createdBy, createdDate, isCompleted)
	values (@name, @processManagment_id, @stagePosition, @userLog, GETDATE(), 0)
	set @id_stage = (SCOPE_IDENTITY())

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Stage')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted stage', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'processManagment_id', @value = @processManagment_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'stagePosition', @value = @stagePosition, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_stage', @value = @id_stage, @EventLog_id = @event_log_id
commit transaction 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_task]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_task]
@stage_id int, @name nvarchar(50), @description nvarchar(100), @type_id int, @userLog int, @taskPosition int, @finishDate date = null, @daysAvailable int = null, @hoursAvailable int = null as 
begin 
begin transaction 
	declare @id_task int, @event_log_id int, @table int
	insert into Task (stage_id, name, [description], [type_id], taskState_id, completedDate, createdBy, finishDate, taskPosition, createdDate, beginDate, daysAvailable, hoursAvailable)
	values (@stage_id, @name, @description, @type_id, 0, null, @userLog, @finishDate, @taskPosition, GETDATE(), null, @daysAvailable, @hoursAvailable)
	set @id_task = (SCOPE_IDENTITY())
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted task', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_task', @value = @id_task, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'stage_id', @value = @stage_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'description', @value = @description, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'finishDate', @value = @finishDate, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'taskPosition', @value = @taskPosition, @EventLog_id = @event_log_id
	select @id_task;
commit transaction 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_taskChange]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_taskChange]
@task_id bigint, @attribute_id bigint = null, @attributeList_id bigint = null, @operation_id int, @value nvarchar(50), @userLog int as
begin
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int, @id_taskChange bigint
	insert into TaskChanges(task_id, attribute_id, operation_id, value, attributeList_id)
	values (@task_id, @attribute_id, @operation_id, @value, @attributeList_id)
	set @id_taskChange = (select @@IDENTITY)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'TaskChanges')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted task change', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_task', @value = @task_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_taskChange', @value = @id_taskChange, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'attribute_id', @value = @attribute_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'operation_id', @value = @operation_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_taskFile]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_taskFile]
@id_task bigint, @fileData varbinary(MAX), @name nvarchar(30), @description nvarchar(50) = null, @fileType nvarchar(150), @fileName nvarchar(200), @userLog int
as
begin
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int, @id_taskFile bigint
	insert into TaskFiles(task_id,fileData, name, [description], createdDate, fileType, [fileName], createdBy) 
	values (@id_task, @fileData, @name, @description,GETDATE(), @fileType, @fileName, @userLog);
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

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_TaskNotification]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_TaskNotification]
@task_id bigint, @message nvarchar(1000), @isStarting bit, @isTelegram bit, @isIntern bit, @isEmail bit, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int, @id_notification int
	insert into Notifications ([message], task_id, isStarting) values (@message, @task_id, @isStarting)
	set @id_notification = (select @@IDENTITY)
	if @isTelegram = 1
	begin
		insert into Notifications_Types (notification_id, [type_id], isSended) values (@id_notification, 2, 0)
	end
	if @isIntern = 1
	begin
		insert into Notifications_Types (notification_id, [type_id], isSended) values (@id_notification, 0, 0)
	end
	if @isEmail = 1
	begin
		insert into Notifications_Types (notification_id, [type_id], isSended) values (@id_notification, 1, 0)
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

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_taskNotificationType]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_taskNotificationType]
@id_notification int, @id_notificationType int, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	insert into Notifications_Types (notification_id, [type_id], isSended) values ( @id_notification, @id_notificationType, 0)
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_taskNotificationUser]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_taskNotificationUser]
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

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_template]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_template]
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

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_typesElement]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_typesElement]
@id_elementType tinyint, @type nvarchar(50)
as
begin
	insert into ElementTypes(id_elementType, type)
	values (@id_elementType, @type)
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_user]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_user]
@userName nvarchar(50) = null, @name nvarchar(50), @fLastName nvarchar(50), @sLastName nvarchar(50) = null,
@email nvarchar(50), @phoneNumber nvarchar(50) = null, @canton_id tinyint = 1, @password nvarchar(50) = 'Password12',
@id numeric(9,0) = null, @birthdate nvarchar(20) = null, @direction nvarchar(50) = null
 as
begin
begin transaction
	declare @user_id int;
	insert into Users(userName, name, fLastName, sLastName, email, phoneNumber, canton_id, [password], createdDate, isEnabled, id,birthdate, direction)
	values (@userName, @name, @fLastName, @sLastName, @email, @phoneNumber, @canton_id, @password, GETDATE(), 1, @id, CONVERT(DATE, @birthdate, 103), @direction );
	set @user_id = (SCOPE_IDENTITY())
	execute usp_insert_userPhoto @user = @email, @photoData = 0xFFD8FFE000104A46494600010100000100010000FFDB0084000906070F0E0F0F0F0E0F0F0F0F0F0F0F0D0F0F0F0F0F100F0F0F1511161615111515181D2820181A251B151521312125292B2E2E2E171F3338332C37282D2E2B010A0A0A0D0D0D0F0D0D0F2B191F192B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2BFFC000110800E000E003012200021101031101FFC4001B00010100030101010000000000000000000001020405030607FFC400301001000200020804060105000000000000000102031104051221314151C13261719122427281A1E1D113526292F0FFC4001501010100000000000000000000000000000001FFC40014110100000000000000000000000000000000FFDA000C03010002110311003F00FD700540000000000000000000000000000000000000000000000000000000000141054000000000000000000000000000000001E3A4E935C38CEDC794739907ADAD1119CCC4447199E0D1C7D6958DD48DAF39DD0E6E93A4DB1273B4EEE558E10F106DE26B0C5B7CDB3F4C64F09C7BCF1BDFFDA5E628F48C7BC70BDFFDA5EF87AC316BF36D7D519B500763035A56775E367CE37C37AB6898CE26262784C707CCBDB46D26D8739D67773ACF0941F423C745D26B8919D78F38E712F60000000000000000000000000618F8D14ACDA7847E67A3E7F1F1A6F69B5B8CFB447486D6B5D236AFB31C29BBD6DCFF0086880028000000000F4C0C69A5A2D5E31ED31D25F41818D17AC5A384FE27A3E6DBDAAB1F66FB33C2FBBD2DC90764000000000000000000001863E26C56D6E9133F7E4CDA7ADAD96165D6D11DFB038B3280A0000000000000B13D1007D260626DD6B6EB113F7E6CDA7AA6D9E17A5A63BF76E200000000000000000003435CF82BF5F696FB4F5B573C29F2B44F6EE0E200A0000080A2280000003B1A9BC16FAFB437DA7AA6B961479DA67B766E2000000000000000000030C6C3DAADABD6261980F9998CB74F18DD28DFD6BA3ECDB6E385B8F959A0A00008202AB1505000588CF74719DD08DFD55A3ED5B6E7853879DBFEEC0EAE0E1ECD6B5E9110CC10000000000000000000000618D8517ACD6DC27F1E6E06918138769ADBED3CA63ABE89E5A4E05712B95BED3CE27C81F3A8D8D2B44B61CEFDF5E568E1FA6BA82000A802AA36345D12D893BB7579DA787EC18E8F813896D9AFDE79447577F070A2958AD7847E7CD8E8D815C3AE55FBCF399F37AA0000000000000000000000000225AD1119CCC447599CA1A38FAD291BAB1369EBC201BD319F1E6D1C7D5B4B6FACEC4FBD7D9A76D6789339C6CC47488DCD8C2D6B59F1D663CE37C035B1356E247088B7A4FF002F09D17123E4B7B4BB74D2F0EDC2F5FBCE53F97A45A39483811A2E24FC96F697BE1EADC49E3115F598ECEC6D473979DF4AC3AF1BD7ED39CFE01E181AB695DF69DB9F6AFB37A232DD1BA21CDC5D6B58F05667CE77435EBACF122739D998E931BBED903B6AE7E06B4A4EEB44D27AF186F56D1319C4C4C758DF00C8000000000000000000001A9A669D5C3DD1F15FA728F561AC74DD8F82BE2E73FDB1FCB8B320F4C7C7B624E769CFCB947A43C814115004001514054501EB818F6C39CEB3979729F5879283BBA1E9D5C4DD3F0DBA729F46DBE6225D9D5DA6EDFC16F14709FEE8FE506F00000000000000035F4DD27FA74CFE69DD58F3EAD870758E3EDE24E5C2BF0C77906B5A666739DF33BE67ACA08A008002008002A00C84505114156B6989898DD31BE27CD8A83E8342D27FA94CFE68DD68F3EAD87075763EC5E3A5BE19ED2EF20000000000000F0D3317630ED6E79651EB3BA1F3CEBEB9BE55AD7ACCCFB47EDC8040450040025004101558A8321160140050015F43A1E2EDE1D6DCF2CA7D6374BE79D7D4B7CEB6AF4989F78FD20E88000000002080E4EBA9F8A91FE333F9FD39CE86B9F1D7E9EF2E780812A202008480892B28042A2C02AA400C958A82AA400AE8EA59F8AF1FE313F9FDB9CE86A6F1DBE8EF083B0B0C5414200115004101C8D73E3AFD3DE5CF7435CF8EBF4F7973C040511255004910041015618A8328562A0AA8A0AA802BA1A9BC76FA7BC39EE86A6F1DBE9EF00EC2B154155007FFD9;

	insert into PersonalAttributes (attribute_id, value, [user_id]) 
	select ca.id_attribute, ca.value, @user_id from CategorieAttributes ca where ca.isGeneral = 0
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_userFile]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_userFile]
@user_id nvarchar(50), @fileData varbinary(MAX), @name nvarchar(30), @description nvarchar(50) = null, @fileType nvarchar(100), @fileName nvarchar(200)
as
begin
	insert into UsersFiles([user_id],fileData, name, [description], createdDate, fileType, [fileName]) 
	values (@user_id, @fileData, @name, @description,GETDATE(), @fileType, @fileName);
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_userImage]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_userImage]
@user_id int, @image_data varbinary(max)
as
begin
	insert into UsersPhotos([user_id], photoData)
	values (@user_id, @image_data);
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_userPhoto]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_userPhoto]
@user nvarchar(50), @photoData varbinary(MAX)
 as
begin
	declare @id int;
	set @id = (select [id_user] from Users where email = @user or userName = @user);
	insert into UsersPhotos([user_id],photoData) 
	values (@id, @photoData);
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_userRole]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_userRole]
@user_id int, @role_id int as
begin
	insert into Users_Roles([user_id],role_id)
	values (@user_id, @role_id)
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_usertaskTargets]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_usertaskTargets]
@task_id bigint, @user_id int, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	insert into Task_Targets ([user_id], task_id, isConfirmed, confirm_date)
	values (@user_id, @task_id, 0, GETDATE());

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task_Targets')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted responsable', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_task', @value = @task_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_jobUpdate_taskState]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_jobUpdate_taskState] as 
begin 
	update Task set taskState_id = 5
	where finishDate < GETDATE() and taskState_id = 1;
end
GO
/****** Object:  StoredProcedure [dbo].[usp_update_AttributeList]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_AttributeList]
@id_attributeValue bigint, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @isEnabled bit, @pUser int as
begin
begin transaction;
	update AttributeList set name = ISNULL(@name, name),
		[type_id] = ISNULL(@type_id, [type_id]),
		value = ISNULL(@value, value),
		isEnabled = ISNULL(@isEnabled, isEnabled)
		where id_attributeValue = @id_attributeValue

	declare @table int, @event_log_id int
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'AttributeList')
	exec @event_log_id = usp_insert_EventLog @description = 'updated attribute list', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @pUser;
	exec usp_insert_Reference @attribute = 'id_attributeValue', @value = @id_attributeValue, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isEnabled', @value = @isEnabled, @EventLog_id = @event_log_id
commit transaction;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_bifurcateProcess]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_bifurcateProcess]
@nextProcess bigint, @previousProcess bigint, @userLog int as
begin
	update Process set nextProcess = @nextProcess
	where processManagment_id = @previousProcess

	update Process set previousProcess = @previousProcess
	where processManagment_id = @nextProcess
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_categorie]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_categorie]
@id_categorie int, @name nvarchar(30) = null, @description nvarchar(100) = null, @isEnabled bit = null as
begin
	update Categories set name = ISNULL(@name, name),
	[description] = ISNULL(@description, [description]),
	isEnabled = ISNULL(@isEnabled, isEnabled)
	where id_categorie = @id_categorie
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_form]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_form]
@id_taskForm bigint, @description nvarchar(300), @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	update TaskForm set [description] = @description
	where id_taskForm = @id_taskForm

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'TaskForm')
	exec @event_log_id = usp_insert_EventLog @description = 'updated form', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_taskForm', @value = @id_taskForm, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'description', @value = @description, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_formUser]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_formUser]
@taskForm_id bigint, @user_id nvarchar(300), @isAnswered bit, @answered_date datetime, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	update Form_Users set isAnswered = @isAnswered, answered_date = @answered_date
	where taskForm_id = @taskForm_id and [user_id] = @user_id
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Form_Users')
	exec @event_log_id = usp_insert_EventLog @description = 'updated form', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_taskForm', @value = @taskForm_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isAnswered', @value = @isAnswered, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'answered_date', @value = @answered_date, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_generalAttribute]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_generalAttribute]
@id_attribute bigint, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @isEnabled bit, @pUser int as
begin
begin transaction;
	update CategorieAttributes set name = ISNULL(@name, name),
		[type] = ISNULL(@type_id, [type]),
		value = ISNULL(@value, value),
		isEnabled = ISNULL(@isEnabled, isEnabled)
		where id_attribute = @id_attribute
	declare @table int, @event_log_id int
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'CategorieAttributes')
	exec @event_log_id = usp_insert_EventLog @description = 'updated general attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @pUser;
	exec usp_insert_Reference @attribute = 'id_attribute', @value = @id_attribute, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isEnabled', @value = @isEnabled, @EventLog_id = @event_log_id
commit transaction;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_group]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_group]
@id_group int, @groupName nvarchar(50)
as
begin 
	update Groups set groupName =  @groupName
	where id_group = @id_group
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_personalAttribute]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_personalAttribute]
@id_attribute bigint, @name nvarchar(50), @type_id tinyint, @value nvarchar(300), @isEnabled bit,@userLog int as
begin
begin transaction;
	update CategorieAttributes set name = ISNULL(@name, name),
		[type] = ISNULL(@type_id, [type]),
		value = ISNULL(@value, value),
		isEnabled = ISNULL(@isEnabled, isEnabled)
		where id_attribute = @id_attribute
	declare @table int, @event_log_id int
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'CategorieAttributes')
	exec @event_log_id = usp_insert_EventLog @description = 'updated general attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_attribute', @value = @id_attribute, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isEnabled', @value = @isEnabled, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @userLog, @EventLog_id = @event_log_id
commit transaction;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_process]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_process]
@id_process int, @name nvarchar(100) = null, @previousProcess bigint = null, @completedPorcentage int = null, @nextProcess bigint = null, @state_id tinyint = null, @userLog int as
begin 
begin transaction
	declare @event_log_id int, @table int
	update ProcessManagment set name = ISNULL(@name, name)
	where id_processManagment = @id_process

	update Process set previousProcess = ISNULL(@previousProcess, previousProcess),
						completedPorcentage = ISNULL(@completedPorcentage, completedPorcentage),
						nextProcess = ISNULL(@nextProcess, nextProcess),
						state_id = ISNULL(@state_id, state_id)
	where processManagment_id = @id_process
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[usp_update_question]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_question]
@id_taskQuestion bigint, @question nvarchar(250) =null, @generalAttributeList int = null, 
@questionType_id int = null, @userLog int, @questionPosition int = null, @isRequired bit as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	update FormQuestions set question = ISNULL(@question, question),
							generalAttributeList = ISNULL(@generalAttributeList, generalAttributeList),
							questionType_id = ISNULL(@questionType_id, questionType_id),
							questionPosition = ISNULL(@questionPosition, questionPosition),
							isRequired = ISNULL(@isRequired, isRequired)
	where id_TaskQuestion = @id_taskQuestion
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'FormQuestions')
	exec @event_log_id = usp_insert_EventLog @description = 'updated question', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_taskQuestion', @value = @id_taskQuestion, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'question', @value = @question, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'generalAttributeList', @value = @generalAttributeList, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'questionType_id', @value = @generalAttributeList, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_roleElement]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_roleElement]
@element_id int, @role_permission_id int, @isEnabled bit as
begin 
	update Roles_Permissions_Elements set isEnabled = @isEnabled
	where @element_id = element_id and @role_permission_id = role_permission_id
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_update_rolePermission]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_rolePermission]
@id_role_permission int, @isEnabled bit as
begin 
	update Roles_Permissions set isEnabled = @isEnabled
	where @id_role_permission = id_role_permission
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_update_stage]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_stage] 
@id_stage bigint, @name nvarchar(100) = null, @stagePosition int = null, @isCompleted bit = null, @completedDate date = null, @startDate date = null, @userLog int as
begin
set transaction isolation level snapshot
begin transaction 
	declare @event_log_id int, @table int
	update Stage set name = ISNULL(@name, name),
					stagePosition = ISNULL(@stagePosition, stagePosition),
					isCompleted = ISNULL(@isCompleted, isCompleted),
					completedDate = ISNULL(@completedDate, completedDate),
					startDate = ISNULL(@startDate, startDate)
	where id_stage = @id_stage

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Stage')
	exec @event_log_id = usp_insert_EventLog @description = 'updated stage', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'stagePosition', @value = @stagePosition, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_stage', @value = @id_stage, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isCompleted', @value = @isCompleted, @EventLog_id = @event_log_id
commit transaction 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_task]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_task]
@id_task int, @name nvarchar(50)=null, @description nvarchar(150)=null, @type_id int=null, @userLog int, @taskState_id int=null, 
@completedDate datetime = null, @finishDate datetime=null, @taskPosition int=null, @beginDate datetime=null, @daysAvailable int = null, @hoursAvailable int = null as
begin
set transaction isolation level snapshot
begin transaction 
	declare @event_log_id int, @table int
	update Task set name = ISNULL(@name, name),
					[description] = ISNULL(@description, [description]),
					[type_id] = ISNULL(@type_id, [type_id]),
					taskState_id = ISNULL(@taskState_id, taskState_id),
					completedDate = ISNULL(@completedDate, completedDate),
					finishDate = ISNULL(@finishDate, finishDate),
					taskPosition = ISNULL(@taskPosition, taskPosition),
					beginDate = ISNULL(@beginDate, beginDate),
					daysAvailable = ISNULL(@daysAvailable, daysAvailable),
					hoursAvailable = ISNULL(@hoursAvailable, hoursAvailable)
	where id_task = @id_task

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task')
	exec @event_log_id = usp_insert_EventLog @description = 'updated task', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'description', @value = @description, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'taskState_id', @value = @taskState_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'completedDate', @value = @completedDate, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'finishDate', @value = @finishDate, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'taskPosition', @value = @taskPosition, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'beginDate', @value = @beginDate, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'daysAvailable', @value = @daysAvailable, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'hoursAvailable', @value = @hoursAvailable, @EventLog_id = @event_log_id
commit transaction 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_taskChange]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_taskChange]
@id_taskChange int, @attribute_id bigint = null, @attributeList_id bigint = null, @operation_id int, @value nvarchar(50), @userLog int as
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	update TaskChanges set	attribute_id = ISNULL(@attribute_id, attribute_id),
							attributeList_id = ISNULL(@attributeList_id, attributeList_id),
							operation_id = ISNULL(@operation_id, operation_id),
							value = ISNULL(@value, value)
	where id_taskChange = @id_taskChange
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'TaskChanges')
	exec @event_log_id = usp_insert_EventLog @description = 'updated task change', @objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_taskChange', @value = @id_taskChange, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'attribute_id', @value = @attribute_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'operation_id', @value = @operation_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_TaskNotification]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_TaskNotification] 
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

GO
/****** Object:  StoredProcedure [dbo].[usp_update_taskNotificationType]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_taskNotificationType]
@id_notification int, @id_notificationType int, @isSended bit,  @userLog int as 
begin 
	update Notifications_Types set isSended = @isSended 
	where notification_id = @id_notification and [type_id] = @id_notificationType
end
GO
/****** Object:  StoredProcedure [dbo].[usp_update_taskTarget]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_taskTarget]
@id_user int, @id_task bigint, @isConfirmed bit, @userLog int as
begin
set transaction isolation level snapshot
begin transaction 
	declare @event_log_id int, @table int
	update Task_Targets set isConfirmed = @isConfirmed
	where task_id = @id_task and [user_id] = @id_user

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task_Targets')
	exec @event_log_id = usp_insert_EventLog @description = 'updated responsable', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'user_id', @value = @id_user, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_task', @value = @id_task, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'isConfirmed', @value = @isConfirmed, @EventLog_id = @event_log_id
commit transaction 
end
GO
/****** Object:  StoredProcedure [dbo].[usp_update_taskTimes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_taskTimes]
@processManagment_id int as
begin 
	-- stages 
	declare cursor_stages cursor forward_only fast_forward
	for select s.id_stage from Stage s where s.processManagment_id = @processManagment_id order by s.stagePosition
	declare @stage_id bigint;
	declare @lastFinishDate datetime = GETDATE(), @lastBeginDate datetime;
	declare @isFirst bit = 0
	open cursor_stages
	fetch next from cursor_stages into @stage_id
	while @@FETCH_STATUS = 0 
	begin
		-- Tasks
		declare cursor_tasks cursor forward_only fast_forward
		for select t.id_task, t.name, t.[description], t.[type_id], t.taskState_id, t.taskPosition, t.daysAvailable, t.hoursAvailable, t.createdDate
		from Task t where t.stage_id = @stage_id order by t.taskPosition
		declare @task_name nvarchar(100), @old_task_id bigint, @task_description nvarchar(150), @task_type_id int, @taskState_id int, @taskPosition int, 
		@task_daysAvailable int, @task_hoursAvailable int, @task_createdDate datetime
		open cursor_tasks
		fetch next from cursor_tasks into @old_task_id, @task_name, @task_description, @task_type_id, @taskState_id, @taskPosition, @task_daysAvailable, @task_hoursAvailable, @task_createdDate
		while @@FETCH_STATUS = 0 
		begin
			if (@isFirst = 0)
			begin
				set @lastFinishDate = DATEADD(hour, @task_hoursAvailable, (DATEADD(day, @task_daysAvailable, @task_createdDate)));
				set @lastBeginDate = @task_createdDate
				set @isFirst = 1
			end
			else
			begin
				set @lastBeginDate = @lastFinishDate
				set @lastFinishDate = DATEADD(hour, @task_hoursAvailable, (DATEADD(day, @task_daysAvailable, @lastFinishDate)));
			end
			update Task set finishDate = @lastFinishDate, beginDate = @lastBeginDate where id_task =  @old_task_id
			fetch next from cursor_tasks into @old_task_id, @task_name, @task_description, @task_type_id, @taskState_id, @taskPosition, @task_daysAvailable, @task_hoursAvailable, @task_createdDate
		end
		close cursor_tasks
		deallocate cursor_tasks
		fetch next from cursor_stages into @stage_id
	end
	close cursor_stages
	deallocate cursor_stages
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_template]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_template]
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

GO
/****** Object:  StoredProcedure [dbo].[usp_update_user]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_user]
@user nvarchar(50) = null, @userName nvarchar(50) = null, @name nvarchar(50) = null, @fLastName nvarchar(50) = null, @sLastName nvarchar(50) = null,
@email nvarchar(50) = null, @phoneNumber nvarchar(50) = null, @canton_id tinyint = 1, @password nvarchar(50) = null,
@id numeric(9,0) = null, @birthdate nvarchar(20) = null, @direction nvarchar(50) = null, @photo varbinary(MAX) = null, 
@telegram_id nvarchar(50) = null, @telegram_user nvarchar(50) = null, @isEnabled bit = null
 as
begin
begin transaction 
		declare @id_user int = (select id_user from Users where email = @email)
		update Users set userName = isnull(@userName,userName),
				     name = ISNULL(@name, name),
					 fLastName = ISNULL(@fLastName, fLastName),
					 sLastName = ISNULL(@sLastName, sLastName),
					 email = ISNULL (@email, email),
					 phoneNumber = ISNULL(@phoneNumber, phoneNumber),
					 canton_id = ISNULL(@canton_id,canton_id),
					 [password] = ISNULL(@password,[password]),
					 id = ISNULL(@id, id),
					 birthdate = ISNULL(try_convert(DATE,@birthdate,103), birthdate),
					 direction = ISNULL(@direction, direction),
					 telegram_id = ISNULL(@telegram_id, telegram_id),
					 telegram_user = ISNULL(@telegram_user, telegram_user),
					 isEnabled = ISNULL(@isEnabled, isEnabled)
		where email = @email or userName = @userName
		update UsersPhotos set photoData = ISNULL(@photo, photoData)
		where [user_id] = @id_user;
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_userAttribute]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_userAttribute]
@id_user int, @id_attribute bigint, @value nvarchar(100), @userLog int as
begin
begin transaction 
	update PersonalAttributes set value = @value
	where @id_attribute = attribute_id and @id_user = [user_id]

	declare @table int, @event_log_id int
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'PersonalAttributes')
	exec @event_log_id = usp_insert_EventLog @description = 'updated user attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_attribute', @value = @id_attribute, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @id_user, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'userLog', @value = @userLog, @EventLog_id = @event_log_id
commit transaction 
end
GO
/****** Object:  StoredProcedure [dbo].[usp_update_userPasssword]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_userPasssword]
@id_user int, @password nvarchar(50), @userLog int as 
begin
	update Users set [password] = @password
	where [id_user] = @id_user
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_userPhoto]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_userPhoto]
@user nvarchar(50), @photoData varbinary(MAX)
 as
begin
	declare @id int;
	set @id = (select [id_user] from Users where email = @user or userName = @user);
	update UsersPhotos set photoData = @photoData where [user_id] = @id;
end

GO
/****** Object:  Table [dbo].[AttributeList]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeList](
	[id_attributeValue] [bigint] IDENTITY(1,1) NOT NULL,
	[attribute_id] [bigint] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[type_id] [tinyint] NOT NULL,
	[value] [nvarchar](300) NOT NULL,
	[isEnabled] [bit] NOT NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AttributeValues] PRIMARY KEY CLUSTERED 
(
	[id_attributeValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [name_unique_AttributeList] UNIQUE NONCLUSTERED 
(
	[name] ASC,
	[attribute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttributeTypes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeTypes](
	[id_type] [tinyint] NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[reg_expr] [nvarchar](350) NULL,
 CONSTRAINT [PK_AttributeTypes] PRIMARY KEY CLUSTERED 
(
	[id_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cantones]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cantones](
	[id_canton] [tinyint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[province_id] [tinyint] NOT NULL,
 CONSTRAINT [PK_Cantones] PRIMARY KEY CLUSTERED 
(
	[id_canton] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategorieAttributes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategorieAttributes](
	[id_attribute] [bigint] IDENTITY(1,1) NOT NULL,
	[categorie_id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[type] [tinyint] NOT NULL,
	[value] [nvarchar](300) NOT NULL,
	[isGeneral] [bit] NOT NULL,
	[isEnabled] [bit] NOT NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CategorieAttributes_1] PRIMARY KEY CLUSTERED 
(
	[id_attribute] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [name_unique_CategorieAttributes] UNIQUE NONCLUSTERED 
(
	[name] ASC,
	[isGeneral] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[id_categorie] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[description] [varchar](100) NULL,
	[createdBy_name] [varchar](80) NOT NULL,
	[createdBy_id] [int] NULL,
	[createdDate] [datetime] NOT NULL,
	[isEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[id_categorie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [unique_name_Categories] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Elements]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elements](
	[id_element] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[type_id] [tinyint] NOT NULL,
	[permission_id] [int] NOT NULL,
 CONSTRAINT [PK_module] PRIMARY KEY CLUSTERED 
(
	[id_element] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [unique_name_Elements] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ElementTypes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ElementTypes](
	[id_elementType] [tinyint] NOT NULL,
	[type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_moduleTypes] PRIMARY KEY CLUSTERED 
(
	[id_elementType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLog](
	[EventLog_id] [bigint] IDENTITY(1,1) NOT NULL,
	[description] [nvarchar](50) NOT NULL,
	[objectLog_id] [bigint] NOT NULL,
	[eventTypeLog_id] [bigint] NOT NULL,
	[eventSourceLog_id] [bigint] NOT NULL,
	[postTime] [datetime] NOT NULL,
	[computer] [nvarchar](30) NOT NULL,
	[user] [int] NOT NULL,
	[CHKsum] [int] NOT NULL,
 CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED 
(
	[EventLog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventLog_Reference]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLog_Reference](
	[eventLog_id] [bigint] NOT NULL,
	[reference_id] [bigint] NOT NULL,
	[postTime] [datetime] NOT NULL,
 CONSTRAINT [PK_EventLog_Reference] PRIMARY KEY CLUSTERED 
(
	[eventLog_id] ASC,
	[reference_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventSourceLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventSourceLog](
	[EventSourceLog_id] [bigint] IDENTITY(1,1) NOT NULL,
	[sourceName] [nvarchar](30) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[computer] [nvarchar](30) NOT NULL,
	[userName] [nvarchar](30) NOT NULL,
	[CHKsum] [int] NOT NULL,
 CONSTRAINT [PK_EventSourceLog] PRIMARY KEY CLUSTERED 
(
	[EventSourceLog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [name_unique_EventSourceLog] UNIQUE NONCLUSTERED 
(
	[sourceName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventTypeLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventTypeLog](
	[EventTypeLog_id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[computer] [nvarchar](30) NOT NULL,
	[userName] [nvarchar](30) NOT NULL,
	[CHKsum] [int] NOT NULL,
 CONSTRAINT [PK_EventTypeLog] PRIMARY KEY CLUSTERED 
(
	[EventTypeLog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [name_uniqueKey_EventTypeLog] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Form_Users]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Form_Users](
	[taskForm_id] [bigint] NOT NULL,
	[user_id] [int] NOT NULL,
	[isAnswered] [bit] NOT NULL,
	[answered_date] [datetime] NULL,
 CONSTRAINT [PK_Form_Users] PRIMARY KEY CLUSTERED 
(
	[taskForm_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FormQuestions]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormQuestions](
	[id_taskQuestion] [bigint] IDENTITY(1,1) NOT NULL,
	[taskForm_id] [bigint] NOT NULL,
	[question] [nvarchar](250) NOT NULL,
	[generalAttributeList] [int] NULL,
	[questionType_id] [tinyint] NOT NULL,
	[questionPosition] [int] NOT NULL,
	[isRequired] [bit] NOT NULL,
 CONSTRAINT [PK_TaskForm] PRIMARY KEY CLUSTERED 
(
	[id_taskQuestion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forms]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forms](
	[id_form] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Forms] PRIMARY KEY CLUSTERED 
(
	[id_form] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forms_Participants]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forms_Participants](
	[form_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_Forms_Participants_1] PRIMARY KEY CLUSTERED 
(
	[form_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GeneralAttributes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeneralAttributes](
	[attribute_id] [bigint] NOT NULL,
 CONSTRAINT [PK_GeneralAttributes] PRIMARY KEY CLUSTERED 
(
	[attribute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Group_Users]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_Users](
	[group_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_Group_Users] PRIMARY KEY CLUSTERED 
(
	[group_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Groups]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[id_group] [int] IDENTITY(1,1) NOT NULL,
	[groupName] [nvarchar](50) NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[isEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[id_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [unique_name_Groups] UNIQUE NONCLUSTERED 
(
	[groupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Modules]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modules](
	[id_module] [tinyint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Modules] PRIMARY KEY CLUSTERED 
(
	[id_module] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [unique_name_Module] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[id_notification] [bigint] IDENTITY(1,1) NOT NULL,
	[message] [nvarchar](1000) NOT NULL,
	[task_id] [bigint] NOT NULL,
	[isStarting] [bit] NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[id_notification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notifications_Types]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications_Types](
	[notification_id] [bigint] NOT NULL,
	[type_id] [tinyint] NOT NULL,
	[isSended] [bit] NOT NULL,
	[sended_date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notifications_Users]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications_Users](
	[notification_id] [bigint] NOT NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_Notifications_Users_1] PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NotificationsTypes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationsTypes](
	[type_id] [tinyint] NOT NULL,
	[type_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NotificationsTypes] PRIMARY KEY CLUSTERED 
(
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ObjectLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ObjectLog](
	[ObjectLog_id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[postTime] [datetime] NOT NULL,
	[computer] [nvarchar](30) NOT NULL,
	[userName] [nvarchar](30) NOT NULL,
	[CHKsum] [int] NOT NULL,
 CONSTRAINT [PK_ObjectLog] PRIMARY KEY CLUSTERED 
(
	[ObjectLog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [name_unique_ObjectLog] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OperationType]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationType](
	[id_operationType] [int] NOT NULL,
	[displayName] [nvarchar](50) NOT NULL,
	[operation] [nvarchar](20) NOT NULL,
	[reg_expr] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_OperationType] PRIMARY KEY CLUSTERED 
(
	[id_operationType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Parameters]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parameters](
	[id_parameter] [int] NOT NULL,
	[type_id] [int] NULL,
	[parameterName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Parameters] PRIMARY KEY CLUSTERED 
(
	[id_parameter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ParameterType]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParameterType](
	[id_parameterType] [int] NOT NULL,
	[typeName] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[id_permission] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[module_id] [tinyint] NOT NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[id_permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonalAttributes]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonalAttributes](
	[attribute_id] [bigint] NOT NULL,
	[user_id] [int] NOT NULL,
	[value] [nvarchar](300) NULL,
 CONSTRAINT [PK_PersonalAttributes_1] PRIMARY KEY CLUSTERED 
(
	[attribute_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Process]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Process](
	[processManagment_id] [bigint] NOT NULL,
	[template_id] [bigint] NOT NULL,
	[state_id] [tinyint] NOT NULL,
	[completedPorcentage] [int] NOT NULL,
	[nextProcess] [bigint] NULL,
	[previousProcess] [bigint] NULL,
 CONSTRAINT [PK_Process_1] PRIMARY KEY CLUSTERED 
(
	[processManagment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Process_Participants]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Process_Participants](
	[processManagment_id] [bigint] NOT NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_Process_Participants] PRIMARY KEY CLUSTERED 
(
	[processManagment_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProcessManagment]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessManagment](
	[id_processManagment] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[createdBy] [int] NULL,
	[createdDate] [datetime] NOT NULL,
	[categorie_id] [int] NULL,
	[isProcess] [bit] NOT NULL,
 CONSTRAINT [PK_ProcessManagment] PRIMARY KEY CLUSTERED 
(
	[id_processManagment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProcessState]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessState](
	[id_processState] [tinyint] NOT NULL,
	[state_name] [nvarchar](50) NOT NULL,
	[state_color] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProcessState] PRIMARY KEY CLUSTERED 
(
	[id_processState] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provinces]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provinces](
	[id_province] [tinyint] NOT NULL,
	[name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Provinces] PRIMARY KEY CLUSTERED 
(
	[id_province] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuestionChanges]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionChanges](
	[taskQuestion_id] [bigint] NOT NULL,
	[taskChange_id] [bigint] NOT NULL,
 CONSTRAINT [PK_QuestionChanges] PRIMARY KEY CLUSTERED 
(
	[taskQuestion_id] ASC,
	[taskChange_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuestionResponse]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuestionResponse](
	[taskQuestion_id] [bigint] NOT NULL,
	[user_id] [int] NOT NULL,
	[response] [varbinary](max) NULL,
 CONSTRAINT [PK_QuestionResponse] PRIMARY KEY CLUSTERED 
(
	[taskQuestion_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuestionType]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionType](
	[id_questionType] [tinyint] NOT NULL,
	[name] [nvarchar](100) NULL,
 CONSTRAINT [PK_QuestionType] PRIMARY KEY CLUSTERED 
(
	[id_questionType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reference]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reference](
	[Reference_id] [bigint] IDENTITY(1,1) NOT NULL,
	[attribute] [nvarchar](50) NOT NULL,
	[value] [nvarchar](80) NULL,
	[postTime] [datetime] NOT NULL,
	[computer] [nvarchar](30) NOT NULL,
	[user] [nvarchar](50) NOT NULL,
	[CHKsum] [int] NOT NULL,
 CONSTRAINT [PK_Reference] PRIMARY KEY CLUSTERED 
(
	[Reference_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id_role] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[description] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles_Permissions]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles_Permissions](
	[id_role_permission] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
	[isEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Roles_Permissions_1] PRIMARY KEY CLUSTERED 
(
	[id_role_permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles_Permissions_Elements]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles_Permissions_Elements](
	[role_permission_id] [int] NOT NULL,
	[element_id] [int] NOT NULL,
	[isEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Roles_Permissions_Elements_1] PRIMARY KEY CLUSTERED 
(
	[role_permission_id] ASC,
	[element_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ScriptsLog]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScriptsLog](
	[id_scriptLog] [int] IDENTITY(1,1) NOT NULL,
	[script] [nvarchar](max) NOT NULL,
	[ejecutedDate] [datetime] NOT NULL,
	[ejecutedBy] [int] NOT NULL,
 CONSTRAINT [PK_ScriptsLog] PRIMARY KEY CLUSTERED 
(
	[id_scriptLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Stage]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stage](
	[id_stage] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[processManagment_id] [bigint] NOT NULL,
	[stagePosition] [int] NOT NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[isCompleted] [bit] NOT NULL,
	[startDate] [datetime] NULL,
	[completedDate] [datetime] NULL,
 CONSTRAINT [PK_Stage] PRIMARY KEY CLUSTERED 
(
	[id_stage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Task]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[id_task] [bigint] IDENTITY(1,1) NOT NULL,
	[stage_id] [bigint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](150) NULL,
	[type_id] [int] NOT NULL,
	[taskState_id] [smallint] NULL,
	[completedDate] [datetime] NULL,
	[createdBy] [int] NOT NULL,
	[finishDate] [datetime] NULL,
	[taskPosition] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[beginDate] [datetime] NULL,
	[daysAvailable] [int] NULL,
	[hoursAvailable] [int] NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[id_task] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Task_Targets]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_Targets](
	[task_id] [bigint] NOT NULL,
	[user_id] [int] NOT NULL,
	[isConfirmed] [bit] NOT NULL,
	[confirm_date] [datetime] NULL,
 CONSTRAINT [PK_Task_Targets] PRIMARY KEY CLUSTERED 
(
	[task_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskChanges]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskChanges](
	[id_taskChange] [bigint] IDENTITY(1,1) NOT NULL,
	[task_id] [bigint] NOT NULL,
	[attribute_id] [bigint] NULL,
	[attributeList_id] [bigint] NULL,
	[operation_id] [int] NOT NULL,
	[value] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TaskChanges] PRIMARY KEY CLUSTERED 
(
	[id_taskChange] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskFiles]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskFiles](
	[id_taskFile] [int] IDENTITY(1,1) NOT NULL,
	[task_id] [bigint] NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[description] [nvarchar](50) NULL,
	[fileData] [varbinary](max) NOT NULL,
	[fileType] [nvarchar](150) NOT NULL,
	[fileName] [nvarchar](200) NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[createdBy] [int] NOT NULL,
 CONSTRAINT [PK_TaskFiles] PRIMARY KEY CLUSTERED 
(
	[id_taskFile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaskForm]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskForm](
	[id_taskForm] [bigint] IDENTITY(1,1) NOT NULL,
	[task_id] [bigint] NOT NULL,
	[description] [nvarchar](300) NULL,
 CONSTRAINT [PK_TaskForm_1] PRIMARY KEY CLUSTERED 
(
	[id_taskForm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskState]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskState](
	[id_taskState] [smallint] NOT NULL,
	[state_name] [nvarchar](100) NOT NULL,
	[state_color] [nvarchar](20) NOT NULL,
	[state_sColor] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_TaskState] PRIMARY KEY CLUSTERED 
(
	[id_taskState] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskType]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskType](
	[id_taskType] [int] NOT NULL,
	[taskName] [nvarchar](50) NOT NULL,
	[needConfirm] [bit] NOT NULL,
	[formNeeded] [bit] NOT NULL,
 CONSTRAINT [PK_TaskType] PRIMARY KEY CLUSTERED 
(
	[id_taskType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Template]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Template](
	[processManagment_id] [bigint] NOT NULL,
 CONSTRAINT [PK_Template_1] PRIMARY KEY CLUSTERED 
(
	[processManagment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](30) NULL,
	[name] [nvarchar](30) NOT NULL,
	[fLastName] [nvarchar](30) NOT NULL,
	[sLastName] [nvarchar](30) NULL,
	[email] [nvarchar](50) NULL,
	[phoneNumber] [nvarchar](20) NULL,
	[canton_id] [tinyint] NULL,
	[password] [nvarchar](50) NULL,
	[createdDate] [datetime] NULL,
	[isEnabled] [bit] NULL,
	[id] [numeric](9, 0) NULL,
	[direction] [nvarchar](50) NULL,
	[birthdate] [date] NULL,
	[telegram_id] [nvarchar](50) NULL,
	[telegram_user] [nvarchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users_Roles]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users_Roles](
	[role_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_Users_Roles_1] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UsersFiles]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UsersFiles](
	[id_file] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[fileData] [varbinary](max) NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[description] [nvarchar](50) NULL,
	[fileType] [nvarchar](100) NOT NULL,
	[fileName] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_UsersFiles] PRIMARY KEY CLUSTERED 
(
	[id_file] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsersPhotos]    Script Date: 09/11/2016 05:26:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UsersPhotos](
	[id_Photo] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[photoData] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_UsersPhotos] PRIMARY KEY CLUSTERED 
(
	[id_Photo] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [unique_name_Roles]    Script Date: 09/11/2016 05:26:58 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [unique_name_Roles] ON [dbo].[Roles]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_email_notnull]    Script Date: 09/11/2016 05:26:58 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_email_notnull] ON [dbo].[Users]
(
	[email] ASC
)
WHERE ([email] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_id_notnull]    Script Date: 09/11/2016 05:26:58 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_id_notnull] ON [dbo].[Users]
(
	[id] ASC
)
WHERE ([id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_username_notnull]    Script Date: 09/11/2016 05:26:58 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_username_notnull] ON [dbo].[Users]
(
	[userName] ASC
)
WHERE ([username] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Form_Users] ADD  CONSTRAINT [DF_Form_Users_isAnswered]  DEFAULT ((0)) FOR [isAnswered]
GO
ALTER TABLE [dbo].[FormQuestions] ADD  CONSTRAINT [DF_FormQuestions_isRequired]  DEFAULT ((0)) FOR [isRequired]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_isEnabled]  DEFAULT ((0)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[Notifications] ADD  CONSTRAINT [DF_Notifications_isStarting]  DEFAULT ((0)) FOR [isStarting]
GO
ALTER TABLE [dbo].[Process] ADD  CONSTRAINT [DF_Process_isCompleted]  DEFAULT ((0)) FOR [state_id]
GO
ALTER TABLE [dbo].[Roles_Permissions] ADD  CONSTRAINT [DF_Roles_Permissions_isEnabled]  DEFAULT ((0)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[Stage] ADD  CONSTRAINT [DF_Stage_isCompleted]  DEFAULT ((0)) FOR [isCompleted]
GO
ALTER TABLE [dbo].[Task_Targets] ADD  CONSTRAINT [DF_Task_Targets_isConfirmed]  DEFAULT ((0)) FOR [isConfirmed]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_isEnabled]  DEFAULT ((1)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[AttributeList]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValues_AttributeTypes] FOREIGN KEY([type_id])
REFERENCES [dbo].[AttributeTypes] ([id_type])
GO
ALTER TABLE [dbo].[AttributeList] CHECK CONSTRAINT [FK_AttributeValues_AttributeTypes]
GO
ALTER TABLE [dbo].[AttributeList]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValues_CategorieAttributes] FOREIGN KEY([attribute_id])
REFERENCES [dbo].[CategorieAttributes] ([id_attribute])
GO
ALTER TABLE [dbo].[AttributeList] CHECK CONSTRAINT [FK_AttributeValues_CategorieAttributes]
GO
ALTER TABLE [dbo].[Cantones]  WITH CHECK ADD  CONSTRAINT [FK_Cantones_Provinces1] FOREIGN KEY([province_id])
REFERENCES [dbo].[Provinces] ([id_province])
GO
ALTER TABLE [dbo].[Cantones] CHECK CONSTRAINT [FK_Cantones_Provinces1]
GO
ALTER TABLE [dbo].[CategorieAttributes]  WITH CHECK ADD  CONSTRAINT [FK_CategorieAttributes_AttributeTypes] FOREIGN KEY([type])
REFERENCES [dbo].[AttributeTypes] ([id_type])
GO
ALTER TABLE [dbo].[CategorieAttributes] CHECK CONSTRAINT [FK_CategorieAttributes_AttributeTypes]
GO
ALTER TABLE [dbo].[CategorieAttributes]  WITH CHECK ADD  CONSTRAINT [FK_CategorieAttributes_Categories1] FOREIGN KEY([categorie_id])
REFERENCES [dbo].[Categories] ([id_categorie])
GO
ALTER TABLE [dbo].[CategorieAttributes] CHECK CONSTRAINT [FK_CategorieAttributes_Categories1]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Users] FOREIGN KEY([createdBy_id])
REFERENCES [dbo].[Users] ([id_user])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Users]
GO
ALTER TABLE [dbo].[Elements]  WITH CHECK ADD  CONSTRAINT [FK_Elements_Permissions] FOREIGN KEY([permission_id])
REFERENCES [dbo].[Permissions] ([id_permission])
GO
ALTER TABLE [dbo].[Elements] CHECK CONSTRAINT [FK_Elements_Permissions]
GO
ALTER TABLE [dbo].[Elements]  WITH CHECK ADD  CONSTRAINT [FK_module_moduleTypes] FOREIGN KEY([type_id])
REFERENCES [dbo].[ElementTypes] ([id_elementType])
GO
ALTER TABLE [dbo].[Elements] CHECK CONSTRAINT [FK_module_moduleTypes]
GO
ALTER TABLE [dbo].[EventLog]  WITH CHECK ADD  CONSTRAINT [FK_EventLog_EventSourceLog] FOREIGN KEY([eventSourceLog_id])
REFERENCES [dbo].[EventSourceLog] ([EventSourceLog_id])
GO
ALTER TABLE [dbo].[EventLog] CHECK CONSTRAINT [FK_EventLog_EventSourceLog]
GO
ALTER TABLE [dbo].[EventLog]  WITH CHECK ADD  CONSTRAINT [FK_EventLog_EventTypeLog] FOREIGN KEY([eventTypeLog_id])
REFERENCES [dbo].[EventTypeLog] ([EventTypeLog_id])
GO
ALTER TABLE [dbo].[EventLog] CHECK CONSTRAINT [FK_EventLog_EventTypeLog]
GO
ALTER TABLE [dbo].[EventLog]  WITH CHECK ADD  CONSTRAINT [FK_EventLog_ObjectLog] FOREIGN KEY([objectLog_id])
REFERENCES [dbo].[ObjectLog] ([ObjectLog_id])
GO
ALTER TABLE [dbo].[EventLog] CHECK CONSTRAINT [FK_EventLog_ObjectLog]
GO
ALTER TABLE [dbo].[EventLog_Reference]  WITH CHECK ADD  CONSTRAINT [FK_EventLog_Reference_EventLog] FOREIGN KEY([eventLog_id])
REFERENCES [dbo].[EventLog] ([EventLog_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventLog_Reference] CHECK CONSTRAINT [FK_EventLog_Reference_EventLog]
GO
ALTER TABLE [dbo].[EventLog_Reference]  WITH CHECK ADD  CONSTRAINT [FK_EventLog_Reference_Reference] FOREIGN KEY([reference_id])
REFERENCES [dbo].[Reference] ([Reference_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventLog_Reference] CHECK CONSTRAINT [FK_EventLog_Reference_Reference]
GO
ALTER TABLE [dbo].[Form_Users]  WITH CHECK ADD  CONSTRAINT [FK_Form_Users_TaskForm] FOREIGN KEY([taskForm_id])
REFERENCES [dbo].[TaskForm] ([id_taskForm])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Form_Users] CHECK CONSTRAINT [FK_Form_Users_TaskForm]
GO
ALTER TABLE [dbo].[Form_Users]  WITH CHECK ADD  CONSTRAINT [FK_Form_Users_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[Form_Users] CHECK CONSTRAINT [FK_Form_Users_Users]
GO
ALTER TABLE [dbo].[FormQuestions]  WITH CHECK ADD  CONSTRAINT [FK_FormQuestions_QuestionType] FOREIGN KEY([questionType_id])
REFERENCES [dbo].[QuestionType] ([id_questionType])
GO
ALTER TABLE [dbo].[FormQuestions] CHECK CONSTRAINT [FK_FormQuestions_QuestionType]
GO
ALTER TABLE [dbo].[FormQuestions]  WITH CHECK ADD  CONSTRAINT [FK_FormQuestions_TaskForm] FOREIGN KEY([taskForm_id])
REFERENCES [dbo].[TaskForm] ([id_taskForm])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FormQuestions] CHECK CONSTRAINT [FK_FormQuestions_TaskForm]
GO
ALTER TABLE [dbo].[Forms_Participants]  WITH CHECK ADD  CONSTRAINT [FK_Forms_Participants_Forms] FOREIGN KEY([form_id])
REFERENCES [dbo].[Forms] ([id_form])
GO
ALTER TABLE [dbo].[Forms_Participants] CHECK CONSTRAINT [FK_Forms_Participants_Forms]
GO
ALTER TABLE [dbo].[Forms_Participants]  WITH CHECK ADD  CONSTRAINT [FK_Forms_Participants_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[Forms_Participants] CHECK CONSTRAINT [FK_Forms_Participants_Users]
GO
ALTER TABLE [dbo].[GeneralAttributes]  WITH CHECK ADD  CONSTRAINT [FK_GeneralAttributes_CategorieAttributes] FOREIGN KEY([attribute_id])
REFERENCES [dbo].[CategorieAttributes] ([id_attribute])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GeneralAttributes] CHECK CONSTRAINT [FK_GeneralAttributes_CategorieAttributes]
GO
ALTER TABLE [dbo].[Group_Users]  WITH CHECK ADD  CONSTRAINT [FK_Group_Users_Groups] FOREIGN KEY([group_id])
REFERENCES [dbo].[Groups] ([id_group])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Group_Users] CHECK CONSTRAINT [FK_Group_Users_Groups]
GO
ALTER TABLE [dbo].[Group_Users]  WITH CHECK ADD  CONSTRAINT [FK_Group_Users_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Group_Users] CHECK CONSTRAINT [FK_Group_Users_Users]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Task] FOREIGN KEY([task_id])
REFERENCES [dbo].[Task] ([id_task])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Task]
GO
ALTER TABLE [dbo].[Notifications_Types]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Types_Notifications] FOREIGN KEY([notification_id])
REFERENCES [dbo].[Notifications] ([id_notification])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notifications_Types] CHECK CONSTRAINT [FK_Notifications_Types_Notifications]
GO
ALTER TABLE [dbo].[Notifications_Types]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Types_NotificationsTypes1] FOREIGN KEY([type_id])
REFERENCES [dbo].[NotificationsTypes] ([type_id])
GO
ALTER TABLE [dbo].[Notifications_Types] CHECK CONSTRAINT [FK_Notifications_Types_NotificationsTypes1]
GO
ALTER TABLE [dbo].[Notifications_Users]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users_Notifications] FOREIGN KEY([notification_id])
REFERENCES [dbo].[Notifications] ([id_notification])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notifications_Users] CHECK CONSTRAINT [FK_Notifications_Users_Notifications]
GO
ALTER TABLE [dbo].[Notifications_Users]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[Notifications_Users] CHECK CONSTRAINT [FK_Notifications_Users_Users]
GO
ALTER TABLE [dbo].[ParameterType]  WITH CHECK ADD  CONSTRAINT [FK_ParameterType_Parameters] FOREIGN KEY([id_parameterType])
REFERENCES [dbo].[Parameters] ([id_parameter])
GO
ALTER TABLE [dbo].[ParameterType] CHECK CONSTRAINT [FK_ParameterType_Parameters]
GO
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Modules] FOREIGN KEY([module_id])
REFERENCES [dbo].[Modules] ([id_module])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Modules]
GO
ALTER TABLE [dbo].[PersonalAttributes]  WITH CHECK ADD  CONSTRAINT [FK_PersonalAttributes_CategorieAttributes] FOREIGN KEY([attribute_id])
REFERENCES [dbo].[CategorieAttributes] ([id_attribute])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonalAttributes] CHECK CONSTRAINT [FK_PersonalAttributes_CategorieAttributes]
GO
ALTER TABLE [dbo].[PersonalAttributes]  WITH CHECK ADD  CONSTRAINT [FK_PersonalAttributes_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[PersonalAttributes] CHECK CONSTRAINT [FK_PersonalAttributes_Users]
GO
ALTER TABLE [dbo].[Process]  WITH CHECK ADD  CONSTRAINT [FK_Process_ProcessManagment] FOREIGN KEY([processManagment_id])
REFERENCES [dbo].[ProcessManagment] ([id_processManagment])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Process] CHECK CONSTRAINT [FK_Process_ProcessManagment]
GO
ALTER TABLE [dbo].[Process]  WITH CHECK ADD  CONSTRAINT [FK_Process_ProcessManagment1] FOREIGN KEY([nextProcess])
REFERENCES [dbo].[ProcessManagment] ([id_processManagment])
GO
ALTER TABLE [dbo].[Process] CHECK CONSTRAINT [FK_Process_ProcessManagment1]
GO
ALTER TABLE [dbo].[Process]  WITH CHECK ADD  CONSTRAINT [FK_Process_ProcessManagment2] FOREIGN KEY([previousProcess])
REFERENCES [dbo].[ProcessManagment] ([id_processManagment])
GO
ALTER TABLE [dbo].[Process] CHECK CONSTRAINT [FK_Process_ProcessManagment2]
GO
ALTER TABLE [dbo].[Process]  WITH CHECK ADD  CONSTRAINT [FK_Process_ProcessState] FOREIGN KEY([state_id])
REFERENCES [dbo].[ProcessState] ([id_processState])
GO
ALTER TABLE [dbo].[Process] CHECK CONSTRAINT [FK_Process_ProcessState]
GO
ALTER TABLE [dbo].[Process]  WITH CHECK ADD  CONSTRAINT [FK_Process_Template] FOREIGN KEY([template_id])
REFERENCES [dbo].[Template] ([processManagment_id])
GO
ALTER TABLE [dbo].[Process] CHECK CONSTRAINT [FK_Process_Template]
GO
ALTER TABLE [dbo].[Process_Participants]  WITH CHECK ADD  CONSTRAINT [FK_Process_Participants_ProcessManagment] FOREIGN KEY([processManagment_id])
REFERENCES [dbo].[ProcessManagment] ([id_processManagment])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Process_Participants] CHECK CONSTRAINT [FK_Process_Participants_ProcessManagment]
GO
ALTER TABLE [dbo].[Process_Participants]  WITH CHECK ADD  CONSTRAINT [FK_Process_Participants_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[Process_Participants] CHECK CONSTRAINT [FK_Process_Participants_Users]
GO
ALTER TABLE [dbo].[ProcessManagment]  WITH CHECK ADD  CONSTRAINT [FK_ProcessManagment_Categories] FOREIGN KEY([categorie_id])
REFERENCES [dbo].[Categories] ([id_categorie])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ProcessManagment] CHECK CONSTRAINT [FK_ProcessManagment_Categories]
GO
ALTER TABLE [dbo].[QuestionChanges]  WITH CHECK ADD  CONSTRAINT [FK_QuestionChanges_FormQuestions] FOREIGN KEY([taskQuestion_id])
REFERENCES [dbo].[FormQuestions] ([id_taskQuestion])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuestionChanges] CHECK CONSTRAINT [FK_QuestionChanges_FormQuestions]
GO
ALTER TABLE [dbo].[QuestionChanges]  WITH CHECK ADD  CONSTRAINT [FK_QuestionChanges_TaskChanges] FOREIGN KEY([taskChange_id])
REFERENCES [dbo].[TaskChanges] ([id_taskChange])
GO
ALTER TABLE [dbo].[QuestionChanges] CHECK CONSTRAINT [FK_QuestionChanges_TaskChanges]
GO
ALTER TABLE [dbo].[QuestionResponse]  WITH CHECK ADD  CONSTRAINT [FK_QuestionResponse_FormQuestions] FOREIGN KEY([taskQuestion_id])
REFERENCES [dbo].[FormQuestions] ([id_taskQuestion])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuestionResponse] CHECK CONSTRAINT [FK_QuestionResponse_FormQuestions]
GO
ALTER TABLE [dbo].[QuestionResponse]  WITH CHECK ADD  CONSTRAINT [FK_QuestionResponse_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[QuestionResponse] CHECK CONSTRAINT [FK_QuestionResponse_Users]
GO
ALTER TABLE [dbo].[Roles_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Roles_Permissions_Permissions] FOREIGN KEY([permission_id])
REFERENCES [dbo].[Permissions] ([id_permission])
GO
ALTER TABLE [dbo].[Roles_Permissions] CHECK CONSTRAINT [FK_Roles_Permissions_Permissions]
GO
ALTER TABLE [dbo].[Roles_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Roles_Permissions_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([id_role])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Roles_Permissions] CHECK CONSTRAINT [FK_Roles_Permissions_Roles]
GO
ALTER TABLE [dbo].[Roles_Permissions_Elements]  WITH CHECK ADD  CONSTRAINT [FK_Roles_Permissions_Elements_Elements] FOREIGN KEY([element_id])
REFERENCES [dbo].[Elements] ([id_element])
GO
ALTER TABLE [dbo].[Roles_Permissions_Elements] CHECK CONSTRAINT [FK_Roles_Permissions_Elements_Elements]
GO
ALTER TABLE [dbo].[Roles_Permissions_Elements]  WITH CHECK ADD  CONSTRAINT [FK_Roles_Permissions_Elements_Roles_Permissions] FOREIGN KEY([role_permission_id])
REFERENCES [dbo].[Roles_Permissions] ([id_role_permission])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Roles_Permissions_Elements] CHECK CONSTRAINT [FK_Roles_Permissions_Elements_Roles_Permissions]
GO
ALTER TABLE [dbo].[ScriptsLog]  WITH CHECK ADD  CONSTRAINT [FK_ScriptsLog_Users] FOREIGN KEY([ejecutedBy])
REFERENCES [dbo].[Users] ([id_user])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ScriptsLog] CHECK CONSTRAINT [FK_ScriptsLog_Users]
GO
ALTER TABLE [dbo].[Stage]  WITH CHECK ADD  CONSTRAINT [FK_Stage_ProcessManagment] FOREIGN KEY([processManagment_id])
REFERENCES [dbo].[ProcessManagment] ([id_processManagment])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Stage] CHECK CONSTRAINT [FK_Stage_ProcessManagment]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Stage] FOREIGN KEY([stage_id])
REFERENCES [dbo].[Stage] ([id_stage])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Stage]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_TaskState] FOREIGN KEY([taskState_id])
REFERENCES [dbo].[TaskState] ([id_taskState])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_TaskState]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_TaskType] FOREIGN KEY([type_id])
REFERENCES [dbo].[TaskType] ([id_taskType])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_TaskType]
GO
ALTER TABLE [dbo].[Task_Targets]  WITH CHECK ADD  CONSTRAINT [FK_Task_Targets_Task] FOREIGN KEY([task_id])
REFERENCES [dbo].[Task] ([id_task])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Task_Targets] CHECK CONSTRAINT [FK_Task_Targets_Task]
GO
ALTER TABLE [dbo].[Task_Targets]  WITH CHECK ADD  CONSTRAINT [FK_Task_Targets_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[Task_Targets] CHECK CONSTRAINT [FK_Task_Targets_Users]
GO
ALTER TABLE [dbo].[TaskChanges]  WITH CHECK ADD  CONSTRAINT [FK_TaskChanges_AttributeList] FOREIGN KEY([attributeList_id])
REFERENCES [dbo].[AttributeList] ([id_attributeValue])
GO
ALTER TABLE [dbo].[TaskChanges] CHECK CONSTRAINT [FK_TaskChanges_AttributeList]
GO
ALTER TABLE [dbo].[TaskChanges]  WITH CHECK ADD  CONSTRAINT [FK_TaskChanges_CategorieAttributes] FOREIGN KEY([attribute_id])
REFERENCES [dbo].[CategorieAttributes] ([id_attribute])
GO
ALTER TABLE [dbo].[TaskChanges] CHECK CONSTRAINT [FK_TaskChanges_CategorieAttributes]
GO
ALTER TABLE [dbo].[TaskChanges]  WITH CHECK ADD  CONSTRAINT [FK_TaskChanges_OperationType] FOREIGN KEY([operation_id])
REFERENCES [dbo].[OperationType] ([id_operationType])
GO
ALTER TABLE [dbo].[TaskChanges] CHECK CONSTRAINT [FK_TaskChanges_OperationType]
GO
ALTER TABLE [dbo].[TaskChanges]  WITH CHECK ADD  CONSTRAINT [FK_TaskChanges_Task] FOREIGN KEY([task_id])
REFERENCES [dbo].[Task] ([id_task])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TaskChanges] CHECK CONSTRAINT [FK_TaskChanges_Task]
GO
ALTER TABLE [dbo].[TaskFiles]  WITH CHECK ADD  CONSTRAINT [FK_TaskFiles_Task] FOREIGN KEY([task_id])
REFERENCES [dbo].[Task] ([id_task])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TaskFiles] CHECK CONSTRAINT [FK_TaskFiles_Task]
GO
ALTER TABLE [dbo].[TaskForm]  WITH CHECK ADD  CONSTRAINT [FK_TaskForm_Task1] FOREIGN KEY([task_id])
REFERENCES [dbo].[Task] ([id_task])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TaskForm] CHECK CONSTRAINT [FK_TaskForm_Task1]
GO
ALTER TABLE [dbo].[Template]  WITH CHECK ADD  CONSTRAINT [FK_Template_ProcessManagment] FOREIGN KEY([processManagment_id])
REFERENCES [dbo].[ProcessManagment] ([id_processManagment])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Template] CHECK CONSTRAINT [FK_Template_ProcessManagment]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Cantones1] FOREIGN KEY([canton_id])
REFERENCES [dbo].[Cantones] ([id_canton])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Cantones1]
GO
ALTER TABLE [dbo].[Users_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([id_role])
GO
ALTER TABLE [dbo].[Users_Roles] CHECK CONSTRAINT [FK_Users_Roles_Roles]
GO
ALTER TABLE [dbo].[Users_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Users_Roles] CHECK CONSTRAINT [FK_Users_Roles_Users]
GO
ALTER TABLE [dbo].[UsersFiles]  WITH CHECK ADD  CONSTRAINT [FK_UsersFiles_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[UsersFiles] CHECK CONSTRAINT [FK_UsersFiles_Users]
GO
ALTER TABLE [dbo].[UsersPhotos]  WITH CHECK ADD  CONSTRAINT [FK_UsersPhotos_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsersPhotos] CHECK CONSTRAINT [FK_UsersPhotos_Users]
GO
USE [master]
GO
ALTER DATABASE [RRHH] SET  READ_WRITE 
GO
