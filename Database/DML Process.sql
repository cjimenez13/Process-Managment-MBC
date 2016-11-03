-- drop procedure usp_get_processes
create procedure usp_get_userProcess
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
create procedure usp_get_processes as
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
go
-- drop procedure usp_get_process
-- exec usp_get_process 18
create procedure usp_get_process 
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
go  

--drop procedure usp_update_bifurcateProcess
create procedure usp_update_bifurcateProcess
@nextProcess bigint, @previousProcess bigint, @userLog int as
begin
	update Process set nextProcess = @nextProcess
	where processManagment_id = @previousProcess

	update Process set previousProcess = @previousProcess
	where processManagment_id = @nextProcess
end
go
-- delete from ProcessManagment where isProcess = 1
-- exec usp_insert_process @name = 'test', @categorie_id = 17, @template_id = 1, @userLog = 76
-- delete from ProcessManagment where isProcess  = 1
-- drop procedure usp_insert_process

create procedure usp_insert_process 
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
		declare @isFirst bit = 0
		declare @lastFinishDate datetime = GETDATE()
		open cursor_stages
		fetch next from cursor_stages into @stage_name, @stage_processManagment_id, @stage_stagePosition, @oldStage_id
		while @@FETCH_STATUS = 0 
		begin
			insert into Stage(name, processManagment_id, stagePosition, createdBy, createdDate) values (@stage_name, @stage_processManagment_id, @stage_stagePosition, @userLog, GETDATE())
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
				set @lastFinishDate = DATEADD(hour, @task_hoursAvailable, (DATEADD(day, @task_daysAvailable, @lastFinishDate)));
				if (@isFirst = 0)
				begin
				insert into Task (stage_id, name, [description], [type_id], taskState_id, completedDate, createdBy, finishDate, taskPosition, createdDate, beginDate, daysAvailable, hoursAvailable)
				values (@stage_id, @task_name, @task_description, @task_type_id, 1, null, @userLog, @lastFinishDate, @taskPosition, GETDATE(), GETDATE(), @task_daysAvailable, @task_hoursAvailable) 
				set @isFirst = 1
				end
				else
				begin
				insert into Task (stage_id, name, [description], [type_id], taskState_id, completedDate, createdBy, finishDate, taskPosition, createdDate, beginDate, daysAvailable, hoursAvailable)
				values (@stage_id, @task_name, @task_description, @task_type_id, 0, null, @userLog, @lastFinishDate, @taskPosition, GETDATE(), null, @task_daysAvailable, @task_hoursAvailable) 
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
go

--select * from ProcessManagment where isProcess  = 1
--select * from Task order by stage_id
-- select * from QuestionResponse
create procedure usp_update_taskTimes
@processManagment_id int as
begin 
	-- stages 
	declare cursor_stages cursor forward_only fast_forward
	for select s.id_stage from Stage s where s.processManagment_id = @processManagment_id order by s.stagePosition
	declare @stage_id bigint;
	declare @lastFinishDate datetime = GETDATE();
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
			end
			else
			begin
				set @lastFinishDate = DATEADD(hour, @task_hoursAvailable, (DATEADD(day, @task_daysAvailable, @lastFinishDate)));
			end
			fetch next from cursor_tasks into @old_task_id, @task_name, @task_description, @task_type_id, @taskState_id, @taskPosition, @task_daysAvailable, @task_hoursAvailable, @task_createdDate
		end
		close cursor_tasks
		deallocate cursor_tasks
		fetch next from cursor_stages into @stage_id
	end
	close cursor_stages
	deallocate cursor_stages
end
go 
-- drop procedure usp_update_process
create procedure usp_update_process
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
go

create procedure usp_delete_process
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
go
