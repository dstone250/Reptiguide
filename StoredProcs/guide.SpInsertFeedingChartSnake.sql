USE [Reptiguide]
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

