USE [Reptiguide]
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

