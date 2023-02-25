USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[LifeStage](
	[LifeStageId] [tinyint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [int] NOT NULL,
	[Stage] [varchar](15) NOT NULL,
	[Note] [varchar](100) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_LifeStage] PRIMARY KEY CLUSTERED 
(
	[LifeStageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[LifeStage] ADD  CONSTRAINT [DF_care_LifeStage_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[LifeStage] ADD  CONSTRAINT [DF_care_LifeStage__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [care].[TrLifeStageUpdate]
ON [care].[LifeStage]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrLifeStageUpdate
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
	UPDATE [care].[LifeStage]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[LifeStage].LifeStageID = i.LifeStageID
END;
GO

ALTER TABLE [care].[LifeStage] ENABLE TRIGGER [TrLifeStageUpdate]
GO

