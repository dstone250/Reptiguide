USE [Reptiguide_20230227]
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

