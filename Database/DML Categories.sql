----------------------- Categories ----------------------------------------
--drop procedure usp_get_categories 
create procedure usp_get_categories as
begin 
	select c.id_categorie, c.name, c.[description], c.createdBy_name, c.createdBy_id, c.createdDate, c.isEnabled 
	from Categories c
end
go

--drop procedure sp_get_categorie 
create procedure usp_get_categorie
@id_categorie int as 
begin 
	select c.id_categorie, c.name, c.[description], c.createdBy_name, c.createdBy_id, c.createdDate, c.isEnabled 
	from Categories c where c.id_categorie = @id_categorie
end
go

--drop procedure usp_insert_categorie 
create procedure usp_insert_categorie
@name nvarchar(30), @description nvarchar(100), @createdBy_name nvarchar(80), @createdBy_id int as
begin
	insert into Categories (name, [description], createdBy_name, createdBy_id, createdDate, isEnabled)
	values (@name, @description, @createdBy_name, @createdBy_id, GETDATE(), 1)
end
go

--drop procedure usp_update_categorie 
create procedure usp_update_categorie
@id_categorie int, @name nvarchar(30) = null, @description nvarchar(100) = null, @isEnabled bit = null as
begin
	update Categories set name = ISNULL(@name, name),
	[description] = ISNULL(@description, [description]),
	isEnabled = ISNULL(@isEnabled, isEnabled)
	where id_categorie = @id_categorie
end
go

--drop procedure usp_delete_categorie 
create procedure usp_delete_categorie
@id_categorie int as
begin
	delete from Categories where id_categorie = @id_categorie
	select @@ROWCOUNT
end
go

--------------------------------------------- General Attributes -----------------------------------------------
--drop procedure sp_get_attributeTypes 
create procedure usp_get_attributeTypes as
begin
	select at.id_type, at.reg_expr, at.[type] from AttributeTypes at 
end
go

--drop procedure usp_get_attributeType 
create procedure usp_get_attributeType
@id_type int as
begin
	select at.id_type, at.reg_expr, at.[type] 
	from AttributeTypes at where at.id_type = @id_type
end
go
--drop procedure usp_get_generalAttributes
create procedure usp_get_generalAttributes 
@categorie_id int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type], ca.value, ca.isEnabled, ca.createdBy, ca.createdDate 
	from CategorieAttributes ca right outer join GeneralAttributes ga on ga.attribute_id = ca.id_attribute
	where ca.categorie_id = @categorie_id
end
go

--drop procedure usp_get_generalAttribute
create procedure usp_get_generalAttribute
@id_attribute bigint as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type],ca.value, ca.isEnabled, ca.createdBy, ca.createdDate 
	from CategorieAttributes ca
	where ca.id_attribute = @id_attribute
end
go

--exec sp_insert_generalAttribute @categorie_id = 17, @name = 'Inventario', @type_id = 1, @value = '', @createdBy = 75, @pUser = 75
-- drop procedure usp_insert_generalAttribute
create procedure usp_insert_generalAttribute
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
go

--drop procedure usp_delete_generalAttribute
create procedure usp_delete_generalAttribute
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
go

--drop procedure usp_update_generalAttribute
create procedure usp_update_generalAttribute
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
go


--------------------------------------------- Attribute Values -----------------------------------------------
-- drop procedure usp_get_AttributesList
create procedure usp_get_AttributesList 
@id_attribute bigint as
begin 
	select at.id_attributeValue, at.attribute_id, at.name, at.[type_id], at.value, at.isEnabled, at.createdBy, at.createdDate 
	from AttributeList at where at.attribute_id = @id_attribute;
end
go

-- drop procedure usp_get_AttributeList
create procedure usp_get_AttributeList 
@id_attributeValue bigint as
begin 
	select at.id_attributeValue, at.attribute_id, at.name, at.[type_id], at.value, at.isEnabled, at.createdBy, at.createdDate 
	from AttributeList at where at.id_attributeValue = @id_attributeValue;
end
go

-- drop procedure sp_insert_AttributeList
-- exec sp_insert_AttributeList @attribute_id = 43, @name = 'Laptop', @type_id = 1, @value = '1234', @createdBy = 75, @pUser = 75
create procedure usp_insert_AttributeList
@attribute_id bigint, @name nvarchar(50), @type_id tinyint, @value nvarchar(100), @createdBy int, @user int as
begin
begin transaction;
	declare @table int, @event_log_id int, @id_attributeValue int
	insert into AttributeList(attribute_id, name, [type_id], value, isEnabled, createdBy, createdDate) 
	values (@attribute_id, @name, @type_id, @value, 1, @createdBy, GETDATE());

	set @id_attributeValue = (SCOPE_IDENTITY())
	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'AttributeList')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted new attribute list', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @user;
	exec usp_insert_Reference @attribute = 'attribute_id', @value = @attribute_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'name', @value = @name, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'type_id', @value = @type_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'value', @value = @value, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'id_attributeValue', @value = @id_attributeValue, @EventLog_id = @event_log_id
