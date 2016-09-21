execute sp_insert_categorie @name = 'Vacaciones', @description='Vacaciones', @createdBy_name = 'Christian Jiménez', @createdBy_id =75 
execute sp_insert_categorie @name = 'Activos', @description='Administración de activos en la empresa', @createdBy_name = 'Yorley Aguilar', @createdBy_id =76

select * from Users
delete from Categories
----------------------- Categories ----------------------------------------
create procedure sp_get_categories as
begin 
	select c.id_categorie, c.name, c.[description], c.createdBy_name, c.createdBy_id, c.createdDate, c.isEnabled 
	from Categories c
end
go
1
create procedure sp_get_categorie
@id_categorie int as 
begin 
	select c.id_categorie, c.name, c.[description], c.createdBy_name, c.createdBy_id, c.createdDate, c.isEnabled 
	from Categories c where c.id_categorie = @id_categorie
end
go

create procedure sp_insert_categorie
@name nvarchar(30), @description nvarchar(100), @createdBy_name nvarchar(80), @createdBy_id int as
begin
	insert into Categories (name, [description], createdBy_name, createdBy_id, createdDate, isEnabled)
	values (@name, @description, @createdBy_name, @createdBy_id, GETDATE(), 1)
end
go

create procedure sp_update_categorie
@id_categorie int, @name nvarchar(30) = null, @description nvarchar(100) = null, @isEnabled bit = null as
begin
	update Categories set name = ISNULL(@name, name),
	[description] = ISNULL(@description, [description]),
	isEnabled = ISNULL(@isEnabled, isEnabled)
	where id_categorie = @id_categorie
end
go

create procedure sp_delete_categorie
@id_categorie int as
begin
	delete from Categories where id_categorie = @id_categorie
	select @@ROWCOUNT
end
go




--------------------------------------------- General Attributes -----------------------------------------------

create procedure sp_get_attributeTypes as
begin
	select at.id_type, at.reg_expr, at.[type] from AttributeTypes at 
end
go

create procedure sp_get_attributeType
@id_type int as
begin
	select at.id_type, at.reg_expr, at.[type] 
	from AttributeTypes at where at.id_type = @id_type
end
go
--drop procedure sp_get_generalAttributes
create procedure sp_get_generalAttributes 
@categorie_id int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type], 
	(select at.[type] from AttributeTypes at where at.id_type = ca.[type]) as [type_name],
	(select at.reg_expr from AttributeTypes at where at.id_type = ca.[type]) as reg_expr,
	ca.value, ca.isEnabled, ca.createdBy, ca.createdDate 
	from CategorieAttributes ca right outer join GeneralAttributes ga on ga.attribute_id = ca.id_attribute
	where ca.categorie_id = @categorie_id
end
go

create procedure sp_get_generalAttribute
@id_attribute int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type], 
	(select at.[type] from AttributeTypes at where at.id_type = ca.[type]) as [type_name],
	(select at.reg_expr from AttributeTypes at where at.id_type = ca.[type]) as reg_expr,
	ca.value, ca.isEnabled, ca.createdBy, ca.createdDate 
	from CategorieAttributes ca
	where ca.id_attribute = @id_attribute
end
go

--exec sp_insert_generalAttribute @categorie_id = 17, @name = 'Inventario', @type_id = 1, @value = '', @createdBy = 75, @pUser = 75
-- drop procedure sp_insert_generalAttribute
-- delete from CategorieAttributes
create procedure sp_insert_generalAttribute
@categorie_id int, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @createdBy int, @pUser int as
begin
	declare @table int, @event_log_id int, @id_attribute int
	insert into CategorieAttributes (categorie_id, name, [type], value, isEnabled, createdBy, createdDate, isGeneral) 
	values (@categorie_id, @name, @type_id, @value, 1, @createdBy, GETDATE(), 1);
	set @id_attribute = (SCOPE_IDENTITY())
	insert into GeneralAttributes (attribute_id) values (@id_attribute)
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'CategorieAttributes')
	exec @event_log_id = sp_insert_EventLog @description = 'inserted new general attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @pUser;
	exec sp_insert_Reference @attribute = 'categorie_id', @value = @categorie_id, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'isGeneral', @value = '1', @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'id_attribute', @value = @id_attribute, @EventLog_id = @event_log_id
