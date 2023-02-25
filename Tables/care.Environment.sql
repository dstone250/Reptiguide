USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Environment](
	[EnvironmentId] [smallint] IDENTITY(1,1) NOT NULL,
	[HotSpot_F] [decimal](2, 0) NOT NULL,
	[TempHigh_F] [decimal](2, 0) NOT NULL,
	[TempLow_F] [decimal](2, 0) NOT NULL,
	[HumidityHighPercentage] [decimal](2, 0) NOT NULL,
	[HumidityLowPercentage] [decimal](2, 0) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Environment] PRIMARY KEY CLUSTERED 
(
	[EnvironmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Environment] ADD  CONSTRAINT [DF_care_Environment_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Environment] ADD  CONSTRAINT [DF_care_Environment__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TRIGGER [care].[TrEnvironmentUpdate]
ON [care].[Environment]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrEnvironmentUpdate
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
	UPDATE [care].[Environment]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Environment].EnvironmentID = i.EnvironmentID
END;
GO

ALTER TABLE [care].[Environment] ENABLE TRIGGER [TrEnvironmentUpdate]
GO

