USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[PlantList](
	[PlantListId] [smallint] IDENTITY(1,1) NOT NULL,
	[CategoryPlantId] [smallint] NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[SubCategory] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_PlantList] PRIMARY KEY CLUSTERED 
(
	[PlantListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[PlantList] ADD  CONSTRAINT [DF_food_PlantList_SubCategory]  DEFAULT ('') FOR [SubCategory]
GO

ALTER TABLE [food].[PlantList] ADD  CONSTRAINT [DF_food_PlantList_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[PlantList] ADD  CONSTRAINT [DF_food_PlantList__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [food].[PlantList]  WITH CHECK ADD  CONSTRAINT [FK_food_PlantList_food_CategoryPlant] FOREIGN KEY([CategoryPlantId])
REFERENCES [food].[CategoryPlant] ([CategoryPlantId])
GO

ALTER TABLE [food].[PlantList] CHECK CONSTRAINT [FK_food_PlantList_food_CategoryPlant]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TRIGGER [food].[TrPlantListUpdate]
ON [food].[PlantList]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrPlantListUpdate
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
	UPDATE [food].[PlantList]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[PlantList].PlantListId = i.PlantListId
END;
GO

ALTER TABLE [food].[PlantList] ENABLE TRIGGER [TrPlantListUpdate]
GO

