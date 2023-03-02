USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [guide].[SpInsertDietNoteTortoise]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertDietNoteTortoise]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertDietNoteTortoise] @SubSpecies = 'russian tortoise', @Debug = 1;

Purpose: Get the denormalized diet information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
	BEGIN
	SET NOCOUNT ON;

	DECLARE 
		 @ReptileListId INT
		,@DietId INT
		,@ReptileType VARCHAR(150)	
		,@Scope	VARCHAR(50)
		,@DietToNoteId	INT	
		,@BowlSize VARCHAR(100)	
		,@FoodSchedule VARCHAR(50)	
		,@SupplementName VARCHAR(50)	
		,@SupplementScedule	VARCHAR(50)
		,@FeedingChartNote VARCHAR(1500)	
		,@OldNote VARCHAR(1500)
		,@NewNote VARCHAR(1500);

	SELECT TOP 1 
		 @ReptileListId = cd.ReptileListId
		,@DietId = cd.DietId
	FROM Care.Diet cd 
		INNER JOIN reptile.ReptileList rl ON rl.ReptileListId = cd.ReptileListId
	WHERE rl.SubSpecies = @SubSpecies;

	SELECT 
		 @ReptileType = ReptileType
		,@Scope	= Scope	
		,@BowlSize	= BowlSize	
		,@SupplementName	= SupplementName	
		,@SupplementScedule	= SupplementSchedule	
	FROM [guide].[VwDenormalizeDiet] 
	WHERE ReptileListId = @ReptileListId;

	SELECT @FeedingChartNote = note 
	FROM [care].[FeedingChartNote]
	WHERE ReptileListId = @ReptileListId

	SET @NewNote = CONCAT('DIET:',CHAR(10),'A ' ,@ReptileType, ' should have a variety of greens and vegetables to eat such as the following: ', @FeedingChartNote,'. ',
		'Their meals can be supplimented with ',@SupplementName, ' ' , @SupplementScedule,'.', CHAR(10),
		'The water bowl should be ',@BowlSize,'.');

	IF(@Debug = 1)
	BEGIN
		SET @OldNote = (
			SELECT DietNote
			FROM guide.Note
			WHERE ReptileListId = @ReptileListId );
 
		PRINT 'Note before update: ' + @OldNote+CHAR(10);
		PRINT 'Note after update:' + @NewNote;
	END;
	ELSE 
	BEGIN
		UPDATE guide.Note
		SET DietNote = @NewNote
		WHERE ReptileListId = @ReptileListId;
	END;
END;
GO




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [guide].[SpInsertCareNoteTortoise]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertCareNoteTortoise]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertCareNoteTortoise] @SubSpecies = 'Russian Tortoise', @Debug = 1;

Purpose: Get the denormalized care information for a Tortoise, and print it out or use it later on.
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

SELECT TOP 1 
	@ReptileListId = rl.ReptileListId,
	@LifeExpectancy = ri.LifeExpectancy
FROM reptile.ReptileList rl
	INNER JOIN reptile.Information ri ON ri.ReptileListId = rl.ReptileListId
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

