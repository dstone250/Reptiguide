USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Substrate](
	[SubstrateId] [smallint] IDENTITY(1,1) NOT NULL,
	[Material] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Substrate] PRIMARY KEY CLUSTERED 
(
	[SubstrateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Substrate] ADD  CONSTRAINT [DF_care_Substrate_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Substrate] ADD  CONSTRAINT [DF_care_Substrate__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [care].[TrSubstrateUpdate]
ON [care].[Substrate]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrSubstrateUpdate
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
	UPDATE [care].[Substrate]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Substrate].SubstrateID = i.SubstrateID
END;
GO

ALTER TABLE [care].[Substrate] ENABLE TRIGGER [TrSubstrateUpdate]
GO

