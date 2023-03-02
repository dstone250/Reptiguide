USE [Reptiguide_20230227]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[InsectList](
	[InsectListId] [smallint] IDENTITY(1,1) NOT NULL,
	[InsectName] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
	[CategoryInsectId] [smallint] NULL,
 CONSTRAINT [PK_food_Insects] PRIMARY KEY CLUSTERED 
(
	[InsectListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[InsectList] ADD  CONSTRAINT [DF_food_Insects_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[InsectList] ADD  CONSTRAINT [DF_food_Insects__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [food].[InsectList]  WITH CHECK ADD  CONSTRAINT [FK_food_InsectList_food_CategoryInsect] FOREIGN KEY([CategoryInsectId])
REFERENCES [food].[CategoryInsect] ([CategoryInsectId])
GO

ALTER TABLE [food].[InsectList] CHECK CONSTRAINT [FK_food_InsectList_food_CategoryInsect]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [food].[TrInsectsUpdate]
ON [food].[InsectList]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrInsectsUpdate
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
	UPDATE [food].[Insects]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[Insects].InsectsId = i.InsectsId
END;
GO

ALTER TABLE [food].[InsectList] ENABLE TRIGGER [TrInsectsUpdate]
GO

