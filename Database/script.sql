USE [RRHH]
GO
/****** Object:  Table [dbo].[AttributeValues]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeValues](
	[id_attributeValue] [bigint] NOT NULL,
	[id_attribute] [bigint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[value] [nvarchar](50) NOT NULL,
	[isEnabled] [bit] NOT NULL,
	[createdBy] [int] NOT NULL,
	[updatedBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[updatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AttributeValues] PRIMARY KEY CLUSTERED 
(
	[id_attributeValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cantones]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[CategorieAttributes]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategorieAttributes](
	[id_attribute] [bigint] NOT NULL,
	[categorie_id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[value] [nvarchar](50) NOT NULL,
	[isEnabled] [bit] NOT NULL,
	[createdBy] [int] NOT NULL,
	[updatedBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[updatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CategorieAttributes_1] PRIMARY KEY CLUSTERED 
(
	[id_attribute] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[id_categorie] [int] NOT NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](50) NULL,
	[createdBy] [int] NULL,
	[createdDate] [datetime] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[id_categorie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventLog]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
	[userName] [nvarchar](30) NOT NULL,
	[CHKsum] [int] NOT NULL,
 CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED 
(
	[EventLog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventSourceLog]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[EventTypeLog]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Forms]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Forms_Participants]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[GeneralAttributes]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Group_Users]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Groups]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[id_group] [int] NOT NULL,
	[groupName] [nvarchar](50) NOT NULL,
	[createdDate] [nchar](10) NOT NULL,
	[isEnabled] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[id_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[module]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[module](
	[module_id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[type_id] [int] NOT NULL,
 CONSTRAINT [PK_module] PRIMARY KEY CLUSTERED 
(
	[module_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[moduleTypes]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[moduleTypes](
	[id_moduleType] [int] NOT NULL,
	[type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_moduleTypes] PRIMARY KEY CLUSTERED 
(
	[id_moduleType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Notifications_Types]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Notifications_Users]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[NotificationsTypes]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[ObjectLog]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Parameters]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[ParameterType]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParameterType](
	[id_parameterType] [int] NOT NULL,
	[typeName] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permission_Module]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission_Module](
	[permission_id] [int] NOT NULL,
	[module_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[id_permission] [int] NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[isEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[id_permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonalAttributes]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonalAttributes](
	[attribute_id] [bigint] NOT NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_PersonalAttributes] PRIMARY KEY CLUSTERED 
(
	[attribute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Process]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Process](
	[id_process] [bigint] NOT NULL,
	[processManagment_id] [bigint] NOT NULL,
	[template_id] [int] NOT NULL,
	[isCompleted] [bit] NOT NULL,
	[completedPorcentage] [int] NOT NULL,
	[nextProcess] [bigint] NOT NULL,
	[previousProcess] [bigint] NOT NULL,
 CONSTRAINT [PK_Process] PRIMARY KEY CLUSTERED 
(
	[id_process] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Process_Participants]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[ProcessManagment]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessManagment](
	[id_ProcessManagment] [bigint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [nvarchar](50) NOT NULL,
	[categorie_id] [int] NOT NULL,
 CONSTRAINT [PK_ProcessManagment] PRIMARY KEY CLUSTERED 
(
	[id_ProcessManagment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provinces]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Reference]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
	[userName] [nvarchar](30) NOT NULL,
	[CHKsum] [int] NOT NULL,
 CONSTRAINT [PK_Reference] PRIMARY KEY CLUSTERED 
(
	[Reference_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reference_by_EventLog]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reference_by_EventLog](
	[Reference_id] [bigint] NOT NULL,
	[eventLog_id] [bigint] NOT NULL,
	[postTime] [datetime] NULL,
	[computer] [nvarchar](30) NOT NULL,
	[userName] [nvarchar](30) NOT NULL,
	[CHKsum] [int] NOT NULL,
 CONSTRAINT [PK_Reference_by_EventLog_1] PRIMARY KEY CLUSTERED 
(
	[Reference_id] ASC,
	[eventLog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id_role] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles_Permissions]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles_Permissions](
	[role_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
 CONSTRAINT [PK_Roles_Permissions_1] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ScriptsLog]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Stage]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stage](
	[id_stage] [bigint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
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
/****** Object:  Table [dbo].[Task]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[TaskFiles]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[TaskForm]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[TaskType]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[Template]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Template](
	[id_Template] [int] NOT NULL,
	[processManagment_id] [bigint] NOT NULL,
 CONSTRAINT [PK_Template] PRIMARY KEY CLUSTERED 
(
	[id_Template] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users_Roles]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[UsersFiles]    Script Date: 02/09/2016 05:22:38 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UsersFiles](
	[id_file] [int] NOT NULL,
	[user_id] [int] NULL,
	[dataFile] [varbinary](max) NULL,
	[createdDate] [datetime] NULL,
 CONSTRAINT [PK_UsersFiles] PRIMARY KEY CLUSTERED 
(
	[id_file] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsersPhotos]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
/****** Object:  Table [dbo].[ValueTypes]    Script Date: 02/09/2016 05:22:38 p.m. ******/
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
ALTER TABLE [dbo].[Groups] ADD  CONSTRAINT [DF_Groups_isEnabled]  DEFAULT ((0)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF_Permissions_isEnabled]  DEFAULT ((0)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[Process] ADD  CONSTRAINT [DF_Process_isCompleted]  DEFAULT ((0)) FOR [isCompleted]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_isEnabled]  DEFAULT ((1)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[AttributeValues]  WITH CHECK ADD  CONSTRAINT [FK_AttributeValues_CategorieAttributes] FOREIGN KEY([id_attribute])
REFERENCES [dbo].[CategorieAttributes] ([id_attribute])
GO
ALTER TABLE [dbo].[AttributeValues] CHECK CONSTRAINT [FK_AttributeValues_CategorieAttributes]
GO
ALTER TABLE [dbo].[Cantones]  WITH CHECK ADD  CONSTRAINT [FK_Cantones_Provinces1] FOREIGN KEY([province_id])
REFERENCES [dbo].[Provinces] ([id_province])
GO
ALTER TABLE [dbo].[Cantones] CHECK CONSTRAINT [FK_Cantones_Provinces1]
GO
ALTER TABLE [dbo].[CategorieAttributes]  WITH CHECK ADD  CONSTRAINT [FK_CategorieAttributes_Categories1] FOREIGN KEY([categorie_id])
REFERENCES [dbo].[Categories] ([id_categorie])
GO
ALTER TABLE [dbo].[CategorieAttributes] CHECK CONSTRAINT [FK_CategorieAttributes_Categories1]
GO
ALTER TABLE [dbo].[CategorieAttributes]  WITH CHECK ADD  CONSTRAINT [FK_CategorieAttributes_PersonalAttributes] FOREIGN KEY([id_attribute])
REFERENCES [dbo].[PersonalAttributes] ([attribute_id])
GO
ALTER TABLE [dbo].[CategorieAttributes] CHECK CONSTRAINT [FK_CategorieAttributes_PersonalAttributes]
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
GO
ALTER TABLE [dbo].[GeneralAttributes] CHECK CONSTRAINT [FK_GeneralAttributes_CategorieAttributes]
GO
ALTER TABLE [dbo].[Group_Users]  WITH CHECK ADD  CONSTRAINT [FK_Group_Users_Groups] FOREIGN KEY([group_id])
REFERENCES [dbo].[Groups] ([id_group])
GO
ALTER TABLE [dbo].[Group_Users] CHECK CONSTRAINT [FK_Group_Users_Groups]
GO
ALTER TABLE [dbo].[Group_Users]  WITH CHECK ADD  CONSTRAINT [FK_Group_Users_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[Group_Users] CHECK CONSTRAINT [FK_Group_Users_Users]
GO
ALTER TABLE [dbo].[module]  WITH CHECK ADD  CONSTRAINT [FK_module_moduleTypes] FOREIGN KEY([type_id])
REFERENCES [dbo].[moduleTypes] ([id_moduleType])
GO
ALTER TABLE [dbo].[module] CHECK CONSTRAINT [FK_module_moduleTypes]
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
ALTER TABLE [dbo].[Permission_Module]  WITH CHECK ADD  CONSTRAINT [FK_Permission_Module_module] FOREIGN KEY([module_id])
REFERENCES [dbo].[module] ([module_id])
GO
ALTER TABLE [dbo].[Permission_Module] CHECK CONSTRAINT [FK_Permission_Module_module]
GO
ALTER TABLE [dbo].[Permission_Module]  WITH CHECK ADD  CONSTRAINT [FK_Permission_Module_Permissions] FOREIGN KEY([permission_id])
REFERENCES [dbo].[Permissions] ([id_permission])
GO
ALTER TABLE [dbo].[Permission_Module] CHECK CONSTRAINT [FK_Permission_Module_Permissions]
GO
ALTER TABLE [dbo].[PersonalAttributes]  WITH CHECK ADD  CONSTRAINT [FK_PersonalAttributes_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[PersonalAttributes] CHECK CONSTRAINT [FK_PersonalAttributes_Users]
GO
ALTER TABLE [dbo].[Process]  WITH CHECK ADD  CONSTRAINT [FK_Process_ProcessManagment] FOREIGN KEY([processManagment_id])
REFERENCES [dbo].[ProcessManagment] ([id_ProcessManagment])
GO
ALTER TABLE [dbo].[Process] CHECK CONSTRAINT [FK_Process_ProcessManagment]
GO
ALTER TABLE [dbo].[Process_Participants]  WITH CHECK ADD  CONSTRAINT [FK_Process_Participants_ProcessManagment] FOREIGN KEY([processManagment_id])
REFERENCES [dbo].[ProcessManagment] ([id_ProcessManagment])
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
GO
ALTER TABLE [dbo].[ProcessManagment] CHECK CONSTRAINT [FK_ProcessManagment_Categories]
GO
ALTER TABLE [dbo].[Reference_by_EventLog]  WITH CHECK ADD  CONSTRAINT [FK_Reference_by_EventLog_EventLog] FOREIGN KEY([eventLog_id])
REFERENCES [dbo].[EventLog] ([EventLog_id])
GO
ALTER TABLE [dbo].[Reference_by_EventLog] CHECK CONSTRAINT [FK_Reference_by_EventLog_EventLog]
GO
ALTER TABLE [dbo].[Reference_by_EventLog]  WITH CHECK ADD  CONSTRAINT [FK_Reference_by_EventLog_Reference] FOREIGN KEY([Reference_id])
REFERENCES [dbo].[Reference] ([Reference_id])
GO
ALTER TABLE [dbo].[Reference_by_EventLog] CHECK CONSTRAINT [FK_Reference_by_EventLog_Reference]
GO
ALTER TABLE [dbo].[Roles_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Roles_Permissions_Permissions] FOREIGN KEY([permission_id])
REFERENCES [dbo].[Permissions] ([id_permission])
GO
ALTER TABLE [dbo].[Roles_Permissions] CHECK CONSTRAINT [FK_Roles_Permissions_Permissions]
GO
ALTER TABLE [dbo].[Roles_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Roles_Permissions_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([id_role])
GO
ALTER TABLE [dbo].[Roles_Permissions] CHECK CONSTRAINT [FK_Roles_Permissions_Roles]
GO
ALTER TABLE [dbo].[Stage]  WITH CHECK ADD  CONSTRAINT [FK_Stage_ProcessManagment] FOREIGN KEY([processManagment_id])
REFERENCES [dbo].[ProcessManagment] ([id_ProcessManagment])
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
REFERENCES [dbo].[ProcessManagment] ([id_ProcessManagment])
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
GO
ALTER TABLE [dbo].[UsersPhotos] CHECK CONSTRAINT [FK_UsersPhotos_Users]
GO
