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