end 
go

--drop procedure sp_delete_generalAttribute
create procedure sp_delete_generalAttribute
@id_attribute bigint, @pUser int as
begin
	delete from CategorieAttributes where id_attribute = @id_attribute
	select @@ROWCOUNT
end
go

--drop procedure sp_update_generalAttribute
create procedure sp_update_generalAttribute
@id_attribute int, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @isEnabled bit, @pUser int as
begin
	update CategorieAttributes set name = ISNULL(@name, name),
		[type] = ISNULL(@type_id, [type]),
		value = ISNULL(@value, value),
		isEnabled = ISNULL(@isEnabled, isEnabled)
		where id_attribute = @id_attribute
	declare @table int, @event_log_id int
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'CategorieAttributes')
	exec @event_log_id = sp_insert_EventLog @description = 'updated general attribute', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @pUser;
	exec sp_insert_Reference @attribute = 'id_attribute', @value = @id_attribute, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'isEnabled', @value = @isEnabled, @EventLog_id = @event_log_id
end
go


--------------------------------------------- Attribute Values -----------------------------------------------
create procedure sp_get_AttributesList 
@id_attribute int as
begin 
	select at.id_attributeValue, at.attribute_id, at.name, at.[type_id], at.value, at.isEnabled, at.createdBy, at.createdDate 
	from AttributeList at where at.attribute_id = @id_attribute;
end
go

create procedure sp_get_AttributeList 
@id_attributeValue int as
begin 
	select at.id_attributeValue, at.attribute_id, at.name, at.[type_id], at.value, at.isEnabled, at.createdBy, at.createdDate 
	from AttributeList at where at.id_attributeValue = @id_attributeValue;
end
go

create procedure sp_get_generalAttribute
@id_attribute int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.value, ca.isEnabled, ca.createdBy, ca.createdDate 
	from CategorieAttributes ca 
	where ca.id_attribute = @id_attribute
end
go
-- drop procedure sp_insert_generalAttribute
create procedure sp_insert_AttributeList
@attribute_id int, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @createdBy int, @pUser int as
begin
	declare @table int, @event_log_id int, @id_attributeValue int
	insert into AttributeList(attribute_id, name, [type_id], value, isEnabled, createdBy, createdDate) 
	values (@attribute_id, @name, @type_id, @value, 1, @createdBy, GETDATE());

	set @id_attributeValue = (SCOPE_IDENTITY())
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'AttributeList')
	exec @event_log_id = sp_insert_EventLog @description = 'inserted new attribute list', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @pUser;
	exec sp_insert_Reference @attribute = 'attribute_id', @value = @attribute_id, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'id_attributeValue', @value = @id_attributeValue, @EventLog_id = @event_log_id
end 
go

--drop procedure sp_delete_generalAttribute
create procedure sp_delete_AttributeList
@id_attributeValue bigint, @pUser int as
begin
	delete from AttributeList where id_attributeValue = @id_attributeValue
	select @@ROWCOUNT
end
go

--drop procedure sp_update_generalAttribute
create procedure sp_update_AttributeList
@id_attributeValue int, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @isEnabled bit, @pUser int as
begin
	update AttributeList set name = ISNULL(@name, name),
		[type_id] = ISNULL(@type_id, [type_id]),
		value = ISNULL(@value, value),
		isEnabled = ISNULL(@isEnabled, isEnabled)
		where id_attributeValue = @id_attributeValue

	declare @table int, @event_log_id int
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'AttributeList')
	exec @event_log_id = sp_insert_EventLog @description = 'updated attribute list', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @pUser;
	exec sp_insert_Reference @attribute = 'id_attributeValue', @value = @id_attributeValue, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec sp_insert_Reference @attribute = 'isEnabled', @value = @isEnabled, @EventLog_id = @event_log_id
end
