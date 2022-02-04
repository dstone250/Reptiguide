USE [Alerting];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO


CREATE PROC [alerting].[StoSyncAlerting]
AS
/************************************************************************************
Object Name:
Created By: David Stone

Parameter List:
N/A

Output List:
N/A

Purpose:  Sync the data in the DBRE alerting system between VcronLinked and VcronDestination
PART 1.0: Create temp tables to store the linked server's data. (vcronLinked) 
PART 1.1: Update vcronDestination..MessageType data to match vcronLinked 
PART 1.2: Insert vcronLinked..MessageType data that only exists there, into vcronDestination
PART 2.0: Insert into the temp tables for Email, TeamsChannel, and TwilioAddress
PART 2.1: INSERT and UPDATE Data that is not synced for Email, TeamsChannel, and TwilioAddress between vcronLinked vcronDestination
PART 2.2: Denormalize the data for LinkedServer..Contact and Destination..Contact to figure out which data to update for Destination..Contact. Then update it.
PART 3.0: Denormalize the data from the CTMTTAT tables to find the data to be deleted from the DestinationCTMTTAT table
PART 3.1: Find the data to be deleted from the DestinationCTMTTAT table, and delete it
PART 3.2: Insert missing data into the destinationCTMTTAT table, and then delete all of the temp tables

NOTE: AlertingSync.alerting is the linked server. The main server needs to be swapped from Alerting.alerting to Alerting.alerting. after testing
------------------------------------------------------------------------------------

Change History:

************************************************************************************/
SET NOCOUNT ON;

-- =============================================================================================================
-- PART 1.0: Drop and Create temp tables to store the linked server's data.  
-- =============================================================================================================

/* Drop all temp tables that may exist */
IF OBJECT_ID(N'tempdb..#LinkedContact') IS NOT NULL
BEGIN
DROP TABLE #LinkedContact;
END

IF OBJECT_ID(N'tempdb..#LinkedMessageType') IS NOT NULL
BEGIN
DROP TABLE #LinkedMessageType;
END

IF OBJECT_ID(N'tempdb..#LinkedAlertType') IS NOT NULL
BEGIN
DROP TABLE #LinkedAlertType;
END

IF OBJECT_ID(N'tempdb..#LinkedEmail') IS NOT NULL
BEGIN
DROP TABLE #LinkedEmail;
END

IF OBJECT_ID(N'tempdb..#LinkedTeamsChannel') IS NOT NULL
BEGIN
DROP TABLE #LinkedTeamsChannel;
END

IF OBJECT_ID(N'tempdb..#denormalizedLinkedContact') IS NOT NULL
BEGIN
DROP TABLE #denormalizedLinkedContact;
END

IF OBJECT_ID(N'tempdb..#denormalizedDestinationContact') IS NOT NULL
BEGIN
DROP TABLE #denormalizedDestinationContact;
END

IF OBJECT_ID(N'tempdb..#LinkedTwilioAddress') IS NOT NULL
BEGIN
DROP TABLE #LinkedTwilioAddress;
END

IF OBJECT_ID(N'tempdb..#DestinationContactDataToInsert') IS NOT NULL
BEGIN
DROP TABLE #DestinationContactDataToInsert;
END

IF OBJECT_ID(N'tempdb..#DestinationContactDataToUpdate') IS NOT NULL
BEGIN
DROP TABLE #DestinationContactDataToUpdate;
END

IF OBJECT_ID(N'tempdb..#denormalizedLinkedCTMTTAT') IS NOT NULL
BEGIN
DROP TABLE #denormalizedLinkedCTMTTAT;
END

IF OBJECT_ID(N'tempdb..#denormalizedDestinationCTMTTAT') IS NOT NULL
BEGIN
DROP TABLE #denormalizedDestinationCTMTTAT;
END

IF OBJECT_ID(N'tempdb..#DestinationCTMTTATData') IS NOT NULL
BEGIN
DROP TABLE #DestinationCTMTTATData;
END

IF OBJECT_ID(N'tempdb..#MissingDestinationCTMTTATData') IS NOT NULL
BEGIN
DROP TABLE #MissingDestinationCTMTTATData;
END

IF OBJECT_ID(N'tempdb..#DestinationCTMTTATDataToDelete') IS NOT NULL
BEGIN
DROP TABLE #DestinationCTMTTATDataToDelete;
END


