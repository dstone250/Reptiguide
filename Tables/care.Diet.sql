USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Diet](
	[DietId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[FoodScopeId] [tinyint] NOT NULL,
	[WaterBowlId] [varchar](50) NOT NULL,
	[SupplementScheduleId] [varchar](50) NULL,
	[SupplementId] [varchar](50) NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Diet] PRIMARY KEY CLUSTERED 
(
	[DietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Diet] ADD  CONSTRAINT [DF_care_Diet_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Diet] ADD  CONSTRAINT [DF_care_Diet__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [care].[TrDietUpdate]
ON [care].[Diet]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrDietUpdate
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
	UPDATE [care].[Diet]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Diet].DietID = i.DietID
END;
GO

ALTER TABLE [care].[Diet] ENABLE TRIGGER [TrDietUpdate]
GO

