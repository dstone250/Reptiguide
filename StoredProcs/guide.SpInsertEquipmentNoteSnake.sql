USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [guide].[SpInsertEquipmentNoteSnake]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertEquipmentNote]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertEquipmentNote] @SubSpecies = 'bci', @Debug = 1;

Purpose: Get the denormalized care information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/

SET NOCOUNT ON;

DECLARE @Materials TABLE (
	ID INT,
	CategoryInfo VARCHAR(50),
	EquipmentName VARCHAR(200)
);

DECLARE 
	 @careInfoId INT
	,@ReptileListId INT
	,@ReptileType VARCHAR(150)	
	,@HeatingList VARCHAR(200) = ''
	,@HumidityList VARCHAR(200) =''
	,@AutomationList VARCHAR(200) = ''
	,@FeedingList VARCHAR(200) = ''
	,@OldNote VARCHAR(1500)
	,@NewNote VARCHAR(1500)
	,@MaterialList VARCHAR(200) = '';

	--,@SubSpecies VARCHAR(100) = 'bci'
	--,@Debug BIT = 1
SELECT TOP 1 @ReptileListId = ReptileListId
FROM reptile.ReptileList
WHERE @SubSpecies = SubSpecies;

IF NOT EXISTS(
	SELECT TOP 1 1 
	FROM [equipment].[ObjectNote]
	WHERE ReptileListId = @ReptileListId)
BEGIN
	EXEC guide.SpInsertEquipmentNotes @ReptileListId = @ReptileListId;
END;

SELECT 
		@HeatingList = Heating
	,@HumidityList = Humidity
	,@AutomationList = Automation
	,@FeedingList = Feeding
FROM [equipment].[ObjectNote]
WHERE ReptileListId = @ReptileListId;

SET @NewNote = CONCAT('EQUIPMENT: ',CHAR(10),'There is a lot of equipment that can help with the care of a reptile. There are four main categories. Heating control, Humidity control, Automation and Feeding. ',
CHAR(10),'Heating equipment is used to keep the temperatures at the proper level: ', @HeatingList,CHAR(10),
'Humidity equipment is used to keep humidity at the proper level: ', @HumidityList,CHAR(10),
'Automation equipment is used to automate all electrical equipment to keep temperatures and humidity in a sweet spot, and to have a set day and night cycle: ',@AutomationList,CHAR(10),
'Feeding equipment is used to assist with feedings: ', @FeedingList,CHAR(10),
'Thermosats are essential for any heating equipment, and timers are a life saver for setting: heat, lighting, and misting to a desired schedule.');

IF(@Debug = 1)
BEGIN
	SET @OldNote = (
		SELECT EquipmentNote
		FROM guide.Note
		WHERE ReptileListId = @ReptileListId );

	PRINT 'Note before update: ' + CHAR(10) + @OldNote + CHAR(10);
	PRINT 'Note after update:' + CHAR(10) +  @NewNote + CHAR(10);
END;
ELSE 
BEGIN
	SET @OldNote = (
		SELECT EquipmentNote
		FROM guide.Note
		WHERE ReptileListId = @ReptileListId );
END;
GO