/* Create all of the temp tables */
CREATE TABLE #LinkedContact
(	
	[ContactId] [TINYINT],
	[Name] [VARCHAR](50),
	[InputValue] [VARCHAR](30),
	[RocketChat] [VARCHAR](50),
	[TeamsChannelId] [SMALLINT],
	[EmailId] [TINYINT],
	[TicketEmailId] [TINYINT],
	[TextTwilioAddressId] [TINYINT],
	[PhoneCallTwilioAddressId] [TINYINT],
	[SquidAlertEmailId] [TINYINT]
);
CREATE TABLE #LinkedMessageType
(	
	[MessageTypeId] [int],
	[Name] [VARCHAR](500),				
	[IsMonitored] [BIT],							
	[MinutesBetweenAlerts] [TINYINT],	
	[IsHighPriority] [BIT],				
	[IsPostMortemEvent] [BIT],			
	[WaitUntilMorning] [BIT],			
	[AlertsRequiredToSend] [TINYINT],	
	[AlertThresholdInMinutes] [SMALLINT]
);
CREATE TABLE #LinkedAlertType
(	
	[AlertTypeId] [TINYINT],
	[Name] [VARCHAR](50) 
);
CREATE TABLE #LinkedEmail
(	
	[EmailId] [TINYINT],
	[Name] [VARCHAR](50) 
);
CREATE TABLE #LinkedTeamsChannel 
(	
	[TeamsChannelId] [TINYINT],
	[Name] [VARCHAR](50),
	[Email] [VARCHAR](MAX)
);
CREATE TABLE #LinkedTwilioAddress
(	
	[TwilioAddressId] [TINYINT],
	[Name] [VARCHAR](50),
	[Url] [VARCHAR](150)
);
CREATE TABLE #denormalizedLinkedContact
(
	[ContactName]			 [VARCHAR](50)  NOT NULL,
	[InputValue]			 [VARCHAR](30)  NOT NULL,
	[RocketChat]			 [VARCHAR](50)  NOT NULL,
	[TeamsChannel]			 [VARCHAR](150) NOT NULL,
	[Email]   				 [VARCHAR](50)  NOT NULL,
	[TicketEmail]            [VARCHAR](50)  NOT NULL,
	[TextTwilioAddress]      [VARCHAR](50)  NOT NULL,
	[PhoneCallTwilioAddress] [VARCHAR](50)  NOT NULL,
	[SquidAlertEmail]        [VARCHAR](50)  NOT NULL,
);									 
CREATE TABLE #denormalizedDestinationContact
(
	[ContactName]			 [VARCHAR](50)  NOT NULL,
	[InputValue]			 [VARCHAR](30)  NOT NULL,
	[RocketChat]			 [VARCHAR](50)  NOT NULL,
	[TeamsChannel]			 [VARCHAR](150) NOT NULL,
	[Email]   				 [VARCHAR](50)  NOT NULL,
	[TicketEmail]            [VARCHAR](50)  NOT NULL,
	[TextTwilioAddress]      [VARCHAR](50)  NOT NULL,
	[PhoneCallTwilioAddress] [VARCHAR](50)  NOT NULL,
	[SquidAlertEmail]        [VARCHAR](50)  NOT NULL,
);										    
CREATE TABLE #DestinationContactDataToUpdate
(										    
	[ContactName]			 [VARCHAR](50)  NOT NULL,
	[InputValue]			 [VARCHAR](30)  NOT NULL,
	[RocketChat]			 [VARCHAR](50)  NOT NULL,
	[TeamsChannel]			 [VARCHAR](150) NOT NULL,
	[Email]   				 [VARCHAR](50)  NOT NULL,
	[TicketEmail]            [VARCHAR](50)  NOT NULL,
	[TextTwilioAddress]      [VARCHAR](50)  NOT NULL,
	[PhoneCallTwilioAddress] [VARCHAR](50)  NOT NULL,
	[SquidAlertEmail]        [VARCHAR](50)  NOT NULL,
);             							    
CREATE TABLE #DestinationContactDataToInsert
(										    
	[ContactName]			 [VARCHAR](50)  NOT NULL,
	[InputValue]			 [VARCHAR](30)  NOT NULL,
	[RocketChat]			 [VARCHAR](50)  NOT NULL,
	[TeamsChannel]			 [VARCHAR](150) NOT NULL,
	[Email]   				 [VARCHAR](50)  NOT NULL,
	[TicketEmail]            [VARCHAR](50)  NOT NULL,
	[TextTwilioAddress]      [VARCHAR](50)  NOT NULL,
	[PhoneCallTwilioAddress] [VARCHAR](50)  NOT NULL,
	[SquidAlertEmail]        [VARCHAR](50)  NOT NULL,
);
CREATE TABLE #MissingDestinationCTMTTATData 
(
ContactName      [VARCHAR](50)  NOT NULL,
MessageTypeName  [VARCHAR](500) NOT NULL,
AlertTypeName    [VARCHAR](50)  NOT NULL
);
CREATE TABLE #denormalizedLinkedCTMTTAT  
(
ContactName     [VARCHAR](50)  NOT NULL,
MessageTypeName [VARCHAR](500) NOT NULL,
AlertTypeName   [VARCHAR](50)  NOT NULL
);
CREATE TABLE #denormalizedDestinationCTMTTAT 
(
ContactName     [VARCHAR](50)  NOT NULL,
MessageTypeName [VARCHAR](500) NOT NULL,
AlertTypeName   [VARCHAR](50)  NOT NULL
);
CREATE TABLE #DestinationCTMTTATData 
(
ContactId     TINYINT NOT NULL,
MessageTypeId SMALLINT NOT NULL,
AlertTypeId   TINYINT NOT NULL
);
CREATE TABLE #DestinationCTMTTATDataToDelete
(
ContactToMessageTypeToAlertTypeId SMALLINT NOT NULL
);
-- =============================================================================================================
-- PART 1.1: Update vcronDestination..MessageType data to match vcronLinked 
-- =============================================================================================================
	
