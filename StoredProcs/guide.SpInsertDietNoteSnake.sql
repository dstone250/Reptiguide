USE [Reptiguide_20230227]
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