SET @NewNote = CONCAT('CARE:',CHAR(10),'The ', @ReptileType ,' can live ',@LifeExpectancy,' in the wild, and they can live even longer with proper care in captivity. One of the more important aspects to care is maintaining a
proper heat gradiant. There should be a cool, and warm side to the encloser as well as a hot spot. Proper temperatures will help the animal digest food properly. Too much heat or cold can kill them. 
For a ',@ReptileType,' The highest ambient temperature in the enclosure should be around',@TempLow_F,' degrees farenheight. The lowest ambient temperature should not be lower than ',@TempHigh_F ,' degrees farenheight. There should be hot spot as well to help the Snake warm up as desired. The average temperature should be around
',@HotSpot_F,' degrees farenheight. Further details will be in the equipment portion.',CHAR(10),CHAR(10));

SET @NewNote += CONCAT('Humidity is also an important aspect to the care of a', @ReptileType ,'. The humidity can fluctuate but the high point should be around ',@HumidityHighPercentage,'%
and the lower humidity should be around ',@HumidityLowPercentage,'%. The type of substrate used should eliminate or retain more moisture depending on the species.',CHAR(10),CHAR(10));

SET @NewNote += CONCAT('An enclosure should be large enough for the tortoise to roam freely. Even a small tortise should have a 75 to 100 gallon enclosure The best Substrates are ',@MaterialList,'. 
It is important to have places for the animal to hide as well.',CHAR(10));

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




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [guide].[SpInsertEquipmentNotes] 
	@ReptileListId SMALLINT
AS
/************************************************************************************
Object Name: [guide].[SpInsertEquipmentNote]
Created By: David Stone

Parameter List:
@ReptileListId: The ReptileListId is used to get the related equipment.

Example: EXEC guide.SpInsertEquipmentNotes @ReptileListId = 5;

Purpose: Get the list of equipment that is used by a reptile.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
BEGIN
	SET NOCOUNT ON;
	DROP TABLE IF EXISTS #Equipment;

	CREATE TABLE #Equipment(
		ReptileListTobjectId SMALLINT,
		Equipment VARCHAR(500)
	);

	DECLARE @EquipmentNote VARCHAR(1000) = '',
		@Equipment VARCHAR(50);
		
	IF NOT EXISTS(
		SELECT TOP 1 1 
		FROM [equipment].[ObjectNote]
		WHERE ReptileListId = @ReptileListId)
	BEGIN
		INSERT INTO [equipment].[ObjectNote] (ReptileListId)
		VALUES(@ReptileListId);
	END;

	INSERT INTO #Equipment(ReptileListTobjectId, Equipment)
	SELECT ReptileListTobjectId, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE CategoryInfo = 'Heating'
	ORDER BY ReptileListTobjectId;

	WHILE EXISTS (
		SELECT TOP 1 1 FROM #Equipment)
	BEGIN
		SET @Equipment = (
		SELECT TOP 1  Equipment 
		FROM #Equipment 
		ORDER BY ReptileListTobjectId)

		IF((SELECT COUNT(*) FROM #Equipment) > 1)
		BEGIN
			SET @EquipmentNote += @Equipment + ', ';
		END;
		ELSE
		BEGIN
			SET @EquipmentNote += @Equipment;
		END;

		DELETE FROM #Equipment
		WHERE Equipment = @Equipment;
	END;

	UPDATE [equipment].[ObjectNote]
	SET Heating = @EquipmentNote
	WHERE ReptileListId = @ReptileListId;

	INSERT INTO #Equipment(ReptileListTobjectId, Equipment)
	SELECT ReptileListTobjectId, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE CategoryInfo = 'Humidity'
	ORDER BY ReptileListTobjectId;

	WHILE EXISTS (
		SELECT TOP 1 1 FROM #Equipment)
	BEGIN
		SET @Equipment = (
		SELECT TOP 1  Equipment 
		FROM #Equipment 
		ORDER BY ReptileListTobjectId)

		IF((SELECT COUNT(*) FROM #Equipment) > 1)
		BEGIN
			SET @EquipmentNote += @Equipment + ', ';
		END;
		ELSE
		BEGIN
			SET @EquipmentNote += @Equipment;
		END;

		DELETE FROM #Equipment
		WHERE Equipment = @Equipment;
	END;

	UPDATE [equipment].[ObjectNote]
	SET Humidity = @EquipmentNote
	WHERE ReptileListId = @ReptileListId;

	INSERT INTO #Equipment(ReptileListTobjectId, Equipment)
	SELECT ReptileListTobjectId, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE CategoryInfo = 'Automation'
	ORDER BY ReptileListTobjectId;

	WHILE EXISTS (
		SELECT TOP 1 1 FROM #Equipment)
	BEGIN
		SET @Equipment = (
		SELECT TOP 1  Equipment 
		FROM #Equipment 
		ORDER BY ReptileListTobjectId)

		IF((SELECT COUNT(*) FROM #Equipment) > 1)
		BEGIN
			SET @EquipmentNote += @Equipment + ', ';
		END;
		ELSE
		BEGIN
			SET @EquipmentNote += @Equipment;
		END;

		DELETE FROM #Equipment
		WHERE Equipment = @Equipment;
	END;

	UPDATE [equipment].[ObjectNote]
	SET Automation = @EquipmentNote
	WHERE ReptileListId = @ReptileListId;


	INSERT INTO #Equipment(ReptileListTobjectId, Equipment)
	SELECT ReptileListTobjectId, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE CategoryInfo = 'Feeding'
	ORDER BY ReptileListTobjectId;

	WHILE EXISTS (
		SELECT TOP 1 1 FROM #Equipment)
	BEGIN
		SET @Equipment = (
		SELECT TOP 1  Equipment 
		FROM #Equipment 
		ORDER BY ReptileListTobjectId)

		IF((SELECT COUNT(*) FROM #Equipment) > 1)
		BEGIN
			SET @EquipmentNote += @Equipment + ', ';
		END;
		ELSE
		BEGIN
			SET @EquipmentNote += @Equipment;
		END;

		DELETE FROM #Equipment
		WHERE Equipment = @Equipment;
	END;

	UPDATE [equipment].[ObjectNote]
	SET Feeding = @EquipmentNote
	WHERE ReptileListId = @ReptileListId;
END;

GO




USE [Reptiguide_empty]
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





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [guide].[SpInsertEquipmentNoteTortoise]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertEquipmentNoteTortoise]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertEquipmentNoteTortoise] @SubSpecies = 'Russian Tortoise', @Debug = 1;

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
'Automation equipment is used to automate all electrical equipment to keep temperatures and humidity in a sweet spot, and to have a set day and night cycle: 
',@AutomationList,CHAR(10),
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
	UPDATE guide.Note
	SET EquipmentNote = @NewNote
	WHERE ReptileListId = @ReptileListId;
END;
GO




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [guide].[SpInsertFeedingChartSnake]
	 @ReptileListId SMALLINT
AS
/************************************************************************************
Object Name: [guide].[SpInsertFeedingChartSnake]
Created By: David Stone

Parameter List:

Example: EXEC [guide].[SpInsertFeedingChartSnake] @ReptileListId = 1;

Purpose: 
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-18

************************************************************************************/
BEGIN
	SET NOCOUNT ON;

	CREATE TABLE #FeedingChartSnake(
		 Stage VARCHAR(15)
		,Note VARCHAR(15)
		,Frequency VARCHAR(15)
		,SmallCategory VARCHAR(15)
		,SmallFeederSize VARCHAR(15)
		,LargeCategory VARCHAR(15)
		,LargeFeederSize VARCHAR(15))

	DECLARE 
		 @Stage VARCHAR(15)
		,@Note VARCHAR(15)
		,@Frequency VARCHAR(15)
		,@SmallCategory VARCHAR(15)
		,@SmallFeederSize VARCHAR(15)
		,@LargeCategory VARCHAR(15)
		,@LargeFeederSize VARCHAR(15)
		,@ReptileType VARCHAR(50)
		,@OutputNote VARCHAR(1000) = '';
	
	SELECT 
		 @ReptileType = ReptileType
	FROM [guide].[VwDenormalizeDiet]
	WHERE ReptileListId = @ReptileListId;

	INSERT INTO #FeedingChartSnake (Stage,Note,Frequency, SmallCategory, SmallFeederSize, LargeCategory, LargeFeederSize) 
	SELECT Stage, Note, Frequency, SmallCategory, SmallFeederSize, LargeCategory, LargeFeederSize 
	FROM [guide].[VwDenormalizeFeedingChartSnake]
	WHERE ReptileListId = @ReptileListId;
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #FeedingChartSnake)
	BEGIN
		SELECT TOP 1 
			 @Stage = Stage
			,@Note = Note
			,@Frequency = Frequency
			,@SmallCategory = SmallCategory
			,@SmallFeederSize = SmallFeederSize
			,@LargeCategory = LargeCategory
			,@LargeFeederSize = LargeFeederSize
		FROM #FeedingChartSnake 
		ORDER BY Note;

		SET @OutputNote +=  CONCAT('A ', @Stage, ' ' ,@ReptileType, ' will be between ',  @Note, ' old. ',
		'It should be fed every ', @Frequency, ' and can eat ', @SmallFeederSize, ' ', @SmallCategory, ' to ' ,@LargeFeederSize, ' ', @LargeCategory,'.', CHAR(10))

		DELETE FROM #FeedingChartSnake 
		WHERE Stage = @Stage;
	END;

	IF NOT EXISTS(SELECT TOP 1 1 
		FROM [care].[FeedingChartNote]
		WHERE ReptileListId = @ReptileListId)
	BEGIN
		INSERT INTO [care].[FeedingChartNote](ReptileListId, Note)
		VALUES (@ReptileListId, @OutputNote)
	END
	ELSE BEGIN
		UPDATE [care].[FeedingChartNote]
		SET note = @OutputNote 
		WHERE ReptileListId = @ReptileListId;
	END;
END;
GO




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [guide].[SpInsertHerbivoreDietList]
	@Subspecies VARCHAR(100)
AS
/*********************************************************************************
Object Name: [guide].[SpInsertHerbivoreDietList]
Created By: David Stone
Parameter List:
Example: EXEC guide.SpInsertHerbivoreDietList @Subspecies = 'Russian Tortoise';
Purpose: Insert the a list of foods an herbivore can eat.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-18
*********************************************************************************/
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS  #FoodList
	DROP TABLE IF EXISTS #FoodTypeList

	CREATE TABLE #FoodList(
		FoodListId SMALLINT IDENTITY (1,1),
		FoodType VARCHAR(50),
		FoodCategory VARCHAR(50),
		Subcategory VARCHAR(50)
	)

	CREATE TABLE #FoodTypeList(
		FoodType VARCHAR(50)
	)

	DECLARE 
		 @ReptileListId SMALLINT
		,@DietNote VARCHAR(1500) = ''
		,@FoodType VARCHAR(50)
		,@FoodCategory VARCHAR(50)	
		,@Subcategory VARCHAR(50);

	SELECT @ReptileListId = ReptileListId 
	FROM Reptile.ReptileList
	WHERE SubSpecies = @Subspecies;

	INSERT INTO #FoodList(FoodType, FoodCategory, Subcategory)
	SELECT 
		ft.Category,
		fh.Category, 
		fh.SubCategory 
	FROM [guide].[ReptileToPlantList] rtp
		INNER JOIN reptile.ReptileList rl ON rl.ReptileListId = rtp.ReptileListId
		INNER JOIN food.PlantList fh ON rtp.PlantListId = fh.PlantListId
		INNER JOIN food.CategoryPlant ft ON ft.CategoryPlantId = fh.CategoryPlantId
	WHERE rtp.ReptileListId = @ReptileListId;

	INSERT INTO #FoodTypeList(FoodType)
	SELECT DISTINCT FoodType
	FROM #FoodList;

	WHILE ((
		SELECT COUNT(*) 
		FROM #FoodTypeList) > 0)
	BEGIN
		SET @FoodType = (
			SELECT TOP 1 FoodType 
			FROM #FoodTypeList);

		WHILE ((
			SELECT COUNT(*) 
			FROM #FoodList
			WHERE FoodType = @FoodType ) > 0)
		BEGIN

			SELECT 
				@FoodCategory = FoodCategory,
				@Subcategory = SubCategory
			FROM #FoodList 
			WHERE FoodType = @FoodType
	
			IF(@Subcategory <> '')
			BEGIN
				SET @DietNote += @FoodCategory;
			END;
			ELSE 
			BEGIN
				SET @DietNote += @FoodCategory + ' '+ @Subcategory
			END;

			IF((
				SELECT COUNT(FoodCategory)
				FROM #FoodList 
				WHERE FoodType = @FoodType) > 1)
			BEGIN
				SET @DietNote += ', ';
			END;

			DELETE FROM #FoodList 
			WHERE FoodCategory = @FoodCategory 
				AND Subcategory = @SubCategory;
		END;
		DELETE FROM #FoodTypeList
		WHERE FoodType = @FoodType;
	END;

	PRINT @DietNote

	IF NOT EXISTS(
		SELECT TOP 1 1 
		FROM [care].[FeedingChartNote]
		WHERE ReptileListId = @ReptileListId)
	BEGIN
		INSERT [care].[FeedingChartNote](ReptileListId, Note)
		VALUES(@ReptileListId, @DietNote);
	END;
	ELSE
	BEGIN
		UPDATE [care].[FeedingChartNote]
		SET Note = @DietNote
		WHERE ReptileListId = @ReptileListId;
	END;
END;
GO



USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [guide].[SpInsertObjectNotes]
	 @ReptileListId SMALLINT
/************************************************************************************
Object Name: [guide].[SpInsertObjectNotes]
Created By: David Stone

Parameter List:
@ReptileListId: Dictates which reptile notes to update

Example: EXEC [guide].[SpInsertObjectNote] @ReptileListId = 1

Purpose: Create the Equipment.Object Notes to be used by [guide].[SpInsertEquipmentNote]
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
AS
BEGIN
	DECLARE @Materials TABLE (
		ID INT,
		CategoryInfo VARCHAR(50),
		EquipmentName VARCHAR(200)
	);

	DECLARE 
		@Heating VARCHAR(200) = ''
		,@Humidity VARCHAR(200) = ''
		,@Automation VARCHAR(200) = ''
		,@Feeding VARCHAR(200) = ''
		,@CategoryInfo VARCHAR(50) =''
		,@EquipmentName VARCHAR(50) =''
		,@Count TINYINT;
	
	/* Get the list of all equipment needed by the reptile. */
	INSERT INTO @Materials(CategoryInfo, EquipmentName)
	SELECT CategoryInfo, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE reptilelistId = @ReptileListId;
	
	/* Create a list oh equpment used for: */
	SET @CategoryInfo = 'Heating';
	WHILE EXISTS(
		SELECT TOP 1 CategoryInfo
		FROM @Materials 
		WHERE CategoryInfo=@CategoryInfo)
	BEGIN
		SET @Count = (
			SELECT COUNT(EquipmentName) 
			FROM @Materials 
			WHERE CategoryInfo = @CategoryInfo);

		SET @EquipmentName = (
			SELECT TOP 1 EquipmentName 
			FROM @Materials 
			WHERE CategoryInfo=@CategoryInfo);
		
		IF(@Count <> 1)
		BEGIN
			SET @Heating += @EquipmentName+', ';
		END;
		ELSE
		BEGIN
			SET @Heating += @EquipmentName;
		END;

		DELETE FROM @Materials 
		WHERE EquipmentName = @EquipmentName;
	END

	/* Create a list oh equpment used for: Humidity */	
	SET @CategoryInfo = 'Humidity';
	WHILE EXISTS(
		SELECT TOP 1 CategoryInfo
		FROM @Materials 
		WHERE CategoryInfo=@CategoryInfo)
	BEGIN
		SET @Count = (
			SELECT COUNT(EquipmentName) 
			FROM @Materials 
			WHERE CategoryInfo = @CategoryInfo);

		SET @EquipmentName = (
			SELECT TOP 1 EquipmentName 
			FROM @Materials 
			WHERE CategoryInfo=@CategoryInfo);
		
		IF(@Count <> 1)
		BEGIN
			SET @Humidity += @EquipmentName+', ';
		END;
		ELSE
		BEGIN
			SET @Humidity += @EquipmentName;
		END;

		DELETE FROM @Materials 
		WHERE EquipmentName = @EquipmentName;
	END;

	/* Create a list oh equpment used for: Automation */	
	SET @CategoryInfo = 'Automation';
	WHILE EXISTS(
		SELECT TOP 1 CategoryInfo
		FROM @Materials 
		WHERE CategoryInfo=@CategoryInfo)
	BEGIN
		SET @Count = (
			SELECT COUNT(EquipmentName) 
			FROM @Materials 
			WHERE CategoryInfo = @CategoryInfo);

		SET @EquipmentName = (
			SELECT TOP 1 EquipmentName 
			FROM @Materials 
			WHERE CategoryInfo=@CategoryInfo);
		
		IF(@Count <> 1)
		BEGIN
			SET @Automation += @EquipmentName+', ';
		END;
		ELSE
		BEGIN
			SET @Automation += @EquipmentName;
		END;

		DELETE FROM @Materials 
		WHERE EquipmentName = @EquipmentName;
	END;

	/* Create a list oh equpment used for: Feeding. */
	SET @CategoryInfo = 'Feeding';
	WHILE EXISTS(
		SELECT TOP 1 CategoryInfo
		FROM @Materials 
		WHERE CategoryInfo=@CategoryInfo)
	BEGIN
		SET @Count = (
			SELECT COUNT(EquipmentName) 
			FROM @Materials 
			WHERE CategoryInfo = @CategoryInfo);

		SET @EquipmentName = (
			SELECT TOP 1 EquipmentName 
			FROM @Materials 
			WHERE CategoryInfo=@CategoryInfo);
		
		IF(@Count <> 1)
		BEGIN
			SET @Feeding += @EquipmentName+', ';
		END;
		ELSE
		BEGIN
			SET @Feeding += @EquipmentName;
		END;

		DELETE FROM @Materials 
		WHERE EquipmentName = @EquipmentName;
	END;

	/* Create the record to hold the lists of it does not yet exist. */
	IF NOT EXISTS(
		SELECT 1 
		FROM [equipment].[ObjectNote] 
		WHERE ReptileListId = @ReptileListId)
	BEGIN
		INSERT INTO [equipment].[ObjectNote](ReptileListId)
		VALUES(@ReptileListId);
	END;

	/* Add the equipment notes to: [equipment].[ObjectNote] */
	UPDATE [equipment].[ObjectNote]
	SET Heating = @Heating,
		Humidity = @Humidity,
		Automation = @Automation, 
		Feeding = @Feeding
	WHERE ReptileListId = @ReptileListId;

	/* Output the results. */
	SELECT * FROM [equipment].[ObjectNote];
END;
GO





USE [Reptiguide_empty]
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

SELECT TOP 1 
	@ReptileListId = rl.ReptileListId,
	@LifeExpectancy = ri.LifeExpectancy
FROM reptile.ReptileList rl
	INNER JOIN reptile.Information ri ON ri.ReptileListId = rl.ReptileListId
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






USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [guide].[SpInsertDietNoteSnake]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertDietNote]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertDietNote] @SubSpecies = 'bci', @Debug = 1;

Purpose: Get the denormalized diet information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
	BEGIN
	SET NOCOUNT ON;

	DECLARE 
		 @ReptileListId INT
		,@DietId INT
		,@ReptileType VARCHAR(150)	
		,@Scope	VARCHAR(50)
		,@DietToNoteId	INT	
		,@BowlSize VARCHAR(100)	
		,@FoodSchedule VARCHAR(50)	
		,@SupplementName VARCHAR(50)	
		,@SupplementSchedule	VARCHAR(50)
		,@FeedingChartNote VARCHAR(500)	
		,@OldNote VARCHAR(1000)
		,@NewNote VARCHAR(1000);

	SELECT TOP 1 
		 @ReptileListId = cd.ReptileListId
		,@DietId = cd.DietId
	FROM Care.Diet cd 
		INNER JOIN reptile.ReptileList rl ON cd.ReptileListId = cd.ReptileListId
	WHERE rl.SubSpecies = @SubSpecies;

	EXEC [guide].[SpInsertFeedingChartSnake] @ReptileListId = @ReptileListId

	SELECT 
		 @ReptileType = ReptileType
		,@Scope	= Scope	
		,@BowlSize	= BowlSize	
		,@SupplementName	= SupplementName	
		,@SupplementSchedule	= SupplementSchedule	
	FROM [guide].[VwDenormalizeDiet] 
	WHERE ReptileListId = @ReptileListId;

	SELECT @FeedingChartNote = note 
	FROM [care].[FeedingChartNote]
	WHERE ReptileListId = @ReptileListId
	

	SET @NewNote = CONCAT('DIET:',CHAR(10),@FeedingChartNote,'whichever is around 10-15% of the body weight of the ',@ReptileType,'. ',
		'Their meals can be supplimented with ',@SupplementName, ' ' , @SupplementSchedule,'.', CHAR(10),
		'The water bowl should be ',@BowlSize,'.');

	IF(@Debug = 1)
	BEGIN
		SET @OldNote = (
			SELECT DietNote
			FROM guide.Note
			WHERE ReptileListId = @ReptileListId );
 
		PRINT 'Note before update: ' + @OldNote+CHAR(10);
		PRINT 'Note after update:' + @NewNote;
	END;
	ELSE 
	BEGIN
		UPDATE guide.Note
		SET DietNote = @NewNote
		WHERE ReptileListId = @ReptileListId;
	END;
END;
GO






USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [guide].[SpGetReptileGuide]
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







USE [Reptiguide_empty]
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







USE [Reptiguide_empty]
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
	EXEC [guide].[SpCreateGuide] @Category = 'snake', @SubSpecies = 'constrictor';
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

EXEC [guide].[SpGetReptileGuide] @SubSpecies = @SubSpecies;



GO