INSERT INTO #LinkedContact ([ContactId], [Name], [InputValue], [RocketChat], [TeamsChannelId], [EmailId], [TicketEmailId],
	   [TextTwilioAddressId], [PhoneCallTwilioAddressId], [SquidAlertEmailId])
SELECT [ContactId], [Name], [InputValue], [RocketChat], [TeamsChannelId], [EmailId], [TicketEmailId],
	   [TextTwilioAddressId], [PhoneCallTwilioAddressId], [SquidAlertEmailId]
FROM AlertingSync.Alerting.alerting.Contact;

INSERT INTO #LinkedMessageType ([MessageTypeId], [Name], [IsMonitored], [MinutesBetweenAlerts], [IsHighPriority], [IsPostMortemEvent], [WaitUntilMorning], 
	   [AlertsRequiredToSend], [AlertThresholdInMinutes] )
SELECT [MessageTypeId], [Name], [IsMonitored], [MinutesBetweenAlerts], [IsHighPriority], [IsPostMortemEvent], [WaitUntilMorning], 
	   [AlertsRequiredToSend], [AlertThresholdInMinutes] 
FROM AlertingSync.Alerting.alerting.MessageType;

INSERT INTO #LinkedAlertType ([AlertTypeId], [Name])
SELECT [AlertTypeId], [Name] 
FROM AlertingSync.Alerting.alerting.AlertType;


UPDATE A
SET
A.[IsMonitored] 			= B.[IsMonitored],
A.[MinutesBetweenAlerts] 	= B.[MinutesBetweenAlerts],
A.[IsHighPriority]   		= B.[IsHighPriority],
A.[IsPostMortemEvent]		= B.[IsPostMortemEvent],
A.[WaitUntilMorning]	    = B.[WaitUntilMorning],
A.[AlertsRequiredToSend]   	= B.[AlertsRequiredToSend],
A.[AlertThresholdInMinutes]	= B.[AlertThresholdInMinutes]
FROM #LinkedMessageType AS B
	INNER JOIN   Alerting.alerting.MessageType AS A ON A.Name = B.Name 
WHERE A.[IsMonitored] 			<> B.[IsMonitored] 			  
OR A.[MinutesBetweenAlerts] 	<> B.[MinutesBetweenAlerts] 	  
OR A.[IsHighPriority]   		<> B.[IsHighPriority]   		  
OR A.[IsPostMortemEvent]		<> B.[IsPostMortemEvent]		  
OR A.[WaitUntilMorning] 		<> B.[WaitUntilMorning] 		  
OR A.[AlertsRequiredToSend]   	<> B.[AlertsRequiredToSend]    
OR A.[AlertThresholdInMinutes]	<> B.[AlertThresholdInMinutes];

