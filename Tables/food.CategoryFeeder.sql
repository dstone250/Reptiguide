USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[CategoryFeeder](
	[CategoryFeederId] [smallint] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[SubCategory] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_CategoryFeeder] PRIMARY KEY CLUSTERED 
(
	[CategoryFeederId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[CategoryFeeder] ADD  CONSTRAINT [DF_food_CategoryFeeder_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[CategoryFeeder] ADD  CONSTRAINT [DF_food_CategoryFeeder_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [food].[TrCategoryFeederUpdate]
ON [food].[CategoryFeeder]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrCategoryFeederUpdate
Created By: Dstone
Parameter List
N/A
Output List
N/A
Purpose: Updates the DateUpdated column with the current date/time.

------------------------------------------------------------------------------------
Change History
2022-07-28  Dstone: Created

************************************************************************************/
BEGIN
	UPDATE [food].[CategoryFeeder]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[CategoryFeeder].CategoryFeederId = i.CategoryFeederId
END;
GO

ALTER TABLE [food].[CategoryFeeder] ENABLE TRIGGER [TrCategoryFeederUpdate]
GO

