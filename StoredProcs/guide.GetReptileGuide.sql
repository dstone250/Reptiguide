USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [guide].[GetReptileGuide]
	@SubSpecies VARCHAR(125)
/************************************************************************************
Object Name: [guide].[InsertIntoEnvironment]
Created By: David Stone

Parameter List:
	@SubSpecies: Name of the reptile to generate the guide for.

Example: guide.GetReptileGuide @SubSpecies = 'Russian Tortoise';

Purpose: Pull the generated notes for the given reptile, and concat them together to output the completed guide.

------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-16

************************************************************************************/
AS
BEGIN
	DECLARE 
--		@SubSpecies VARCHAR(50) = 'Russian Tortoise',
		@DietNote VARCHAR(2000), 
		@CareNote VARCHAR (2000), 
		@EquipmentNote VARCHAR (2000), 
		@SQL VARCHAR(6000), 
		@ReptileName VARCHAR(30),
		@ReptileListId SMALLINT;

	SELECT TOP 1 
		@ReptileName = CONCAT(Species, ': ', SubSpecies),
		@ReptileListId = ReptileListId
	FROM Reptile.ReptileList
	WHERE SubSpecies = @SubSpecies;

	SELECT 
		@DietNote = dietNote,
		@CareNote = carenote,
		@EquipmentNote = EquipmentNote
	FROM guide.Note
	WHERE ReptileListId = @ReptileListId;

	SET @SQL = 'REPTIGUIDE for: ' + @ReptileName + CHAR(10) +
	'DISCLAIMER: This guide is only supplimentory, and some basics. Please do in-depth research on all espects of a reptiles care before purchasing. Many reptiles can live decades or more.'
	+ CHAR(10) + CHAR(10) + @DietNote + CHAR(10)+ CHAR(10) + @CareNote
	+ CHAR(10) + @EquipmentNote;

	PRINT @SQL;
END;
GO