-- =============================================================================================================
-- PART 1.2: Insert vcronLinked..MessageType data that only exists there, into vcronDestination
-- =============================================================================================================

INSERT INTO Alerting.alerting.MessageType ([Name], [IsMonitored], [MinutesBetweenAlerts], [IsHighPriority], [IsPostMortemEvent], [WaitUntilMorning], [AlertsRequiredToSend], [AlertThresholdInMinutes])
SELECT A.[Name], A.[IsMonitored], A.[MinutesBetweenAlerts], A.[IsHighPriority], A.[IsPostMortemEvent], A.[WaitUntilMorning], A.[AlertsRequiredToSend], A.[AlertThresholdInMinutes]
FROM #LinkedMessageType AS A
	LEFT JOIN  Alerting.alerting.MessageType AS B ON B.Name = A.Name
WHERE B.[IsMonitored]  IS NULL;

-- =========================================================================================================================
-- PART 2.0: Insert into the temp tables for Email, TeamsChannel, and TwilioAddress
-- =========================================================================================================================
-- Insert the Linked Server Data into the temp tables
INSERT INTO #LinkedEmail([EmailId], [Name])
SELECT [EmailId], [Name]
FROM AlertingSync.Alerting.alerting.Email;

INSERT INTO #LinkedTeamsChannel([TeamsChannelId], [Name], [Email])
SELECT [TeamsChannelId], [Name], [Email]
FROM AlertingSync.Alerting.alerting.TeamsChannel;

INSERT INTO #LinkedTwilioAddress([TwilioAddressId], [Name], [Url])
SELECT [TwilioAddressId], [Name], [Url]
FROM AlertingSync.Alerting.alerting.TwilioAddress;

-- =========================================================================================================================
-- PART 2.1: INSERT and UPDATE Data that is not synced for Email, TeamsChannel, and TwilioAddress between vcronLinked vcronDestination
-- =========================================================================================================================

--UPDATE TeamsChannel
UPDATE B
SET B.[Email] = A.[Email]
FROM #LinkedTeamsChannel AS A
	INNER JOIN Alerting.alerting.TeamsChannel AS B ON A.Name = B.Name --OR A.Email = B.Email 
WHERE A.[Email] <> B.[Email];

--UPDATE TwilioAddress
UPDATE B
SET B.[Url] = A.[Url]
FROM #LinkedTwilioAddress AS A
	INNER JOIN Alerting.alerting.TwilioAddress AS B ON A.Name = B.Name --OR A.Url = B.Url
WHERE A.[Url] <> B.[Url];

-- Insert Email data that only exists in Linked, into the Destination table 
INSERT INTO Alerting.alerting.Email ([Name])
SELECT A.[Name]
FROM #LinkedEmail AS A
	LEFT JOIN  Alerting.alerting.Email AS B ON B.Name = A.Name
WHERE B.[Name]  IS NULL;

-- Insert TeamsChannel data that only exists in Linked, into the Destination table 
INSERT INTO Alerting.alerting.TeamsChannel ([Name], [Email])
SELECT A.[Name],  A.[Email]
FROM #LinkedTeamsChannel AS A
	LEFT JOIN  Alerting.alerting.TeamsChannel AS B ON B.Name = A.Name
WHERE B.[Name]  IS NULL;

-- Insert TwilioAddress data that only exists in Linked, into the Destination table 
INSERT INTO Alerting.alerting.TwilioAddress ([Name], [Url])
SELECT A.[Name], A.[Url]
FROM #LinkedTwilioAddress AS A
	LEFT JOIN  Alerting.alerting.TwilioAddress AS B ON B.Name = A.Name
WHERE B.[Name]  IS NULL;

-- =============================================================================================================
-- PART 2.2: Denormalize the data for Linked and Destination to figure out which data to update for Contact 
-- =============================================================================================================

