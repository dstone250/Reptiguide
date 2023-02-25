USE [Reptiguide]
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

