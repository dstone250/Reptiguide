USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[Feeder](
	[FeederId] [smallint] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[Size] [varchar](15) NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_Feeder] PRIMARY KEY CLUSTERED 
(
	[FeederId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[Feeder] ADD  CONSTRAINT [DF_food_Feeder_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[Feeder] ADD  CONSTRAINT [DF_food_Feeder__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TRIGGER [food].[TrFeederUpdate]
ON [food].[Feeder]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrFeederUpdate
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
	UPDATE [food].[Feeder]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[Feeder].FeederId = i.FeederId
END;
GO

ALTER TABLE [food].[Feeder] ENABLE TRIGGER [TrFeederUpdate]
GO

