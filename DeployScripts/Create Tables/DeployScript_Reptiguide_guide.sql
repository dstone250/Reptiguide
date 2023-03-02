/******************************************************************************************************************
  Create guide Tables
******************************************************************************************************************/

USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[Note](
	[NoteId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[DietNote] [varchar](1500) NOT NULL,
	[CareNote] [varchar](1500) NOT NULL,
	[EquipmentNote] [varchar](1500) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_Note] PRIMARY KEY CLUSTERED 
(
	[NoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_Note_DietNote]  DEFAULT ('') FOR [DietNote]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_Note_CareNote]  DEFAULT ('') FOR [CareNote]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_Note_EquipmentNote]  DEFAULT ('') FOR [EquipmentNote]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_guide_Note_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_guide_Note__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[Note]  WITH CHECK ADD  CONSTRAINT [FK_guide_Note_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[Note] CHECK CONSTRAINT [FK_guide_Note_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [guide].[TrNoteUpdate]
ON [guide].[Note]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrNoteUpdate
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
	UPDATE [guide].[Note]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[Note].NoteID = i.NoteID
END;
GO

ALTER TABLE [guide].[Note] ENABLE TRIGGER [TrNoteUpdate]
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileListToEquipment](
	[ReptileListTobjectId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[objectId] [smallint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileListTobject] PRIMARY KEY CLUSTERED 
(
	[ReptileListTobjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileListToEquipment] ADD  CONSTRAINT [DF_guide_ReptileListTobject_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileListToEquipment] ADD  CONSTRAINT [DF_guide_ReptileListTobject__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[ReptileListToEquipment]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileListToEquipment_equipment_Object] FOREIGN KEY([objectId])
REFERENCES [equipment].[Object] ([ObjectId])
GO

ALTER TABLE [guide].[ReptileListToEquipment] CHECK CONSTRAINT [FK_guide_ReptileListToEquipment_equipment_Object]
GO

ALTER TABLE [guide].[ReptileListToEquipment]  WITH CHECK ADD  CONSTRAINT [FK_reptile_ReptileListToEquipment_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[ReptileListToEquipment] CHECK CONSTRAINT [FK_reptile_ReptileListToEquipment_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE TRIGGER [guide].[TrReptileListTobjectUpdate]
ON [guide].[ReptileListToEquipment]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileListTobjectUpdate
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
	UPDATE [guide].[ReptileListTobject]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileListTobject].ReptileListTobjectID = i.ReptileListTobjectID
END;
GO

ALTER TABLE [guide].[ReptileListToEquipment] ENABLE TRIGGER [TrReptileListTobjectUpdate]
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileListToHandleability](
	[ReptilelistToHandleabilityId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[HandleabilityId] [smallint] NOT NULL,
	[HandleabilityNote] [varchar](500) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileListToHandleability] PRIMARY KEY CLUSTERED 
(
	[ReptilelistToHandleabilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileListToHandleability] ADD  CONSTRAINT [DF__ReptileLis__Note__090A5324]  DEFAULT ('') FOR [HandleabilityId]
GO

ALTER TABLE [guide].[ReptileListToHandleability] ADD  DEFAULT ('') FOR [HandleabilityNote]
GO

ALTER TABLE [guide].[ReptileListToHandleability] ADD  CONSTRAINT [DF_guide_ReptileListToHandleability_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileListToHandleability] ADD  CONSTRAINT [DF_guide_ReptileListToHandleability__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[ReptileListToHandleability]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptilelistToHandleability_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[ReptileListToHandleability] CHECK CONSTRAINT [FK_guide_ReptilelistToHandleability_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [guide].[TrReptileListToHandleabilityUpdate]
ON [guide].[ReptileListToHandleability]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileListToHandleabilityUpdate
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
	UPDATE [guide].[ReptileListToHandleability]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileListToHandleability].ReptileListToHandleabilityID = i.ReptileListToHandleabilityID
END;
GO

ALTER TABLE [guide].[ReptileListToHandleability] ENABLE TRIGGER [TrReptileListToHandleabilityUpdate]
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileListToSubstrate](
	[ReptileListToSubstrateId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[SubstrateId] [smallint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileListToSubstrate] PRIMARY KEY CLUSTERED 
(
	[ReptileListToSubstrateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileListToSubstrate] ADD  CONSTRAINT [DF_guide_ReptileListToSubstrate_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileListToSubstrate] ADD  CONSTRAINT [DF_guide_ReptileListToSubstrate__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[ReptileListToSubstrate]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileListToSubstrate_care_Substrate] FOREIGN KEY([SubstrateId])
REFERENCES [care].[Substrate] ([SubstrateId])
GO

ALTER TABLE [guide].[ReptileListToSubstrate] CHECK CONSTRAINT [FK_guide_ReptileListToSubstrate_care_Substrate]
GO

ALTER TABLE [guide].[ReptileListToSubstrate]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileListToSubstrate_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[ReptileListToSubstrate] CHECK CONSTRAINT [FK_guide_ReptileListToSubstrate_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE TRIGGER [guide].[TrReptileListToSubstrateUpdate]
ON [guide].[ReptileListToSubstrate]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileListToSubstrateUpdate
Created By: Dstonea
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
	UPDATE [guide].[ReptileListToSubstrate]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileListToSubstrate].ReptileListToSubstrateID = i.ReptileListToSubstrateID
END;
GO

ALTER TABLE [guide].[ReptileListToSubstrate] ENABLE TRIGGER [TrReptileListToSubstrateUpdate]
GO







USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileToHerbivore](
	[ReptileToHerbivoreId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[HerbivoreId] [varchar](1000) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileToHerbivore] PRIMARY KEY CLUSTERED 
(
	[ReptileToHerbivoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileToHerbivore] ADD  CONSTRAINT [DF_guide_ReptileToHerbivore_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileToHerbivore] ADD  CONSTRAINT [DF_guide_ReptileToHerbivore__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE TRIGGER [guide].[TrReptileToHerbivoreUpdate]
ON [guide].[ReptileToHerbivore]
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

ALTER TABLE [guide].[ReptileToHerbivore] ENABLE TRIGGER [TrReptileToHerbivoreUpdate]
GO



USE [Reptiguide_Empty]
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
 CONSTRAINT [PK_guide_ReptileToPlantList] PRIMARY KEY CLUSTERED 
(
	[ReptileToPlantListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileToPlantList] ADD  CONSTRAINT [DF_guide_ReptileToPlantList_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileToPlantList] ADD  CONSTRAINT [DF_guide_ReptileToPlantList__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[ReptileToPlantList]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileToPlantList_food_PlantList] FOREIGN KEY([PlantListId])
REFERENCES [food].[PlantList] ([PlantListId])
GO

ALTER TABLE [guide].[ReptileToPlantList] CHECK CONSTRAINT [FK_guide_ReptileToPlantList_food_PlantList]
GO

ALTER TABLE [guide].[ReptileToPlantList]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileToPlantList_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[ReptileToPlantList] CHECK CONSTRAINT [FK_guide_ReptileToPlantList_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [guide].[TrReptileToPlantListUpdate]
ON [guide].[ReptileToPlantList]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileToPlantUpdate
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
	UPDATE [guide].[ReptileToPlant]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileToPlant].ReptileToPlantID = i.ReptileToPlantID
END;
GO

ALTER TABLE [guide].[ReptileToPlantList] ENABLE TRIGGER [TrReptileToPlantListUpdate]
GO


