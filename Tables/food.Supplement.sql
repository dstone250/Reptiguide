USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[Supplement](
	[supplementId] [smallint] IDENTITY(1,1) NOT NULL,
	[SupplementName] [varchar](50) NOT NULL,
	[SupplementDesc] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_supplement] PRIMARY KEY CLUSTERED 
(
	[supplementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[Supplement] ADD  CONSTRAINT [DF_food_supplement_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[Supplement] ADD  CONSTRAINT [DF_food_supplement__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE TRIGGER [food].[TrsupplementUpdate]
ON [food].[Supplement]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrsupplementUpdate
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
	UPDATE [food].[supplement]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[supplement].supplementId = i.supplementId
END;
GO

ALTER TABLE [food].[Supplement] ENABLE TRIGGER [TrsupplementUpdate]
GO

