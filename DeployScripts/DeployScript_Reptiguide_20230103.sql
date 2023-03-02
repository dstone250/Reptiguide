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





/****************************************************************************************************************
  Create Views
****************************************************************************************************************/


USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [guide].[VwDenormalizeDiet] 
AS
/************************************************************************************
View Name: [guide].[VwDenormalizeDiet]
Created By: David Stone

Parameter List:
N/A

Example:
SELECT * FROM [guide].[VwDenormalizeDiet];

Purpose: Denormalize [guide].[DenormalizeDiet];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT
	cd.DietId
	,rc.ReptileListId
	,CONCAT(rc.Species, ': ', rc.SubSpecies) AS [ReptileType]
	,ffs.Scope
	,CASE cwb.Note
		WHEN '' THEN cwb.BowlSize
		 ELSE CONCAT(cwb.BowlSize, ': ', cwb.Note)
	 END AS BowlSize	
	,fs.SupplementName 
	,cfscs.Frequency AS SupplementSchedule
FROM care.Diet cd
	LEFT JOIN reptile.ReptileList rc ON cd.ReptileListId = rc.ReptileListId
	LEFT JOIN reptile.FoodScope ffs ON cd.FoodScopeId = ffs.FoodScopeId
	LEFT JOIN care.WaterBowl cwb ON cd.WaterBowlId = cwb.WaterBowlId
	LEFT JOIN food.supplement fs ON cd.SupplementId = fs.supplementId
	LEFT JOIN care.FoodSchedule cfscs ON cd.FoodScheduleId = cfscs.FoodScheduleId;
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [guide].[VwDenormalizeEnvironment] AS
/************************************************************************************
View Name: [guide].[VwDenormalizeEnvironment]
Created By: David Stone

Parameter List:
N/A

Example:
SELECT * FROM [guide].[VwDenormalizeEnvironment];

Purpose: Denormalize [guide].[DenormalizeEnvironment];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT
	rc.ReptileListId
	,CONCAT(rc.Species, ' ', rc.SubSpecies) AS [ReptileType]
	,re.HotSpot_F     
	,re.TempLow_F     
	,re.TempHigh_F    
	,re.HumidityLowPercentage 
	,re.HumidityHighPercentage
FROM reptile.Environment re
	LEFT JOIN reptile.ReptileList rc ON re.ReptileListId = rc.ReptileListId
GO






USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [guide].[VwDenormalizeEquipment]
AS
/************************************************************************************
View Name: [guide].[VwDenormalizeEquipment]
Created By: David Stone

Parameter List:
N/A

Example:
SELECT * FROM [guide].[VwDenormalizeEquipment];

Purpose: Denormalize [guide].[DenormalizeEquipment];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT A.ObjectId, B.CategoryInfo, A.EquipmentName
FROM [equipment].[object] A
	INNER JOIN [equipment].[Category] B ON A.CategoryId = B.CategoryId;
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [guide].[VwDenormalizeFeedingChartSnake] AS
/************************************************************************************
View Name: [guide].[VwDenormalizeFeedingChartSnake]
Created By: David Stone
Parameter List:
N/A
Example:
	SELECT * FROM [guide].[VwDenormalizeFeedingChartSnake]
	WHERE ReptileListId = 1;

Purpose: Denormalize [care].[FeedingChartSnake];
------------------------------------------------------------------------------------
Change History
2023-02-18 David Stone: Created.
************************************************************************************/
SELECT 
B.ReptileListId, 
B.Stage, 
B.Note, 
C.Frequency,
F.Category SmallCategory, 
D.Size SmallFeederSize, 
F.Category  LargeCategory, 
E.Size LargeFeederSize
FROM [care].[FeedingChartSnake] A
	INNER JOIN [reptile].[LifeStage] B ON A.LifeStageId = B.LifeStageId
	INNER JOIN [care].[FoodSchedule] C ON C.FoodScheduleId = A.FoodScheduleId
	INNER JOIN [food].[FeederList] D ON D.FeederListId = A.FeederListIdSmall
	INNER JOIN [food].[FeederList] E ON E.FeederListId = A.FeederListIdLarge
	INNER JOIN [food].[CategoryFeeder] F ON F.CategoryFeederId = D.CategoryFeederId
	INNER JOIN [food].[CategoryFeeder] G ON G.CategoryFeederId = E.CategoryFeederId
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE View [guide].[VwDenormalizeInformation]
AS
/************************************************************************************
View Name: [guide].[VwDenormalizeInformation]
Created By: David Stone

Parameter List:
N/A

Example:
	SELECT * FROM [guide].[VwDenormalizeInformation];

Purpose: Denormalize [guide].[VwDenormalizeInformation];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT
	 ri.InformationId
	,rc.ReptileType
	,rl.Species
	,rl.SubSpecies
	,CASE ri.isMale
		WHEN 0 THEN 'Female'
		ELSE 'Male'
	END	Sex
	,ri.LifeExpectancy
	,fs.Scope
	,CONCAT(ri.inchesMin/12,''' ',ri.inchesMin%12, '"') [MinLength]
	,CONCAT(ri.inchesMax/12,''' ',ri.inchesMax%12, '"') [MaxLength]
	,CONCAT(ri.lbsMin, ' lbs') MinWeight 
	,CONCAT(ri.lbsMax, ' lbs') MaxWeight
FROM reptile.Information ri
	INNER JOIN reptile.ReptileList rl ON rl.reptilelistID = ri.ReptileListId
	INNER JOIN reptile.Category rc ON ri.CategoryId = rc.CategoryId
	INNER JOIN reptile.FoodScope fs ON ri.FoodScopeId = fs.FoodScopeId;
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [guide].[VwReptileListToEquipment]
AS
/************************************************************************************
View Name: [guide].[VwReptileListToEquipment]
Created By: David Stone

Parameter List:
N/A

Example:
SELECT * FROM [guide].[VwReptileListToEquipment];

Purpose: Denormalize [guide].[ReptileListToEquipment];
------------------------------------------------------------------------------------
Change History
2023-02-11 David Stone: Created.

************************************************************************************/
SELECT A.ReptileListTobjectId, A.ReptileListId, C.CategoryInfo, B.EquipmentName
FROM [guide].[ReptileListToEquipment] A
	INNER JOIN [equipment].[Object] B ON A.objectId = B.objectId
	INNER JOIN [equipment].category C ON B.categoryId = C.categoryId;
