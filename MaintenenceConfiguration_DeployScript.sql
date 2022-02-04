/*
#### *Database Deploy*
DBMON_Repository

CREATE TABLE [configuration].[MaintenanceConfigurationFragmentation]
CREATE TABLE [configuration].[MaintenanceConfigurationBackupDirectory]
CREATE TABLE [configuration].[MaintenanceConfigurationIndex]
CREATE TABLE [configuration].[MaintenanceConfigurationDatabase]
CREATE TABLE [configuration].[MaintenanceConfiguration]
CREATE Procedure [collector].[processMaintenanceConfiguration]
CREATE VIEW [configuration].[VwMaintenanceConfiguration]
Create Job DBMON_processMaintenenceConfiguration

*Ticket:* 349591
*/ 

USE [DBMON_Repository]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [configuration].[MaintenanceConfigurationFragmentation](
	[MaintenanceConfigurationFragmentationID] [int] IDENTITY(1,1) NOT NULL,
	[FragmentationAction] [varchar](256) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_Configuration_MaintenanceConfigurationFragmentation] PRIMARY KEY CLUSTERED 
(
	[MaintenanceConfigurationFragmentationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Configuration_MaintenanceConfigurationFragmentation] UNIQUE NONCLUSTERED 
(
	[FragmentationAction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [configuration].[MaintenanceConfigurationFragmentation] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfigurationFragmentation_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [configuration].[MaintenanceConfigurationFragmentation] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfigurationFragmentation_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [configuration].[TrMaintenanceConfigurationFragmentationUpdate]
ON [configuration].[MaintenanceConfigurationFragmentation]
AFTER UPDATE  
AS 
/************************************************************************************
Object Name: TrMaintenanceConfigurationFragmentationUpdate
Parameter List
N/A
Output List
N/A
Purpose: Updates the DateUpdated column with the current date/time.

------------------------------------------------------------------------------------
Change History

************************************************************************************/
SET NOCOUNT ON;
UPDATE configuration.[MaintenanceConfigurationFragmentation]
SET DateUpdated = GETDATE() 
WHERE MaintenanceConfigurationFragmentationID IN (	
    SELECT i.MaintenanceConfigurationFragmentationID
	FROM INSERTED i 
		INNER JOIN DELETED d ON i.MaintenanceConfigurationFragmentationID = d.MaintenanceConfigurationFragmentationID );
GO

ALTER TABLE [configuration].[MaintenanceConfigurationFragmentation] ENABLE TRIGGER [TrMaintenanceConfigurationFragmentationUpdate]
GO

USE [DBMON_Repository]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [configuration].[MaintenanceConfigurationBackupDirectory](
	[MaintenanceConfigurationBackupDirectoryID] [int] IDENTITY(1,1) NOT NULL,
	[BackupDirectory] [varchar](256) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_Configuration_MaintenanceConfigurationBackupDirectory] PRIMARY KEY CLUSTERED 
(
	[MaintenanceConfigurationBackupDirectoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Configuration_MaintenanceConfigurationBackupDirectory] UNIQUE NONCLUSTERED 
(
	[BackupDirectory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [configuration].[MaintenanceConfigurationBackupDirectory] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfigurationBackupDirectory_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [configuration].[MaintenanceConfigurationBackupDirectory] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfigurationBackupDirectory_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [configuration].[TrMaintenanceConfigurationBackupDirectoryUpdate]
ON [configuration].[MaintenanceConfigurationBackupDirectory]
AFTER UPDATE  
AS 
/************************************************************************************
Object Name: TrMaintenanceConfigurationBackupDirectoryUpdate
Parameter List
N/A
Output List
N/A
Purpose: Updates the DateUpdated column with the current date/time.

------------------------------------------------------------------------------------
Change History

************************************************************************************/
SET NOCOUNT ON;
UPDATE configuration.[MaintenanceConfigurationBackupDirectory]
SET DateUpdated = GETDATE() 
WHERE MaintenanceConfigurationBackupDirectoryID IN (	
    SELECT i.MaintenanceConfigurationBackupDirectoryID
	FROM INSERTED i 
		INNER JOIN DELETED d ON i.MaintenanceConfigurationBackupDirectoryID = d.MaintenanceConfigurationBackupDirectoryID );
GO

ALTER TABLE [configuration].[MaintenanceConfigurationBackupDirectory] ENABLE TRIGGER [TrMaintenanceConfigurationBackupDirectoryUpdate]
GO

USE [DBMON_Repository]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [configuration].[MaintenanceConfigurationIndex](
	[MaintenanceConfigurationIndexID] [int] IDENTITY(1,1) NOT NULL,
	[IndexName] [varchar](128) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_Configuration_MaintenanceConfigurationIndex] PRIMARY KEY CLUSTERED 
(
	[MaintenanceConfigurationIndexID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Configuration_MaintenanceConfigurationIndex] UNIQUE NONCLUSTERED 
(
	[IndexName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [configuration].[MaintenanceConfigurationIndex] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfigurationIndex_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [configuration].[MaintenanceConfigurationIndex] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfigurationIndex_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [configuration].[TrMaintenanceConfigurationIndexUpdate]
ON [configuration].[MaintenanceConfigurationIndex]
AFTER UPDATE  
AS 
/************************************************************************************
Object Name: TrMaintenanceConfigurationIndexUpdate
Parameter List
N/A
Output List
N/A
Purpose: Updates the DateUpdated column with the current date/time.

------------------------------------------------------------------------------------
Change History

************************************************************************************/
SET NOCOUNT ON;
UPDATE configuration.[MaintenanceConfigurationIndex]
SET DateUpdated = GETDATE() 
WHERE MaintenanceConfigurationIndexID IN (	
    SELECT i.MaintenanceConfigurationIndexID
	FROM INSERTED i 
		INNER JOIN DELETED d ON i.MaintenanceConfigurationIndexID = d.MaintenanceConfigurationIndexID );
GO

ALTER TABLE [configuration].[MaintenanceConfigurationIndex] ENABLE TRIGGER [TrMaintenanceConfigurationIndexUpdate]
GO

USE [DBMON_Repository]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [configuration].[MaintenanceConfigurationDatabase](
	[MaintenanceConfigurationDatabaseID] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseName] [varchar](128) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_Configuration_MaintenanceConfigurationDatabase] PRIMARY KEY CLUSTERED 
(
	[MaintenanceConfigurationDatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Configuration_MaintenanceConfigurationDatabase] UNIQUE NONCLUSTERED 
(
	[DatabaseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [configuration].[MaintenanceConfigurationDatabase] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfigurationDatabase_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [configuration].[MaintenanceConfigurationDatabase] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfigurationDatabase_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [configuration].[TrMaintenanceConfigurationDatabaseUpdate]
ON [configuration].[MaintenanceConfigurationDatabase]
AFTER UPDATE  
AS 
/************************************************************************************
Object Name: TrMaintenanceConfigurationDatabaseUpdate
Parameter List
N/A
Output List
N/A
Purpose: Updates the DateUpdated column with the current date/time.

------------------------------------------------------------------------------------
Change History

************************************************************************************/
SET NOCOUNT ON;
UPDATE configuration.[MaintenanceConfigurationDatabase]
SET DateUpdated = GETDATE() 
WHERE MaintenanceConfigurationDatabaseID IN (	
    SELECT i.MaintenanceConfigurationDatabaseID
	FROM INSERTED i 
		INNER JOIN DELETED d ON i.MaintenanceConfigurationDatabaseID = d.MaintenanceConfigurationDatabaseID );
GO

ALTER TABLE [configuration].[MaintenanceConfigurationDatabase] ENABLE TRIGGER [TrMaintenanceConfigurationDatabaseUpdate]
GO

USE [DBMON_Repository]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [configuration].[MaintenanceConfiguration](
	[MaintenanceConfigurationId] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [bigint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
	[DatabaseID] [int] NOT NULL,
	[IndexID] [int] NULL,
	[IsDatabaseExcluded] [bit] NOT NULL,
	[IsIndexExcluded] [bit] NOT NULL,
	[MaintenanceConfigurationBackupDirectoryID] [int] NULL,
	[LogMaintenanceConfigurationBackupDirectoryID] [int] NULL,
	[IsDBCCExcluded] [bit] NOT NULL,
	[Notes] [varchar](200) NULL,
	[MediumMaintenanceConfigurationFragmentationID] [int] NULL,
	[HighMaintenanceConfigurationFragmentationID] [int] NULL,
	[AvailabilityGroupName] [varchar](128) NULL,
	[IsAvailabilityGroupExcluded] [bit] NOT NULL,
 CONSTRAINT [PK_Configuration_MaintenanceConfiguration] PRIMARY KEY CLUSTERED 
(
	[MaintenanceConfigurationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfiguration_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfiguration_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfiguration_IsDatabaseExcluded]  DEFAULT ((0)) FOR [IsDatabaseExcluded]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfiguration_IsIndexExcluded]  DEFAULT ((0)) FOR [IsIndexExcluded]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfiguration_IsDBCCExcluded]  DEFAULT ((0)) FOR [IsDBCCExcluded]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfiguration_Notes]  DEFAULT ('') FOR [Notes]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfiguration_AvailabilityGroupName]  DEFAULT ('') FOR [AvailabilityGroupName]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] ADD  CONSTRAINT [DF_Configuration_MaintenanceConfiguration_IsAvasilabilityGroupExcluded]  DEFAULT ((0)) FOR [IsAvailabilityGroupExcluded]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_Configuration_MaintenanceConfiguration_BackupDirectory_Configuration_MaintenanceConfigurationBackupDirectory] FOREIGN KEY([MaintenanceConfigurationBackupDirectoryID])
REFERENCES [configuration].[MaintenanceConfigurationBackupDirectory] ([MaintenanceConfigurationBackupDirectoryID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_Configuration_MaintenanceConfiguration_BackupDirectory_Configuration_MaintenanceConfigurationBackupDirectory]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_Configuration_MaintenanceConfiguration_Configuration_MaintenanceConfigurationDatabase] FOREIGN KEY([DatabaseID])
REFERENCES [configuration].[MaintenanceConfigurationDatabase] ([MaintenanceConfigurationDatabaseID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_Configuration_MaintenanceConfiguration_Configuration_MaintenanceConfigurationDatabase]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_Configuration_MaintenanceConfiguration_Configuration_MaintenanceConfigurationIndex] FOREIGN KEY([IndexID])
REFERENCES [configuration].[MaintenanceConfigurationIndex] ([MaintenanceConfigurationIndexID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_Configuration_MaintenanceConfiguration_Configuration_MaintenanceConfigurationIndex]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_Configuration_MaintenanceConfiguration_Dbo_SqlServers] FOREIGN KEY([ServerID])
REFERENCES [dbo].[SQLServers] ([ServerID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_Configuration_MaintenanceConfiguration_Dbo_SqlServers]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_Configuration_MaintenanceConfiguration_FragmentationHigh_Configuration_MaintenanceConfigurationFragmentation] FOREIGN KEY([HighMaintenanceConfigurationFragmentationID])
REFERENCES [configuration].[MaintenanceConfigurationFragmentation] ([MaintenanceConfigurationFragmentationID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_Configuration_MaintenanceConfiguration_FragmentationHigh_Configuration_MaintenanceConfigurationFragmentation]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_Configuration_MaintenanceConfiguration_FragmentationMedium_Configuration_MaintenanceConfigurationFragmentation] FOREIGN KEY([MediumMaintenanceConfigurationFragmentationID])
REFERENCES [configuration].[MaintenanceConfigurationFragmentation] ([MaintenanceConfigurationFragmentationID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_Configuration_MaintenanceConfiguration_FragmentationMedium_Configuration_MaintenanceConfigurationFragmentation]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_Configuration_MaintenanceConfiguration_LogBackupDirectory_Configuration_MaintenanceConfigurationBackupDirectory] FOREIGN KEY([LogMaintenanceConfigurationBackupDirectoryID])
REFERENCES [configuration].[MaintenanceConfigurationBackupDirectory] ([MaintenanceConfigurationBackupDirectoryID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_Configuration_MaintenanceConfiguration_LogBackupDirectory_Configuration_MaintenanceConfigurationBackupDirectory]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceConfiguration_HighMaintenanceConfigurationFragmentationID_MaintenanceConfigurationFragmentation] FOREIGN KEY([HighMaintenanceConfigurationFragmentationID])
REFERENCES [configuration].[MaintenanceConfigurationFragmentation] ([MaintenanceConfigurationFragmentationID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_MaintenanceConfiguration_HighMaintenanceConfigurationFragmentationID_MaintenanceConfigurationFragmentation]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceConfiguration_LogMaintenanceConfigurationBackupDirectoryID_MaintenanceConfigurationBackupDirectory] FOREIGN KEY([LogMaintenanceConfigurationBackupDirectoryID])
REFERENCES [configuration].[MaintenanceConfigurationBackupDirectory] ([MaintenanceConfigurationBackupDirectoryID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_MaintenanceConfiguration_LogMaintenanceConfigurationBackupDirectoryID_MaintenanceConfigurationBackupDirectory]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceConfiguration_MaintenanceConfigurationBackupDirectoryID_MaintenanceConfigurationBackupDirectory] FOREIGN KEY([MaintenanceConfigurationBackupDirectoryID])
REFERENCES [configuration].[MaintenanceConfigurationBackupDirectory] ([MaintenanceConfigurationBackupDirectoryID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_MaintenanceConfiguration_MaintenanceConfigurationBackupDirectoryID_MaintenanceConfigurationBackupDirectory]
GO

ALTER TABLE [configuration].[MaintenanceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_MaintenanceConfiguration_MediumMaintenanceConfigurationFragmentationID_MaintenanceConfigurationFragmentation] FOREIGN KEY([MediumMaintenanceConfigurationFragmentationID])
REFERENCES [configuration].[MaintenanceConfigurationFragmentation] ([MaintenanceConfigurationFragmentationID])
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] CHECK CONSTRAINT [FK_MaintenanceConfiguration_MediumMaintenanceConfigurationFragmentationID_MaintenanceConfigurationFragmentation]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [configuration].[TrMaintenanceConfigurationUpdate]
ON [configuration].[MaintenanceConfiguration]
AFTER UPDATE  
AS 
/************************************************************************************
Object Name: TrMaintenanceConfigurationUpdate
Parameter List
N/A
Output List
N/A
Purpose: Updates the DateUpdated column with the current date/time.

------------------------------------------------------------------------------------
Change History

************************************************************************************/
SET NOCOUNT ON;
UPDATE configuration.MaintenanceConfiguration 
SET DateUpdated = GETDATE() 
WHERE MaintenanceConfigurationId IN (	
    SELECT i.MaintenanceConfigurationId
	FROM INSERTED i 
		INNER JOIN DELETED d ON i.MaintenanceConfigurationId = d.MaintenanceConfigurationId );
GO

ALTER TABLE [configuration].[MaintenanceConfiguration] ENABLE TRIGGER [TrMaintenanceConfigurationUpdate]
GO

USE [DBMON_Repository]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [collector].[processMaintenanceConfiguration] AS

/*****************************************************************************
Object Name: collector.processMaintenenceConfiguration
Date Created: 2022-01-04
Created By: David Stone

Parameter List
N/A

Output List
N/A

Purpose: This will process all the MaintenenceConfiguration messages and update the MaintenenceConfiguration table.
-----------------------------------------------------------------------------
Change History

*****************************************************************************/

SET NOCOUNT ON;
SET ANSI_PADDING ON;

IF OBJECT_ID('tempdb.dbo.#MaintenanceConfiguration') IS NOT NULL 
	DROP TABLE #MaintenanceConfiguration;
IF OBJECT_ID('tempdb.dbo.#Messages') IS NOT NULL 
	DROP TABLE #Messages;
IF OBJECT_ID('tempdb.dbo.#MaintenanceConfigurationUpdate') IS NOT NULL 
	DROP TABLE #MaintenanceConfigurationUpdate;
IF OBJECT_ID('tempdb.dbo.#BackupDirectory') IS NOT NULL 
	DROP TABLE #BackupDirectory;
IF OBJECT_ID('tempdb.dbo.#LogBackupDirectory') IS NOT NULL 
	DROP TABLE #LogBackupDirectory;


DECLARE @RetXML XML; 
DECLARE @MessageID BIGINT; 
DECLARE @MessageDateTime DATETIME;
DECLARE @HoursToKeep INT;
DECLARE @ServerName VARCHAR(255);

CREATE TABLE #MaintenanceConfiguration(
	ServerName VARCHAR(255),
	DatabaseName VARCHAR(128),
	IndexName VARCHAR(128),
	IsDatabaseExcluded BIT,
	IsIndexExcluded BIT,
	BackupDirectory VARCHAR(200),
	LogBackupDirectory VARCHAR(200),
	IsDBCCExcluded BIT,
	Notes VARCHAR(200),
	FragmentationMedium NVARCHAR(1000),
	FragmentationHigh NVARCHAR(1000),
	AvailabilityGroupName VARCHAR(128),
	IsAvailabilityGroupExcluded BIT);

CREATE TABLE #BackupDirectory(
	ServerID bigint,
	DatabaseID int,
	MaintenanceConfigurationBackupDirectoryID INT,
	);
CREATE TABLE #LogBackupDirectory(
	ServerID bigint,
	DatabaseID int,
	LogMaintenanceConfigurationBackupDirectoryID INT  
	);

CREATE TABLE #Messages(
	 MessageID BIGINT NOT NULL
	,MessageDateTime DATETIME NOT NULL
	,ServerName VARCHAR(255)
	,MessageXML VARCHAR(MAX) NOT NULL);

INSERT INTO #Messages(MessageId, MessageDateTime, ServerName, MessageXML)
SELECT MessageID
	 , MessageDateTime
	 , ServerName
	 , MessageXML
FROM collector.Messages
WHERE MessageType = 'MaintenanceConfiguration'
	  AND MessageDateTime < DATEADD(ss, -15, GETDATE())
	  AND Processed = 0
ORDER BY MessageDateTime;

WHILE (SELECT TOP 1 1 FROM #Messages) IS NOT NULL
BEGIN
	SELECT @MessageId = (SELECT TOP 1 MessageId FROM #Messages ORDER BY MessageId);
	SELECT @RetXML = CAST((SELECT MessageXML FROM #Messages WHERE MessageId = @MessageId) AS XML);
	SELECT @ServerName = (SELECT TOP 1 ServerName FROM #Messages ORDER BY MessageId);
	
	BEGIN TRY
		INSERT INTO #MaintenanceConfiguration
			(ServerName,DatabaseName,IndexName,IsDatabaseExcluded,IsIndexExcluded,
			BackupDirectory,LogBackupDirectory,IsDBCCExcluded,Notes,FragmentationMedium,
			FragmentationHigh,AvailabilityGroupName,IsAvailabilityGroupExcluded)
		SELECT 
			@ServerName
			,x.item.value('DatabaseName[1]', 'VARCHAR(128)') AS 'DatabaseName'
			,x.item.value('IndexName[1]' , 'VARCHAR(128)') AS 'IndexName'
			,x.item.value('IsDatabaseExcluded[1]','BIT') AS  'IsDatabaseExcluded'
			,x.item.value('IsIndexExcluded[1]' ,'BIT') AS  'IsIndexExcluded'
			,x.item.value('BackupDirectory[1]' ,'VARCHAR(256)') AS  'BackupDirectory'
			,x.item.value('LogBackupDirectory[1]','VARCHAR(256)') AS  'LogBackupDirectory'
			,x.item.value('IsDBCCExcluded[1]' ,'BIT') AS  'IsDBCCExcluded'
			,x.item.value('Notes[1]' ,'VARCHAR(200)') AS  'Notes'
			,x.item.value('FragmentationMedium[1]' ,'NVARCHAR(1000)') AS  'FragmentationMedium'
			,x.item.value('FragmentationHigh[1]' ,'NVARCHAR(1000)') AS  'FragmentationHigh'
			,x.item.value('AvailabilityGroupName[1]' ,'VARCHAR(128)') AS  'AvailabilityGroupName'
			,x.item.value('IsAvailabilityGroupExcluded[1]','BIT') AS  'IsAvailabilityGroupExcluded'
		FROM @RetXML.nodes('//MaintenanceConfiguration') AS x(item);
		 
		UPDATE	collector.Messages 
		SET		Processed = 1, 
				Failed = 0
		WHERE	MessageID = @MessageID;
	END TRY
	BEGIN CATCH
		UPDATE	collector.Messages 
		SET		Failed = 1, 
				Processed = 0, 
				FailedMessage = LEFT(ERROR_MESSAGE(), 500)
		WHERE	MessageID = @MessageID;
	END CATCH;
	
	DELETE a
	FROM #Messages a
	WHERE MessageID = @MessageID;
END

/*Replace blank spaces with NULL*/
UPDATE #MaintenanceConfiguration
	SET  IndexName = NULL
	WHERE IndexName='';
UPDATE #MaintenanceConfiguration
	SET  BackupDirectory = NULL
	WHERE BackupDirectory ='';
UPDATE #MaintenanceConfiguration
	SET  LogBackupDirectory = NULL
	WHERE LogBackupDirectory ='';
UPDATE #MaintenanceConfiguration
	SET  Notes = NULL
	WHERE Notes ='';
UPDATE #MaintenanceConfiguration
	SET  FragmentationMedium = NULL
	WHERE FragmentationMedium ='';
UPDATE #MaintenanceConfiguration
	SET  FragmentationHigh = NULL
	WHERE FragmentationHigh ='';
UPDATE #MaintenanceConfiguration
	SET  AvailabilityGroupName = NULL
	WHERE AvailabilityGroupName ='';

/*Add new data to the look up tables*/
/*DatabaseName*/
INSERT INTO configuration.MaintenanceConfigurationDatabase (DatabaseName)
SELECT DISTINCT mc.DatabaseName 
FROM #MaintenanceConfiguration mc
	LEFT JOIN configuration.MaintenanceConfigurationDatabase cmc ON cmc.DatabaseName = mc.DatabaseName
WHERE cmc.DatabaseName IS NULL
	AND mc.DatabaseName IS NOT NULL;

/*IndexName*/
INSERT INTO configuration.MaintenanceConfigurationIndex (IndexName)
SELECT DISTINCT mc.IndexName 
FROM #MaintenanceConfiguration mc
	LEFT JOIN configuration.MaintenanceConfigurationIndex cmci ON cmci.IndexName = mc.IndexName
WHERE cmci.IndexName IS NULL
	AND mc.IndexName IS NOT NULL;

/*Fragmentation Medium*/
INSERT INTO configuration.MaintenanceConfigurationFragmentation (FragmentationAction)
SELECT DISTINCT mc.FragmentationMedium
FROM #MaintenanceConfiguration mc
	LEFT JOIN configuration.MaintenanceConfigurationFragmentation frag ON frag.FragmentationAction = mc.FragmentationMedium
WHERE frag.FragmentationAction IS NULL
	AND mc.FragmentationMedium IS NOT NULL;

/*Fragmentation High*/
INSERT INTO configuration.MaintenanceConfigurationFragmentation (FragmentationAction)
SELECT DISTINCT mc.FragmentationHigh
FROM #MaintenanceConfiguration mc
	LEFT JOIN configuration.MaintenanceConfigurationFragmentation frag 
	ON frag.FragmentationAction = mc.FragmentationHigh
WHERE frag.FragmentationAction IS NULL
	AND mc.FragmentationHigh IS NOT NULL;

/*BackupDirectory*/
INSERT INTO configuration.MaintenanceConfigurationBackupDirectory (BackupDirectory)
SELECT DISTINCT mc.BackupDirectory
FROM #MaintenanceConfiguration mc
	LEFT JOIN configuration.MaintenanceConfigurationBackupDirectory cmcbak
	ON cmcbak.BackupDirectory = mc.BackupDirectory
WHERE cmcbak.BackupDirectory IS NULL
	AND mc.BackupDirectory IS NOT NULL;

/*LogBackupDirectory*/
INSERT INTO configuration.MaintenanceConfigurationBackupDirectory (BackupDirectory)
SELECT DISTINCT mc.LogBackupDirectory
FROM #MaintenanceConfiguration mc
	LEFT JOIN configuration.MaintenanceConfigurationBackupDirectory cmcbak
	ON cmcbak.BackupDirectory = mc.LogBackupDirectory
WHERE cmcbak.BackupDirectory IS NULL
	AND mc.LogBackupDirectory IS NOT NULL;

/*Insert Normalized data into temp tables, to update a changed Backup and LogBackup directory.*/
INSERT INTO #BackupDirectory (ServerID, DatabaseID, MaintenanceConfigurationBackupDirectoryID)
SELECT 
	ss.ServerID
	,db.MaintenanceConfigurationDatabaseID
	,bak.MaintenanceConfigurationBackupDirectoryID
FROM #MaintenanceConfiguration mc
	LEFT JOIN dbo.SQLServers ss ON ss.ServerName = mc.ServerName
    LEFT JOIN configuration.MaintenanceConfigurationDatabase		AS db	  ON db.DatabaseName		   = mc.DatabaseName
	LEFT JOIN configuration.MaintenanceConfigurationBackupDirectory AS bak    ON bak.BackupDirectory       = mc.BackupDirectory
	LEFT JOIN configuration.MaintenanceConfiguration cmc ON  
			cmc.ServerID				= ss.ServerID
		AND cmc.DatabaseID			= db.MaintenanceConfigurationDatabaseID;

INSERT INTO #LogBackupDirectory (ServerID, DatabaseID, LogMaintenanceConfigurationBackupDirectoryID)
SELECT
	ss.ServerID
	,db.MaintenanceConfigurationDatabaseID
	,bakL.MaintenanceConfigurationBackupDirectoryID
FROM #MaintenanceConfiguration mc
	LEFT JOIN dbo.SQLServers ss ON ss.ServerName = mc.ServerName
    LEFT JOIN configuration.MaintenanceConfigurationDatabase		AS db	  ON db.DatabaseName		   = mc.DatabaseName
	LEFT JOIN configuration.MaintenanceConfigurationBackupDirectory AS bakL   ON bakL.BackupDirectory      = mc.LogBackupDirectory
	LEFT JOIN configuration.MaintenanceConfiguration cmc ON  
			cmc.ServerID				= ss.ServerID
		AND cmc.DatabaseID			= db.MaintenanceConfigurationDatabaseID;

/*Update the Backup and LogBackup Directories*/
UPDATE cmc
SET cmc.MaintenanceConfigurationBackupDirectoryID = bd.MaintenanceConfigurationBackupDirectoryID
FROM configuration.MaintenanceConfiguration cmc 
	LEFT JOIN #BackupDirectory bd ON bd.ServerID = cmc.ServerID AND bd.DatabaseID= cmc.DatabaseID 
WHERE bd.ServerID = cmc.ServerID 
	AND bd.DatabaseID = cmc.DatabaseID
	AND cmc.MaintenanceConfigurationBackupDirectoryID <> bd.MaintenanceConfigurationBackupDirectoryID
	OR bd.ServerID = cmc.ServerID 
		AND bd.DatabaseID = cmc.DatabaseID 
		AND bd.MaintenanceConfigurationBackupDirectoryID IS NULL 
		AND cmc.MaintenanceConfigurationBackupDirectoryID IS NOT NULL;

UPDATE cmc
SET cmc.LogMaintenanceConfigurationBackupDirectoryID = lbd.LogMaintenanceConfigurationBackupDirectoryID
FROM configuration.MaintenanceConfiguration cmc 
	LEFT JOIN #LogBackupDirectory lbd ON lbd.ServerID = cmc.ServerID AND lbd.DatabaseID= cmc.DatabaseID 
WHERE lbd.ServerID = cmc.ServerID 
	AND lbd.DatabaseID= cmc.DatabaseID
	AND cmc.LogMaintenanceConfigurationBackupDirectoryID <> lbd.LogMaintenanceConfigurationBackupDirectoryID
	OR lbd.ServerID = cmc.ServerID 
		AND lbd.DatabaseID = cmc.DatabaseID 
		AND lbd.LogMaintenanceConfigurationBackupDirectoryID IS NULL 
		AND cmc.LogMaintenanceConfigurationBackupDirectoryID IS NOT NULL;

/*Insert the normalized data into configuration.MaintenanceConfiguration*/
INSERT INTO configuration.MaintenanceConfiguration
	(ServerID    
	,DatabaseID 
	,IndexID  
	,IsDatabaseExcluded  
	,IsIndexExcluded  
	,MaintenanceConfigurationBackupDirectoryID    
	,LogMaintenanceConfigurationBackupDirectoryID
	,IsDBCCExcluded  
	,Notes  
	,MediumMaintenanceConfigurationFragmentationID  
	,HighMaintenanceConfigurationFragmentationID 
	,AvailabilityGroupName  
	,IsAvailabilityGroupExcluded)
SELECT 
	 ss.ServerID  
	,db.MaintenanceConfigurationDatabaseID
	,ix.MaintenanceConfigurationIndexID
	,mc.IsDatabaseExcluded  
	,mc.IsIndexExcluded  
	,bak.MaintenanceConfigurationBackupDirectoryID  
	,bakL.MaintenanceConfigurationBackupDirectoryID
	,mc.IsDBCCExcluded  
	,mc.Notes  
	,fragM.MaintenanceConfigurationFragmentationID 
	,fragH.MaintenanceConfigurationFragmentationID 
	,mc.AvailabilityGroupName  
	,mc.IsAvailabilityGroupExcluded
FROM #MaintenanceConfiguration mc
	LEFT JOIN dbo.SQLServers ss ON ss.ServerName = mc.ServerName
    LEFT JOIN configuration.MaintenanceConfigurationDatabase		AS db	  ON db.DatabaseName		   = mc.DatabaseName
	LEFT JOIN configuration.MaintenanceConfigurationIndex			AS ix	  ON ix.IndexName			   = mc.IndexName
	LEFT JOIN configuration.MaintenanceConfigurationFragmentation   AS fragM  ON fragM.FragmentationAction = mc.FragmentationMedium
	LEFT JOIN configuration.MaintenanceConfigurationFragmentation   AS fragH  ON fragH.FragmentationAction = mc.FragmentationHigh
	LEFT JOIN configuration.MaintenanceConfigurationBackupDirectory AS bak    ON bak.BackupDirectory       = mc.BackupDirectory
	LEFT JOIN configuration.MaintenanceConfigurationBackupDirectory AS bakL   ON bakL.BackupDirectory      = mc.LogBackupDirectory
	LEFT JOIN configuration.MaintenanceConfiguration cmc ON  
			(cmc.ServerID				= ss.ServerID OR cmc.ServerID IS NULL AND ss.ServerID IS NULL)
		AND (cmc.DatabaseID			= db.MaintenanceConfigurationDatabaseID OR cmc.DatabaseID	IS NULL AND db.MaintenanceConfigurationDatabaseID IS NULL ) 
		AND (cmc.IndexID				= ix.MaintenanceConfigurationIndexID OR cmc.IndexID IS NULL AND ix.MaintenanceConfigurationIndexID IS NULL)  
		AND (cmc.IsDatabaseExcluded	= mc.IsDatabaseExcluded OR cmc.IsDatabaseExcluded IS NULL AND mc.IsDatabaseExcluded IS NULL)  
		AND (cmc.IsIndexExcluded		= mc.IsIndexExcluded OR cmc.IsIndexExcluded	IS NULL AND mc.IsIndexExcluded IS NULL)  
		AND (cmc.MaintenanceConfigurationBackupDirectoryID		= bak.MaintenanceConfigurationBackupDirectoryID OR cmc.MaintenanceConfigurationBackupDirectoryID IS NULL AND  bak.MaintenanceConfigurationBackupDirectoryID IS NULL)
		AND (cmc.LogMaintenanceConfigurationBackupDirectoryID	= bakL.MaintenanceConfigurationBackupDirectoryID OR cmc.LogMaintenanceConfigurationBackupDirectoryID IS NULL AND bakL.MaintenanceConfigurationBackupDirectoryID IS NULL)
		AND (cmc.IsDBCCExcluded		= mc.IsDBCCExcluded OR cmc.IsDBCCExcluded IS NULL AND  mc.IsDBCCExcluded  IS NULL)  
		AND (cmc.Notes					= mc.Notes OR cmc.Notes	IS NULL AND mc.Notes  IS NULL)
		AND (cmc.MediumMaintenanceConfigurationFragmentationID =  fragM.MaintenanceConfigurationFragmentationID OR cmc.MediumMaintenanceConfigurationFragmentationID IS NULL AND fragM.MaintenanceConfigurationFragmentationID IS NULL)  
		AND (cmc.HighMaintenanceConfigurationFragmentationID   =  fragH.MaintenanceConfigurationFragmentationID OR cmc.HighMaintenanceConfigurationFragmentationID   IS NULL AND fragH.MaintenanceConfigurationFragmentationID IS NULL)   
		AND (cmc.AvailabilityGroupName = mc.AvailabilityGroupName OR cmc.AvailabilityGroupName IS NULL AND  mc.AvailabilityGroupName IS NULL)
		AND (cmc.IsAvailabilityGroupExcluded = mc.IsAvailabilityGroupExcluded OR cmc.IsAvailabilityGroupExcluded IS NULL AND  mc.IsAvailabilityGroupExcluded IS NULL)
	WHERE cmc.ServerID IS NULL;

/*Insert/Update last message date/time*/
MERGE INTO collector.LastMessage AS target
USING (	SELECT	DISTINCT s.ServerID,
				'DatabaseInfo' 'MessageType', 
				GETDATE() 'MessageReceived'
		FROM	#MaintenanceConfiguration p
				INNER JOIN dbo.SQLServers s ON s.ServerName = p.ServerName) AS source
ON source.ServerID = target.ServerID
	AND source.MessageType = target.MessageType
WHEN NOT MATCHED BY target
	THEN INSERT (	ServerID, MessageType, MessageReceived)
		VALUES	(	source.ServerID, source.MessageType, source.MessageReceived)
WHEN MATCHED THEN UPDATE
	SET	MessageReceived = source.MessageReceived;

/*Drop the temp table.*/
DROP TABLE #MaintenanceConfiguration;
DROP TABLE #Messages;

SET ANSI_PADDING OFF;
GO



USE [DBMON_Repository]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [configuration].[VwMaintenanceConfiguration] AS

/************************************************************************************
Object Name: [configuration].[VwMaintenanceConfiguration]
Date Created: 2022-01-04

Parameter List
N/A

Example
Select * From [configuration].[VwMaintenanceConfiguration]

Output List:
MaintenanceConfigurationId,
ServerName,
DatabaseName,
DateCreated,
DateUpdated,
IndexName,
IsDatabaseExcluded,
IsIndexExcluded,
BackupDirectory,
LogBackupDirectory, 
IsDBCCExcluded,
Notes,
FragmentationMedium,
FragmentationHigh,
AvailabilityGroupName,
IsAvailabilityGroupExcluded


Purpose: Denormalize all of the data from configuration.MaintenanceConfiguration for readability
------------------------------------------------------------------------------------
Change History

************************************************************************************/
SELECT 
mcn.MaintenanceConfigurationId,
ss.ServerName,
db.DatabaseName,
mcn.DateCreated,
mcn.DateUpdated,
ix.IndexName,
IsDatabaseExcluded,
IsIndexExcluded,
bak.BackupDirectory AS BackupDirectory,
bakL.BackupDirectory AS LogBackupDirectory, 
IsDBCCExcluded,
Notes,
fragM.FragmentationAction AS FragmentationMedium,
fragH.FragmentationAction AS FragmentationHigh,
AvailabilityGroupName,
IsAvailabilityGroupExcluded
FROM configuration.MaintenanceConfiguration mcn
LEFT JOIN dbo.[SQLServers] ss ON ss.ServerID = mcn.ServerID
LEFT JOIN configuration.MaintenanceConfigurationDatabase		AS db	  ON db.MaintenanceConfigurationDatabaseID			= mcn.DatabaseID
LEFT JOIN configuration.MaintenanceConfigurationIndex			AS ix	  ON ix.MaintenanceConfigurationIndexID			    = mcn.IndexID
LEFT JOIN configuration.MaintenanceConfigurationBackupDirectory AS bak    ON bak.MaintenanceConfigurationBackupDirectoryID  = mcn.MaintenanceConfigurationBackupDirectoryID
LEFT JOIN configuration.MaintenanceConfigurationBackupDirectory AS bakL   ON bakL.MaintenanceConfigurationBackupDirectoryID = mcn.[LogMaintenanceConfigurationBackupDirectoryID]
LEFT JOIN configuration.MaintenanceConfigurationFragmentation   AS fragM  ON fragM.MaintenanceConfigurationFragmentationID  = mcn.[MediumMaintenanceConfigurationFragmentationID]
LEFT JOIN configuration.MaintenanceConfigurationFragmentation   AS fragH  ON fragH.MaintenanceConfigurationFragmentationID  = mcn.[HighMaintenanceConfigurationFragmentationID];
GO

USE [msdb]
GO

BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBMON_processMaintenenceConfiguration', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Calls the DBMON_Repository.collector.processMaintenenceConfiguration stored procedure.this job is only scheduled to execute once every day.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'LANCASTER\dstone', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'EXEC collector.processMaintenenceConfiguration', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC DBMON_Repository.[collector].[processMaintenenceConfiguration]', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Run Daily at 8am', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20220106, 
		@active_end_date=99991231, 
		@active_start_time=80000, 
		@active_end_time=235959, 
		@schedule_uid=N'e304ffac-ca13-4475-bab0-1801f9b986f1'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


