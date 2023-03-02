USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileToPlantList](
	[ReptileToPlantListId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[PlantListId] [smallint] NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileToHerbivore] PRIMARY KEY CLUSTERED 
(
	[ReptileToPlantListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileToPlantList] ADD  CONSTRAINT [DF_guide_ReptileToHerbivore_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileToPlantList] ADD  CONSTRAINT [DF_guide_ReptileToHerbivore__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[ReptileToPlantList]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileToHerbivore_food_herbivore] FOREIGN KEY([PlantListId])
REFERENCES [food].[PlantList] ([PlantListId])
GO

ALTER TABLE [guide].[ReptileToPlantList] CHECK CONSTRAINT [FK_guide_ReptileToHerbivore_food_herbivore]
GO

ALTER TABLE [guide].[ReptileToPlantList]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileToHerbivore_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[ReptileToPlantList] CHECK CONSTRAINT [FK_guide_ReptileToHerbivore_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE TRIGGER [guide].[TrReptileToHerbivoreUpdate]
ON [guide].[ReptileToPlantList]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileToHerbivoreUpdate
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
	UPDATE [guide].[ReptileToHerbivore]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileToHerbivore].ReptileToHerbivoreID = i.ReptileToHerbivoreID
END;
GO

ALTER TABLE [guide].[ReptileToPlantList] ENABLE TRIGGER [TrReptileToHerbivoreUpdate]
GO

