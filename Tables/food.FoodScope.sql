USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[FoodScope](
	[FoodScopeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[Scope] [varchar](15) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_FoodScope] PRIMARY KEY CLUSTERED 
(
	[FoodScopeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[FoodScope] ADD  CONSTRAINT [DF_food_FoodScope_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[FoodScope] ADD  CONSTRAINT [DF_food_FoodScope__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE TRIGGER [food].[TrFoodScopeUpdate]
ON [food].[FoodScope]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrFoodScopeUpdate
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
	UPDATE [food].[FoodScope]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[FoodScope].FoodScopeID = i.FoodScopeID
END;
GO

ALTER TABLE [food].[FoodScope] ENABLE TRIGGER [TrFoodScopeUpdate]
GO

