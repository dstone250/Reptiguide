
/******************************************************************************************************************
  Create equipment Tables
******************************************************************************************************************/

USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [equipment].[Category](
	[CategoryId] [smallint] IDENTITY(1,1) NOT NULL,
	[CategoryInfo] [varchar](100) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_equipment_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [equipment].[Category] ADD  DEFAULT ('') FOR [CategoryInfo]
GO

ALTER TABLE [equipment].[Category] ADD  CONSTRAINT [DF_equipment_Category_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [equipment].[Category] ADD  CONSTRAINT [DF_equipment_Category__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [equipment].[TrCategoryUpdate]
ON [equipment].[Category]
FOR UPDATE AS
/************************************************************************************
Category Name: equipment.TrCategoryUpdate
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
	UPDATE [equipment].[Category]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [equipment].[Category].CategoryID = i.CategoryID
END;
GO

ALTER TABLE [equipment].[Category] ENABLE TRIGGER [TrCategoryUpdate]
GO



USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [equipment].[Object](
	[ObjectId] [smallint] IDENTITY(1,1) NOT NULL,
	[CategoryId] [smallint] NOT NULL,
	[EquipmentName] [varchar](100) NOT NULL,
	[EquipmentInfo] [varchar](250) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_equipment_Object] PRIMARY KEY CLUSTERED 
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [equipment].[Object] ADD  DEFAULT ('') FOR [EquipmentInfo]
GO

ALTER TABLE [equipment].[Object] ADD  CONSTRAINT [DF_equipment_Object_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [equipment].[Object] ADD  CONSTRAINT [DF_equipment_Object__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [equipment].[Object]  WITH CHECK ADD  CONSTRAINT [FK_equipment_Object_equipment_Category] FOREIGN KEY([CategoryId])
REFERENCES [equipment].[Category] ([CategoryId])
GO

ALTER TABLE [equipment].[Object] CHECK CONSTRAINT [FK_equipment_Object_equipment_Category]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [equipment].[TrObjectUpdate]
ON [equipment].[Object]
FOR UPDATE AS
/************************************************************************************
Object Name: equipment.TrObjectUpdate
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
	UPDATE [equipment].[Object]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [equipment].[Object].ObjectID = i.ObjectID
END;
GO

ALTER TABLE [equipment].[Object] ENABLE TRIGGER [TrObjectUpdate]
GO

USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [equipment].[ObjectNote](
	[ObjectNoteId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NULL,
	[Heating] [varchar](1000) NOT NULL,
	[Humidity] [varchar](1000) NOT NULL,
	[Automation] [varchar](1000) NOT NULL,
	[Feeding] [varchar](1000) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_equipment_ObjectNote] PRIMARY KEY CLUSTERED 
(
	[ObjectNoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  DEFAULT ('') FOR [Heating]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  DEFAULT ('') FOR [Humidity]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  DEFAULT ('') FOR [Automation]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  DEFAULT ('') FOR [Feeding]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  CONSTRAINT [DF_equipment_ObjectNote_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  CONSTRAINT [DF_equipment_ObjectNote__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [equipment].[ObjectNote]  WITH CHECK ADD  CONSTRAINT [FK_equipment_ObjectNote_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [equipment].[ObjectNote] CHECK CONSTRAINT [FK_equipment_ObjectNote_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [equipment].[TrObjectNoteUpdate]
ON [equipment].[ObjectNote]
FOR UPDATE AS
/************************************************************************************
ObjectNote Name: equipment.TrObjectNoteUpdate
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
	UPDATE [equipment].[ObjectNote]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [equipment].[ObjectNote].ObjectNoteID = i.ObjectNoteID
END;
GO

ALTER TABLE [equipment].[ObjectNote] ENABLE TRIGGER [TrObjectNoteUpdate]
GO

