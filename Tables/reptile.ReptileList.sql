USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[ReptileList](
	[ReptileListId] [smallint] IDENTITY(1,1) NOT NULL,
	[CategoryId] [smallint] NOT NULL,
	[Species] [varchar](50) NOT NULL,
	[SubSpecies] [varchar](200) NOT NULL,
	[LifeExpectancy] [smallint] NOT NULL,
	[FoodScopeId] [tinyint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_reptile_ReptileList] PRIMARY KEY CLUSTERED 
(
	[ReptileListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[ReptileList] ADD  CONSTRAINT [DF_reptile_ReptileList_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[ReptileList] ADD  CONSTRAINT [DF_reptile_ReptileList__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [reptile].[ReptileList]  WITH CHECK ADD  CONSTRAINT [FK_reptile_ReptileList_food_FoodScope] FOREIGN KEY([FoodScopeId])
REFERENCES [food].[FoodScope] ([FoodScopeId])
GO

ALTER TABLE [reptile].[ReptileList] CHECK CONSTRAINT [FK_reptile_ReptileList_food_FoodScope]
GO

ALTER TABLE [reptile].[ReptileList]  WITH CHECK ADD  CONSTRAINT [FK_reptile_ReptileList_reptile_Category] FOREIGN KEY([CategoryId])
REFERENCES [reptile].[Category] ([CategoryId])
GO

ALTER TABLE [reptile].[ReptileList] CHECK CONSTRAINT [FK_reptile_ReptileList_reptile_Category]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [reptile].[TrReptileListUpdate]
ON [reptile].[ReptileList]
FOR UPDATE AS
/************************************************************************************
Object Name: reptile.TrReptileListUpdate
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
	UPDATE [reptile].[ReptileList]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [reptile].[ReptileList].ReptileListID = i.ReptileListID
END;
GO

ALTER TABLE [reptile].[ReptileList] ENABLE TRIGGER [TrReptileListUpdate]
GO

