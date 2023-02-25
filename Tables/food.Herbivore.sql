USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[herbivore](
	[herbivoreId] [smallint] IDENTITY(1,1) NOT NULL,
	[FoodTypeId] [smallint] NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[SubCategory] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_Herbavore] PRIMARY KEY CLUSTERED 
(
	[herbivoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[herbivore] ADD  DEFAULT ('') FOR [SubCategory]
GO

ALTER TABLE [food].[herbivore] ADD  CONSTRAINT [DF_food_Herbavore_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[herbivore] ADD  CONSTRAINT [DF_food_Herbavore__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE TRIGGER [food].[TrHerbavoreUpdate]
ON [food].[herbivore]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrHerbavoreUpdate
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
	UPDATE [food].[Herbavore]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[Herbavore].HerbavoreId = i.HerbavoreId
END;
GO

ALTER TABLE [food].[herbivore] ENABLE TRIGGER [TrHerbavoreUpdate]
GO

