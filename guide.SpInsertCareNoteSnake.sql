USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [guide].[SpInsertCareNoteSnake]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertCareNote]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertCareNote] @SubSpecies = 'bci', @Debug = 1;

Purpose: Get the denormalized care information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
SET NOCOUNT ON;

DECLARE @Materials TABLE (
	ID INT,
	Material VARCHAR(50)
);

DECLARE 
	 @careInfoId INT
	,@ReptileListId INT
	,@ReptileType VARCHAR(150)	
	,@LifeExpectancy VARCHAR(50) 	
	,@HotSpot_F TINYINT   
	,@TempLow_F TINYINT    
	,@TempHigh_F TINYINT   
	,@HumidityLowPercentage TINYINT 
	,@HumidityHighPercentage TINYINT
	,@OldNote VARCHAR(1500)
	,@NewNote VARCHAR(MAX)
	,@MaterialList VARCHAR(200) = '';

	--,@SubSpecies VARCHAR(100) = 'bci'
	--,@Debug BIT = 1

SELECT TOP 1 
	@ReptileListId = ReptileListId,
	@LifeExpectancy = LifeExpectancy
FROM reptile.ReptileList
WHERE @SubSpecies = SubSpecies;

SELECT 
	 @ReptileType = ReptileType
	,@HotSpot_F = HotSpot_F
	,@TempLow_F = TempLow_F
	,@TempHigh_F = TempHigh_F
	,@HumidityLowPercentage = HumidityLowPercentage
	,@HumidityHighPercentage = HumidityHighPercentage
FROM [guide].[VwDenormalizeEnvironment]
WHERE ReptileListId = @ReptileListId;

INSERT INTO @Materials(ID, Material)
SELECT rl.SubstrateId, cs.Material 
FROM guide.ReptileListToSubstrate rl
INNER JOIN care.Substrate cs ON rl.SubstrateId = cs.SubstrateId

WHILE EXISTS (SELECT TOP 1 1 FROM @Materials)
BEGIN
	SET @MaterialList += (SELECT TOP 1 Material FROM @Materials ORDER BY ID);	
	
	IF ((SELECT COUNT(ID) FROM @Materials) > 1)
	BEGIN
		SET @MaterialList += ', ';
	END;	
	DELETE FROM @Materials 
	WHERE ID = (SELECT TOP 1 ID FROM @Materials ORDER BY ID)
END;

SET @NewNote = CONCAT('CARE:',CHAR(10),'The ', @ReptileType ,' can live ',@LifeExpectancy,' in the wild, and they can live even longer with proper care in captivity. 
One of the more important aspects to care is maintaining a proper heat gradiant. There should be a cool, and warm side to the encloser as well as a hot spot. 
Proper temperatures will help the animal digest food properly. Too much heat or cold can kill them. For a ',@ReptileType,' The highest ambient temperature in the enclosure should be around ',
@TempLow_F,' degrees farenheight. 
The lowest ambient temperature should not be lower than ',@TempHigh_F ,' degrees farenheight. There should be hot spot as well to help the Snake warm up as desired. 
The average temperature should be around ',@HotSpot_F,' degrees farenheight. Further details will be in the equipment portion.',CHAR(10),CHAR(10));

SET @NewNote += CONCAT('Humidity is also an important aspect to the care of a', @ReptileType ,'. The humidity can fluctuate but the high point should be around ',@HumidityHighPercentage,'%
and the lower humidity should be around ',@HumidityLowPercentage,'%. The type of substrate used can retain more moisture. A larger water bowl can be used to maintain humidity. 
Daily misting will also help maintain the humidity.',CHAR(10),CHAR(10));

SET @NewNote += CONCAT('An enclosure should be as long as the snake, so it can fully strech out. The best Substrates are ',@MaterialList,'. 
It is best practice to have two or more places to hide, and snakes prefer a hide slightly larger than their body when curled up.',CHAR(10));

IF(@Debug = 1)
BEGIN
	SET @OldNote = (
		SELECT CareNote
		FROM guide.Note
		WHERE ReptileListId = @ReptileListId );

	PRINT 'Note before update: ' + CHAR(10) + @OldNote + CHAR(10);
	PRINT 'Note after update:' + CHAR(10) +  @NewNote + CHAR(10)
END;
ELSE 
BEGIN
	UPDATE guide.Note
	SET CareNote = @NewNote
	WHERE ReptileListId = @ReptileListId;
END;
GO

