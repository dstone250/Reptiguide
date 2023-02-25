USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[Insect](
	[InsectId] [smallint] IDENTITY(1,1) NOT NULL,
	[InsectName] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_Insects] PRIMARY KEY CLUSTERED 
(
	[InsectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[Insect] ADD  CONSTRAINT [DF_food_Insects_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[Insect] ADD  CONSTRAINT [DF_food_Insects__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [food].[TrInsectsUpdate]
ON [food].[Insect]
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

ALTER TABLE [food].[Insect] ENABLE TRIGGER [TrInsectsUpdate]
GO

