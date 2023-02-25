USE [Reptiguide]
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

