USE [Reptiguide_20230227]
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

