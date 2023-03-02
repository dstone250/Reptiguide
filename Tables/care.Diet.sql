USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Diet](
	[DietId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[FoodScopeId] [tinyint] NOT NULL,
	[WaterBowlId] [varchar](50) NOT NULL,
	[FoodScheduleId] [smallint] NOT NULL,
	[SupplementId] [smallint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Diet] PRIMARY KEY CLUSTERED 
(
	[DietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Diet] ADD  CONSTRAINT [DF_care_Diet_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Diet] ADD  CONSTRAINT [DF_care_Diet__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_care_FoodSchedule] FOREIGN KEY([FoodScheduleId])
REFERENCES [care].[FoodSchedule] ([FoodScheduleId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_care_FoodSchedule]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_food_Supplement] FOREIGN KEY([SupplementId])
REFERENCES [food].[Supplement] ([supplementId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_food_Supplement]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_reptile_Foodscope] FOREIGN KEY([FoodScopeId])
REFERENCES [reptile].[FoodScope] ([FoodScopeId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_reptile_Foodscope]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [care].[TrDietUpdate]
ON [care].[Diet]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrDietUpdate
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
	UPDATE [care].[Diet]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Diet].DietID = i.DietID
END;
GO

ALTER TABLE [care].[Diet] ENABLE TRIGGER [TrDietUpdate]
GO

