/****************************************************************************************************************
  Create Schemas
****************************************************************************************************************/

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
  Create Reptile Tables
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