--insert the denormalized data into Linked
INSERT INTO #denormalizedLinkedContact ([ContactName], [InputValue], [RocketChat], [TeamsChannel], [Email], [TicketEmail],
[TextTwilioAddress], [PhoneCallTwilioAddress], [SquidAlertEmail])
SELECT 
ISNULL (A.Name, '') AS ContactName, 
ISNULL (A.InputValue, ''), 
ISNULL (A.RocketChat, ''), 
ISNULL (TC.Name, '') AS TeamsChannel, 
ISNULL (EM.Name, '') AS Email, 
ISNULL (TE.Name, '') AS TicketEmail, 
ISNULL (TW.Name, '') AS TextTwilioAddress, 
ISNULL (PC.Name, '') AS PhoneCallTwilioAddress, 
ISNULL (SQ.Name, '') AS SquidAlertEmail
FROM #LinkedContact A
	LEFT JOIN AlertingSync.Alerting.alerting.Email	       AS EM ON A.EmailId                  = EM.EmailId
	LEFT JOIN AlertingSync.Alerting.alerting.TeamsChannel  AS TC ON A.TeamsChannelId           = TC.TeamsChannelId     
	LEFT JOIN AlertingSync.Alerting.alerting.TwilioAddress AS TW ON A.TextTwilioAddressId      = TW.TwilioAddressId    
	LEFT JOIN AlertingSync.Alerting.alerting.TwilioAddress AS PC ON A.PhoneCallTwilioAddressId = PC.TwilioAddressId
	LEFT JOIN AlertingSync.Alerting.alerting.Email	       AS SQ ON A.SquidAlertEmailId        = SQ.EmailId
	LEFT JOIN AlertingSync.Alerting.alerting.Email	       AS TE ON A.TicketEmailId            = TE.EmailId;

--insert the denormalized data into Destination
INSERT INTO #denormalizedDestinationContact ([ContactName], [InputValue], [RocketChat], [TeamsChannel], [Email], [TicketEmail],
[TextTwilioAddress], [PhoneCallTwilioAddress], [SquidAlertEmail])
SELECT 
ISNULL (A.Name, '') AS ContactName, 
ISNULL (A.InputValue, ''), 
ISNULL (A.RocketChat, ''), 
ISNULL (TC.Name, '') AS TeamsChannel, 
ISNULL (EM.Name, '') AS Email, 
ISNULL (TE.Name, '') AS TicketEmail, 
ISNULL (TW.Name, '') AS TextTwilioAddress, 
ISNULL (PC.Name, '') AS PhoneCallTwilioAddress, 
ISNULL (SQ.Name, '') AS SquidAlertEmaill	
FROM Alerting.alerting.Contact A
	LEFT JOIN Alerting.alerting.Email	       AS EM ON A.EmailId                  = EM.EmailId
	LEFT JOIN Alerting.alerting.TeamsChannel  AS TC ON A.TeamsChannelId           = TC.TeamsChannelId     
	LEFT JOIN Alerting.alerting.TwilioAddress AS TW ON A.TextTwilioAddressId      = TW.TwilioAddressId    
	LEFT JOIN Alerting.alerting.TwilioAddress AS PC ON A.PhoneCallTwilioAddressId = PC.TwilioAddressId
	LEFT JOIN Alerting.alerting.Email	       AS SQ ON A.SquidAlertEmailId        = SQ.EmailId
	LEFT JOIN Alerting.alerting.Email	       AS TE ON A.TicketEmailId            = TE.EmailId;

/* Get the data that needs to be inserted into the destination contact table */
INSERT INTO #DestinationContactDataToInsert (ContactName, InputValue, RocketChat, TeamsChannel, Email, TicketEmail, TextTwilioAddress, PhoneCallTwilioAddress, SquidAlertEmail) 
SELECT A.ContactName, A.InputValue, A.RocketChat, A.TeamsChannel, A.Email, A.TicketEmail, A.TextTwilioAddress, A.PhoneCallTwilioAddress, A.SquidAlertEmail
FROM #denormalizedLinkedContact A
	LEFT JOIN #denormalizedDestinationContact B ON 
	A.ContactName            = B.ContactName 
WHERE B.ContactName IS NULL;

