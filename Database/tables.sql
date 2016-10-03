USE [master]
GO
/****** Object:  Database [RRHH]    Script Date: 03/10/2016 05:29:45 p.m. ******/
CREATE DATABASE [RRHH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RRHH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MBCTEC\MSSQL\DATA\RRHH.mdf' , SIZE = 9216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RRHH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MBCTEC\MSSQL\DATA\RRHH_log.ldf' , SIZE = 24384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [RRHH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
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
/****** Object:  StoredProcedure [dbo].[usp_delete_AttributeList]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_categorie]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_generalAttribute]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_group]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_groupUser]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_personalAttribute]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_process_participant]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_role]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_stage]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_template]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_delete_userFile]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_AttributeList]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_AttributesList]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_attributeType]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_attributeTypes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_attributeTypes] as
begin
	select at.id_type, at.reg_expr, at.[type] from AttributeTypes at 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_cantones]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_categorie]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_categories]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_categories] as
begin 
	select c.id_categorie, c.name, c.[description], c.createdBy_name, c.createdBy_id, c.createdDate, c.isEnabled 
	from Categories c
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_Elements]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_generalAttribute]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_generalAttributes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_group]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_groupMembers]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_groups]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_groups] as
begin
	select g.id_group, g.groupName, g.createdDate, g.isEnabled
	from Groups g 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_modules]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_modules] as
begin
	select id_module, name from Modules order by id_module
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_personalAttribute]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_personalAttributes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_process_participants]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_process_stage]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_process_stage] 
@id_stage bigint as
begin 
	select s.id_stage, s.name, s.processManagment_id, s.stagePosition, s.createdBy, s.createdDate 
	from Stage s where  s.id_stage = @id_stage
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_process_stages]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_process_stages]
@id_processManagment bigint as
begin 
	select s.id_stage, s.name, s.processManagment_id, s.stagePosition, s.createdBy, s.createdDate 
	from Stage s where  s.processManagment_id = @id_processManagment
	order by s.stagePosition
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_provinces]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_provinces] as
begin
	select id_province, name from Provinces;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_role]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_rolePermissions_byModule]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_roles]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_template]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_templates]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_user]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_user] 
@user nvarchar(50) as
begin
	begin 
		select u.id_user, u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
		u.direction, convert(nvarchar, u.birthdate, 103) as birthdate, u.[password],
		(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
		(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
		(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id,
		(select up.photoData from UsersPhotos up where up.[user_id] = u.id_user) as photoData
		from Users u 
		where u.isEnabled = 1 and (u.userName = @user or u.email = @user) ;
	end
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_user_byID]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_user_byID] 
@user_id nvarchar(50) as
begin
	begin 
		select u.id_user, u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
		u.direction, convert(nvarchar, u.birthdate, 103) as birthdate, u.[password],
		(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
		(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
		(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id,
		(select up.photoData from UsersPhotos up where up.[user_id] = u.id_user) as photoData
		from Users u 
		where u.isEnabled = 1 and (u.id_user = @user_id) ;
	end
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_userAttributes_byCategorie]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_userCategories]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userCategories]
@id_user int as
begin 
	select c.id_categorie, c.name, c.[description], c.isEnabled
	from CategorieAttributes ca inner join 
	(select pa.attribute_id, pa.[user_id], pa.value from PersonalAttributes pa where pa.[user_id] = 75)pa
	on pa.attribute_id = ca.id_attribute
	inner join Categories c on c.id_categorie = ca.categorie_id
	where c.isEnabled = 1
	group by c.id_categorie, c.name, c.[description], c.isEnabled
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_userElements]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_userElements]
@user_id int, @isEnabled int as
begin 
	select distinct rpe.element_id, e.name, (select type from ElementTypes et where et.id_elementType = e.[type_id]) as [type]
	from Users_Roles ur inner join Roles_Permissions rp on rp.role_id = ur.role_id
	inner join Roles_Permissions_Elements rpe on rp.id_role_permission= rpe.role_permission_id
	left outer join Elements e on e.id_element = rpe.element_id
	where ur.[user_id] = 59 and rpe.isEnabled = 0
end

GO
/****** Object:  StoredProcedure [dbo].[usp_get_userFiles]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_userRoles]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_get_Users]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_get_Users] as
begin
	select u.userName, u.name, u.fLastName, u.sLastName, u.email, u.phoneNumber, u.canton_id, createdDate, u.id, 
	u.direction, u.birthdate, u.[password], u.id_user , 
	(select c.name  from Cantones c where c.id_canton = u.canton_id) as canton_name,
	(select p.name  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_name,
	(select p.id_province  from Cantones c inner join Provinces p on p.id_province = c.province_id where c.id_canton = u.canton_id) as province_id,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from Users u 
	where u.isEnabled = 1;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_AttributeList]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_categorie]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_element]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_EventLog]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_EventSourceLog]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_EventTypeLog]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_generalAttribute]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_group]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_groupUser]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_module]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_ObjectLog]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_permission]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_personalAttribute]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_process_participant]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_processGroup]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_Reference]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_role]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_stage]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[usp_insert_stage]
@name nvarchar(100), @processManagment_id bigint, @stagePosition int, @userLog int as
begin 
begin transaction 
	declare @id_stage int, @event_log_id int, @table int
	insert into Stage (name, processManagment_id, stagePosition, createdBy, createdDate)
	values (@name, @processManagment_id, @stagePosition, @userLog, GETDATE())
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
/****** Object:  StoredProcedure [dbo].[usp_insert_template]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_typesElement]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_user]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_insert_user]
@userName nvarchar(50) = null, @name nvarchar(50), @fLastName nvarchar(50), @sLastName nvarchar(50) = null,
@email nvarchar(50), @phoneNumber nvarchar(50) = null, @canton_id tinyint = 1, @password nvarchar(50) = 'tmp1234',
@id numeric(9,0) = null, @birthdate nvarchar(20) = null, @direction nvarchar(50) = null
 as
begin
	insert into Users(userName, name, fLastName, sLastName, email, phoneNumber, canton_id, [password], createdDate, isEnabled, id,birthdate, direction)
	values (@userName, @name, @fLastName, @sLastName, @email, @phoneNumber, @canton_id, @password, GETDATE(), 1, @id, CONVERT(DATE, @birthdate, 103), @direction );
	execute usp_insert_userPhoto @user = @email, @photoData = 0xFFD8FFE000104A46494600010100000100010000FFDB0084000906070F0E0F0F0F0E0F0F0F0F0F0F0F0D0F0F0F0F0F100F0F0F1511161615111515181D2820181A251B151521312125292B2E2E2E171F3338332C37282D2E2B010A0A0A0D0D0D0F0D0D0F2B191F192B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2BFFC000110800E000E003012200021101031101FFC4001B00010100030101010000000000000000000001020405030607FFC400301001000200020804060105000000000000000102031104051221314151C13261719122427281A1E1D113526292F0FFC4001501010100000000000000000000000000000001FFC40014110100000000000000000000000000000000FFDA000C03010002110311003F00FD700540000000000000000000000000000000000000000000000000000000000141054000000000000000000000000000000001E3A4E935C38CEDC794739907ADAD1119CCC4447199E0D1C7D6958DD48DAF39DD0E6E93A4DB1273B4EEE558E10F106DE26B0C5B7CDB3F4C64F09C7BCF1BDFFDA5E628F48C7BC70BDFFDA5EF87AC316BF36D7D519B500763035A56775E367CE37C37AB6898CE26262784C707CCBDB46D26D8739D67773ACF0941F423C745D26B8919D78F38E712F60000000000000000000000000618F8D14ACDA7847E67A3E7F1F1A6F69B5B8CFB447486D6B5D236AFB31C29BBD6DCFF0086880028000000000F4C0C69A5A2D5E31ED31D25F41818D17AC5A384FE27A3E6DBDAAB1F66FB33C2FBBD2DC90764000000000000000000001863E26C56D6E9133F7E4CDA7ADAD96165D6D11DFB038B3280A0000000000000B13D1007D260626DD6B6EB113F7E6CDA7AA6D9E17A5A63BF76E200000000000000000003435CF82BF5F696FB4F5B573C29F2B44F6EE0E200A0000080A2280000003B1A9BC16FAFB437DA7AA6B961479DA67B766E2000000000000000000030C6C3DAADABD6261980F9998CB74F18DD28DFD6BA3ECDB6E385B8F959A0A00008202AB1505000588CF74719DD08DFD55A3ED5B6E7853879DBFEEC0EAE0E1ECD6B5E9110CC10000000000000000000000618D8517ACD6DC27F1E6E06918138769ADBED3CA63ABE89E5A4E05712B95BED3CE27C81F3A8D8D2B44B61CEFDF5E568E1FA6BA82000A802AA36345D12D893BB7579DA787EC18E8F813896D9AFDE79447577F070A2958AD7847E7CD8E8D815C3AE55FBCF399F37AA0000000000000000000000000225AD1119CCC447599CA1A38FAD291BAB1369EBC201BD319F1E6D1C7D5B4B6FACEC4FBD7D9A76D6789339C6CC47488DCD8C2D6B59F1D663CE37C035B1356E247088B7A4FF002F09D17123E4B7B4BB74D2F0EDC2F5FBCE53F97A45A39483811A2E24FC96F697BE1EADC49E3115F598ECEC6D473979DF4AC3AF1BD7ED39CFE01E181AB695DF69DB9F6AFB37A232DD1BA21CDC5D6B58F05667CE77435EBACF122739D998E931BBED903B6AE7E06B4A4EEB44D27AF186F56D1319C4C4C758DF00C8000000000000000000001A9A669D5C3DD1F15FA728F561AC74DD8F82BE2E73FDB1FCB8B320F4C7C7B624E769CFCB947A43C814115004001514054501EB818F6C39CEB3979729F5879283BBA1E9D5C4DD3F0DBA729F46DBE6225D9D5DA6EDFC16F14709FEE8FE506F00000000000000035F4DD27FA74CFE69DD58F3EAD870758E3EDE24E5C2BF0C77906B5A666739DF33BE67ACA08A008002008002A00C84505114156B6989898DD31BE27CD8A83E8342D27FA94CFE68DD68F3EAD87075763EC5E3A5BE19ED2EF20000000000000F0D3317630ED6E79651EB3BA1F3CEBEB9BE55AD7ACCCFB47EDC8040450040025004101558A8321160140050015F43A1E2EDE1D6DCF2CA7D6374BE79D7D4B7CEB6AF4989F78FD20E88000000002080E4EBA9F8A91FE333F9FD39CE86B9F1D7E9EF2E780812A202008480892B28042A2C02AA400C958A82AA400AE8EA59F8AF1FE313F9FDB9CE86A6F1DBE8EF083B0B0C5414200115004101C8D73E3AFD3DE5CF7435CF8EBF4F7973C040511255004910041015618A8328562A0AA8A0AA802BA1A9BC76FA7BC39EE86A6F1DBE9EF00EC2B154155007FFD9;
end

GO
/****** Object:  StoredProcedure [dbo].[usp_insert_userFile]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_userImage]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_userPhoto]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_insert_userRole]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_AttributeList]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_categorie]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_generalAttribute]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_group]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_personalAttribute]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_roleElement]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_rolePermission]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_stage]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_stage] 
@id_stage bigint, @name nvarchar(100) = null, @stagePosition int = null, @userLog int as
begin
begin transaction 
	declare @event_log_id int, @table int
	update Stage set name = ISNULL(@name, name),
					stagePosition = ISNULL(@stagePosition, stagePosition)
	where id_stage = @id_stage

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Stage')
	exec @event_log_id = usp_insert_EventLog @description = 'updated stage', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 2, @user = @userLog;
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'stagePosition', @value = @stagePosition, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_stage', @value = @id_stage, @EventLog_id = @event_log_id
commit transaction 
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_template]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_user]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_update_user]
@user nvarchar(50), @userName nvarchar(50) = null, @name nvarchar(50), @fLastName nvarchar(50), @sLastName nvarchar(50) = null,
@email nvarchar(50), @phoneNumber nvarchar(50) = null, @canton_id tinyint = 1, @password nvarchar(50) = 'tmp1234',
@id numeric(9,0) = null, @birthdate nvarchar(20) = null, @direction nvarchar(50) = null, @photo varbinary(MAX) = null
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
					 direction = ISNULL(@direction, direction)
		where email = @email or userName = @userName
		update UsersPhotos set photoData = ISNULL(@photo, photoData)
		where [user_id] = @id_user;
commit transaction
end

GO
/****** Object:  StoredProcedure [dbo].[usp_update_userAttribute]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  StoredProcedure [dbo].[usp_update_userPhoto]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[AttributeList]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttributeTypes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Cantones]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[CategorieAttributes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Elements]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[ElementTypes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[EventLog]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[EventLog_Reference]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[EventSourceLog]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[EventTypeLog]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Forms]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Forms_Participants]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[GeneralAttributes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Group_Users]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Groups]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Modules]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Notifications]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[id_Notification] [bigint] NOT NULL,
	[message] [nvarchar](1000) NOT NULL,
	[task_id] [bigint] NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[id_Notification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notifications_Types]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications_Types](
	[id_Notification] [bigint] NOT NULL,
	[id_type] [tinyint] NOT NULL,
	[isReaded] [bit] NOT NULL,
	[isSended] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notifications_Users]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications_Users](
	[id_notification_users] [int] NOT NULL,
	[id_notification] [bigint] NULL,
	[id_user] [int] NULL,
 CONSTRAINT [PK_Notifications_Users] PRIMARY KEY CLUSTERED 
(
	[id_notification_users] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NotificationsTypes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationsTypes](
	[type_id] [tinyint] NOT NULL,
	[type] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_NotificationsTypes] PRIMARY KEY CLUSTERED 
(
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ObjectLog]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Parameters]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[ParameterType]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParameterType](
	[id_parameterType] [int] NOT NULL,
	[typeName] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[PersonalAttributes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Process]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Process](
	[processManagment_id] [bigint] NOT NULL,
	[template_id] [int] NOT NULL,
	[isCompleted] [bit] NOT NULL,
	[completedPorcentage] [int] NOT NULL,
	[nextProcess] [bigint] NOT NULL,
	[previousProcess] [bigint] NOT NULL,
 CONSTRAINT [PK_Process_1] PRIMARY KEY CLUSTERED 
(
	[processManagment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Process_Participants]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[ProcessManagment]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Provinces]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Reference]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reference](
	[Reference_id] [bigint] IDENTITY(1,1) NOT NULL,
	[attribute] [nvarchar](50) NOT NULL,
	[value] [nvarchar](80) NOT NULL,
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
/****** Object:  Table [dbo].[Roles]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Roles_Permissions]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Roles_Permissions_Elements]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[ScriptsLog]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScriptsLog](
	[id_script] [int] NOT NULL,
	[script] [nvarchar](1000) NOT NULL,
	[lastEjecutedDate] [datetime] NOT NULL,
	[ejecutedBy] [int] NOT NULL,
 CONSTRAINT [PK_ScriptsLog] PRIMARY KEY CLUSTERED 
(
	[id_script] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Stage]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stage](
	[id_stage] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[processManagment_id] [bigint] NOT NULL,
	[stagePosition] [int] NOT NULL,
	[createdBy] [int] NULL,
	[createdDate] [datetime] NULL,
 CONSTRAINT [PK_Stage] PRIMARY KEY CLUSTERED 
(
	[id_stage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Task]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[id_task] [bigint] NOT NULL,
	[stage_id] [bigint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NULL,
	[type_id] [int] NOT NULL,
	[isCompleted] [bit] NOT NULL,
	[completedDate] [datetime] NULL,
	[createdBy] [int] NOT NULL,
	[attendedBy] [int] NOT NULL,
	[duration] [int] NOT NULL,
	[taskPosition] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[id_task] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskFiles]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskFiles](
	[id_TaskFile] [int] NOT NULL,
	[id_Task] [bigint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[fileData] [varbinary](max) NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[createdBy] [int] NOT NULL,
 CONSTRAINT [PK_TaskFiles] PRIMARY KEY CLUSTERED 
(
	[id_TaskFile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaskForm]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskForm](
	[id_TaskForm] [bigint] NOT NULL,
	[task_id] [bigint] NOT NULL,
	[name] [bit] NOT NULL,
	[type_id] [smallint] NOT NULL,
	[attribute] [bigint] NOT NULL,
	[value] [varchar](500) NOT NULL,
	[list_id] [nchar](10) NULL,
 CONSTRAINT [PK_TaskForm] PRIMARY KEY CLUSTERED 
(
	[id_TaskForm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaskType]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskType](
	[id_taskType] [int] NOT NULL,
	[taskName] [nvarchar](50) NOT NULL,
	[needConfirm] [bit] NOT NULL,
 CONSTRAINT [PK_TaskType] PRIMARY KEY CLUSTERED 
(
	[id_taskType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Template]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
	[telegram] [nvarchar](80) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users_Roles]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[UsersFiles]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
/****** Object:  Table [dbo].[UsersPhotos]    Script Date: 03/10/2016 05:29:45 p.m. ******/
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
	[id_Photo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ValueTypes]    Script Date: 03/10/2016 05:29:45 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValueTypes](
	[id_Type] [smallint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ValueTypes] PRIMARY KEY CLUSTERED 
(
	[id_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [unique_name_Roles]    Script Date: 03/10/2016 05:29:45 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [unique_name_Roles] ON [dbo].[Roles]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_email_notnull]    Script Date: 03/10/2016 05:29:45 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_email_notnull] ON [dbo].[Users]
(
	[email] ASC
)
WHERE ([email] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_id_notnull]    Script Date: 03/10/2016 05:29:45 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_id_notnull] ON [dbo].[Users]
(
	[id] ASC
)
WHERE ([id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_username_notnull]    Script Date: 03/10/2016 05:29:45 p.m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [idx_username_notnull] ON [dbo].[Users]
(
	[userName] ASC
)
WHERE ([username] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_isEnabled]  DEFAULT ((0)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[Process] ADD  CONSTRAINT [DF_Process_isCompleted]  DEFAULT ((0)) FOR [isCompleted]
GO
ALTER TABLE [dbo].[Roles_Permissions] ADD  CONSTRAINT [DF_Roles_Permissions_isEnabled]  DEFAULT ((0)) FOR [isEnabled]
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
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Task]
GO
ALTER TABLE [dbo].[Notifications_Types]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Types_Notifications] FOREIGN KEY([id_Notification])
REFERENCES [dbo].[Notifications] ([id_Notification])
GO
ALTER TABLE [dbo].[Notifications_Types] CHECK CONSTRAINT [FK_Notifications_Types_Notifications]
GO
ALTER TABLE [dbo].[Notifications_Types]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Types_NotificationsTypes1] FOREIGN KEY([id_type])
REFERENCES [dbo].[NotificationsTypes] ([type_id])
GO
ALTER TABLE [dbo].[Notifications_Types] CHECK CONSTRAINT [FK_Notifications_Types_NotificationsTypes1]
GO
ALTER TABLE [dbo].[Notifications_Users]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users_Notifications] FOREIGN KEY([id_notification])
REFERENCES [dbo].[Notifications] ([id_Notification])
GO
ALTER TABLE [dbo].[Notifications_Users] CHECK CONSTRAINT [FK_Notifications_Users_Notifications]
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
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Process] CHECK CONSTRAINT [FK_Process_ProcessManagment]
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
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ScriptsLog] CHECK CONSTRAINT [FK_ScriptsLog_Users]
GO
ALTER TABLE [dbo].[Stage]  WITH CHECK ADD  CONSTRAINT [FK_Stage_ProcessManagment] FOREIGN KEY([processManagment_id])
REFERENCES [dbo].[ProcessManagment] ([id_processManagment])
GO
ALTER TABLE [dbo].[Stage] CHECK CONSTRAINT [FK_Stage_ProcessManagment]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Stage] FOREIGN KEY([stage_id])
REFERENCES [dbo].[Stage] ([id_stage])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Stage]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_TaskType] FOREIGN KEY([type_id])
REFERENCES [dbo].[TaskType] ([id_taskType])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_TaskType]
GO
ALTER TABLE [dbo].[TaskFiles]  WITH CHECK ADD  CONSTRAINT [FK_TaskFiles_Task] FOREIGN KEY([id_Task])
REFERENCES [dbo].[Task] ([id_task])
GO
ALTER TABLE [dbo].[TaskFiles] CHECK CONSTRAINT [FK_TaskFiles_Task]
GO
ALTER TABLE [dbo].[TaskForm]  WITH CHECK ADD  CONSTRAINT [FK_TaskForm_Task] FOREIGN KEY([task_id])
REFERENCES [dbo].[Task] ([id_task])
GO
ALTER TABLE [dbo].[TaskForm] CHECK CONSTRAINT [FK_TaskForm_Task]
GO
ALTER TABLE [dbo].[TaskForm]  WITH CHECK ADD  CONSTRAINT [FK_TaskForm_ValueTypes1] FOREIGN KEY([type_id])
REFERENCES [dbo].[ValueTypes] ([id_Type])
GO
ALTER TABLE [dbo].[TaskForm] CHECK CONSTRAINT [FK_TaskForm_ValueTypes1]
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
