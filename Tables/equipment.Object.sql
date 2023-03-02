USE [Reptiguide_20230227]
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

