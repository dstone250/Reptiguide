USE [Reptiguide]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[FoodSchedule](
	[FoodScheduleId] [smallint] IDENTITY(1,1) NOT NULL,
	[Frequency] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_FoodSchedule] PRIMARY KEY CLUSTERED 
(
	[FoodScheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[FoodSchedule] ADD  CONSTRAINT [DF_care_FoodSchedule_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[FoodSchedule] ADD  CONSTRAINT [DF_care_FoodSchedule__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [care].[TrFoodScheduleUpdate]
ON [care].[FoodSchedule]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrFoodScheduleUpdate
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
	UPDATE [care].[FoodSchedule]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[FoodSchedule].FoodScheduleId = i.FoodScheduleId
END;
GO

ALTER TABLE [care].[FoodSchedule] ENABLE TRIGGER [TrFoodScheduleUpdate]
GO

