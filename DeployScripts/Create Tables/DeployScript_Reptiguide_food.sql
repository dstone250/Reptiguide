

/*
  CREATE FOOD TABLES
*/


USE [Reptiguide_empty]
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



USE [Reptiguide_Empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[CategoryFeeder](
	[CategoryFeederId] [smallint] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[SubCategory] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_CategoryFeeder] PRIMARY KEY CLUSTERED 
(
	[CategoryFeederId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[CategoryFeeder] ADD  CONSTRAINT [DF_food_CategoryFeeder_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[CategoryFeeder] ADD  CONSTRAINT [DF_food_CategoryFeeder_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [food].[TrCategoryFeederUpdate]
ON [food].[CategoryFeeder]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrCategoryFeederUpdate
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
	UPDATE [food].[CategoryFeeder]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[CategoryFeeder].CategoryFeederId = i.CategoryFeederId
END;
GO

ALTER TABLE [food].[CategoryFeeder] ENABLE TRIGGER [TrCategoryFeederUpdate]
GO


USE [Reptiguide_Empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[CategoryInsect](
	[CategoryInsectId] [smallint] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[SubCategory] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_CategoryInsect] PRIMARY KEY CLUSTERED 
(
	[CategoryInsectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[CategoryInsect] ADD  DEFAULT ('') FOR [SubCategory]
GO

ALTER TABLE [food].[CategoryInsect] ADD  CONSTRAINT [DF_food_FoodTypeInsect_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[CategoryInsect] ADD  CONSTRAINT [DF_food_FoodTypeInsect_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [food].[TrCategoryInsectUpdate]
ON [food].[CategoryInsect]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrCategoryInsectUpdate
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
	UPDATE [food].[CategoryInsect]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[CategoryInsect].CategoryInsectId = i.CategoryInsectId
END;
GO

ALTER TABLE [food].[CategoryInsect] ENABLE TRIGGER [TrCategoryInsectUpdate]
GO

USE [Reptiguide_Empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[CategoryPlant](
	[CategoryPlantId] [smallint] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_CategoryPlant] PRIMARY KEY CLUSTERED 
(
	[CategoryPlantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[CategoryPlant] ADD  CONSTRAINT [DF_food_FoodType_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[CategoryPlant] ADD  CONSTRAINT [DF_food_FoodType_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [food].[TrCategoryPlantUpdate]
ON [food].[CategoryPlant]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrCategoryPlantUpdate
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
	UPDATE [food].[CategoryPlant]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[CategoryPlant].CategoryPlantId = i.CategoryPlantId
END;
GO

ALTER TABLE [food].[CategoryPlant] ENABLE TRIGGER [TrCategoryPlantUpdate]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







USE [Reptiguide_Empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [food].[PlantList](
	[PlantListId] [smallint] IDENTITY(1,1) NOT NULL,
	[CategoryPlantId] [smallint] NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[SubCategory] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_PlantList] PRIMARY KEY CLUSTERED 
(
	[PlantListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [food].[PlantList] ADD  CONSTRAINT [DF_food_PlantList_SubCategory]  DEFAULT ('') FOR [SubCategory]
GO

ALTER TABLE [food].[PlantList] ADD  CONSTRAINT [DF_food_PlantList_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [food].[PlantList] ADD  CONSTRAINT [DF_food_PlantList__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [food].[PlantList]  WITH CHECK ADD  CONSTRAINT [FK_food_PlantList_food_CategoryPlant] FOREIGN KEY([CategoryPlantId])
REFERENCES [food].[CategoryPlant] ([CategoryPlantId])
GO

ALTER TABLE [food].[PlantList] CHECK CONSTRAINT [FK_food_PlantList_food_CategoryPlant]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TRIGGER [food].[TrPlantListUpdate]
ON [food].[PlantList]
FOR UPDATE AS
/************************************************************************************
Object Name: food.TrPlantListUpdate
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
	UPDATE [food].[PlantList]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [food].[PlantList].PlantListId = i.PlantListId
END;
GO

ALTER TABLE [food].[PlantList] ENABLE TRIGGER [TrPlantListUpdate]
GO









USE [Reptiguide_empty]
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













