USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[CategoryInsect](
	[CategoryInsectId] [smallint] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[SubCategory] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_CategoryInsect] PRIMARY KEY CLUSTERED 
(
	[CategoryInsectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[CategoryInsect] ADD  DEFAULT ('') FOR [SubCategory]
GO

ALTER TABLE [food].[CategoryInsect] ADD  CONSTRAINT [DF_food_FoodTypeInsect_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[CategoryInsect] ADD  CONSTRAINT [DF_food_FoodTypeInsect_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [food].[TrCategoryInsectUpdate]
ON [food].[CategoryInsect]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrCategoryInsectUpdate
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
	UPDATE [food].[CategoryInsect]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[CategoryInsect].CategoryInsectId = i.CategoryInsectId
END;
GO

ALTER TABLE [food].[CategoryInsect] ENABLE TRIGGER [TrCategoryInsectUpdate]
GO

