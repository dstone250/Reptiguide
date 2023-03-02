USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[FoodScope](
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

ALTER TABLE [reptile].[FoodScope] ADD  CONSTRAINT [DF_food_FoodScope_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[FoodScope] ADD  CONSTRAINT [DF_food_FoodScope__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TRIGGER [reptile].[TrFoodScopeUpdate]
ON [reptile].[FoodScope]
FOR UPDATE AS
/************************************************************************************
Object Name: reptile.TrFoodScopeUpdate
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
	UPDATE [reptile].[FoodScope]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [reptile].[FoodScope].FoodScopeID = i.FoodScopeID
END;
GO

ALTER TABLE [reptile].[FoodScope] ENABLE TRIGGER [TrFoodScopeUpdate]
GO

