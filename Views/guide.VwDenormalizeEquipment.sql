USE [Reptiguide]
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

