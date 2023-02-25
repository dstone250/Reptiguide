USE [Reptiguide]
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

