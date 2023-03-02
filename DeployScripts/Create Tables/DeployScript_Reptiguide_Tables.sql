/****************************************************************************************************************
  Create Schemas
***************************************************************************************************************/

USE Reptiguide_empty
GO

CREATE SCHEMA reptile;
GO

CREATE SCHEMA food;
GO

CREATE SCHEMA care;
GO

CREATE SCHEMA guide;
GO

CREATE SCHEMA equipment;
GO

/******************************************************************************************************************
  Create reptile Tables
******************************************************************************************************************/


USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[ReptileList](
	[ReptileListId] [smallint] IDENTITY(1,1) NOT NULL,
	[Species] [varchar](50) NOT NULL,
	[SubSpecies] [varchar](200) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_reptile_ReptileList] PRIMARY KEY CLUSTERED 
(
	[ReptileListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[ReptileList] ADD  CONSTRAINT [DF_reptile_ReptileList_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[ReptileList] ADD  CONSTRAINT [DF_reptile_ReptileList__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [reptile].[TrReptileListUpdate]
ON [reptile].[ReptileList]
FOR UPDATE AS
/************************************************************************************
Object Name: reptile.TrReptileListUpdate
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
	UPDATE [reptile].[ReptileList]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [reptile].[ReptileList].ReptileListID = i.ReptileListID
END;
GO

ALTER TABLE [reptile].[ReptileList] ENABLE TRIGGER [TrReptileListUpdate]
GO

use [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[Category](
	[CategoryId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileType] [varchar](20) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_reptile_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[Category] ADD  CONSTRAINT [DF_reptile_Category_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[Category] ADD  CONSTRAINT [DF_reptile_Category__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [reptile].[TrCategoryUpdate]
ON [reptile].[Category]
FOR UPDATE AS
/************************************************************************************
Object Name: reptile.TrCategoryUpdate
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
	UPDATE [reptile].[Category]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [reptile].[Category].CategoryID = i.CategoryID
END;
GO

ALTER TABLE [reptile].[Category] ENABLE TRIGGER [TrCategoryUpdate]
GO




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[LifeStage](
	[LifeStageId] [tinyint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[Stage] [varchar](15) NOT NULL,
	[Note] [varchar](100) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_LifeStage] PRIMARY KEY CLUSTERED 
(
	[LifeStageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[LifeStage]  WITH CHECK ADD  CONSTRAINT [FK_reptile_LifeStage_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [reptile].[LifeStage] CHECK CONSTRAINT [FK_reptile_LifeStage_reptile_ReptileList]
GO






USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[FoodScope](
	[FoodScopeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[Scope] [varchar](15) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_food_FoodScope] PRIMARY KEY CLUSTERED 
(
	[FoodScopeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[FoodScope] ADD  CONSTRAINT [DF_food_FoodScope_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[FoodScope] ADD  CONSTRAINT [DF_food_FoodScope__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TRIGGER [reptile].[TrFoodScopeUpdate]
ON [reptile].[FoodScope]
FOR UPDATE AS
/************************************************************************************
Object Name: reptile.TrFoodScopeUpdate
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
	UPDATE [reptile].[FoodScope]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [reptile].[FoodScope].FoodScopeID = i.FoodScopeID
END;
GO

ALTER TABLE [reptile].[FoodScope] ENABLE TRIGGER [TrFoodScopeUpdate]
GO






use [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[Environment](
	[EnvironmentId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[HotSpot_F] [decimal](2, 0) NOT NULL,
	[TempHigh_F] [decimal](2, 0) NOT NULL,
	[TempLow_F] [decimal](2, 0) NOT NULL,
	[HumidityHighPercentage] [decimal](2, 0) NOT NULL,
	[HumidityLowPercentage] [decimal](2, 0) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_reptile_Environment] PRIMARY KEY CLUSTERED 
(
	[EnvironmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[Environment] ADD  CONSTRAINT [DF_reptile_Environment_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[Environment] ADD  CONSTRAINT [DF_reptile_Environment_DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [reptile].[Environment]  WITH CHECK ADD  CONSTRAINT [FK_reptile_Environment_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [reptile].[Environment] CHECK CONSTRAINT [FK_reptile_Environment_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE TRIGGER [reptile].[TrEnvironmentUpdate]
ON [reptile].[Environment]
FOR UPDATE AS
/************************************************************************************
Object Name: reptile.TrEnvironmentUpdate
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
	UPDATE [reptile].[Environment]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [reptile].[Environment].EnvironmentID = i.EnvironmentID
END;
GO

ALTER TABLE [reptile].[Environment] ENABLE TRIGGER [TrEnvironmentUpdate]
GO

use [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[Handleability](
	[handleabilityId] [tinyint] IDENTITY(1,1) NOT NULL,
	[Score] [tinyint] NOT NULL,
	[handleabilityNote] [varchar](500) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_Reptile_handleability] PRIMARY KEY CLUSTERED 
(
	[handleabilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[Handleability] ADD  CONSTRAINT [DF_Reptile_handleability_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[Handleability] ADD  CONSTRAINT [DF_Reptile_handleability__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TRIGGER [reptile].[TrhandleabilityUpdate]
ON [reptile].[Handleability]
FOR UPDATE AS
/************************************************************************************
Object Name: Reptile.TrhandleabilityUpdate
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
	UPDATE [Reptile].[handleability]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [Reptile].[handleability].handleabilityID = i.handleabilityID
END;
GO

ALTER TABLE [reptile].[Handleability] ENABLE TRIGGER [TrhandleabilityUpdate]
GO







use [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [reptile].[Information](
	[InformationId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[CategoryId] [smallint] NOT NULL,
	[LifeExpectancy] [smallint] NOT NULL,
	[FoodScopeId] [tinyint] NOT NULL,
	[IsMale] [bit] NOT NULL,
	[InchesMin] [smallint] NOT NULL,
	[InchesMax] [smallint] NOT NULL,
	[lbsMin] [decimal](18, 0) NOT NULL,
	[lbsMax] [decimal](18, 0) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_reptile_Information] PRIMARY KEY CLUSTERED 
(
	[InformationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [reptile].[Information] ADD  DEFAULT ((0)) FOR [InchesMin]
GO

ALTER TABLE [reptile].[Information] ADD  DEFAULT ((0)) FOR [InchesMax]
GO

ALTER TABLE [reptile].[Information] ADD  DEFAULT ((0)) FOR [lbsMin]
GO

ALTER TABLE [reptile].[Information] ADD  DEFAULT ((0)) FOR [lbsMax]
GO

ALTER TABLE [reptile].[Information] ADD  CONSTRAINT [DF_reptile_Information_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [reptile].[Information] ADD  CONSTRAINT [DF_reptile_Information__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [reptile].[Information]  WITH CHECK ADD  CONSTRAINT [FK_reptile_Information_reptile_Category] FOREIGN KEY([CategoryId])
REFERENCES [reptile].[Category] ([CategoryId])
GO

ALTER TABLE [reptile].[Information] CHECK CONSTRAINT [FK_reptile_Information_reptile_Category]
GO

ALTER TABLE [reptile].[Information]  WITH CHECK ADD  CONSTRAINT [FK_reptile_Information_reptile_FoodScope] FOREIGN KEY([FoodScopeId])
REFERENCES [reptile].[FoodScope] ([FoodScopeId])
GO

ALTER TABLE [reptile].[Information] CHECK CONSTRAINT [FK_reptile_Information_reptile_FoodScope]
GO

ALTER TABLE [reptile].[Information]  WITH CHECK ADD  CONSTRAINT [FK_reptile_Information_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [reptile].[Information] CHECK CONSTRAINT [FK_reptile_Information_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [reptile].[TrInformationUpdate]
ON [reptile].[Information]
FOR UPDATE AS
/************************************************************************************
Object Name: reptile.TrInformationUpdate
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
	UPDATE [reptile].[Information]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [reptile].[Information].InformationID = i.InformationID
END;
GO

ALTER TABLE [reptile].[Information] ENABLE TRIGGER [TrInformationUpdate]
GO


USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[LifeStage](
	[LifeStageId] [tinyint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [int] NOT NULL,
	[Stage] [varchar](15) NOT NULL,
	[Note] [varchar](100) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_LifeStage] PRIMARY KEY CLUSTERED 
(
	[LifeStageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[LifeStage] ADD  CONSTRAINT [DF_care_LifeStage_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[LifeStage] ADD  CONSTRAINT [DF_care_LifeStage__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [care].[TrLifeStageUpdate]
ON [care].[LifeStage]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrLifeStageUpdate
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
	UPDATE [care].[LifeStage]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[LifeStage].LifeStageID = i.LifeStageID
END;
GO

ALTER TABLE [care].[LifeStage] ENABLE TRIGGER [TrLifeStageUpdate]
GO





/******************************************************************************************************************
  Create food Tables
******************************************************************************************************************/



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



USE [Reptiguide_empty]
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


USE [Reptiguide_empty]
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

USE [Reptiguide_empty]
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







USE [Reptiguide_empty]
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



/******************************************************************************************************************
  Create care Tables
******************************************************************************************************************/

USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Substrate](
	[SubstrateId] [smallint] IDENTITY(1,1) NOT NULL,
	[Material] [varchar](50) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Substrate] PRIMARY KEY CLUSTERED 
(
	[SubstrateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Substrate] ADD  CONSTRAINT [DF_care_Substrate_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Substrate] ADD  CONSTRAINT [DF_care_Substrate__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [care].[TrSubstrateUpdate]
ON [care].[Substrate]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrSubstrateUpdate
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
	UPDATE [care].[Substrate]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Substrate].SubstrateID = i.SubstrateID
END;
GO

ALTER TABLE [care].[Substrate] ENABLE TRIGGER [TrSubstrateUpdate]
GO





USE [Reptiguide_empty]
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

USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[WaterBowl](
	[WaterBowlId] [smallint] IDENTITY(1,1) NOT NULL,
	[BowlSize] [varchar](50) NOT NULL,
	[Note] [varchar](100) NOT NULL,
	[WaterLevel] [varchar](15) NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_WaterBowl] PRIMARY KEY CLUSTERED 
(
	[WaterBowlId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[WaterBowl] ADD  CONSTRAINT [DF_care_WaterBowl_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[WaterBowl] ADD  CONSTRAINT [DF_care_WaterBowl__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE TRIGGER [care].[TrWaterBowlUpdate]
ON [care].[WaterBowl]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrWaterBowlUpdate
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
	UPDATE [care].[WaterBowl]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[WaterBowl].WaterBowlId = i.WaterBowlId
END;
GO

ALTER TABLE [care].[WaterBowl] ENABLE TRIGGER [TrWaterBowlUpdate]
GO

USE [Reptiguide_empty]
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




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[Diet](
	[DietId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[FoodScopeId] [tinyint] NOT NULL,
	[WaterBowlId] [varchar](50) NOT NULL,
	[FoodScheduleId] [smallint] NOT NULL,
	[SupplementId] [smallint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_Diet] PRIMARY KEY CLUSTERED 
(
	[DietId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[Diet] ADD  CONSTRAINT [DF_care_Diet_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[Diet] ADD  CONSTRAINT [DF_care_Diet__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_care_FoodSchedule] FOREIGN KEY([FoodScheduleId])
REFERENCES [care].[FoodSchedule] ([FoodScheduleId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_care_FoodSchedule]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_food_Supplement] FOREIGN KEY([SupplementId])
REFERENCES [food].[Supplement] ([supplementId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_food_Supplement]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_reptile_Foodscope] FOREIGN KEY([FoodScopeId])
REFERENCES [reptile].[FoodScope] ([FoodScopeId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_reptile_Foodscope]
GO

ALTER TABLE [care].[Diet]  WITH CHECK ADD  CONSTRAINT [FK_care_Diet_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [care].[Diet] CHECK CONSTRAINT [FK_care_Diet_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [care].[TrDietUpdate]
ON [care].[Diet]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrDietUpdate
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
	UPDATE [care].[Diet]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[Diet].DietID = i.DietID
END;
GO

ALTER TABLE [care].[Diet] ENABLE TRIGGER [TrDietUpdate]
GO


USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[FeedingChartSnake](
	[FeedingChartSnakeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NULL,
	[LifeStageId] [tinyint] NULL,
	[FoodScheduleId] [smallint] NULL,
	[FeederListIdSmall] [smallint] NULL,
	[FeederListIdLarge] [smallint] NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_care_FeedingChartSnake] PRIMARY KEY CLUSTERED 
(
	[FeedingChartSnakeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [care].[FeedingChartSnake] ADD  CONSTRAINT [DF_care_FeedingChartSnake_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [care].[FeedingChartSnake] ADD  CONSTRAINT [DF_care_FeedingChartSnake__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [care].[FeedingChartSnake]  WITH CHECK ADD  CONSTRAINT [FK_care_FeedingChartSnake_care_FoodSchedule] FOREIGN KEY([FoodScheduleId])
REFERENCES [care].[FoodSchedule] ([FoodScheduleId])
GO

ALTER TABLE [care].[FeedingChartSnake] CHECK CONSTRAINT [FK_care_FeedingChartSnake_care_FoodSchedule]
GO

ALTER TABLE [care].[FeedingChartSnake]  WITH CHECK ADD  CONSTRAINT [FK_care_FeedingChartSnake_reptile_LifeStage] FOREIGN KEY([LifeStageId])
REFERENCES [reptile].[LifeStage] ([LifeStageId])
GO

ALTER TABLE [care].[FeedingChartSnake] CHECK CONSTRAINT [FK_care_FeedingChartSnake_reptile_LifeStage]
GO

ALTER TABLE [care].[FeedingChartSnake]  WITH CHECK ADD  CONSTRAINT [FK_care_FeedingChartSnake_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [care].[FeedingChartSnake] CHECK CONSTRAINT [FK_care_FeedingChartSnake_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [care].[TrFeedingChartSnakeUpdate]
ON [care].[FeedingChartSnake]
FOR UPDATE AS
/************************************************************************************
Object Name: care.TrFeedingChartSnakeUpdate
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
	UPDATE [care].[FeedingChartSnake]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [care].[FeedingChartSnake].FeedingChartSnakeID = i.FeedingChartSnakeID
END;
GO

ALTER TABLE [care].[FeedingChartSnake] ENABLE TRIGGER [TrFeedingChartSnakeUpdate]
GO

USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [care].[FeedingChartNote](
	[FeedingChartNoteId] [tinyint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NULL,
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

ALTER TABLE [care].[FeedingChartNote]  WITH CHECK ADD  CONSTRAINT [FK_care_FeedingChartNote_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [care].[FeedingChartNote] CHECK CONSTRAINT [FK_care_FeedingChartNote_reptile_ReptileList]
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




/******************************************************************************************************************
  Create equipment Tables
******************************************************************************************************************/


USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [equipment].[Category](
	[CategoryId] [smallint] IDENTITY(1,1) NOT NULL,
	[CategoryInfo] [varchar](100) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_equipment_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [equipment].[Category] ADD  DEFAULT ('') FOR [CategoryInfo]
GO

ALTER TABLE [equipment].[Category] ADD  CONSTRAINT [DF_equipment_Category_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [equipment].[Category] ADD  CONSTRAINT [DF_equipment_Category__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [equipment].[TrCategoryUpdate]
ON [equipment].[Category]
FOR UPDATE AS
/************************************************************************************
Category Name: equipment.TrCategoryUpdate
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
	UPDATE [equipment].[Category]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [equipment].[Category].CategoryID = i.CategoryID
END;
GO

ALTER TABLE [equipment].[Category] ENABLE TRIGGER [TrCategoryUpdate]
GO



USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [equipment].[Object](
	[ObjectId] [smallint] IDENTITY(1,1) NOT NULL,
	[CategoryId] [smallint] NOT NULL,
	[EquipmentName] [varchar](100) NOT NULL,
	[EquipmentInfo] [varchar](250) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_equipment_Object] PRIMARY KEY CLUSTERED 
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [equipment].[Object] ADD  DEFAULT ('') FOR [EquipmentInfo]
GO

ALTER TABLE [equipment].[Object] ADD  CONSTRAINT [DF_equipment_Object_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [equipment].[Object] ADD  CONSTRAINT [DF_equipment_Object__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [equipment].[Object]  WITH CHECK ADD  CONSTRAINT [FK_equipment_Object_equipment_Category] FOREIGN KEY([CategoryId])
REFERENCES [equipment].[Category] ([CategoryId])
GO

ALTER TABLE [equipment].[Object] CHECK CONSTRAINT [FK_equipment_Object_equipment_Category]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [equipment].[TrObjectUpdate]
ON [equipment].[Object]
FOR UPDATE AS
/************************************************************************************
Object Name: equipment.TrObjectUpdate
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
	UPDATE [equipment].[Object]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [equipment].[Object].ObjectID = i.ObjectID
END;
GO

ALTER TABLE [equipment].[Object] ENABLE TRIGGER [TrObjectUpdate]
GO

USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [equipment].[ObjectNote](
	[ObjectNoteId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NULL,
	[Heating] [varchar](1000) NOT NULL,
	[Humidity] [varchar](1000) NOT NULL,
	[Automation] [varchar](1000) NOT NULL,
	[Feeding] [varchar](1000) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_equipment_ObjectNote] PRIMARY KEY CLUSTERED 
(
	[ObjectNoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  DEFAULT ('') FOR [Heating]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  DEFAULT ('') FOR [Humidity]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  DEFAULT ('') FOR [Automation]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  DEFAULT ('') FOR [Feeding]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  CONSTRAINT [DF_equipment_ObjectNote_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [equipment].[ObjectNote] ADD  CONSTRAINT [DF_equipment_ObjectNote__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [equipment].[ObjectNote]  WITH CHECK ADD  CONSTRAINT [FK_equipment_ObjectNote_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [equipment].[ObjectNote] CHECK CONSTRAINT [FK_equipment_ObjectNote_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [equipment].[TrObjectNoteUpdate]
ON [equipment].[ObjectNote]
FOR UPDATE AS
/************************************************************************************
ObjectNote Name: equipment.TrObjectNoteUpdate
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
	UPDATE [equipment].[ObjectNote]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [equipment].[ObjectNote].ObjectNoteID = i.ObjectNoteID
END;
GO

ALTER TABLE [equipment].[ObjectNote] ENABLE TRIGGER [TrObjectNoteUpdate]
GO



/******************************************************************************************************************
  Create guide Tables
******************************************************************************************************************/



GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[Note](
	[NoteId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[DietNote] [varchar](1500) NOT NULL,
	[CareNote] [varchar](1500) NOT NULL,
	[EquipmentNote] [varchar](1500) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_Note] PRIMARY KEY CLUSTERED 
(
	[NoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_Note_DietNote]  DEFAULT ('') FOR [DietNote]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_Note_CareNote]  DEFAULT ('') FOR [CareNote]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_Note_EquipmentNote]  DEFAULT ('') FOR [EquipmentNote]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_guide_Note_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[Note] ADD  CONSTRAINT [DF_guide_Note__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[Note]  WITH CHECK ADD  CONSTRAINT [FK_guide_Note_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[Note] CHECK CONSTRAINT [FK_guide_Note_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [guide].[TrNoteUpdate]
ON [guide].[Note]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrNoteUpdate
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
	UPDATE [guide].[Note]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[Note].NoteID = i.NoteID
END;
GO

ALTER TABLE [guide].[Note] ENABLE TRIGGER [TrNoteUpdate]
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileListToEquipment](
	[ReptileListTobjectId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[objectId] [smallint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileListTobject] PRIMARY KEY CLUSTERED 
(
	[ReptileListTobjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileListToEquipment] ADD  CONSTRAINT [DF_guide_ReptileListTobject_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileListToEquipment] ADD  CONSTRAINT [DF_guide_ReptileListTobject__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[ReptileListToEquipment]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileListToEquipment_equipment_Object] FOREIGN KEY([objectId])
REFERENCES [equipment].[Object] ([ObjectId])
GO

ALTER TABLE [guide].[ReptileListToEquipment] CHECK CONSTRAINT [FK_guide_ReptileListToEquipment_equipment_Object]
GO

ALTER TABLE [guide].[ReptileListToEquipment]  WITH CHECK ADD  CONSTRAINT [FK_reptile_ReptileListToEquipment_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[ReptileListToEquipment] CHECK CONSTRAINT [FK_reptile_ReptileListToEquipment_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE TRIGGER [guide].[TrReptileListTobjectUpdate]
ON [guide].[ReptileListToEquipment]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileListTobjectUpdate
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
	UPDATE [guide].[ReptileListTobject]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileListTobject].ReptileListTobjectID = i.ReptileListTobjectID
END;
GO

ALTER TABLE [guide].[ReptileListToEquipment] ENABLE TRIGGER [TrReptileListTobjectUpdate]
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileListToHandleability](
	[ReptilelistToHandleabilityId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[HandleabilityId] [smallint] NOT NULL,
	[HandleabilityNote] [varchar](500) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileListToHandleability] PRIMARY KEY CLUSTERED 
(
	[ReptilelistToHandleabilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileListToHandleability] ADD  CONSTRAINT [DF__ReptileLis__Note__090A5324]  DEFAULT ('') FOR [HandleabilityId]
GO

ALTER TABLE [guide].[ReptileListToHandleability] ADD  DEFAULT ('') FOR [HandleabilityNote]
GO

ALTER TABLE [guide].[ReptileListToHandleability] ADD  CONSTRAINT [DF_guide_ReptileListToHandleability_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileListToHandleability] ADD  CONSTRAINT [DF_guide_ReptileListToHandleability__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[ReptileListToHandleability]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptilelistToHandleability_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[ReptileListToHandleability] CHECK CONSTRAINT [FK_guide_ReptilelistToHandleability_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [guide].[TrReptileListToHandleabilityUpdate]
ON [guide].[ReptileListToHandleability]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileListToHandleabilityUpdate
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
	UPDATE [guide].[ReptileListToHandleability]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileListToHandleability].ReptileListToHandleabilityID = i.ReptileListToHandleabilityID
END;
GO

ALTER TABLE [guide].[ReptileListToHandleability] ENABLE TRIGGER [TrReptileListToHandleabilityUpdate]
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileListToSubstrate](
	[ReptileListToSubstrateId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[SubstrateId] [smallint] NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileListToSubstrate] PRIMARY KEY CLUSTERED 
(
	[ReptileListToSubstrateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileListToSubstrate] ADD  CONSTRAINT [DF_guide_ReptileListToSubstrate_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileListToSubstrate] ADD  CONSTRAINT [DF_guide_ReptileListToSubstrate__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[ReptileListToSubstrate]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileListToSubstrate_care_Substrate] FOREIGN KEY([SubstrateId])
REFERENCES [care].[Substrate] ([SubstrateId])
GO

ALTER TABLE [guide].[ReptileListToSubstrate] CHECK CONSTRAINT [FK_guide_ReptileListToSubstrate_care_Substrate]
GO

ALTER TABLE [guide].[ReptileListToSubstrate]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileListToSubstrate_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[ReptileListToSubstrate] CHECK CONSTRAINT [FK_guide_ReptileListToSubstrate_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE TRIGGER [guide].[TrReptileListToSubstrateUpdate]
ON [guide].[ReptileListToSubstrate]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileListToSubstrateUpdate
Created By: Dstonea
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
	UPDATE [guide].[ReptileListToSubstrate]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileListToSubstrate].ReptileListToSubstrateID = i.ReptileListToSubstrateID
END;
GO

ALTER TABLE [guide].[ReptileListToSubstrate] ENABLE TRIGGER [TrReptileListToSubstrateUpdate]
GO







USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileToHerbivore](
	[ReptileToHerbivoreId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[HerbivoreId] [varchar](1000) NOT NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileToHerbivore] PRIMARY KEY CLUSTERED 
(
	[ReptileToHerbivoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileToHerbivore] ADD  CONSTRAINT [DF_guide_ReptileToHerbivore_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileToHerbivore] ADD  CONSTRAINT [DF_guide_ReptileToHerbivore__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE TRIGGER [guide].[TrReptileToHerbivoreUpdate]
ON [guide].[ReptileToHerbivore]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileToHerbivoreUpdate
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
	UPDATE [guide].[ReptileToHerbivore]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileToHerbivore].ReptileToHerbivoreID = i.ReptileToHerbivoreID
END;
GO

ALTER TABLE [guide].[ReptileToHerbivore] ENABLE TRIGGER [TrReptileToHerbivoreUpdate]
GO



USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [guide].[ReptileToPlantList](
	[ReptileToPlantListId] [smallint] IDENTITY(1,1) NOT NULL,
	[ReptileListId] [smallint] NOT NULL,
	[PlantListId] [smallint] NULL,
	[DateCreated] [datetime2](2) NOT NULL,
	[DateUpdated] [datetime2](2) NOT NULL,
 CONSTRAINT [PK_guide_ReptileToPlantList] PRIMARY KEY CLUSTERED 
(
	[ReptileToPlantListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [guide].[ReptileToPlantList] ADD  CONSTRAINT [DF_guide_ReptileToPlantList_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [guide].[ReptileToPlantList] ADD  CONSTRAINT [DF_guide_ReptileToPlantList__DateUpdated]  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [guide].[ReptileToPlantList]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileToPlantList_food_PlantList] FOREIGN KEY([PlantListId])
REFERENCES [food].[PlantList] ([PlantListId])
GO

ALTER TABLE [guide].[ReptileToPlantList] CHECK CONSTRAINT [FK_guide_ReptileToPlantList_food_PlantList]
GO

ALTER TABLE [guide].[ReptileToPlantList]  WITH CHECK ADD  CONSTRAINT [FK_guide_ReptileToPlantList_reptile_ReptileList] FOREIGN KEY([ReptileListId])
REFERENCES [reptile].[ReptileList] ([ReptileListId])
GO

ALTER TABLE [guide].[ReptileToPlantList] CHECK CONSTRAINT [FK_guide_ReptileToPlantList_reptile_ReptileList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [guide].[TrReptileToPlantListUpdate]
ON [guide].[ReptileToPlantList]
FOR UPDATE AS
/************************************************************************************
Object Name: guide.TrReptileToPlantUpdate
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
	UPDATE [guide].[ReptileToPlant]
	SET DateUpdated = GETDATE()
	FROM Inserted i
	WHERE [guide].[ReptileToPlant].ReptileToPlantID = i.ReptileToPlantID
END;
GO

ALTER TABLE [guide].[ReptileToPlantList] ENABLE TRIGGER [TrReptileToPlantListUpdate]
GO