commit transaction;
end 
go

--drop procedure usp_delete_AttributeList
create procedure usp_delete_AttributeList
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
go

--drop procedure usp_update_AttributeList
create procedure usp_update_AttributeList
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
go
--------------------------------------------- Personal attributes -----------------------------------------------

--drop procedure usp_get_personalAttributes
create procedure usp_get_personalAttributes 
@categorie_id int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type],ca.value, ca.isEnabled, ca.createdBy, ca.createdDate
	from CategorieAttributes ca
	where ca.categorie_id = @categorie_id and ca.isGeneral = 0
end
go

--drop procedure sp_getusp_get_personalAttribute_personalAttribute
create procedure usp_get_personalAttribute
@id_attribute int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type],ca.value, ca.isEnabled, ca.createdBy, ca.createdDate
	from CategorieAttributes ca
	where ca.id_attribute = @id_attribute
end
go

-- exec sp_insert_personalAttribute @categorie_id = 17, @name = 'Mouse', @type_id = 1, @value = '12', @createdBy = 75, @userLog = 75
-- drop procedure sp_insert_personalAttribute
create procedure usp_insert_personalAttribute
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
go

--drop procedure 

create procedure usp_delete_personalAttribute
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
go

--drop procedure sp_update_personalAttribute
create procedure usp_update_personalAttribute
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
go

--drop procedure sp_get_userAttributes_byCategorie
create procedure usp_get_userAttributes_byCategorie
@id_user int, @id_categorie int as
begin 
	select ca.id_attribute, ca.categorie_id, ca.name, ca.[type],ca.value as defaultValue, ca.isEnabled, ca.createdBy, ca.createdDate, pa.value
	from CategorieAttributes ca inner join 
	(select pa.attribute_id, pa.[user_id], pa.value from PersonalAttributes pa where pa.[user_id] = @id_user)pa
	on pa.attribute_id = ca.id_attribute
	where ca.categorie_id = @id_categorie
end
go

--drop procedure sp_get_userCategories
create procedure usp_get_userCategories
@id_user int as
begin 
	select ca.categorie_id, c.name, c.[description], c.isEnabled
	from CategorieAttributes ca inner join 
	(select pa.attribute_id, pa.[user_id], pa.value from PersonalAttributes pa where pa.[user_id] = 75)pa
	on pa.attribute_id = ca.id_attribute
	inner join Categories c on c.id_categorie = ca.categorie_id
	group by ca.categorie_id, c.name, c.[description], c.isEnabled
end
go

-- drop procedure usp_update_userAttribute
create procedure usp_update_userAttribute
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



------------------------------------------------- Logs  -----------------------------------------------

-- select specific table logs
declare @objectLog_id int 
set @objectLog_id = (select ol.ObjectLog_id from ObjectLog ol where ol.name = 'PersonalAttributes')
select el.EventLog_id, el.[description], el.objectLog_id, el.eventTypeLog_id, el.eventSourceLog_id, el.postTime, r.attribute, r.value
from EventLog el inner join EventLog_Reference er on el.EventLog_id = er.eventLog_id inner join Reference r on er.reference_id = r.Reference_id
where el.objectLog_id = @objectLog_id
go

-- select specific categorie attributes
set statistics time on 
declare @objectLog_id int 
set @objectLog_id = (select ol.ObjectLog_id from ObjectLog ol where ol.name = 'CategorieAttributes')
select * from 
(
	select el.EventLog_id, el.[description], el.postTime, r.attribute, r.value from 
	(select el.EventLog_id, el.[description], el.postTime from EventLog el where el.eventTypeLog_id = 1 and (el.eventSourceLog_id = 1 or el.eventTypeLog_id = 2) and el.objectLog_id = @objectLog_id)el
	inner join EventLog_Reference er on er.eventLog_id = el.EventLog_id
	inner join (select r.Reference_id, r.attribute, r.value from Reference r)r on r.Reference_id = er.reference_id
)src pivot (max (src.value) for attribute in (id_attribute,name,[type_id],categorie_id))piv
set statistics time off
go

--- test select 
	declare @objectLog_id int 
	set @objectLog_id = (select ol.ObjectLog_id from ObjectLog ol where ol.name = 'CategorieAttributes')
	select el.EventLog_id, el.[description], el.postTime, r.attribute, r.value from 
	(select el.EventLog_id, el.[description], el.postTime from EventLog el where el.eventTypeLog_id = 1 and (el.eventSourceLog_id = 1 or el.eventTypeLog_id = 2) and el.objectLog_id = @objectLog_id)el
	inner join EventLog_Reference er on er.eventLog_id = el.EventLog_id
	inner join (select r.Reference_id, r.attribute, r.value from Reference r)r on r.Reference_id = er.reference_id
	where attribute = 'id_attribute'
---


-- Pivot example
select Reference_id,  id_attribute
from (select Reference_id, value, attribute from Reference where attribute = 'id_attribute') r 
pivot (max(value) for attribute in (id_attribute))piv
