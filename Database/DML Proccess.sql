create procedure usp_insert_process
@name nvarchar(100), @categorie_id int = null, @template_id int = null, @userLog int, @previousProcess int as
begin
begin transaction 
	declare @processManagment_id  int
	insert into ProcessManagment (name, createdBy, createdDate, categorie_id, isProcess)
	values (@name, @userLog, GETDATE(), @categorie_id,1)
	set @processManagment_id = (SCOPE_IDENTITY())
	insert into Process (processManagment_id, template_id, isCompleted, completedPorcentage, nextProcess, previousProcess)
	values (@processManagment_id, @template_id, 0, 0, null, @previousProcess)
commit transaction 
end