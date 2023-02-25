USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[HerbivoreDietList](
	[HerbivoreDietListId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[DietList] [varchar](500) NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_HerbivoreDietList] PRIMARY KEY CLUSTERED 
(
	[HerbivoreDietListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[HerbivoreDietList] ADD  DEFAULT ('') FOR [DietList]
GO

ALTER TABLE [guide].[HerbivoreDietList] ADD  CONSTRAINT [DF_guide_HerbivoreDietList_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[HerbivoreDietList] ADD  CONSTRAINT [DF_guide_HerbivoreDietList_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE TRIGGER [guide].[TrHerbivoreDietListUpdate]
ON [guide].[HerbivoreDietList]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrHerbivoreDietListUpdate
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
	UPDATE [guide].[HerbivoreDietList]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[HerbivoreDietList].HerbivoreDietListID = i.HerbivoreDietListID
END;
GO

ALTER TABLE [guide].[HerbivoreDietList] ENABLE TRIGGER [TrHerbivoreDietListUpdate]
GO

