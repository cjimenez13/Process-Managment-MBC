-------------------------------------------- Tasks --------------------------------------------------
-- drop procedure usp_get_userTasks
create procedure usp_get_userTasks
@user_id int as 
begin 
	select t.id_task, t.stage_id, t.name, t.[description], t.[type_id], t.stage_id, t.taskState_id, t.createdBy, t.finishDate, t.taskPosition, t.createdDate, 
	t.beginDate, t.daysAvailable, t.hoursAvailable, tt.[user_id],
	(select pm.name from ProcessManagment pm where pm.id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = t.stage_id)) as process_name
	from Task_Targets tt inner join Task t on t.id_task = tt.task_id
	where tt.[user_id] = 75 and tt.isConfirmed = 0 and t.taskState_id = 1 or t.taskState_id = 0
	order by t.[type_id] desc, finishDate desc
end

create procedure usp_get_process_tasks
@id_stage bigint as
begin 
	select t.id_task, t.stage_id, t.name, t.[description], t.[type_id], t.taskState_id, t.completedDate, t.createdBy, t.finishDate, t.taskPosition, t.createdDate, 
	t.beginDate, t.daysAvailable, t.hoursAvailable,
	(select pm.isProcess from ProcessManagment pm where pm.id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = @id_stage)) as isProcess
	from Task t where t.stage_id = @id_stage
	order by t.taskPosition
end
go
-- drop procedure usp_get_process_task
create procedure usp_get_process_task
@id_task bigint as
begin 
	select t.id_task, t.stage_id, t.name, t.[description], t.[type_id], t.taskState_id, t.completedDate, t.createdBy, t.finishDate, t.taskPosition, t.createdDate, 
	t.beginDate, t.daysAvailable, t.hoursAvailable,
	(select pm.isProcess from ProcessManagment pm where pm.id_processManagment = (select s.processManagment_id from Stage s where s.id_stage = t.stage_id)) as isProcess
	from Task t where t.id_task = @id_task
	order by t.taskPosition
end
go

-- drop procedure usp_get_participantsTask
create procedure usp_get_participantsTask
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


-- drop procedure usp_insert_task
create procedure usp_insert_task
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
go
-- drop procedure usp_update_task
create procedure usp_update_task
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
go

create procedure usp_delete_task
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
go

--------------------------- Task types --------------------------------

create procedure usp_get_taskTypes as
begin 
	select tt.id_taskType, tt.taskName, tt.needConfirm, tt.formNeeded
	from TaskType tt 
end
go 

create procedure usp_get_taskType
@id_taskType tinyint as
begin 
	select tt.id_taskType, tt.taskName, tt.needConfirm, tt.formNeeded
	from TaskType tt
	where tt.id_taskType = @id_taskType 
end
go 

create procedure usp_get_taskStates as 
begin 
	select ts.id_taskState, state_name, state_color
	from taskState ts
end
go

create procedure usp_get_taskState 
@id_taskState int as 
begin 
	select ts.id_taskState, state_name, state_color
	from taskState ts
	where ts.id_taskState = @id_taskState
end
go


------------------------------------- // Task Targets // ----------------------------------
-- drop procedure usp_get_taskTargets
create procedure usp_get_taskTargets
@task_id bigint as
begin
	select part.task_id, part.[user_id],  part.isConfirmed, u.name, u.sLastName, u.fLastName, u.userName, u.email,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from (select tt.task_id, tt.[user_id], tt.isConfirmed from Task_Targets tt where tt.task_id = @task_id) part 
	inner join Users u on part.[user_id] = u.id_user
	where u.isEnabled = 1
end
go

-- drop procedure usp_insert_usertaskTargets
create procedure usp_insert_usertaskTargets
@task_id bigint, @user_id int, @userLog int as 
begin 
set transaction isolation level snapshot
begin transaction
	declare @event_log_id int, @table int
	insert into Task_Targets ([user_id], task_id, isConfirmed)
	values (@user_id, @task_id, 0);

	set @table = (select objectLog_id from ObjectLog ol where ol.name = 'Task_Targets')
	exec @event_log_id = usp_insert_EventLog @description = 'inserted responsable', 
	@objectLog_id = @table, @eventTypeLog_id = 1, @eventSource_id = 1, @user = @userLog;
	exec usp_insert_Reference @attribute = 'id_task', @value = @task_id, @EventLog_id = @event_log_id
	exec usp_insert_Reference @attribute = 'user_id', @value = @user_id, @EventLog_id = @event_log_id
