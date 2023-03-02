USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [guide].[SpFindReptile]
	@Species VARCHAR(125) = NULL,
	@SubSpecies VARCHAR(125) = NULL
/************************************************************************************
Object Name: [guide].[SpFindReptile]
Created By: David Stone

Parameter List:
	@Species: Species of the reptile to find.
	@SubSpecies: SubSpecies of the reptile to find. 

Example: [guide].[SpFindReptile] @Species = 'Boa', @SubSpecies = 'Imperator';

Purpose:

------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-16

************************************************************************************/
AS
BEGIN
	DECLARE @Reptile VARCHAR(125);

	IF @Species IS NULL
	BEGIN
		PRINT 'ERROR!: Must DECLARE @Species.'+ CHAR(10)+'DECLARE @Species but not @Subspecies to get a list of all subspecies for the declared @species that exist in reptile.ReptileList.';
		RETURN;
	END;
	
	IF(@Species IS NOT NULL AND @SubSpecies IS NULL)
	BEGIN
		IF(SELECT COUNT(ReptileListId)
			FROM reptile.ReptileList 
			WHERE Species LIKE '%'+@Species+'%') = 0
		BEGIN
			SELECT 'No species found! Please RE-DECLARE @Species.' AS 'ERROR!' 
			RETURN;
		END;
		ELSE
		BEGIN
			SELECT CONCAT('Species: ', Species, ' - SubSpecies: ', SubSpecies) AS 'DECLARE @Species & @Subspecies'
			FROM Reptile.ReptileList
			WHERE Species LIKE '%'+@Species+'%';
			RETURN;
		END;
	END;
	
	IF(@Species IS NOT NULL AND @SubSpecies IS NOT NULL)
	BEGIN
		IF NOT EXISTS (
			SELECT ReptileListId
			FROM reptile.ReptileList 
			WHERE SubSpecies = @SubSpecies)
		BEGIN
			PRINT 'ERROR!: No SubSpecies found! Please RE-DECLARE @SubSpecies.';
			RETURN;
		END;
		ELSE 
		BEGIN
			SELECT * 
			FROM [guide].[VwDenormalizeInformation]
			WHERE Species = @Species
				AND SubSpecies = @SubSpecies;
		END;
	END;
END;
GO