/* Insert the data that needs to be inserted into the destination contact table */
INSERT INTO Alerting.alerting.Contact (Name, InputValue, RocketChat, TeamsChannelId, EmailId, TicketEmailId, TextTwilioAddressId, 
PhoneCallTwilioAddressId, SquidAlertEmailId)
SELECT 
B.ContactName,
B.InputValue,
B.RocketChat,
TC.TeamsChannelId, 
EM.EmailId,        
TE.EmailId,        
TW.TwilioAddressId,
PC.TwilioAddressId,
SQ.EmailId    
FROM #DestinationContactDataToInsert B 
	LEFT JOIN Alerting.alerting.Contact       AS  A ON A.Name                   = B.ContactName
	LEFT JOIN Alerting.alerting.Email         AS EM ON B.Email                  = EM.Name
	LEFT JOIN Alerting.alerting.TeamsChannel  AS TC ON B.TeamsChannel           = TC.Name    
	LEFT JOIN Alerting.alerting.TwilioAddress AS TW ON B.TextTwilioAddress      = TW.Name    
	LEFT JOIN Alerting.alerting.TwilioAddress AS PC ON B.PhoneCallTwilioAddress = PC.Name
	LEFT JOIN Alerting.alerting.Email         AS SQ ON B.SquidAlertEmail        = SQ.Name
	LEFT JOIN Alerting.alerting.Email         AS TE ON B.TicketEmail            = TE.Name	
WHERE A.Name IS NULL;
	
-- INSERT the data that will be updated for Contact
INSERT INTO #DestinationContactDataToUpdate (ContactName, InputValue, RocketChat, TeamsChannel, Email, TicketEmail, TextTwilioAddress, PhoneCallTwilioAddress, SquidAlertEmail)
SELECT DISTINCT A.ContactName, A.InputValue, A.RocketChat, A.TeamsChannel, A.Email, A.TicketEmail, A.TextTwilioAddress, A.PhoneCallTwilioAddress, A.SquidAlertEmail
FROM #denormalizedLinkedContact A
	LEFT JOIN #denormalizedDestinationContact B ON 
	A.ContactName            = B.ContactName AND 
	A.InputValue             = B.InputValue AND 
	A.RocketChat             = B.RocketChat AND
	A.TeamsChannel           = B.TeamsChannel AND
	A.Email                  = B.Email AND
	A.TicketEmail            = B.TicketEmail AND
	A.TextTwilioAddress      = B.TextTwilioAddress AND
	A.PhoneCallTwilioAddress = B.PhoneCallTwilioAddress AND
	A.SquidAlertEmail        = B.SquidAlertEmail
WHERE B.ContactName IS NULL;

--UPDATE the data in Destination.Contact to match Linked.Contact
UPDATE A
SET	 
	A.InputValue               = B.InputValue,
	A.RocketChat               = B.RocketChat,
	A.TeamsChannelId           = TC.TeamsChannelId,     
	A.EmailId                  = EM.EmailId,         	
	A.TicketEmailId            = TE.EmailId,        	
	A.TextTwilioAddressId      = TW.TwilioAddressId,    
	A.PhoneCallTwilioAddressId = PC.TwilioAddressId,	
	A.SquidAlertEmailId        = SQ.EmailId    
FROM #DestinationContactDataToUpdate B
	LEFT JOIN Alerting.alerting.Contact         AS  A ON A.Name                   = B.ContactName
	LEFT JOIN Alerting.alerting.Email           AS EM ON B.Email                  = EM.Name
	LEFT JOIN Alerting.alerting.TeamsChannel    AS TC ON B.TeamsChannel           = TC.Name    
	LEFT JOIN Alerting.alerting.TwilioAddress   AS TW ON B.TextTwilioAddress      = TW.Name    
	LEFT JOIN Alerting.alerting.TwilioAddress   AS PC ON B.PhoneCallTwilioAddress = PC.Name
	LEFT JOIN Alerting.alerting.Email           AS SQ ON B.SquidAlertEmail        = SQ.Name
	LEFT JOIN Alerting.alerting.Email           AS TE ON B.TicketEmail            = TE.Name	
WHERE B.ContactName = A.Name; 
	
-- ================================================================================================================================
-- PART 3.0: Denormalize the data from the CTMTTAT tables to find the data to be deleted from the DestinationCTMTTAT table
-- ================================================================================================================================

/* DENORMALIZE the data into tables for vcronLinked, and vcronDestination */
INSERT INTO #denormalizedLinkedCTMTTAT (ContactName, MessageTypeName, AlertTypeName)
SELECT B.Name AS ContactName, C.Name AS MessageTypeName, D.Name AS AlertTypeName 
FROM AlertingSync.Alerting.alerting.ContactToMessageTypeToAlertType AS A
	INNER JOIN #LinkedContact	  AS B ON A.ContactId     = B.ContactId
	INNER JOIN #LinkedMessageType AS C ON A.MessageTypeId = C.MessageTypeId 
	INNER JOIN #LinkedAlertType	  AS D ON A.AlertTypeId   = D.AlertTypeId;

