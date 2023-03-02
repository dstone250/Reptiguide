USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[Handleability](
	[handleabilityId] [tinyint] IDENTITY(1,1) NOT NULL,
	[Score] [tinyint] NOT NULL,
	[handleabilityNote] [varchar](500) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_Reptile_handleability] PRIMARY KEY CLUSTERED 
(
	[handleabilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[Handleability] ADD  CONSTRAINT [DF_Reptile_handleability_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[Handleability] ADD  CONSTRAINT [DF_Reptile_handleability__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TRIGGER [reptile].[TrhandleabilityUpdate]
ON [reptile].[Handleability]
FOR UPDATE AS
/************************************************************************************
Object Name: Reptile.TrhandleabilityUpdate
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
	UPDATE [Reptile].[handleability]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [Reptile].[handleability].handleabilityID = i.handleabilityID
END;
GO

ALTER TABLE [reptile].[Handleability] ENABLE TRIGGER [TrhandleabilityUpdate]
GO

