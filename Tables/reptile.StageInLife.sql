USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[StageInLife](
	[StageInLifeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[Juvenile] [varchar](15) NOT NULL,
	[YoungAdult] [varchar](15) NOT NULL,
	[Mature] [varchar](15) NOT NULL,
	[FullyGrown] [varchar](15) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_StageInLife] PRIMARY KEY CLUSTERED 
(
	[StageInLifeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[StageInLife] ADD  CONSTRAINT [DF_reptile_StageInLife_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[StageInLife] ADD  CONSTRAINT [DF_reptile_StageInLife__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [reptile].[StageInLife]  WITH CHECK ADD  CONSTRAINT [FK_reptile_StageInLife_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [reptile].[StageInLife] CHECK CONSTRAINT [FK_reptile_StageInLife_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [reptile].[TrStageInLifeUpdate]
ON [reptile].[StageInLife]
FOR UPDATE AS
/************************************************************************************
Object Name: reptile.TrStageInLifeUpdate
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
	UPDATE [reptile].[StageInLife]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [reptile].[StageInLife].StageInLifeID = i.StageInLifeID
END;
GO

ALTER TABLE [reptile].[StageInLife] ENABLE TRIGGER [TrStageInLifeUpdate]
GO

