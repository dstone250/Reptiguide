USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[FeedingChartNote](
	[FeedingChartNoteId] [tinyint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [tinyint] NOT NULL,
	[Note] [varchar](1500) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_FeedingChartNote] PRIMARY KEY CLUSTERED 
(
	[FeedingChartNoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[FeedingChartNote] ADD  CONSTRAINT [DF__FeedingCha__Note__627A95E8]  DEFAULT ('') FOR [Note]
GO

ALTER TABLE [care].[FeedingChartNote] ADD  CONSTRAINT [DF_care_FeedingChartNote_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[FeedingChartNote] ADD  CONSTRAINT [DF_care_FeedingChartNote__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [care].[TrFeedingChartNoteUpdate]
ON [care].[FeedingChartNote]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrFeedingChartNoteUpdate
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
	UPDATE [care].[FeedingChartNote]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[FeedingChartNote].FeedingChartNoteID = i.FeedingChartNoteID
END;
GO

ALTER TABLE [care].[FeedingChartNote] ENABLE TRIGGER [TrFeedingChartNoteUpdate]
GO

