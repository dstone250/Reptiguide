USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Enclosure](
	[EnclosureId] [smallint] IDENTITY(1,1) NOT NULL,
	[Material] [varchar](50) NOT NULL,
	[LengthInch] [smallint] NOT NULL,
	[HeightInch] [smallint] NOT NULL,
	[WidthInch] [smallint] NOT NULL,
	[Gallons] [int] NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Enclosure] PRIMARY KEY CLUSTERED 
(
	[EnclosureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Enclosure] ADD  CONSTRAINT [DF_care_Enclosure_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Enclosure] ADD  CONSTRAINT [DF_care_Enclosure__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [care].[TrEnclosureUpdate]
ON [care].[Enclosure]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrEnclosureUpdate
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
	UPDATE [care].[Enclosure]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Enclosure].EnclosureID = i.EnclosureID
END;
GO

ALTER TABLE [care].[Enclosure] ENABLE TRIGGER [TrEnclosureUpdate]
GO

