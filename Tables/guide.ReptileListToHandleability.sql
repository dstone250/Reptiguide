USE [Reptiguide]
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

