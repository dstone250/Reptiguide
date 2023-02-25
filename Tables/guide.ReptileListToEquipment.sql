USE [Reptiguide]
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

