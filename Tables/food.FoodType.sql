USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[FoodType](
	[FoodTypeId] [smallint] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_FoodType] PRIMARY KEY CLUSTERED 
(
	[FoodTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[FoodType] ADD  CONSTRAINT [DF_food_FoodType_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[FoodType] ADD  CONSTRAINT [DF_food_FoodType_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE TRIGGER [food].[TrFoodTypeUpdate]
ON [food].[FoodType]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrFoodTypeUpdate
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
	UPDATE [food].[FoodType]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[FoodType].FoodTypeId = i.FoodTypeId
END;
GO

ALTER TABLE [food].[FoodType] ENABLE TRIGGER [TrFoodTypeUpdate]
GO

