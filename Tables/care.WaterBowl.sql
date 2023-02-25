USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[WaterBowl](
	[WaterBowlId] [smallint] IDENTITY(1,1) NOT NULL,
	[BowlSize] [varchar](50) NOT NULL,
	[Note] [varchar](100) NOT NULL,
	[WaterLevel] [varchar](15) NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_WaterBowl] PRIMARY KEY CLUSTERED 
(
	[WaterBowlId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[WaterBowl] ADD  CONSTRAINT [DF_care_WaterBowl_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[WaterBowl] ADD  CONSTRAINT [DF_care_WaterBowl__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE TRIGGER [care].[TrWaterBowlUpdate]
ON [care].[WaterBowl]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrWaterBowlUpdate
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
	UPDATE [care].[WaterBowl]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[WaterBowl].WaterBowlId = i.WaterBowlId
END;
GO

ALTER TABLE [care].[WaterBowl] ENABLE TRIGGER [TrWaterBowlUpdate]
GO

