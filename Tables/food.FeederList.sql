USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[FeederList](
	[FeederListId] [smallint] IDENTITY(1,1) NOT NULL,
	[CategoryFeederId] [smallint] NULL,
	[Size] [varchar](15) NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_Feeder] PRIMARY KEY CLUSTERED 
(
	[FeederListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[FeederList] ADD  CONSTRAINT [DF_food_Feeder_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[FeederList] ADD  CONSTRAINT [DF_food_Feeder__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [food].[FeederList]  WITH CHECK ADD  CONSTRAINT [FK_food_FeederList_food_CategoryFeeder] FOREIGN KEY([CategoryFeederId])
REFERENCES [food].[CategoryFeeder] ([CategoryFeederId])
GO

ALTER TABLE [food].[FeederList] CHECK CONSTRAINT [FK_food_FeederList_food_CategoryFeeder]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [food].[TrFeederListUpdate]
ON [food].[FeederList]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrFeederListUpdate
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
	UPDATE [food].[FeederList]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[FeederList].FeederListId = i.FeederListId
END;
GO

ALTER TABLE [food].[FeederList] ENABLE TRIGGER [TrFeederListUpdate]
GO

