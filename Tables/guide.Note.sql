USE [Reptiguide]
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

