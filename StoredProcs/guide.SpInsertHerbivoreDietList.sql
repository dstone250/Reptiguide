USE [Reptiguide]
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
		 @ReptileId SMALLINT
		,@DietNote VARCHAR(1500) = ''
		,@FoodType VARCHAR(50)
		,@FoodCategory VARCHAR(50)	
		,@Subcategory VARCHAR(50);

	SELECT @ReptileId = ReptileListId 
	FROM Reptile.ReptileList
	WHERE SubSpecies = @Subspecies;

	INSERT INTO #FoodList(FoodType, FoodCategory, Subcategory)
	SELECT 
		ft.Category,
		fh.Category, 
		fh.SubCategory 
	FROM [guide].[ReptileToHerbivore] rh
		INNER JOIN reptile.ReptileList rl ON rl.ReptileListId = rh.ReptileListId
		INNER JOIN food.herbivore fh ON rh.HerbivoreId = fh.herbivoreId
		INNER JOIN food.FoodType ft ON ft.FoodTypeId = fh.FoodTypeId
	WHERE rh.ReptileListId = @ReptileId;

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
		WHERE ReptileListId = @ReptileId)
	BEGIN
		INSERT [care].[FeedingChartNote](ReptileListId, Note)
		VALUES(@ReptileId, @DietNote);
	END;
	ELSE
	BEGIN
		UPDATE [care].[FeedingChartNote]
		SET Note = @DietNote
		WHERE ReptileListId = @ReptileId;
	END;
END;
GO

