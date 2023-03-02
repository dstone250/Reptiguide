USE [Reptiguide_20230227]
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
	UPDATE [guide].[ReptileListToSubstrate]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileListToSubstrate].ReptileListToSubstrateID = i.ReptileListToSubstrateID
END;
GO

ALTER TABLE [guide].[ReptileListToSubstrate] ENABLE TRIGGER [TrReptileListToSubstrateUpdate]
GO

