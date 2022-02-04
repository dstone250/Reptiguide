/*
#### *Database Deploy*
BackupMonitor
CREATE SCHEMA [BackupHistory]
CREATE TABLE  [BackupHistory].[MissingBackup]
CREATE StoProc [BackupHistory].[MissingBackupsAlert]
*Ticket:* #######
*/ 

USE [BackupMonitor]
GO

CREATE SCHEMA [BackupHistory]
GO

USE [BackupMonitor]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BackupHistory].[MissingBackup](
	[MissingBackupID] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [smallint] NOT NULL,
	[DatabaseID] [smallint] NOT NULL,
	[BackupCount] [tinyint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_BackupHistory_MissingBackup] PRIMARY KEY CLUSTERED 
(
	[MissingBackupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [BackupHistory].[MissingBackup] ADD  CONSTRAINT [DF_BackupHistory_MissingBackup_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [BackupHistory].[MissingBackup] ADD  CONSTRAINT [DF_BackupHistory_MissingBackup_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [BackupHistory].[MissingBackup]  WITH CHECK ADD  CONSTRAINT [FK_MissingBackup_BackupHistory_MissingBackup_Database] FOREIGN KEY([DatabaseID])
REFERENCES [BackupHistory].[Database] ([DatabaseID])
GO

ALTER TABLE [BackupHistory].[MissingBackup] CHECK CONSTRAINT [FK_MissingBackup_BackupHistory_MissingBackup_Database]
GO

ALTER TABLE [BackupHistory].[MissingBackup]  WITH CHECK ADD  CONSTRAINT [FK_MissingBackup_BackupHistory_MissingBackup_Server] FOREIGN KEY([ServerID])
REFERENCES [BackupHistory].[Server] ([ServerID])
GO

ALTER TABLE [BackupHistory].[MissingBackup] CHECK CONSTRAINT [FK_MissingBackup_BackupHistory_MissingBackup_Server]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [BackupHistory].[TrMissingBackup]
ON [BackupHistory].[MissingBackup]
FOR UPDATE AS
BEGIN
UPDATE [BackupHistory].[MissingBackup]
SET DateUpdated = GETDATE() 
FROM Inserted i
WHERE [BackupHistory].[MissingBackup].MissingBackupID= i.MissingBackupID
END;
GO

ALTER TABLE [BackupHistory].[MissingBackup] ENABLE TRIGGER [TrMissingBackup]
GO

USE [BackupMonitor]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BackupHistory].[MissingBackupsAlert] 
	@recipients VARCHAR(60) = 'stonetdavid@gmail.com'
	,@profile_name VARCHAR(20) = 'DBA'
	,@BaseBackupCount TINYINT = 3
AS
/************************************************************************************
Object Name: Backuphistory.MissingBackupsAlert

Parameter List
@recipients: 'stonetdavid@gmail.com' --The default email to sent the alert to.
@profile_name: The profile name to use to send the emails. DBA is the proper profile.
@BaseBackupCount: The default backup count. Dev/Test is 3, Prod is 20.

Purpose: Email DBRE a list of how many backups are missing.

------------------------------------------------------------------------------------
Change History

11/18/2021 I created a better html table to fit our standards.
12/06/2021 I added more details as well as a link to the wiki to the alert.
12/13/2021 I changed the message size to VARCHAR(MAX) from VARCHAR(500) so it doesnt truncate the message
************************************************************************************/
SET NOCOUNT ON;

IF OBJECT_ID(N'tempdb..#Counts') IS NOT NULL
BEGIN
	DROP TABLE #Counts;
END
--look at the defaults
CREATE TABLE #Counts
(	BackupCount INT   
);

--Email variables
DECLARE @Body VARCHAR(MAX);
DECLARE @XML VARCHAR(MAX);
DECLARE @subject VARCHAR(50) = 'Missing backups';
DECLARE @body_format VARCHAR(10) = 'html';
--StoProc variables
DECLARE @Comment VARCHAR(MAX) ='<b>This is the record of how many databases are missing backups.</b><br>';
DECLARE @Wiki VARCHAR(150) = '<br><br><b>Wiki Article:</b> [Link here]';
DECLARE @Proc VARCHAR(100) = '<br>Stored Procedure: BackupMonitor.BackupHistory.MissingBackupsAlert';
DECLARE @Server VARCHAR(255) = '<br>Server: ' + (SELECT @@SERVERNAME);
DECLARE @Table VARCHAR(60) = '<br>Table: BackupHistory.MissingBackup';
DECLARE @BackupNumber INT;
DECLARE @Count INT;

SET @Comment += @Server + @Table + @Proc + @Wiki + '<br><br>';

INSERT INTO #Counts(BackupCount)
SELECT DISTINCT BackupCount 
FROM BackupHistory.MissingBackup
WHERE BackupCount <> @BaseBackupCount
AND DateUpdated > DATEADD(HOUR,-1,GETDATE());

IF((SELECT COUNT(BackupCount) FROM #Counts) > 0)
BEGIN
	WHILE((SELECT COUNT(BackupCount) FROM #Counts) > 0)
	BEGIN
		SET @Count = (
			SELECT COUNT(BackupCount) 
			FROM BackupHistory.MissingBackup 
			WHERE BackupCount = (
				SELECT TOP 1 BackupCount 
				FROM #COUNTS)
					AND DateUpdated > DATEADD(HOUR,-1,GETDATE()));
		SET @BackupNumber = (SELECT TOP 1 BackupCount FROM #COUNTS);
		SET @Comment += 'There are ' + CAST(@Count AS VARCHAR(4))  + ' databases with ' + CAST(@BackupNumber AS VARCHAR(4))  + ' backup files.<br>';
		
		DELETE FROM #COUNTS
		WHERE BackupCount = (SELECT TOP 1 BackupCount FROM #COUNTS);
	END

	EXEC msdb.dbo.sp_send_dbmail
	@profile_name = @profile_name, -- replace with the correct SQL Database Mail Profile (DBA)
	@body = @Comment,
	@body_format = @body_format,
	@recipients = @recipients, -- replace with the intended email address 
	@subject = @subject;
END
GO

