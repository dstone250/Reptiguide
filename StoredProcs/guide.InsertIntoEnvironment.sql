USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [guide].[InsertIntoEnvironment]
	 @Subspecies VARCHAR(100)
	,@HotSpot_F SMALLINT
	,@TempHigh_F SMALLINT
	,@TempLow_F SMALLINT
	,@HumidityHighPercentage SMALLINT
	,@HumidityLowPercentage SMALLINT
AS
/************************************************************************************
Object Name: [guide].[InsertIntoEnvironment]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs an equipment list inserted.
@HotSpot_F: Reptiles Hotspot temp.
@TempHigh_F: Reptiles high ambient temp.
@TempLow_F: Reptiles low ambient temp. 
@HumidityHighPercentage: Reptiles high humidity point.  
@HumidityLowPercentage: Reptiles low humidity point.   

Example: 
	EXEC [guide].[InsertIntoEnvironment] @SubSpecies = 'Russian Tortoise';

Purpose: Insert the environment values for a reptile into the [reptile].[Environment] table.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
BEGIN
	DECLARE @ReptileListId SMALLINT 

	SELECT TOP 1 @ReptileListId = ReptileListId
	FROM reptile.ReptileList
	WHERE SubSpecies = @Subspecies;

	INSERT INTO [reptile].[Environment](
		ReptileListId
		,HotSpot_F
		,TempHigh_F
		,TempLow_F
		,HumidityHighPercentage
		,HumidityLowPercentage )
	VALUES(
		@ReptileListId,@HotSpot_F,@TempHigh_F,@TempLow_F, @HumidityHighPercentage, @HumidityLowPercentage);
END;
GO