commit transaction
end
go

create procedure usp_insert_grouptaskTargets
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
go 

--drop procedure usp_delete_taskTarget
create procedure usp_delete_taskTarget
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
go

create procedure usp_update_taskTarget
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
go



------------------------------------- // Task Form // ----------------------------------
-------- //Questions
-- drop procedure usp_getTaskQuestions
create procedure usp_getTaskQuestions
@taskForm_id bigint as
begin
	select fq.id_taskQuestion, fq.taskForm_id, fq.question, fq.generalAttributeList, fq.questionType_id,fq.questionPosition, fq.isRequired
	from FormQuestions fq 
	where fq.taskForm_id = @taskForm_id
	order by fq.questionPosition
end
go
-- drop procedure usp_getTaskQuestion
create procedure usp_getTaskQuestion
@id_taskQuestion bigint as
begin
	select fq.id_TaskQuestion, fq.taskForm_id, fq.question, fq.generalAttributeList, fq.questionType_id, fq.questionPosition, fq.isRequired
	from FormQuestions fq 
	where fq.id_taskQuestion = @id_taskQuestion
end
go
create procedure usp_get_questionTypes as
begin 
	select qt.id_questionType, qt.name from QuestionType qt 
end
go
create procedure usp_get_availableAttributesbyTask
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
go
--drop procedure usp_insert_question
create procedure usp_insert_question
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
go
--drop procedure usp_update_question
create procedure usp_update_question
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
go

create procedure usp_delete_question
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
go

------- //Question Changes
create procedure usp_getQuestionChanges
@id_taskQuestion bigint as 
begin 
	select qc2.taskQuestion_id, qc2.taskChange_id, tc.task_id, tc.id_attribute, tc.operation_id, tc.value from (select qc.taskQuestion_id, qc.taskChange_id from QuestionChanges qc
	where qc.taskQuestion_id = @id_taskQuestion) qc2
	inner join TaskChanges tc on tc.id_taskChange = qc2.taskChange_id
end
go
------- //Form
create procedure usp_getTaskForm
@id_task bigint as
begin
	select tf.id_taskForm, tf.[description], tf.task_id
	from TaskForm tf 
	where tf.task_id = @id_task
end
go
--drop procedure usp_insert_form
create procedure usp_insert_form
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
go
create procedure usp_update_form
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
go

--// Form users
--drop procedure usp_get_formUsers
create procedure usp_get_formUsers
@taskForm_id bigint as
begin
	select part.[user_id], part.taskForm_id,  part.isAnswered, u.name, u.sLastName, u.fLastName, u.userName, u.email,
	(select up.photoData from UsersPhotos up where u.id_user = up.[user_id] ) as photoData
	from (select fu.[user_id], fu.isAnswered, fu.taskForm_id from Form_Users fu where fu.taskForm_id = @taskForm_id) part 
	inner join Users u on part.[user_id] = u.id_user
	where u.isEnabled = 1
end
go

--drop procedure usp_insert_formUser
create procedure usp_insert_formUser
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
go
-- drop procedure usp_delete_formUser
create procedure usp_delete_formUser
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
go
------------------------------------- // Task Changes // ----------------------------------
-- drop procedure usp_get_TaskChanges
create procedure usp_get_TaskChanges 
@id_task bigint as 
begin 
	select tc.id_taskChange, tc.task_id, tc.attribute_id, tc.operation_id, tc.value, tc.attributeList_id, 
	(select ca.[type] from CategorieAttributes ca where ca.id_attribute = tc.attribute_id) as attribute_type,
	(select al.[type_id] from AttributeList al where al.id_attributeValue = tc.attributeList_id) as attributeList_type
	from TaskChanges tc
	where tc.task_id = @id_task
end
go

-- drop procedure usp_get_OperationTypes
create procedure usp_get_OperationTypes as 
begin 
	select ot.id_operationType, ot.displayName, ot.operation, ot.reg_expr from OperationType ot
end
go

-- drop procedure usp_insert_taskChange
create procedure usp_insert_taskChange
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
go

-- drop procedure usp_update_taskChange
create procedure usp_update_taskChange
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
go

create procedure usp_delete_taskChange
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


