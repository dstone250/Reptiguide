USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [guide].[SpCreateGuide]
	 @Category VARCHAR(10), 
	 @SubSpecies VARCHAR(50) = NULL
AS
/************************************************************************************
Object Name: [guide].[SpCreateGuide]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: 
	EXEC [guide].[SpCreateGuide] @Category = 'snake', @SubSpecies = 'bci';
	EXEC [guide].[SpCreateGuide] @Category = 'Tortoise', @SubSpecies = 'Russian Tortoise';

Purpose: Get the denormalized care information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
SET NOCOUNT ON;

DECLARE @ReptileListId SMALLINT;

IF @SubSpecies IS NULL
BEGIN
	SELECT 'ERROR: Must SET @SubSpecies';
	RETURN;
END;

SET @ReptileListId =(
	SELECT ReptileListId 
	FROM Reptile.ReptileList
	WHERE SubSpecies = @SubSpecies);

IF NOT EXISTS (
	SELECT ReptileListId
	FROM [guide].[Note]
	WHERE ReptileListId = @ReptileListId)
BEGIN
	INSERT INTO [guide].[Note](ReptileListId)
	VALUES(@ReptileListId)
END;

IF(@Category = 'Snake')
BEGIN
	EXEC [guide].[SpInsertDietNoteSnake] @SubSpecies = @SubSpecies;
	EXEC [guide].[SpInsertCareNoteSnake] @SubSpecies = @SubSpecies;
	EXEC [guide].[SpInsertEquipmentNoteSnake] @SubSpecies = @SubSpecies;
END;

IF(@Category LIKE 'Tortoise')
BEGIN
	EXEC [guide].[SpInsertDietNoteTortoise] @SubSpecies = @SubSpecies;
	EXEC [guide].[SpInsertCareNoteTortoise] @SubSpecies = @SubSpecies;
	EXEC [guide].[SpInsertEquipmentNoteTortoise] @SubSpecies = @SubSpecies;
END;

EXEC [guide].[GetReptileGuide] @SubSpecies = @SubSpecies;



GO