INSERT INTO #denormalizedDestinationCTMTTAT (ContactName, MessageTypeName, AlertTypeName)
SELECT B.Name AS ContactName, C.Name AS MessageTypeName, D.Name AS AlertTypeName 
FROM Alerting.alerting.ContactToMessageTypeToAlertType AS A
	INNER JOIN Alerting.alerting.Contact     AS B ON A.ContactId     = B.ContactId
	INNER JOIN Alerting.alerting.MessageType AS C ON A.MessageTypeId = C.MessageTypeId 
	INNER JOIN Alerting.alerting.AlertType   AS D ON A.AlertTypeId   = D.AlertTypeId;

-- ================================================================================================================================
-- PART 3.1: Find the data to be deleted from the DestinationCTMTTAT table, and delete it
-- ================================================================================================================================
	
/* Get the ContactToMessageTypeToAlertTypeIds that need to be delete from the destination table. */
INSERT INTO #DestinationCTMTTATDataToDelete (ContactToMessageTypeToAlertTypeId)
SELECT  F.ContactToMessageTypeToAlertTypeId
FROM #denormalizedDestinationCTMTTAT A
	LEFT JOIN #denormalizedLinkedCTMTTAT B ON 
	A.ContactName =     B.ContactName     AND 
	A.MessageTypeName = B.MessageTypeName AND 
	A.AlertTypeName   = B.AlertTypeName
	LEFT JOIN Alerting.alerting.Contact     AS C ON C.NAME = A.ContactName  
	LEFT JOIN Alerting.alerting.MessageType AS D ON D.NAME = A.MessageTypeName  
	LEFT JOIN Alerting.alerting.AlertType   AS E ON E.NAME = A.AlertTypeName
	LEFT JOIN Alerting.alerting.ContactToMessageTypeToAlertType AS F ON
	F.ContactId         = C.ContactId  AND   
	F.MessageTypeId     = D.MessageTypeId AND 
	F.AlertTypeId       = E.AlertTypeId    
WHERE B.MessageTypeName IS NULL;
	
/* Delete the ID's from the destination */	
DELETE A
FROM Alerting.alerting.ContactToMessageTypeToAlertType A
INNER JOIN #DestinationCTMTTATDataToDelete AS B ON A.ContactToMessageTypeToAlertTypeId = B.ContactToMessageTypeToAlertTypeId;

-- =======================================================================================================================================
-- PART 3.2: Get the data that has to be insterted into the destinationCTMTTAT table from the LinkedCTMTTAT table. Delete all temp tables
-- =======================================================================================================================================

INSERT INTO Alerting.alerting.ContactToMessageTypeToAlertType (ContactId, MessageTypeId, AlertTypeId)
SELECT C.ContactId, D.MessagetypeId, E.AlertTypeId
FROM #denormalizedLinkedCTMTTAT  A
	LEFT JOIN #denormalizedDestinationCTMTTAT B ON 
	A.ContactName = B.ContactName AND 
	A.MessageTypeName = B.MessageTypeName AND 
	A.AlertTypeName   = B.AlertTypeName
	LEFT JOIN Alerting.alerting.Contact     AS C ON C.NAME = A.ContactName  
	LEFT JOIN Alerting.alerting.MessageType AS D ON D.NAME = A.MessageTypeName  
	LEFT JOIN Alerting.alerting.AlertType   AS E ON E.NAME = A.AlertTypeName
WHERE B.MessageTypeName IS NULL;

/* DROP all of the remaining temp tables */
DROP TABLE #LinkedContact;
DROP TABLE #LinkedMessageType;
DROP TABLE #LinkedAlertType;
DROP TABLE #LinkedEmail;
DROP TABLE #LinkedTeamsChannel;
DROP TABLE #denormalizedLinkedContact;
DROP TABLE #denormalizedDestinationContact;
DROP TABLE #LinkedTwilioAddress;
DROP TABLE #DestinationContactDataToInsert;
DROP TABLE #DestinationContactDataToUpdate;
DROP TABLE #denormalizedLinkedCTMTTAT;
DROP TABLE #denormalizedDestinationCTMTTAT;
DROP TABLE #DestinationCTMTTATData;
DROP TABLE #DestinationCTMTTATDataToDelete;
DROP TABLE #MissingDestinationCTMTTATData;
GO


