-- drop procedure usp_get_process
create procedure usp_get_processes as
begin
	select pm2.id_ProcessManagment, pm2.name, pm2.createdBy, pm2.createdDate, pm2.categorie_id, p.completedPorcentage, p.template_id, p.state_id, 
	ps.state_name, ps.state_color, (select c. name from Categories c where c.id_categorie = pm2.categorie_id) as categorie_name, 
	(select t.name from ProcessManagment t where t.id_processManagment = p.template_id) as template_name
	from (select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id from ProcessManagment pm where pm.isProcess = 1)pm2
	inner join Process p on p.processManagment_id = pm2.id_ProcessManagment
	inner join ProcessState ps on ps.id_processState = p.state_id
end
go
create procedure usp_get_process 
@id_process bigint as
begin
	select pm2.id_ProcessManagment, pm2.name, pm2.createdBy, pm2.createdDate, pm2.categorie_id, p.completedPorcentage, p.template_id, p.state_id, 
	ps.state_name, ps.state_color, (select c. name from Categories c where c.id_categorie = pm2.categorie_id) as categorie_name, 
	(select t.name from ProcessManagment t where t.id_processManagment = p.template_id) as template_name
	from (select pm.id_ProcessManagment, pm.name, pm.createdBy, pm.createdDate, pm.categorie_id from ProcessManagment pm where pm.isProcess = 1 and pm.id_processManagment = @id_process)pm2
	inner join Process p on p.processManagment_id = pm2.id_ProcessManagment
	inner join ProcessState ps on ps.id_processState = p.state_id
end
go  

-- delete from ProcessManagment where isProcess = 1
-- exec usp_insert_process @name = 'test', @categorie_id = 17, @template_id = 1, @userLog = 76
-- drop procedure usp_insert_process
create procedure usp_insert_process
@name nvarchar(100), @categorie_id int = null, @template_id bigint, @previousProcess bigint = null, @userLog int as
begin
begin transaction 
	declare @processManagment_id  int, @event_log_id int, @table int
	insert into ProcessManagment (name, createdBy, createdDate, categorie_id, isProcess)
	values (@name, @userLog, GETDATE(), @categorie_id,1)
	set @processManagment_id = (SCOPE_IDENTITY())
	insert into Process(processManagment_id, template_id, state_id, completedPorcentage, previousProcess) values (@processManagment_id, @template_id, 0, 0, @previousProcess)
	if (@template_id is not null)
	begin 
		-- Participans
		insert into Process_Participants(processManagment_id, [user_id]) 
		select @processManagment_id, pp.[user_id] from Process_Participants pp where pp.processManagment_id = @template_id
		-- stages 
		declare cursor_stages cursor forward_only fast_forward
		for select s.name, @processManagment_id, s.stagePosition from Stage s where s.processManagment_id = @template_id
		declare @stage_name nvarchar(100), @stage_processManagment_id bigint, @stage_stagePosition int, @stage_id bigint;
		open cursor_stages
		fetch next from cursor_stages into @stage_name, @stage_processManagment_id, @stage_stagePosition
		while @@FETCH_STATUS = 0 
		begin
			insert into Stage(name, processManagment_id, stagePosition, createdBy, createdDate) values (@stage_name, @stage_processManagment_id, @stage_stagePosition, @userLog, GETDATE())
			set @stage_id = (select SCOPE_IDENTITY())
			------ Tasks
			declare cursor_tasks cursor forward_only fast_forward
			for select t.name, t.[description], t.[type_id], t.taskState_id, t.taskPosition, t.daysAvailable, t.hoursAvailable from Task t where t.stage_id = @stage_id
			declare @task_name nvarchar(100), @id_task bigint, @task_description nvarchar(150), @task_type_id int, @taskState_id int, @taskPosition int, @task_daysAvailable int, @task_hoursAvailable int;
			open cursor_tasks
			fetch next from cursor_tasks into @task_name, @task_description, @task_type_id, @taskState_id, @taskState_id, @task_daysAvailable, @task_hoursAvailable
			while @@FETCH_STATUS = 0 
			begin
				insert into Task (stage_id, name, [description], [type_id], taskState_id, completedDate, createdBy, finishDate, taskPosition, createdDate, beginDate, daysAvailable, hoursAvailable)
				values (@stage_id, @task_name, @task_description, @task_type_id, 0, null, @userLog, null, @taskPosition, GETDATE(), null, @task_daysAvailable, @task_hoursAvailable) 
				fetch next from cursor_tasks into @task_name, @task_description, @task_type_id, @taskState_id, @taskState_id, @task_daysAvailable, @task_hoursAvailable
			end
			close cursor_tasks
			deallocate cursor_tasks
			fetch next from cursor_stages into @stage_name, @stage_processManagment_id, @stage_stagePosition
		end
		close cursor_stages
		deallocate cursor_stages
		--insert into Stage(name, processManagment_id, stagePosition, createdBy, createdDate)
		--select s.name, @processManagment_id, s.stagePosition, @userLog, GETDATE() from Stage s where s.processManagment_id = @template_id
	end
commit transaction 
end
go


create procedure usp_update_process
@id_process int, @name nvarchar(100) = null, @previousProcess bigint = null, @completedPorcentage int = null, @nextProcess bigint = null, @state_id tinyint, @userLog int as
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