GO



/****************************************************************************************************************
  Create Stored Procedures
****************************************************************************************************************/


USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [guide].[SpInsertDietNoteTortoise]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertDietNoteTortoise]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertDietNoteTortoise] @SubSpecies = 'russian tortoise', @Debug = 1;

Purpose: Get the denormalized diet information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
	BEGIN
	SET NOCOUNT ON;

	DECLARE 
		 @ReptileListId INT
		,@DietId INT
		,@ReptileType VARCHAR(150)	
		,@Scope	VARCHAR(50)
		,@DietToNoteId	INT	
		,@BowlSize VARCHAR(100)	
		,@FoodSchedule VARCHAR(50)	
		,@SupplementName VARCHAR(50)	
		,@SupplementScedule	VARCHAR(50)
		,@FeedingChartNote VARCHAR(1500)	
		,@OldNote VARCHAR(1500)
		,@NewNote VARCHAR(1500);

	SELECT TOP 1 
		 @ReptileListId = cd.ReptileListId
		,@DietId = cd.DietId
	FROM Care.Diet cd 
		INNER JOIN reptile.ReptileList rl ON rl.ReptileListId = cd.ReptileListId
	WHERE rl.SubSpecies = @SubSpecies;

	SELECT 
		 @ReptileType = ReptileType
		,@Scope	= Scope	
		,@BowlSize	= BowlSize	
		,@SupplementName	= SupplementName	
		,@SupplementScedule	= SupplementSchedule	
	FROM [guide].[VwDenormalizeDiet] 
	WHERE ReptileListId = @ReptileListId;

	SELECT @FeedingChartNote = note 
	FROM [care].[FeedingChartNote]
	WHERE ReptileListId = @ReptileListId

	SET @NewNote = CONCAT('DIET:',CHAR(10),'A ' ,@ReptileType, ' should have a variety of greens and vegetables to eat such as the following: ', @FeedingChartNote,'. ',
		'Their meals can be supplimented with ',@SupplementName, ' ' , @SupplementScedule,'.', CHAR(10),
		'The water bowl should be ',@BowlSize,'.');

	IF(@Debug = 1)
	BEGIN
		SET @OldNote = (
			SELECT DietNote
			FROM guide.Note
			WHERE ReptileListId = @ReptileListId );
 
		PRINT 'Note before update: ' + @OldNote+CHAR(10);
		PRINT 'Note after update:' + @NewNote;
	END;
	ELSE 
	BEGIN
		UPDATE guide.Note
		SET DietNote = @NewNote
		WHERE ReptileListId = @ReptileListId;
	END;
END;
GO




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [guide].[SpInsertCareNoteTortoise]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertCareNoteTortoise]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertCareNoteTortoise] @SubSpecies = 'Russian Tortoise', @Debug = 1;

Purpose: Get the denormalized care information for a Tortoise, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
SET NOCOUNT ON;

DECLARE @Materials TABLE (
	ID INT,
	Material VARCHAR(50)
);

DECLARE 
	 @careInfoId INT
	,@ReptileListId INT
	,@ReptileType VARCHAR(150)	
	,@LifeExpectancy VARCHAR(50) 	
	,@HotSpot_F TINYINT   
	,@TempLow_F TINYINT    
	,@TempHigh_F TINYINT   
	,@HumidityLowPercentage TINYINT 
	,@HumidityHighPercentage TINYINT
	,@OldNote VARCHAR(1500)
	,@NewNote VARCHAR(MAX)
	,@MaterialList VARCHAR(200) = '';

SELECT TOP 1 
	@ReptileListId = rl.ReptileListId,
	@LifeExpectancy = ri.LifeExpectancy
FROM reptile.ReptileList rl
	INNER JOIN reptile.Information ri ON ri.ReptileListId = rl.ReptileListId
WHERE @SubSpecies = SubSpecies;

SELECT 
	 @ReptileType = ReptileType
	,@HotSpot_F = HotSpot_F
	,@TempLow_F = TempLow_F
	,@TempHigh_F = TempHigh_F
	,@HumidityLowPercentage = HumidityLowPercentage
	,@HumidityHighPercentage = HumidityHighPercentage
FROM [guide].[VwDenormalizeEnvironment]
WHERE ReptileListId = @ReptileListId;

INSERT INTO @Materials(ID, Material)
SELECT rl.SubstrateId, cs.Material 
FROM guide.ReptileListToSubstrate rl
INNER JOIN care.Substrate cs ON rl.SubstrateId = cs.SubstrateId

WHILE EXISTS (SELECT TOP 1 1 FROM @Materials)
BEGIN
	SET @MaterialList += (SELECT TOP 1 Material FROM @Materials ORDER BY ID);	
	
	IF ((SELECT COUNT(ID) FROM @Materials) > 1)
	BEGIN
		SET @MaterialList += ', ';
	END;	
	DELETE FROM @Materials 
	WHERE ID = (SELECT TOP 1 ID FROM @Materials ORDER BY ID)
END;

