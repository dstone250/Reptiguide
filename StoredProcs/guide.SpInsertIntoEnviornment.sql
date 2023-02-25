USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [guide].[SpInsertIntoEnviornment]
	 @Subspecies VARCHAR(100)
	,@HotSpot_F SMALLINT
	,@TempHigh_F SMALLINT
	,@TempLow_F SMALLINT
	,@HumidityHighPercentage SMALLINT
	,@HumidityLowPercentage SMALLINT
AS
/*
	--@ReptileListId,95,80,70,	70,	50
	EXEC Guide.SpInsertIntoEnviornment
	@Subspecies = 'Russian Tortoise',
	@HotSpot_F = 95,
	@TempHigh_F =80,
	@TempLow_F = 70, 
	@HumidityHighPercentage =70, 
	@HumidityLowPercentage = 50;
*/
BEGIN
DECLARE 
	 @ReptileListId SMALLINT 

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
		@ReptileListId,
		@HotSpot_F,
		@TempHigh_F,
		@TempLow_F, 
		@HumidityHighPercentage, 
		@HumidityLowPercentage);
END;
GO