SET @NewNote = CONCAT('CARE:',CHAR(10),'The ', @ReptileType ,' can live ',@LifeExpectancy,' in the wild, and they can live even longer with proper care in captivity. One of the more important aspects to care is maintaining a
proper heat gradiant. There should be a cool, and warm side to the encloser as well as a hot spot. Proper temperatures will help the animal digest food properly. Too much heat or cold can kill them. 
For a ',@ReptileType,' The highest ambient temperature in the enclosure should be around',@TempLow_F,' degrees farenheight. The lowest ambient temperature should not be lower than ',@TempHigh_F ,' degrees farenheight. There should be hot spot as well to help the Snake warm up as desired. The average temperature should be around
',@HotSpot_F,' degrees farenheight. Further details will be in the equipment portion.',CHAR(10),CHAR(10));

SET @NewNote += CONCAT('Humidity is also an important aspect to the care of a', @ReptileType ,'. The humidity can fluctuate but the high point should be around ',@HumidityHighPercentage,'%
and the lower humidity should be around ',@HumidityLowPercentage,'%. The type of substrate used should eliminate or retain more moisture depending on the species.',CHAR(10),CHAR(10));

SET @NewNote += CONCAT('An enclosure should be large enough for the tortoise to roam freely. Even a small tortise should have a 75 to 100 gallon enclosure The best Substrates are ',@MaterialList,'. 
It is important to have places for the animal to hide as well.',CHAR(10));

IF(@Debug = 1)
BEGIN
	SET @OldNote = (
		SELECT CareNote
		FROM guide.Note
		WHERE ReptileListId = @ReptileListId );

	PRINT 'Note before update: ' + CHAR(10) + @OldNote + CHAR(10);
	PRINT 'Note after update:' + CHAR(10) +  @NewNote + CHAR(10)
END;
ELSE 
BEGIN
	UPDATE guide.Note
	SET CareNote = @NewNote
	WHERE ReptileListId = @ReptileListId;
END;
GO




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [guide].[SpInsertEquipmentNotes] 
	@ReptileListId SMALLINT
AS
/************************************************************************************
Object Name: [guide].[SpInsertEquipmentNote]
Created By: David Stone

Parameter List:
@ReptileListId: The ReptileListId is used to get the related equipment.

Example: EXEC guide.SpInsertEquipmentNotes @ReptileListId = 5;

Purpose: Get the list of equipment that is used by a reptile.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
BEGIN
	SET NOCOUNT ON;
	DROP TABLE IF EXISTS #Equipment;

	CREATE TABLE #Equipment(
		ReptileListTobjectId SMALLINT,
		Equipment VARCHAR(500)
	);

	DECLARE @EquipmentNote VARCHAR(1000) = '',
		@Equipment VARCHAR(50);
		
	IF NOT EXISTS(
		SELECT TOP 1 1 
		FROM [equipment].[ObjectNote]
		WHERE ReptileListId = @ReptileListId)
	BEGIN
		INSERT INTO [equipment].[ObjectNote] (ReptileListId)
		VALUES(@ReptileListId);
	END;

	INSERT INTO #Equipment(ReptileListTobjectId, Equipment)
	SELECT ReptileListTobjectId, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE CategoryInfo = 'Heating'
	ORDER BY ReptileListTobjectId;

	WHILE EXISTS (
		SELECT TOP 1 1 FROM #Equipment)
	BEGIN
		SET @Equipment = (
		SELECT TOP 1  Equipment 
		FROM #Equipment 
		ORDER BY ReptileListTobjectId)

		IF((SELECT COUNT(*) FROM #Equipment) > 1)
		BEGIN
			SET @EquipmentNote += @Equipment + ', ';
		END;
		ELSE
		BEGIN
			SET @EquipmentNote += @Equipment;
		END;

		DELETE FROM #Equipment
		WHERE Equipment = @Equipment;
	END;

	UPDATE [equipment].[ObjectNote]
	SET Heating = @EquipmentNote
	WHERE ReptileListId = @ReptileListId;

	INSERT INTO #Equipment(ReptileListTobjectId, Equipment)
	SELECT ReptileListTobjectId, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE CategoryInfo = 'Humidity'
	ORDER BY ReptileListTobjectId;

	WHILE EXISTS (
		SELECT TOP 1 1 FROM #Equipment)
	BEGIN
		SET @Equipment = (
		SELECT TOP 1  Equipment 
		FROM #Equipment 
		ORDER BY ReptileListTobjectId)

		IF((SELECT COUNT(*) FROM #Equipment) > 1)
		BEGIN
			SET @EquipmentNote += @Equipment + ', ';
		END;
		ELSE
		BEGIN
			SET @EquipmentNote += @Equipment;
		END;

		DELETE FROM #Equipment
		WHERE Equipment = @Equipment;
	END;

	UPDATE [equipment].[ObjectNote]
	SET Humidity = @EquipmentNote
	WHERE ReptileListId = @ReptileListId;

	INSERT INTO #Equipment(ReptileListTobjectId, Equipment)
	SELECT ReptileListTobjectId, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE CategoryInfo = 'Automation'
	ORDER BY ReptileListTobjectId;

	WHILE EXISTS (
		SELECT TOP 1 1 FROM #Equipment)
	BEGIN
		SET @Equipment = (
		SELECT TOP 1  Equipment 
		FROM #Equipment 
		ORDER BY ReptileListTobjectId)

		IF((SELECT COUNT(*) FROM #Equipment) > 1)
		BEGIN
			SET @EquipmentNote += @Equipment + ', ';
		END;
		ELSE
		BEGIN
			SET @EquipmentNote += @Equipment;
		END;

		DELETE FROM #Equipment
		WHERE Equipment = @Equipment;
	END;

	UPDATE [equipment].[ObjectNote]
	SET Automation = @EquipmentNote
	WHERE ReptileListId = @ReptileListId;


	INSERT INTO #Equipment(ReptileListTobjectId, Equipment)
	SELECT ReptileListTobjectId, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE CategoryInfo = 'Feeding'
	ORDER BY ReptileListTobjectId;

	WHILE EXISTS (
		SELECT TOP 1 1 FROM #Equipment)
	BEGIN
		SET @Equipment = (
		SELECT TOP 1  Equipment 
		FROM #Equipment 
		ORDER BY ReptileListTobjectId)

		IF((SELECT COUNT(*) FROM #Equipment) > 1)
		BEGIN
			SET @EquipmentNote += @Equipment + ', ';
		END;
		ELSE
		BEGIN
			SET @EquipmentNote += @Equipment;
		END;

		DELETE FROM #Equipment
		WHERE Equipment = @Equipment;
	END;

	UPDATE [equipment].[ObjectNote]
	SET Feeding = @EquipmentNote
	WHERE ReptileListId = @ReptileListId;
END;

GO




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [guide].[SpInsertEquipmentNoteSnake]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertEquipmentNote]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertEquipmentNote] @SubSpecies = 'bci', @Debug = 1;

Purpose: Get the denormalized care information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/

SET NOCOUNT ON;

DECLARE @Materials TABLE (
	ID INT,
	CategoryInfo VARCHAR(50),
	EquipmentName VARCHAR(200)
);

DECLARE 
	 @careInfoId INT
	,@ReptileListId INT
	,@ReptileType VARCHAR(150)	
	,@HeatingList VARCHAR(200) = ''
	,@HumidityList VARCHAR(200) =''
	,@AutomationList VARCHAR(200) = ''
	,@FeedingList VARCHAR(200) = ''
	,@OldNote VARCHAR(1500)
	,@NewNote VARCHAR(1500)
	,@MaterialList VARCHAR(200) = '';

	--,@SubSpecies VARCHAR(100) = 'bci'
	--,@Debug BIT = 1
SELECT TOP 1 @ReptileListId = ReptileListId
FROM reptile.ReptileList
WHERE @SubSpecies = SubSpecies;

IF NOT EXISTS(
	SELECT TOP 1 1 
	FROM [equipment].[ObjectNote]
	WHERE ReptileListId = @ReptileListId)
BEGIN
	EXEC guide.SpInsertEquipmentNotes @ReptileListId = @ReptileListId;
END;

SELECT 
		@HeatingList = Heating
	,@HumidityList = Humidity
	,@AutomationList = Automation
	,@FeedingList = Feeding
FROM [equipment].[ObjectNote]
WHERE ReptileListId = @ReptileListId;

SET @NewNote = CONCAT('EQUIPMENT: ',CHAR(10),'There is a lot of equipment that can help with the care of a reptile. There are four main categories. Heating control, Humidity control, Automation and Feeding. ',
CHAR(10),'Heating equipment is used to keep the temperatures at the proper level: ', @HeatingList,CHAR(10),
'Humidity equipment is used to keep humidity at the proper level: ', @HumidityList,CHAR(10),
'Automation equipment is used to automate all electrical equipment to keep temperatures and humidity in a sweet spot, and to have a set day and night cycle: ',@AutomationList,CHAR(10),
'Feeding equipment is used to assist with feedings: ', @FeedingList,CHAR(10),
'Thermosats are essential for any heating equipment, and timers are a life saver for setting: heat, lighting, and misting to a desired schedule.');

IF(@Debug = 1)
BEGIN
	SET @OldNote = (
		SELECT EquipmentNote
		FROM guide.Note
		WHERE ReptileListId = @ReptileListId );

	PRINT 'Note before update: ' + CHAR(10) + @OldNote + CHAR(10);
	PRINT 'Note after update:' + CHAR(10) +  @NewNote + CHAR(10);
END;
ELSE 
BEGIN
	SET @OldNote = (
		SELECT EquipmentNote
		FROM guide.Note
		WHERE ReptileListId = @ReptileListId );
END;
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [guide].[SpInsertEquipmentNoteTortoise]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertEquipmentNoteTortoise]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertEquipmentNoteTortoise] @SubSpecies = 'Russian Tortoise', @Debug = 1;

Purpose: Get the denormalized care information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/

SET NOCOUNT ON;

DECLARE @Materials TABLE (
	ID INT,
	CategoryInfo VARCHAR(50),
	EquipmentName VARCHAR(200)
);

DECLARE 
	 @careInfoId INT
	,@ReptileListId INT
	,@ReptileType VARCHAR(150)	
	,@HeatingList VARCHAR(200) = ''
	,@HumidityList VARCHAR(200) =''
	,@AutomationList VARCHAR(200) = ''
	,@FeedingList VARCHAR(200) = ''
	,@OldNote VARCHAR(1500)
	,@NewNote VARCHAR(1500)
	,@MaterialList VARCHAR(200) = '';

	--,@SubSpecies VARCHAR(100) = 'bci'
	--,@Debug BIT = 1
SELECT TOP 1 @ReptileListId = ReptileListId
FROM reptile.ReptileList
WHERE @SubSpecies = SubSpecies;

IF NOT EXISTS(
	SELECT TOP 1 1 
	FROM [equipment].[ObjectNote]
	WHERE ReptileListId = @ReptileListId)
BEGIN
	EXEC guide.SpInsertEquipmentNotes @ReptileListId = @ReptileListId;
END;

SELECT 
	@HeatingList = Heating
	,@HumidityList = Humidity
	,@AutomationList = Automation
	,@FeedingList = Feeding
FROM [equipment].[ObjectNote]
WHERE ReptileListId = @ReptileListId;

SET @NewNote = CONCAT('EQUIPMENT: ',CHAR(10),'There is a lot of equipment that can help with the care of a reptile. There are four main categories. Heating control, Humidity control, Automation and Feeding. ',
CHAR(10),'Heating equipment is used to keep the temperatures at the proper level: ', @HeatingList,CHAR(10),
'Humidity equipment is used to keep humidity at the proper level: ', @HumidityList,CHAR(10),
'Automation equipment is used to automate all electrical equipment to keep temperatures and humidity in a sweet spot, and to have a set day and night cycle: 
',@AutomationList,CHAR(10),
'Feeding equipment is used to assist with feedings: ', @FeedingList,CHAR(10),
'Thermosats are essential for any heating equipment, and timers are a life saver for setting: heat, lighting, and misting to a desired schedule.');

IF(@Debug = 1)
BEGIN
	SET @OldNote = (
		SELECT EquipmentNote
		FROM guide.Note
		WHERE ReptileListId = @ReptileListId );

	PRINT 'Note before update: ' + CHAR(10) + @OldNote + CHAR(10);
	PRINT 'Note after update:' + CHAR(10) +  @NewNote + CHAR(10);
END;
ELSE 
BEGIN
	UPDATE guide.Note
	SET EquipmentNote = @NewNote
	WHERE ReptileListId = @ReptileListId;
END;
GO




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [guide].[SpInsertFeedingChartSnake]
	 @ReptileListId SMALLINT
AS
/************************************************************************************
Object Name: [guide].[SpInsertFeedingChartSnake]
Created By: David Stone

Parameter List:

Example: EXEC [guide].[SpInsertFeedingChartSnake] @ReptileListId = 1;

Purpose: 
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-18

************************************************************************************/
BEGIN
	SET NOCOUNT ON;

	CREATE TABLE #FeedingChartSnake(
		 Stage VARCHAR(15)
		,Note VARCHAR(15)
		,Frequency VARCHAR(15)
		,SmallCategory VARCHAR(15)
		,SmallFeederSize VARCHAR(15)
		,LargeCategory VARCHAR(15)
		,LargeFeederSize VARCHAR(15))

	DECLARE 
		 @Stage VARCHAR(15)
		,@Note VARCHAR(15)
		,@Frequency VARCHAR(15)
		,@SmallCategory VARCHAR(15)
		,@SmallFeederSize VARCHAR(15)
		,@LargeCategory VARCHAR(15)
		,@LargeFeederSize VARCHAR(15)
		,@ReptileType VARCHAR(50)
		,@OutputNote VARCHAR(1000) = '';
	
	SELECT 
		 @ReptileType = ReptileType
	FROM [guide].[VwDenormalizeDiet]
	WHERE ReptileListId = @ReptileListId;

	INSERT INTO #FeedingChartSnake (Stage,Note,Frequency, SmallCategory, SmallFeederSize, LargeCategory, LargeFeederSize) 
	SELECT Stage, Note, Frequency, SmallCategory, SmallFeederSize, LargeCategory, LargeFeederSize 
	FROM [guide].[VwDenormalizeFeedingChartSnake]
	WHERE ReptileListId = @ReptileListId;
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #FeedingChartSnake)
	BEGIN
		SELECT TOP 1 
			 @Stage = Stage
			,@Note = Note
			,@Frequency = Frequency
			,@SmallCategory = SmallCategory
			,@SmallFeederSize = SmallFeederSize
			,@LargeCategory = LargeCategory
			,@LargeFeederSize = LargeFeederSize
		FROM #FeedingChartSnake 
		ORDER BY Note;

		SET @OutputNote +=  CONCAT('A ', @Stage, ' ' ,@ReptileType, ' will be between ',  @Note, ' old. ',
		'It should be fed every ', @Frequency, ' and can eat ', @SmallFeederSize, ' ', @SmallCategory, ' to ' ,@LargeFeederSize, ' ', @LargeCategory,'.', CHAR(10))

		DELETE FROM #FeedingChartSnake 
		WHERE Stage = @Stage;
	END;

	IF NOT EXISTS(SELECT TOP 1 1 
		FROM [care].[FeedingChartNote]
		WHERE ReptileListId = @ReptileListId)
	BEGIN
		INSERT INTO [care].[FeedingChartNote](ReptileListId, Note)
		VALUES (@ReptileListId, @OutputNote)
	END
	ELSE BEGIN
		UPDATE [care].[FeedingChartNote]
		SET note = @OutputNote 
		WHERE ReptileListId = @ReptileListId;
	END;
END;
GO




USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [guide].[SpInsertHerbivoreDietList]
	@Subspecies VARCHAR(100)
AS
/*********************************************************************************
Object Name: [guide].[SpInsertHerbivoreDietList]
Created By: David Stone
Parameter List:
Example: EXEC guide.SpInsertHerbivoreDietList @Subspecies = 'Russian Tortoise';
Purpose: Insert the a list of foods an herbivore can eat.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-18
*********************************************************************************/
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS  #FoodList
	DROP TABLE IF EXISTS #FoodTypeList

	CREATE TABLE #FoodList(
		FoodListId SMALLINT IDENTITY (1,1),
		FoodType VARCHAR(50),
		FoodCategory VARCHAR(50),
		Subcategory VARCHAR(50)
	)

	CREATE TABLE #FoodTypeList(
		FoodType VARCHAR(50)
	)

	DECLARE 
		 @ReptileListId SMALLINT
		,@DietNote VARCHAR(1500) = ''
		,@FoodType VARCHAR(50)
		,@FoodCategory VARCHAR(50)	
		,@Subcategory VARCHAR(50);

	SELECT @ReptileListId = ReptileListId 
	FROM Reptile.ReptileList
	WHERE SubSpecies = @Subspecies;

	INSERT INTO #FoodList(FoodType, FoodCategory, Subcategory)
	SELECT 
		ft.Category,
		fh.Category, 
		fh.SubCategory 
	FROM [guide].[ReptileToPlantList] rtp
		INNER JOIN reptile.ReptileList rl ON rl.ReptileListId = rtp.ReptileListId
		INNER JOIN food.PlantList fh ON rtp.PlantListId = fh.PlantListId
		INNER JOIN food.CategoryPlant ft ON ft.CategoryPlantId = fh.CategoryPlantId
	WHERE rtp.ReptileListId = @ReptileListId;

	INSERT INTO #FoodTypeList(FoodType)
	SELECT DISTINCT FoodType
	FROM #FoodList;

	WHILE ((
		SELECT COUNT(*) 
		FROM #FoodTypeList) > 0)
	BEGIN
		SET @FoodType = (
			SELECT TOP 1 FoodType 
			FROM #FoodTypeList);

		WHILE ((
			SELECT COUNT(*) 
			FROM #FoodList
			WHERE FoodType = @FoodType ) > 0)
		BEGIN

			SELECT 
				@FoodCategory = FoodCategory,
				@Subcategory = SubCategory
			FROM #FoodList 
			WHERE FoodType = @FoodType
	
			IF(@Subcategory <> '')
			BEGIN
				SET @DietNote += @FoodCategory;
			END;
			ELSE 
			BEGIN
				SET @DietNote += @FoodCategory + ' '+ @Subcategory
			END;

			IF((
				SELECT COUNT(FoodCategory)
				FROM #FoodList 
				WHERE FoodType = @FoodType) > 1)
			BEGIN
				SET @DietNote += ', ';
			END;

			DELETE FROM #FoodList 
			WHERE FoodCategory = @FoodCategory 
				AND Subcategory = @SubCategory;
		END;
		DELETE FROM #FoodTypeList
		WHERE FoodType = @FoodType;
	END;

	PRINT @DietNote

	IF NOT EXISTS(
		SELECT TOP 1 1 
		FROM [care].[FeedingChartNote]
		WHERE ReptileListId = @ReptileListId)
	BEGIN
		INSERT [care].[FeedingChartNote](ReptileListId, Note)
		VALUES(@ReptileListId, @DietNote);
	END;
	ELSE
	BEGIN
		UPDATE [care].[FeedingChartNote]
		SET Note = @DietNote
		WHERE ReptileListId = @ReptileListId;
	END;
END;
GO



USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [guide].[SpInsertObjectNotes]
	 @ReptileListId SMALLINT
/************************************************************************************
Object Name: [guide].[SpInsertObjectNotes]
Created By: David Stone

Parameter List:
@ReptileListId: Dictates which reptile notes to update

Example: EXEC [guide].[SpInsertObjectNote] @ReptileListId = 1

Purpose: Create the Equipment.Object Notes to be used by [guide].[SpInsertEquipmentNote]
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
AS
BEGIN
	DECLARE @Materials TABLE (
		ID INT,
		CategoryInfo VARCHAR(50),
		EquipmentName VARCHAR(200)
	);

	DECLARE 
		@Heating VARCHAR(200) = ''
		,@Humidity VARCHAR(200) = ''
		,@Automation VARCHAR(200) = ''
		,@Feeding VARCHAR(200) = ''
		,@CategoryInfo VARCHAR(50) =''
		,@EquipmentName VARCHAR(50) =''
		,@Count TINYINT;
	
	/* Get the list of all equipment needed by the reptile. */
	INSERT INTO @Materials(CategoryInfo, EquipmentName)
	SELECT CategoryInfo, EquipmentName
	FROM [guide].[VwReptileListToEquipment]
	WHERE reptilelistId = @ReptileListId;
	
	/* Create a list oh equpment used for: */
	SET @CategoryInfo = 'Heating';
	WHILE EXISTS(
		SELECT TOP 1 CategoryInfo
		FROM @Materials 
		WHERE CategoryInfo=@CategoryInfo)
	BEGIN
		SET @Count = (
			SELECT COUNT(EquipmentName) 
			FROM @Materials 
			WHERE CategoryInfo = @CategoryInfo);

		SET @EquipmentName = (
			SELECT TOP 1 EquipmentName 
			FROM @Materials 
			WHERE CategoryInfo=@CategoryInfo);
		
		IF(@Count <> 1)
		BEGIN
			SET @Heating += @EquipmentName+', ';
		END;
		ELSE
		BEGIN
			SET @Heating += @EquipmentName;
		END;

		DELETE FROM @Materials 
		WHERE EquipmentName = @EquipmentName;
	END

	/* Create a list oh equpment used for: Humidity */	
	SET @CategoryInfo = 'Humidity';
	WHILE EXISTS(
		SELECT TOP 1 CategoryInfo
		FROM @Materials 
		WHERE CategoryInfo=@CategoryInfo)
	BEGIN
		SET @Count = (
			SELECT COUNT(EquipmentName) 
			FROM @Materials 
			WHERE CategoryInfo = @CategoryInfo);

		SET @EquipmentName = (
			SELECT TOP 1 EquipmentName 
			FROM @Materials 
			WHERE CategoryInfo=@CategoryInfo);
		
		IF(@Count <> 1)
		BEGIN
			SET @Humidity += @EquipmentName+', ';
		END;
		ELSE
		BEGIN
			SET @Humidity += @EquipmentName;
		END;

		DELETE FROM @Materials 
		WHERE EquipmentName = @EquipmentName;
	END;

	/* Create a list oh equpment used for: Automation */	
	SET @CategoryInfo = 'Automation';
	WHILE EXISTS(
		SELECT TOP 1 CategoryInfo
		FROM @Materials 
		WHERE CategoryInfo=@CategoryInfo)
	BEGIN
		SET @Count = (
			SELECT COUNT(EquipmentName) 
			FROM @Materials 
			WHERE CategoryInfo = @CategoryInfo);

		SET @EquipmentName = (
			SELECT TOP 1 EquipmentName 
			FROM @Materials 
			WHERE CategoryInfo=@CategoryInfo);
		
		IF(@Count <> 1)
		BEGIN
			SET @Automation += @EquipmentName+', ';
		END;
		ELSE
		BEGIN
			SET @Automation += @EquipmentName;
		END;

		DELETE FROM @Materials 
		WHERE EquipmentName = @EquipmentName;
	END;

	/* Create a list oh equpment used for: Feeding. */
	SET @CategoryInfo = 'Feeding';
	WHILE EXISTS(
		SELECT TOP 1 CategoryInfo
		FROM @Materials 
		WHERE CategoryInfo=@CategoryInfo)
	BEGIN
		SET @Count = (
			SELECT COUNT(EquipmentName) 
			FROM @Materials 
			WHERE CategoryInfo = @CategoryInfo);

		SET @EquipmentName = (
			SELECT TOP 1 EquipmentName 
			FROM @Materials 
			WHERE CategoryInfo=@CategoryInfo);
		
		IF(@Count <> 1)
		BEGIN
			SET @Feeding += @EquipmentName+', ';
		END;
		ELSE
		BEGIN
			SET @Feeding += @EquipmentName;
		END;

		DELETE FROM @Materials 
		WHERE EquipmentName = @EquipmentName;
	END;

	/* Create the record to hold the lists of it does not yet exist. */
	IF NOT EXISTS(
		SELECT 1 
		FROM [equipment].[ObjectNote] 
		WHERE ReptileListId = @ReptileListId)
	BEGIN
		INSERT INTO [equipment].[ObjectNote](ReptileListId)
		VALUES(@ReptileListId);
	END;

	/* Add the equipment notes to: [equipment].[ObjectNote] */
	UPDATE [equipment].[ObjectNote]
	SET Heating = @Heating,
		Humidity = @Humidity,
		Automation = @Automation, 
		Feeding = @Feeding
	WHERE ReptileListId = @ReptileListId;

	/* Output the results. */
	SELECT * FROM [equipment].[ObjectNote];
END;
GO





USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [guide].[SpInsertCareNoteSnake]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertCareNote]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertCareNote] @SubSpecies = 'bci', @Debug = 1;

Purpose: Get the denormalized care information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
SET NOCOUNT ON;

DECLARE @Materials TABLE (
	ID INT,
	Material VARCHAR(50)
);

DECLARE 
	 @careInfoId INT
	,@ReptileListId INT
	,@ReptileType VARCHAR(150)	
	,@LifeExpectancy VARCHAR(50) 	
	,@HotSpot_F TINYINT   
	,@TempLow_F TINYINT    
	,@TempHigh_F TINYINT   
	,@HumidityLowPercentage TINYINT 
	,@HumidityHighPercentage TINYINT
	,@OldNote VARCHAR(1500)
	,@NewNote VARCHAR(MAX)
	,@MaterialList VARCHAR(200) = '';

SELECT TOP 1 
	@ReptileListId = rl.ReptileListId,
	@LifeExpectancy = ri.LifeExpectancy
FROM reptile.ReptileList rl
	INNER JOIN reptile.Information ri ON ri.ReptileListId = rl.ReptileListId
WHERE @SubSpecies = SubSpecies;

SELECT 
	 @ReptileType = ReptileType
	,@HotSpot_F = HotSpot_F
	,@TempLow_F = TempLow_F
	,@TempHigh_F = TempHigh_F
	,@HumidityLowPercentage = HumidityLowPercentage
	,@HumidityHighPercentage = HumidityHighPercentage
FROM [guide].[VwDenormalizeEnvironment]
WHERE ReptileListId = @ReptileListId;

INSERT INTO @Materials(ID, Material)
SELECT rl.SubstrateId, cs.Material 
FROM guide.ReptileListToSubstrate rl
INNER JOIN care.Substrate cs ON rl.SubstrateId = cs.SubstrateId

WHILE EXISTS (SELECT TOP 1 1 FROM @Materials)
BEGIN
	SET @MaterialList += (SELECT TOP 1 Material FROM @Materials ORDER BY ID);	
	
	IF ((SELECT COUNT(ID) FROM @Materials) > 1)
	BEGIN
		SET @MaterialList += ', ';
	END;	
	DELETE FROM @Materials 
	WHERE ID = (SELECT TOP 1 ID FROM @Materials ORDER BY ID)
END;

SET @NewNote = CONCAT('CARE:',CHAR(10),'The ', @ReptileType ,' can live ',@LifeExpectancy,' in the wild, and they can live even longer with proper care in captivity. 
One of the more important aspects to care is maintaining a proper heat gradiant. There should be a cool, and warm side to the encloser as well as a hot spot. 
Proper temperatures will help the animal digest food properly. Too much heat or cold can kill them. For a ',@ReptileType,' The highest ambient temperature in the enclosure should be around ',
@TempLow_F,' degrees farenheight. 
The lowest ambient temperature should not be lower than ',@TempHigh_F ,' degrees farenheight. There should be hot spot as well to help the Snake warm up as desired. 
The average temperature should be around ',@HotSpot_F,' degrees farenheight. Further details will be in the equipment portion.',CHAR(10),CHAR(10));

SET @NewNote += CONCAT('Humidity is also an important aspect to the care of a', @ReptileType ,'. The humidity can fluctuate but the high point should be around ',@HumidityHighPercentage,'%
and the lower humidity should be around ',@HumidityLowPercentage,'%. The type of substrate used can retain more moisture. A larger water bowl can be used to maintain humidity. 
Daily misting will also help maintain the humidity.',CHAR(10),CHAR(10));

SET @NewNote += CONCAT('An enclosure should be as long as the snake, so it can fully strech out. The best Substrates are ',@MaterialList,'. 
It is best practice to have two or more places to hide, and snakes prefer a hide slightly larger than their body when curled up.',CHAR(10));

IF(@Debug = 1)
BEGIN
	SET @OldNote = (
		SELECT CareNote
		FROM guide.Note
		WHERE ReptileListId = @ReptileListId );

	PRINT 'Note before update: ' + CHAR(10) + @OldNote + CHAR(10);
	PRINT 'Note after update:' + CHAR(10) +  @NewNote + CHAR(10)
END;
ELSE 
BEGIN
	UPDATE guide.Note
	SET CareNote = @NewNote
	WHERE ReptileListId = @ReptileListId;
END;
GO






USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [guide].[SpInsertDietNoteSnake]
	 @SubSpecies VARCHAR(100)
	,@Debug BIT = 0
AS
/************************************************************************************
Object Name: [guide].[SpInsertDietNote]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: EXEC [guide].[SpInsertDietNote] @SubSpecies = 'bci', @Debug = 1;

Purpose: Get the denormalized diet information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
	BEGIN
	SET NOCOUNT ON;

	DECLARE 
		 @ReptileListId INT
		,@DietId INT
		,@ReptileType VARCHAR(150)	
		,@Scope	VARCHAR(50)
		,@DietToNoteId	INT	
		,@BowlSize VARCHAR(100)	
		,@FoodSchedule VARCHAR(50)	
		,@SupplementName VARCHAR(50)	
		,@SupplementSchedule	VARCHAR(50)
		,@FeedingChartNote VARCHAR(500)	
		,@OldNote VARCHAR(1000)
		,@NewNote VARCHAR(1000);

	SELECT TOP 1 
		 @ReptileListId = cd.ReptileListId
		,@DietId = cd.DietId
	FROM Care.Diet cd 
		INNER JOIN reptile.ReptileList rl ON cd.ReptileListId = cd.ReptileListId
	WHERE rl.SubSpecies = @SubSpecies;

	EXEC [guide].[SpInsertFeedingChartSnake] @ReptileListId = @ReptileListId

	SELECT 
		 @ReptileType = ReptileType
		,@Scope	= Scope	
		,@BowlSize	= BowlSize	
		,@SupplementName	= SupplementName	
		,@SupplementSchedule	= SupplementSchedule	
	FROM [guide].[VwDenormalizeDiet] 
	WHERE ReptileListId = @ReptileListId;

	SELECT @FeedingChartNote = note 
	FROM [care].[FeedingChartNote]
	WHERE ReptileListId = @ReptileListId
	

	SET @NewNote = CONCAT('DIET:',CHAR(10),@FeedingChartNote,'whichever is around 10-15% of the body weight of the ',@ReptileType,'. ',
		'Their meals can be supplimented with ',@SupplementName, ' ' , @SupplementSchedule,'.', CHAR(10),
		'The water bowl should be ',@BowlSize,'.');

	IF(@Debug = 1)
	BEGIN
		SET @OldNote = (
			SELECT DietNote
			FROM guide.Note
			WHERE ReptileListId = @ReptileListId );
 
		PRINT 'Note before update: ' + @OldNote+CHAR(10);
		PRINT 'Note after update:' + @NewNote;
	END;
	ELSE 
	BEGIN
		UPDATE guide.Note
		SET DietNote = @NewNote
		WHERE ReptileListId = @ReptileListId;
	END;
END;
GO






USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [guide].[SpGetReptileGuide]
	@SubSpecies VARCHAR(125)
/************************************************************************************
Object Name: [guide].[InsertIntoEnvironment]
Created By: David Stone

Parameter List:
	@SubSpecies: Name of the reptile to generate the guide for.

Example: guide.GetReptileGuide @SubSpecies = 'Russian Tortoise';

Purpose: Pull the generated notes for the given reptile, and concat them together to output the completed guide.

------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-16

************************************************************************************/
AS
BEGIN
	DECLARE 
--		@SubSpecies VARCHAR(50) = 'Russian Tortoise',
		@DietNote VARCHAR(2000), 
		@CareNote VARCHAR (2000), 
		@EquipmentNote VARCHAR (2000), 
		@SQL VARCHAR(6000), 
		@ReptileName VARCHAR(30),
		@ReptileListId SMALLINT;

	SELECT TOP 1 
		@ReptileName = CONCAT(Species, ': ', SubSpecies),
		@ReptileListId = ReptileListId
	FROM Reptile.ReptileList
	WHERE SubSpecies = @SubSpecies;

	SELECT 
		@DietNote = dietNote,
		@CareNote = carenote,
		@EquipmentNote = EquipmentNote
	FROM guide.Note
	WHERE ReptileListId = @ReptileListId;

	SET @SQL = 'REPTIGUIDE for: ' + @ReptileName + CHAR(10) +
	'DISCLAIMER: This guide is only supplimentory, and some basics. Please do in-depth research on all espects of a reptiles care before purchasing. Many reptiles can live decades or more.'
	+ CHAR(10) + CHAR(10) + @DietNote + CHAR(10)+ CHAR(10) + @CareNote
	+ CHAR(10) + @EquipmentNote;

	PRINT @SQL;
END;
GO







USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [guide].[SpFindReptile]
	@Species VARCHAR(125) = NULL,
	@SubSpecies VARCHAR(125) = NULL
/************************************************************************************
Object Name: [guide].[SpFindReptile]
Created By: David Stone

Parameter List:
	@Species: Species of the reptile to find.
	@SubSpecies: SubSpecies of the reptile to find. 

Example: [guide].[SpFindReptile] @Species = 'Boa', @SubSpecies = 'Imperator';

Purpose:

------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-16

************************************************************************************/
AS
BEGIN
	DECLARE @Reptile VARCHAR(125);

	IF @Species IS NULL
	BEGIN
		PRINT 'ERROR!: Must DECLARE @Species.'+ CHAR(10)+'DECLARE @Species but not @Subspecies to get a list of all subspecies for the declared @species that exist in reptile.ReptileList.';
		RETURN;
	END;
	
	IF(@Species IS NOT NULL AND @SubSpecies IS NULL)
	BEGIN
		IF(SELECT COUNT(ReptileListId)
			FROM reptile.ReptileList 
			WHERE Species LIKE '%'+@Species+'%') = 0
		BEGIN
			SELECT 'No species found! Please RE-DECLARE @Species.' AS 'ERROR!' 
			RETURN;
		END;
		ELSE
		BEGIN
			SELECT CONCAT('Species: ', Species, ' - SubSpecies: ', SubSpecies) AS 'DECLARE @Species & @Subspecies'
			FROM Reptile.ReptileList
			WHERE Species LIKE '%'+@Species+'%';
			RETURN;
		END;
	END;
	
	IF(@Species IS NOT NULL AND @SubSpecies IS NOT NULL)
	BEGIN
		IF NOT EXISTS (
			SELECT ReptileListId
			FROM reptile.ReptileList 
			WHERE SubSpecies = @SubSpecies)
		BEGIN
			PRINT 'ERROR!: No SubSpecies found! Please RE-DECLARE @SubSpecies.';
			RETURN;
		END;
		ELSE 
		BEGIN
			SELECT * 
			FROM [guide].[VwDenormalizeInformation]
			WHERE Species = @Species
				AND SubSpecies = @SubSpecies;
		END;
	END;
END;
GO







USE [Reptiguide_empty]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [guide].[SpCreateGuide]
	 @Category VARCHAR(10), 
	 @SubSpecies VARCHAR(50) = NULL
AS
/************************************************************************************
Object Name: [guide].[SpCreateGuide]
Created By: David Stone

Parameter List:
@SubSpecies: Name of the reptile that needs it's diet note updated.
@Debug: Set to 1 to print the insert statement instead of inserting.

Example: 
	EXEC [guide].[SpCreateGuide] @Category = 'snake', @SubSpecies = 'constrictor';
	EXEC [guide].[SpCreateGuide] @Category = 'Tortoise', @SubSpecies = 'Russian Tortoise';

Purpose: Get the denormalized care information for a reptile, and print it out or use it later on.
------------------------------------------------------------------------------------
Change History
Date Created: 2023-02-11

************************************************************************************/
SET NOCOUNT ON;

DECLARE @ReptileListId SMALLINT;

IF @SubSpecies IS NULL
BEGIN
	SELECT 'ERROR: Must SET @SubSpecies';
	RETURN;
END;

SET @ReptileListId =(
	SELECT ReptileListId 
	FROM Reptile.ReptileList
	WHERE SubSpecies = @SubSpecies);

IF NOT EXISTS (
	SELECT ReptileListId
	FROM [guide].[Note]
	WHERE ReptileListId = @ReptileListId)
BEGIN
	INSERT INTO [guide].[Note](ReptileListId)
	VALUES(@ReptileListId)
END;

IF(@Category = 'Snake')
BEGIN
	EXEC [guide].[SpInsertDietNoteSnake] @SubSpecies = @SubSpecies;
	EXEC [guide].[SpInsertCareNoteSnake] @SubSpecies = @SubSpecies;
	EXEC [guide].[SpInsertEquipmentNoteSnake] @SubSpecies = @SubSpecies;
END;

IF(@Category LIKE 'Tortoise')
BEGIN
	EXEC [guide].[SpInsertDietNoteTortoise] @SubSpecies = @SubSpecies;
	EXEC [guide].[SpInsertCareNoteTortoise] @SubSpecies = @SubSpecies;
	EXEC [guide].[SpInsertEquipmentNoteTortoise] @SubSpecies = @SubSpecies;
END;

EXEC [guide].[SpGetReptileGuide] @SubSpecies = @SubSpecies;



GO

